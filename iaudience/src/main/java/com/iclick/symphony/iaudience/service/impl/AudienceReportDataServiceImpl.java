package com.iclick.symphony.iaudience.service.impl;

import com.iclick.symphony.iaudience.clients.AudienceRestClient;
import com.iclick.symphony.iaudience.constants.ReportDataTypeEnum;
import com.iclick.symphony.iaudience.dao.AudiencePlanRepository;
import com.iclick.symphony.iaudience.dao.AudienceReportDataRepository;
import com.iclick.symphony.iaudience.entity.AudiencePlan;
import com.iclick.symphony.iaudience.entity.AudienceReportData;
import com.iclick.symphony.iaudience.entity.Brand;
import com.iclick.symphony.iaudience.entity.Product;
import com.iclick.symphony.iaudience.model.remote.AudienceComposition;
import com.iclick.symphony.iaudience.model.report.Market;
import com.iclick.symphony.iaudience.model.report.MixTrend;
import com.iclick.symphony.iaudience.service.AudienceAnalysisRecordService;
import com.iclick.symphony.iaudience.service.AudiencePlanService;
import com.iclick.symphony.iaudience.service.AudienceReportDataService;
import com.iclick.symphony.iaudience.util.CommonDateUtil;
import com.iclick.symphony.iaudience.util.Constant;
import com.iclick.symphony.iaudience.util.JsonMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by wenjie.sun on 2017/6/20.
 */
@Service
public class AudienceReportDataServiceImpl implements AudienceReportDataService {
    @Resource
    private AudiencePlanService audiencePlanService;

    @Resource
    private AudienceReportDataRepository audienceReportDataRepository;

    @Resource
    private AudienceRestClient audienceRestClient;

    @Resource
    private AudiencePlanRepository audiencePlanRepository;

    @Resource
    private AudienceAnalysisRecordService audienceAnalysisRecordService;


    
    
    @Override
    public void saveReportData() {
        List<AudiencePlan> audiencePlanList = audiencePlanService.getAudiencePlanList();
        if (audiencePlanList != null) {
            for (AudiencePlan audiencePlan : audiencePlanList) {
                System.out.println("=======api======");
                this.invokeChartApi(audiencePlan.getId());
            }
        }
    }

