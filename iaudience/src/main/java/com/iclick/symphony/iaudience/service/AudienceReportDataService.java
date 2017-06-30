package com.iclick.symphony.iaudience.service;

import com.iclick.symphony.iaudience.entity.AudiencePlan;
import com.iclick.symphony.iaudience.model.report.MixTrend;

import java.util.List;
import java.util.Map;

/**
 * Created by wenjie.sun on 2017/6/20.
 */
public interface AudienceReportDataService {
    void saveReportData();
    /**
     * 异步执行耗时较长的操作
     **/
    void invokeChartApi(Integer id);
    Map<Integer, Object> getLastReportData(List<AudiencePlan> audiencePlans);
    MixTrend getLastMonthMixThrendData(int audiencePlanId,int type);
    void updateAnalyseStatus(AudiencePlan audiencePlan,Integer status);

}
