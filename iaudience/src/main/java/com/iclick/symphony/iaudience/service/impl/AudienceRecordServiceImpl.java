package com.iclick.symphony.iaudience.service.impl;

import com.iclick.symphony.iaudience.clients.AudienceRestClient;
import com.iclick.symphony.iaudience.constants.AudienceTypeEnum;
import com.iclick.symphony.iaudience.dao.AudienceRecordRespository;
import com.iclick.symphony.iaudience.entity.AudienceRecord;
import com.iclick.symphony.iaudience.model.remote.AudienceComposition;
import com.iclick.symphony.iaudience.model.remote.Interest;
import com.iclick.symphony.iaudience.service.AudienceRecordService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by wenjie.sun on 2017/3/29.
 */
@Service
public class AudienceRecordServiceImpl implements AudienceRecordService {
    @Resource
    private AudienceRestClient audienceRestClient;
    @Resource
    private AudienceRecordRespository audienceRecordRespository;

    protected Logger log = LoggerFactory.getLogger(this.getClass());

    public void saveAudienceRecords() {
        // 保存兴趣标签基础数据
        saveInterestLabelRecords();

        // 保存自定义关键词
//        saveAudienceCustomRecords();
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void saveInterestLabelRecords() {
        AudienceComposition audienceComposition = audienceRestClient.getInterestAudience(null, true);
        List<Interest> interestList = audienceComposition.getInterest();
        for (int i = 0; i < interestList.size(); i++) {
            AudienceRecord audienceRecord = new AudienceRecord();
            Interest interest = interestList.get(i);
            DateFormat df = new SimpleDateFormat("yyyyMMdd");
            audienceRecord.setAudienceId(Integer.parseInt(interest.getKey()));
            audienceRecord.setTotal(interest.getDoc_count());
            audienceRecord.setDate(df.format(new Date()));
            audienceRecord.setType(AudienceTypeEnum.INTEREST.getValue());
            audienceRecord.setCreateTime(new Date());
            audienceRecordRespository.save(audienceRecord);
        }
    }

//    @Transactional(propagation = Propagation.REQUIRED)
//    public void saveAudienceCustomRecords() {
//        List<AudienceCustom> audienceCustomList = audienceCustomService.getAudienceCustomList();
//        List<String> parameList = new ArrayList<>();
//        List<String> returnList = null;
//        String parame;
//        for (AudienceCustom audienceCustom : audienceCustomList) {
//            parame = AudienceRestUtil.getAudienceCustomParame(StringUtils.split(audienceCustom.getKeyword(), ","), null,
//                    StringUtils.split(audienceCustom.getAgeGroup(), ","), StringUtils.split(audienceCustom.getGender(), ","),
//                    StringUtils.split(audienceCustom.getRegion(), ","));
//            parameList.add(parame);
//        }
//        returnList = audienceRestClient.getAudienceCustom(parameList);
//        List<AudienceRecord> audienceRecordList = new ArrayList<>();
//        for (int i = 0; i < returnList.size(); i++) {
//            String result = returnList.get(i);
//            if (StringUtils.isNotBlank(result)) {
//                AudienceComposition audienceComposition = JSON.parseObject(result, AudienceComposition.class);
//                AudienceRecord audienceRecord = new AudienceRecord();
//                DateFormat df = new SimpleDateFormat("yyyyMMdd");
//                audienceRecord.setAudienceId(audienceCustomList.get(i).getId());
//                audienceRecord.setTotal(audienceComposition.getTotal());
//                audienceRecord.setDate(df.format(new Date()));
//                audienceRecord.setType(AudienceTypeEnum.CUSTOM.getValue());
//                audienceRecord.setCreateTime(new Date());
//                audienceRecordList.add(audienceRecord);
//            }
//        }
//        audienceRecordRespository.save(audienceRecordList);
//    }

}