    @Async
    public void invokeChartApi(Integer id){
        System.out.println("========audiencePlanId:"+id);
        AudiencePlan audiencePlan = audiencePlanRepository.findOne(id);
        //调用api接口
        try {
            saveCompetitorsAudience(audiencePlan);
            //如果未开始分析
            if (audiencePlan.getAnalyseStatus() == Constant.UNSTART){
                this.updateAnalyseStatus(audiencePlan,Constant.RUNNING);
            }
            Boolean brandAnalysis = audienceAnalysisRecordService.brandAnalysis(audiencePlan);
            Boolean marketAnalysis = audienceAnalysisRecordService.createMarketAnalysisData(audiencePlan);
            if (brandAnalysis && marketAnalysis){
                //如果是分析中
                if (audiencePlan.getAnalyseStatus() == Constant.RUNNING) {
                    this.updateAnalyseStatus(audiencePlan,Constant.COMPLETE);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("=======planId:"+audiencePlan.getId());
            this.updateAnalyseStatus(audiencePlan,Constant.UNSTART);
        }
    }

    public Map<Integer, Object> getLastReportData(List<AudiencePlan> audiencePlans){
        Map<Integer, Object> audienceMap = new HashMap<>();
        String date = CommonDateUtil.toDateYYYYMMDD3(new Date());
        if (!audiencePlans.isEmpty()){
            for (AudiencePlan audiencePlan : audiencePlans) {
                Map<String, Object> map = new HashMap<>();
                List<AudienceReportData> audienceReportDataList = audienceReportDataRepository.getAudienceReportDataByPlanId(audiencePlan.getId(), date);
                if (!audienceReportDataList.isEmpty())
                    for (AudienceReportData audienceReportData : audienceReportDataList) {
                        if (audienceReportData.getType() == ReportDataTypeEnum.BRAND.getValue()){
                            map.put(ReportDataTypeEnum.BRAND.getType(), audienceReportData.getTotal());
                        }else if (audienceReportData.getType() == ReportDataTypeEnum.COMPETITORS.getValue()){
                            map.put(ReportDataTypeEnum.COMPETITORS.getType(), audienceReportData.getTotal());
                        }else if (audienceReportData.getType() == ReportDataTypeEnum.POTENTIAL.getValue()){
                            map.put(ReportDataTypeEnum.POTENTIAL.getType(), audienceReportData.getTotal());
                        }
                    }
                audienceMap.put(audiencePlan.getId(), map);
            }
        }
        return audienceMap;
    }


    public MixTrend getLastMonthMixThrendData(int audiencePlanId,int type) {
        Map<String,Date> dateRange = lastMonthDateRange();
        String startDate = CommonDateUtil.toDateYYYYMMDD3(dateRange.get("lastMonth"));
        String endDate = CommonDateUtil.toDateYYYYMMDD3(dateRange.get("yesterday"));
        List<AudienceReportData> audienceReportDataList = audienceReportDataRepository.findLastMonthsDataByType(audiencePlanId,type,startDate,endDate);
        MixTrend mixTrend = new MixTrend();
        mixTrend.setDataPeriod(CommonDateUtil.toDateYYYYMMDD2(dateRange.get("lastMonth"))+" - "+CommonDateUtil.toDateYYYYMMDD2(dateRange.get("yesterday")));
        List<Market> marketList = new ArrayList<>();
        if (!audienceReportDataList.isEmpty()){
            for (AudienceReportData audienceReportData : audienceReportDataList) {
                Market  market  = new Market();
                market.setDate(audienceReportData.getDate());
                market.setValue(String.valueOf(audienceReportData.getTotal()));
                marketList.add(market);
            }
        }
        Map<String, List<Market>> result = new HashMap<String, List<Market>> ();
        result.put(ReportDataTypeEnum.findByValue(type).getType(), marketList);
        mixTrend.setResult(result);
        return mixTrend;
     }

    private Map<String,Date> lastMonthDateRange(){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, -30);
        Date lastMonth = calendar.getTime();

        Calendar calendarYes = Calendar.getInstance();
        calendarYes.setTime(new Date());
        calendarYes.add(Calendar.DATE, -1);
        Date yesterDay = calendarYes.getTime();
        Map<String, Date> mapDateRange = new HashMap<>();
        mapDateRange.put("yesterday", yesterDay);
        mapDateRange.put("lastMonth", lastMonth);
        return mapDateRange;
    }

    //保存所有competitors人群数量
    private void  saveCompetitorsAudience(AudiencePlan audiencePlan) {
        List<String> competitorsKeyWords = new ArrayList<>();
        if (audiencePlan != null && audiencePlan.getBrands().size() > 0) {
            for (Brand brand : audiencePlan.getBrands()) {
                if (brand.isCompetitor() && StringUtils.isNotBlank(brand.getKeyWords())) {
                    competitorsKeyWords.add(brand.getKeyWords());
                }
                if (brand.getProducts().size() > 0) {
                    for (Product product : brand.getProducts()) {
                        if (StringUtils.isNotBlank(product.getKeyWords()))
                            competitorsKeyWords.add(product.getKeyWords());
                    }
                }
            }
        }
        if (!competitorsKeyWords.isEmpty()) {
            String productResult = audienceRestClient.brandAnalysis(StringUtils.join(competitorsKeyWords, ","), true);
            JsonMapper jm = new JsonMapper();
            AudienceComposition brandObject = jm.fromJson(productResult, AudienceComposition.class);

            int type = ReportDataTypeEnum.COMPETITORS.getValue();
            int audiencePlanId = audiencePlan.getId();
            Long total = brandObject.getTotal();
            String date = CommonDateUtil.toDateYYYYMMDD3(new Date());
            AudienceReportData audienceReportData = null;
            audienceReportData = audienceReportDataRepository.findLastReportData(audiencePlanId, type, date);
            if (audienceReportData == null) {
                audienceReportData = new AudienceReportData();
                audienceReportData.setType(type);
                audienceReportData.setAudiencePlanId(audiencePlanId);
            }
            audienceReportData.setTotal(total);
            audienceReportData.setDate(date);
            audienceReportData.setCreateTime(new Date());
            audienceReportDataRepository.save(audienceReportData);
        }
    }
    public void updateAnalyseStatus(AudiencePlan audiencePlan,Integer status) {
        if (audiencePlan != null){
            audiencePlan.setAnalyseStatus(status);
            audiencePlanRepository.save(audiencePlan);
        }
    }






}
