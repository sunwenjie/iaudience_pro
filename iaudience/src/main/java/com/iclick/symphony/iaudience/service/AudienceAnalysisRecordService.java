package com.iclick.symphony.iaudience.service;

import com.iclick.symphony.iaudience.entity.AudienceAnalysisRecord;
import com.iclick.symphony.iaudience.entity.AudienceNews;
import com.iclick.symphony.iaudience.entity.AudiencePlan;
import com.iclick.symphony.iaudience.entity.AudienceReportData;
import com.iclick.symphony.iaudience.model.common.AnalysisModel;
import com.iclick.symphony.iaudience.model.view.BrandProductTrend;

import java.util.List;

public interface AudienceAnalysisRecordService {
	public List<AudienceAnalysisRecord> getAudienceAnalysisRecordList();

	public AudienceAnalysisRecord getAudienceAnalysisRecordById(Integer id);

	public AudienceAnalysisRecord getAudienceAnalysisRecordByPlanId(Integer planId,int type);

	public void save(AudienceAnalysisRecord audienceAnalysisRecord);

	boolean saveOrUpdate(AudienceAnalysisRecord entity);

	public boolean saveNews(AudienceNews audienceNews);

	public List<AudienceNews> getNewsListByDate(int planId,String date,int type);

	public boolean saveAudienceReportData(AudienceReportData audienceReportData);

	public List<AudienceReportData> getAudienceReportDataByPlanId(AudienceReportData audienceReportData);
	
	public List<AudienceReportData> getAudienceReportDataByDate(int planId,int type,String startDay,String endDay);

	public List<AudienceReportData> getTop5Data(int planId,String date,int type);
	public void saveDataFromApi(AnalysisModel model);
	public boolean createMarketAnalysisData( AudiencePlan audiencePlan);
    
    public boolean brandAnalysis(AudiencePlan audiencePlan);

    public BrandProductTrend getBrandTrendFromDB(int planId, String begin, String end);
    
    public AudienceAnalysisRecord getRecordFromDB(int planId, int type);
	
}
