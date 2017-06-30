package com.iclick.symphony.iaudience.service.impl;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.iclick.symphony.iaudience.clients.AudienceRestClient;
import com.iclick.symphony.iaudience.constants.ReportDataTypeEnum;
import com.iclick.symphony.iaudience.dao.AudienceAnalysisRecordRespository;
import com.iclick.symphony.iaudience.dao.AudienceNewsRepository;
import com.iclick.symphony.iaudience.dao.AudienceReportDataRepository;
import com.iclick.symphony.iaudience.entity.*;
import com.iclick.symphony.iaudience.model.common.AnalysisModel;
import com.iclick.symphony.iaudience.model.remote.*;
import com.iclick.symphony.iaudience.model.report.*;
import com.iclick.symphony.iaudience.model.view.BrandProductTrend;
import com.iclick.symphony.iaudience.service.AudienceAnalysisRecordService;
import com.iclick.symphony.iaudience.service.AudiencePlanService;
import com.iclick.symphony.iaudience.service.BaseService;
import com.iclick.symphony.iaudience.util.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class AudienceAnalysisRecordServiceImpl extends BaseService implements AudienceAnalysisRecordService {
	@Autowired
    private AudienceAnalysisRecordRespository  audienceAnalysisRecordRespository;
    @Autowired
    private AudienceNewsRepository  audienceNewsRepository;
    @Autowired
    private AudienceReportDataRepository  audienceReportDataRepository;
    @Autowired
    private AudienceRestClient audienceRestClient;


	@Autowired
	private AudiencePlanService audiencePlanService;

	@Override
	public void save(AudienceAnalysisRecord audienceAnalysisRecord) {
		audienceAnalysisRecordRespository.save(audienceAnalysisRecord);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public boolean saveOrUpdate(AudienceAnalysisRecord audienceAnalysisRecord) {
		AudienceAnalysisRecord analysisRecord = null;
		try {
			// 新增
			if (audienceAnalysisRecord.getId() == null) {
				analysisRecord = new AudienceAnalysisRecord();
				// audiencePlan.setCreateBy(UserUtil.getLoginUserId());
				// audiencePlan.setUpdateBy(UserUtil.getLoginUserId());
				analysisRecord.setCreateBy(1206);
				analysisRecord.setCreateTime(new Date());
				analysisRecord.setUpdateBy(1206);
				analysisRecord.setUpdateTime(new Date());
				
			} else {
				// 修改
				analysisRecord = this.getAudienceAnalysisRecordById(audienceAnalysisRecord.getId());
				// audiencePlan.setUpdateBy(UserUtil.getLoginUserId());
				analysisRecord.setUpdateBy(1208);
				analysisRecord.setUpdateTime(new Date());
			}
			analysisRecord.setPlanId(audienceAnalysisRecord.getPlanId());
			analysisRecord.setPlanName(audienceAnalysisRecord.getPlanName());
			analysisRecord.setType(audienceAnalysisRecord.getType());
			analysisRecord.setResultJson1(audienceAnalysisRecord.getResultJson1());
			analysisRecord.setResultJson2(audienceAnalysisRecord.getResultJson2());
			analysisRecord.setResultJson3(audienceAnalysisRecord.getResultJson3());
			analysisRecord.setResultJson4(audienceAnalysisRecord.getResultJson4());
			analysisRecord.setResultJson5(audienceAnalysisRecord.getResultJson5());

		} catch (Exception e) {
			e.getMessage();
			return false;
		}
		this.save(analysisRecord);
		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public boolean saveNews(AudienceNews audienceNews) {
		audienceNewsRepository.save(audienceNews);
		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public List<AudienceNews> getNewsListByDate(int planId, String date, int type) {

		return audienceNewsRepository.getAudienceNewsList(planId, date, type);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public List<AudienceReportData> getTop5Data(int planId, String date, int type) {
		System.out.println("==========date:" + date);
		return audienceReportDataRepository.getTop5DataList(planId, date, type);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public boolean saveAudienceReportData(AudienceReportData audienceReportData) {
		audienceReportDataRepository.save(audienceReportData);
		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public List<AudienceReportData> getAudienceReportDataByPlanId(AudienceReportData audienceReportData) {

		return audienceReportDataRepository.getAudienceReportDataByPlanId(audienceReportData.getAudiencePlanId(),
				audienceReportData.getDate());
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public List<AudienceReportData> getAudienceReportDataByDate(int planId, int type, String startDay, String endDay) {

		return audienceReportDataRepository.findLastMonthsDataByType(planId, type, startDay, endDay);
	}

	@Transactional(readOnly = true)
	public List<AudienceAnalysisRecord> getAudienceAnalysisRecordList() {
		Sort sort = new Sort(Direction.DESC, "createTime");
		return audienceAnalysisRecordRespository.findAll(sort);
	}

	@Transactional(readOnly = true)
	public AudienceAnalysisRecord getAudienceAnalysisRecordById(Integer id) {
		if (id == null) {
			return null;
		}
		return audienceAnalysisRecordRespository.findOne(id);

	}

	@Transactional(readOnly = true)
	public AudienceAnalysisRecord getAudienceAnalysisRecordByPlanId(Integer id, int type) {
		if (id == null) {
			return null;
		}
		return audienceAnalysisRecordRespository.getAnalysisRecordByPlanId(id, type);

	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void saveDataFromApi(AnalysisModel model) {

		String result = "";
		String[] gender = null;
		if (StringUtils.isNoneBlank(model.getGender())) {
			gender = new String[] { model.getGender() };
		}
		// // 当前品牌的人群
		// String parames =
		// AudienceRestUtil.getAudienceTotalParame(model.getKeyword(), null,
		// model.getAgeGroup(), gender,
		// model.getRegion());
		// result = audienceRestClient.getIaudienceAudience(parames);
		// AudienceComposition audience = JSON.parseObject(result,
		// AudienceComposition.class);

		// 总互联网的人群
		String internetTotal = audienceRestClient.getIaudienceAudience("{}");
		AudienceComposition internet = JSON.parseObject(internetTotal, AudienceComposition.class);

		// 品牌相关的市场人群
		String allMarketParams = AudienceRestUtil.getAllMarketParame(model.getKeyword(), model.getInterest(),
				model.getAgeGroup(), gender, model.getRegion());
		String allMarket = audienceRestClient.getAllMarketComparesion(allMarketParams);
		AudienceComposition market = JSON.parseObject(allMarket, AudienceComposition.class);

		saveMarketShareRecord(model, market.getTotal(), internet.getTotal());

	}

	@Transactional(propagation = Propagation.REQUIRED)
	private void saveMarketShareRecord(AnalysisModel model, Long share, Long total) {

		// // brand audience 人群
		// AudienceReportData audienceData = new AudienceReportData();
		// audienceData.setDate(DateUtil.nowDayStr());
		// // brand id
		// audienceData.setRefId(model.getBrandId());
		// audienceData.setTotal(audience);
		// audienceData.setAudiencePlanId(model.getPlanId());
		// audienceData.setType(ReportDataTypeEnum.BRAND.getValue());
		// this.saveAudienceReportData(audienceData);

		// market 人群
		AudienceReportData marketData = new AudienceReportData();
		marketData.setDate(DateUtil.nowDayStr());
		marketData.setRefId(0);
		marketData.setTotal(share);
		marketData.setAudiencePlanId(model.getPlanId());
		marketData.setType(ReportDataTypeEnum.MARKET.getValue());
		marketData.setCreateTime(new Date());
		this.saveAudienceReportData(marketData);

		// 互联网人群
		AudienceReportData InternetData = new AudienceReportData();
		InternetData.setDate(DateUtil.nowDayStr());
		InternetData.setRefId(0);
		InternetData.setTotal(total);
		InternetData.setAudiencePlanId(model.getPlanId());
		InternetData.setType(ReportDataTypeEnum.INTERNET.getValue());
		InternetData.setCreateTime(new Date());
		this.saveAudienceReportData(InternetData);

		// 品牌人群占市场人群比
		AudienceReportData marketShare = new AudienceReportData();
		marketShare.setDate(DateUtil.nowDayStr());
		marketShare.setRefId(0);
		Double rate = share.doubleValue() * 100 / total.doubleValue();
		if (rate < 1) {
			rate = 1.0;
		}
		marketShare.setTotal(rate.longValue());
		marketShare.setAudiencePlanId(model.getPlanId());
		marketShare.setType(ReportDataTypeEnum.MARKETSHARE.getValue());
		marketShare.setCreateTime(new Date());
		this.saveAudienceReportData(marketShare);

		// 主品牌的相关文章
		JSONObject articleJson = audienceRestClient.getIaudienceArticleSuggestion(model.getMainBrandName(), 8);
		ArticleComposition articleComposition = JSON.toJavaObject(articleJson, ArticleComposition.class);

		String[] index = { "A", "B", "C", "D", "E", "F", "G", "H" };
		for (int i = 0; i < articleComposition.getArticles().size(); i++) {
			Article article = articleComposition.getArticles().get(i);
			AudienceNews audienceNews = new AudienceNews();
			audienceNews.setDate(DateUtil.nowDayStr());
			audienceNews.setMeta(article.getMeta().getDescription());
			audienceNews.setTitle(article.getTitle());
			audienceNews.setSummary(article.getSummary());
			audienceNews.setTopImg(article.getTopImg());
			audienceNews.setScore(article.getScore());
			audienceNews.setUrl(article.getUrl());
			audienceNews.setAudiencePlanId(model.getPlanId());
			audienceNews.setIndex_sort(index[i]);
			audienceNews.setType(ReportDataTypeEnum.MARKET.getValue());
			audienceNews.setCreateTime(new Date());

			this.saveNews(audienceNews);
		}

	}

    @Transactional(propagation = Propagation.REQUIRED)
	public boolean createMarketAnalysisData (AudiencePlan audiencePlan) {
    	AnalysisModel model = new AnalysisModel();
    	model.setPlanId(audiencePlan.getId());

		List<String> otherBrandList = new ArrayList<String>();
		List<String> keyWordList = new ArrayList<String>();
		// List<String> interestList = new ArrayList<String>();
		for (Brand brand : audiencePlan.getBrands()) {
			if (!brand.isCompetitor()) {
				model.setMainBrandName(brand.getName());
			} else {
				otherBrandList.add(brand.getName());
				model.setCompetitor(brand.isCompetitor());
			}
			model.setBrandId(brand.getId());

			keyWordList.add(brand.getName());
			keyWordList.add(brand.getKeyWords());
			for (Product product : brand.getProducts()) {
				keyWordList.add(product.getName());
				keyWordList.add(product.getKeyWords());
			}

		}
		model.setInterest(new String[] { audiencePlan.getCategoryId() + "" });
		model.setKeyword(CommonModelUtil.listToArray(keyWordList));
		// 保存历史数据
		this.saveDataFromApi(model);

		model.setOtherBrandList(otherBrandList);

		// RequestContext requestContext = new RequestContext(request);
		// Locale locale = requestContext.getLocale();
		// 解析接口返回值
		ChartData charData = new ChartData();
		// if (Locale.ENGLISH.equals(locale)) {
		// charData.setGeoMapping(MappingUtils.getProvinceEnZHMapping());
		// }

		AudienceChart shareChart = new AudienceChart();
		getShareData(shareChart, model);

		AudienceChart marketChart = new AudienceChart();
		getMarketData(model, marketChart);
		String date = DateUtil.yesterday();
		List<AudienceReportData> topBrandList = this.getTop5Data(model.getPlanId(), date,
				ReportDataTypeEnum.BRAND.getValue());
		Map<String, Long> top5brand = new HashMap<>();
		String brandNmae = "";
		for (int i = 0; i < topBrandList.size(); i++) {
			AudienceReportData rep = topBrandList.get(i);
			if (brandNmae.equals(rep.getRefName())) {
				continue;
			}
			brandNmae = rep.getRefName();
			top5brand.put(brandNmae, rep.getTotal());

		}

		Map<String, Long> top5products = new HashMap<>();
		List<AudienceReportData> topProductList = this.getTop5Data(model.getPlanId(), date,
				ReportDataTypeEnum.PRODUCT.getValue());
		String productNmae = "";
		for (int i = 0; i < topProductList.size(); i++) {
			AudienceReportData rep = topProductList.get(i);
			if (productNmae.equals(rep.getRefName())) {
				continue;
			}
			productNmae = rep.getRefName();
			top5products.put(productNmae, rep.getTotal());
		}

		MarketChartData mCharData = (MarketChartData) marketChart.getData();
		if (mCharData != null) {
			for (AudienceChart chart : mCharData.getResult()) {
				((AudienceChartData) chart.getData()).setTop5brand(top5brand);
				((AudienceChartData) chart.getData()).setTop5products(top5products);
			}
		}

		marketChart.setData(mCharData);

		// market and share
		List<AudienceChart> audienceChartList = new ArrayList<>();
		// share data
		audienceChartList.add(shareChart);
		// market
		audienceChartList.add(marketChart);
		// data json
		charData.setResult(audienceChartList);

		String resultJson = charData.toString();
		// String marketJson = charData.toString();
		return saveAnalysisRecord(model, resultJson);

	}

	private void getShareData(AudienceChart shareChart, AnalysisModel model) {
		AudienceChartData data = new AudienceChartData();
		Map<String, Long> market_share = new HashMap<>();
		// String result = "";

		// cloud 推荐关键词
		String keyParams = model.getMainBrandName() + "&num=10&fs=true";
		JSON resKeyWord = audienceRestClient.getIaudienceKeyWord(keyParams);

		KeyWordComposition suggestKey = JSON.toJavaObject(resKeyWord, KeyWordComposition.class);
		List<CloudTag> cloud_tags = new ArrayList<CloudTag>();
		if (suggestKey != null) {
			for (Keyword key : suggestKey.getCn_en()) {
				CloudTag tag = new CloudTag();
				tag.setText(key.getKey());
				tag.setWeight(key.getScore() * 100);
				cloud_tags.add(tag);
			}
		}
		data.setCloud_tag(cloud_tags);

		AudienceReportData report = new AudienceReportData();
		String date = DateUtil.yesterday();
		report.setDate(date);
		report.setAudiencePlanId(model.getPlanId());

		List<AudienceReportData> reportList = this.getAudienceReportDataByPlanId(report);
		for (AudienceReportData rep : reportList) {
			// if (rep.getRefId() == model.getBrandId() &&
			// !model.isCompetitor()) {
			// audience
			if (rep.getType() == 3) {
				data.setAudience(rep.getTotal());
				// 互联网人群
			} else if (rep.getType() == 2) {
				market_share.put("market", rep.getTotal());
				// market 人群
			} else if (rep.getType() == 1) {
				market_share.put("market_show", rep.getTotal());
				// market的人群
				data.setAllMarket(rep.getTotal());
				model.setAllMarket(rep.getTotal());
				// market的人群
				data.setAudience(rep.getTotal());
			}
			// }
		}

		data.setMarket_share(market_share);

		MixTrend mixTrend = getMixTrend(model);
		data.setMixTrend(mixTrend);

		shareChart.setName("share");
		shareChart.setData(data);

	}

	private MixTrend getMixTrend(AnalysisModel model) {

		MixTrend mixTrend = new MixTrend();
		List<TopBrand> topBrands = new ArrayList<TopBrand>();

		Map<String, List<Market>> result = new HashMap<String, List<Market>>();
		model.setStartDay(DateUtil.beforSevenDay());
		model.setEndDay(DateUtil.yesterday());
		List<AudienceReportData> audienceList = this.getAudienceReportDataByDate(model.getPlanId(),
				ReportDataTypeEnum.MARKET.getValue(), model.getStartDay(), model.getEndDay());
		List<Market> marketA = new ArrayList<Market>();

		List<AudienceReportData> shareList = this.getAudienceReportDataByDate(model.getPlanId(),
				ReportDataTypeEnum.MARKETSHARE.getValue(), model.getStartDay(), model.getEndDay());
		List<Market> marketS = new ArrayList<Market>();
		String date = "";
		for (AudienceReportData rep : audienceList) {

			// market audience
			if (!date.equals(rep.getDate())) {
				Market market = new Market();
				market.setDate(rep.getDate());
				market.setName("Market Audience");
				market.setValue(rep.getTotal().toString());
				marketA.add(market);
				date = rep.getDate();
				getNewsByDay(topBrands, date, model.getPlanId());
			}

		}

		for (AudienceReportData rep : shareList) {
			// market share 人群 市场的份额
			if (!date.equals(rep.getDate())) {
				Market market = new Market();
				market.setDate(rep.getDate());
				market.setName("Market Share");
				market.setValue(rep.getTotal().toString());
				marketS.add(market);
			}
			date = rep.getDate();

		}
		result.put("Market Audience", marketA);
		result.put("Market Share", marketS);

		String period = "Period: " + model.getStartDay() + "-" + model.getEndDay();
		mixTrend.setDataPeriod(period);
		mixTrend.setResult(result);
		mixTrend.setTopBrands(topBrands);

		return mixTrend;
	}

	private void getNewsByDay(List<TopBrand> topBrands, String date, int planId) {
		List<ArticleDes> articles = new ArrayList<ArticleDes>();
		List<AudienceNews> newsList = this.getNewsListByDate(planId, date, 1);
		if (!newsList.isEmpty() && newsList.size() > 8) {
			newsList = newsList.subList(0, 8);

		}
		for (AudienceNews article : newsList) {
			// 最新8条新闻

			ArticleDes art = new ArticleDes();
			art.setDate(date);
			art.setIndex(article.getIndex_sort());
			art.setTitle(article.getTitle());
			art.setContent(article.getSummary());
			art.setPic(article.getTopImg());
			articles.add(art);
		}

		TopBrand brand = new TopBrand();
		brand.setDate(date);
		brand.setArticles(articles);
		topBrands.add(brand);
	}

	private boolean saveAnalysisRecord(AnalysisModel model, String resultJson) {
		int type = ReportDataTypeEnum.MARKET.getValue();
		AudienceAnalysisRecord entity = this.getAudienceAnalysisRecordByPlanId(model.getPlanId(), type);
		if (entity == null) {
			entity = new AudienceAnalysisRecord();
		}
		entity.setPlanId(model.getPlanId());
		entity.setPlanName(model.getMainBrandName());
		entity.setResultJson1(resultJson);
		entity.setType(type);
		boolean res = this.saveOrUpdate(entity);
		return res;
	}

	private MarketChartData getMarketData(AnalysisModel model, AudienceChart marketChart) {
		marketChart.setName("market");
		String brand = model.getMainBrandName();

		JSONObject returnObj = null;
		// 解析接口返回值
		MarketChartData charData = new MarketChartData();
		try {
			List<String> otherBrandList = model.getOtherBrandList();

			List<String> parames = AudienceRestUtil.getIaudienceComparesionParames(brand, otherBrandList);
			List<String> resultStrList = null;
			resultStrList = audienceRestClient.getAudienceComparesion(parames);

			List<ComparisonComposition> comparisonCompositionList = new ArrayList<ComparisonComposition>();
			// RequestContext requestContext = new RequestContext(request);
			// Locale locale = requestContext.getLocale();
			for (String result : resultStrList) {
				if (StringUtils.isNotBlank(result)) {
					ComparisonComposition comparisonComposition = JSON.parseObject(result, ComparisonComposition.class);
					comparisonCompositionList.add(comparisonComposition);
				}
			}

			// 泡泡图
			List<BubbleChart> bubbleCharRowList = ConvertToReportDataUtils.getBubbleChart(comparisonCompositionList,
					brand, otherBrandList);
			charData.setBubble(bubbleCharRowList);

			// 其他图
			List<AudienceChart> audienceChart = ConvertToReportDataUtils.getAudienceChartList(comparisonCompositionList,
					brand, otherBrandList, null, null, null, null, model.getAllMarket());
			charData.setResult(audienceChart);
			// if (Locale.ENGLISH.equals(locale)) {
			// charData.setGeoMapping(MappingUtils.getProvinceEnZHMapping());
			// }
			// charData.setResultStrList(resultStrList);

			marketChart.setData(charData);
		} catch (Exception e) {
			returnObj = new JSONObject();
			returnObj.put("error", "Get Report Date Error");
		}
		return charData;
	}

	@Override
	@Transactional
	public boolean brandAnalysis(AudiencePlan plan) {
    	if (plan == null) return false;
    	int planId = plan.getId();
		Brand brand = plan.getMasterBrand();
		if(brand == null)return false;
		List<AudienceChart> charts = new ArrayList<>();
		List<Product> products = audiencePlanService.getProductsByBrandId(brand.getId());
		AudienceChart chart = new AudienceChart();
		chart.setName(brand.getName());
		chart.setType("Brand");
		JsonMapper jm = new JsonMapper();
		List<String> brandKeyWords = new ArrayList<>();
		brandKeyWords.add(brand.getKeyWords());
		List<AudienceComposition> productObjects = new ArrayList<>();
		List<Long> productAudienceList = new ArrayList<>();
		for(int i = 0; i < products.size(); i++){
			String productResult = audienceRestClient.brandAnalysis(products.get(i).getKeyWords(),false);
			AudienceComposition productObject = jm.fromJson(productResult, AudienceComposition.class);
			productObjects.add(productObject);
			productAudienceList.add(productObject.getTotal());
			if(StringUtils.isNotBlank(products.get(i).getKeyWords()))
				brandKeyWords.add(products.get(i).getKeyWords());
		}
		//先删除已存在的本日数据
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());
		audienceReportDataRepository.deleteBrandAndProductData(planId, ReportDataTypeEnum.BRAND.getValue(), ReportDataTypeEnum.PRODUCT.getValue(), today);
		audienceNewsRepository.deleteNews(planId, 2, today);
		while(products.size() > 5){
			int index = getMinInList(productAudienceList);
			//保存product的历史数据
			AudienceChartData productData = audienceComposition2AudienceChartData(productObjects.get(index));
			audienceReportDataRepository.save(audienceChartData2AudienceReportData(productData, ReportDataTypeEnum.PRODUCT.getValue(), products.get(index).getId(), products.get(index).getName(), planId, today));
			//delete
			productAudienceList.remove(index);
			productObjects.remove(index);
			products.remove(index);
		}
		String brandResult = audienceRestClient.brandAnalysis(StringUtils.join(brandKeyWords, ","),false);//, productKeywords
		AudienceComposition brandObject = jm.fromJson(brandResult, AudienceComposition.class);
		SuggestionComposition keyWords = audienceRestClient.getKeyWords(brand.getKeyWords(), "cn", 10);
		
		AudienceChartData data = audienceComposition2AudienceChartData(brandObject);
		data.setCloud_tag(keyWords.keyword2CloudTag());
		chart.setData(data);
		charts.add(chart);
		//保存brand的历史数据
		audienceReportDataRepository.save(audienceChartData2AudienceReportData(data, ReportDataTypeEnum.BRAND.getValue(), brand.getId(), brand.getName(), planId, today));
		
		for(int i = 0; i < productObjects.size(); i++){
			AudienceChart productChart = new AudienceChart();
			productChart.setName(products.get(i).getName());
			productChart.setType("Product");
			AudienceChartData productData = audienceComposition2AudienceChartData(productObjects.get(i));
			productChart.setData(productData);
			charts.add(productChart);
			//保存product的历史数据
			audienceReportDataRepository.save(audienceChartData2AudienceReportData(productData, ReportDataTypeEnum.PRODUCT.getValue(), products.get(i).getId(), products.get(i).getName(), planId, today));
		}
		
		//news
		JSONObject news = audienceRestClient.getIaudienceArticleSuggestion(brand.getKeyWords(), 8);
		List<AudienceNews> list = jsonObject2TopBrand(news, planId, brand.getName());
		
		//save to mysql
		AudienceAnalysisRecord record = getRecordFromDB(planId, ReportDataTypeEnum.BRAND.getValue());
		if(record == null)
			record = new AudienceAnalysisRecord();
		record.setCreateTime(new Date());
		record.setPlanId(planId);
		record.setPlanName(plan.getName());
		record.setResultJson1(JSON.toJSONString(charts));
		record.setType(ReportDataTypeEnum.BRAND.getValue());
		audienceAnalysisRecordRespository.save(record);
		
		for(AudienceNews audienceNews : list){
			audienceNewsRepository.save(audienceNews);
		}
		
		return true;
	}
	
	private int getMinInList(List<Long> list){
		Long num = Collections.min(list);
		return list.indexOf(num);
	}
	
	private AudienceChartData audienceComposition2AudienceChartData(AudienceComposition object){
		AudienceChartData data = new AudienceChartData();
		data.setAge_group(object.getAgeMap());
		data.setAudience(object.getTotal());
		data.setGender(object.getGenerMap());
		data.setInterestZH(object.getInterestMap("zh"));
		data.setInterestEN(object.getInterestMap("en"));
		data.setRegionsZH(object.getProvinceList("zh"));
		data.setRegionsEN(object.getProvinceList("en"));
		return data;
	}
	
	private AudienceReportData audienceChartData2AudienceReportData(AudienceChartData data, int type, int refId, String refName, int audiencePlanId, String today){
		AudienceReportData audienceReportData = new AudienceReportData();
		audienceReportData.setCreateTime(new Date());
		audienceReportData.setDate(today);
		audienceReportData.setTotal(data.getAudience());
		audienceReportData.setType(type);
		audienceReportData.setRefId(refId);
		audienceReportData.setAudiencePlanId(audiencePlanId);
		audienceReportData.setRefName(refName);
		return audienceReportData;
	}
	
	private List<AudienceNews> jsonObject2TopBrand(JSONObject news, int audiencePlanId, String brandName){
		List<AudienceNews> brandList = new ArrayList<>();
		List<Object> articles = (List<Object>)news.get("articles");
		for(int i = 0; i < articles.size(); i++){
			Article object = JSONObject.parseObject(JSONObject.toJSONString(articles.get(i)), Article.class);
			AudienceNews audienceNews = new AudienceNews();
			audienceNews.setContent(object.getSite().getName());
			audienceNews.setTitle(object.getTitle());
			audienceNews.setScore(object.getScore());
			audienceNews.setDate(object.getCreateTime());
			Character index = (char)('A' + i);
			audienceNews.setIndex_sort(index.toString());
			audienceNews.setTopImg(object.getTopImg());
			audienceNews.setUrl(object.getUrl());
			audienceNews.setCreateTime(new Date());
			audienceNews.setAudiencePlanId(audiencePlanId);
			audienceNews.setSummary(object.getSummary());
			audienceNews.setType(2);
			audienceNews.setName(brandName);
			brandList.add(audienceNews);
		}
		return brandList;
	}



	/**
	 * brand trend & product analysis 功能部分相同，放在一个方法里<br>
	 * 结果包含以上两部分
	 */
	@Override
	public BrandProductTrend getBrandTrendFromDB(int planId, String begin, String end) {
		AudiencePlan plan = audiencePlanService.getAudiencePlanById(planId);
		Brand brand = plan.getMasterBrand();
		List<AudienceReportData> allList = audienceReportDataRepository.getAudienceReportDataList(planId, begin, end);
		List<AudienceReportData> top5Products = audienceReportDataRepository.getTop5DataList(planId, end, ReportDataTypeEnum.PRODUCT.getValue());
		Map<String, Long> brandMap = new HashMap<>();
		Map<String, Long> marketMap = new HashMap<>();
		List<Market> brandAudience = new ArrayList<>();// return
		//Map<Integer, List<Market>> top5ProductsAudience = new HashMap<>();// return
		List<Integer> top5productIds = new ArrayList<>();
		List<Market> top5ProductsAudienceList = new ArrayList<>();// return
		if(top5Products.size() > 5)
			top5Products = top5Products.subList(0, 5);
		for(AudienceReportData product : top5Products){
			top5productIds.add(product.getRefId());
			//top5ProductsAudience.put(product.getRefId(), new ArrayList<Market>());
		}
		List<Long> potential1 = new ArrayList<Long>();
		List<Long> potential2 = new ArrayList<Long>();
		List<Long> potential3 = new ArrayList<Long>();
		List<Long> potential4 = new ArrayList<Long>();
		List<Long> brand1 = new ArrayList<Long>();
		List<Long> brand2 = new ArrayList<Long>();
		List<Long> brand3 = new ArrayList<Long>();
		List<Long> brand4 = new ArrayList<Long>();
		List<Long> market1 = new ArrayList<Long>();
		List<Long> market2 = new ArrayList<Long>();
		List<Long> market3 = new ArrayList<Long>();
		List<Long> market4 = new ArrayList<Long>();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(today);
		c.add(Calendar.DATE, -7);
		String week4 = format.format(c.getTime());
		c.add(Calendar.DATE, -7);
		String week3 = format.format(c.getTime());
		c.add(Calendar.DATE, -7);
		String week2 = format.format(c.getTime());
		c.add(Calendar.DATE, -7);
		String week1 = format.format(c.getTime());
		for(AudienceReportData data : allList){
			Market market = new Market();
			market.setDate(data.getDate());
			market.setValue(data.getTotal().toString());
			if(data.getType() == ReportDataTypeEnum.PRODUCT.getValue() && top5productIds.contains(data.getRefId())){
				market.setName(data.getRefName());// name
				top5ProductsAudienceList.add(market);
				//top5ProductsAudience.get(data.getRefId()).add(market);
			}
			//判断主品牌
			if(data.getType() == ReportDataTypeEnum.BRAND.getValue() && data.getRefId() == brand.getId()){
				market.setName("Brand Audience");
				brandMap.put(data.getDate(), data.getTotal());
				brandAudience.add(market);
				
				if(data.getDate().compareTo(week4) >= 0)
					brand4.add(data.getTotal());
				else if(data.getDate().compareTo(week3) >= 0)
					brand3.add(data.getTotal());
				else if(data.getDate().compareTo(week2) >= 0)
					brand2.add(data.getTotal());
				else if(data.getDate().compareTo(week1) >= 0)
					brand1.add(data.getTotal());
			}
			if(data.getType() == ReportDataTypeEnum.MARKET.getValue()){
				//market.setName("Brand Audience");
				marketMap.put(data.getDate(), data.getTotal());
				
				if(data.getDate().compareTo(week4) >= 0)
					market4.add(data.getTotal());
				else if(data.getDate().compareTo(week3) >= 0)
					market3.add(data.getTotal());
				else if(data.getDate().compareTo(week2) >= 0)
					market2.add(data.getTotal());
				else if(data.getDate().compareTo(week1) >= 0)
					market1.add(data.getTotal());
			}
			
			if(data.getType() == ReportDataTypeEnum.POTENTIAL.getValue()){
				if(data.getDate().compareTo(week4) >= 0)
					potential4.add(data.getTotal());
				else if(data.getDate().compareTo(week3) >= 0)
					potential3.add(data.getTotal());
				else if(data.getDate().compareTo(week2) >= 0)
					potential2.add(data.getTotal());
				else if(data.getDate().compareTo(week1) >= 0)
					potential1.add(data.getTotal());
			}
		}
		List<Market> brandShare = new ArrayList<>();// return
		for(Market brandMarket : brandAudience){
			Market bShare = new Market();
			bShare.setDate(brandMarket.getDate());
			bShare.setName("Brand Share");
			if(marketMap == null || marketMap.get(bShare.getDate()) == null || marketMap.get(bShare.getDate()).compareTo(0L) == 0)
				bShare.setValue("0");
			else
				bShare.setValue(String.valueOf(Long.parseLong(brandMarket.getValue())*100/marketMap.get(bShare.getDate())));
			brandShare.add(bShare);
		}
		

		List<AudienceNews> newsList = audienceNewsRepository.getAudienceNewsListInPeriod(begin, end, 2);
		Map<String, List<ArticleDes>> newsMap = new HashMap<>();
		for(AudienceNews news : newsList){
			List<ArticleDes> arts;
			if(newsMap.containsKey(news.getDate()))
				arts = newsMap.get(news.getDate());
			else
				arts = new ArrayList<>();
			arts.add(news.news2Article());
			newsMap.put(news.getDate(), arts);
		}
		List<TopBrand> topBrandList = new ArrayList<>();
		for(String artKey : newsMap.keySet()){
			TopBrand topBrand = new TopBrand();
			topBrand.setArticles(newsMap.get(artKey));
			topBrand.setDate(artKey);
			topBrandList.add(topBrand);
		}
		
		BrandProductTrend trend = new BrandProductTrend();
		trend.setBrandAudience(brandAudience);
		trend.setBrandShare(brandShare);
		//trend.setTop5ProductsAudience(top5ProductsAudience);
		trend.setTop5ProductsAudienceList(top5ProductsAudienceList);
		trend.setTopBrandList(topBrandList);
		trend.setMarketAudience(marketMap.get(end));
		int weekIndex = 0;
		for(List<Long> l : new ArrayList<List<Long>>(){{add(potential1); add(potential2);add(potential3); add(potential4);}}){
			weekIndex++;
			Market m = new Market();
			m.setDate("week" + weekIndex);
			m.setName("Potential");
			m.setValue(getAverage(l).toString());
			trend.getPotentialWeek().add(m);
		}
		weekIndex = 0;
		for(List<Long> l : new ArrayList<List<Long>>(){{add(brand1); add(brand2);add(brand3); add(brand4);}}){
			weekIndex++;
			Market m = new Market();
			m.setDate("week" + weekIndex);
			m.setName("Brand");
			m.setValue(getAverage(l).toString());
			trend.getBrandWeek().add(m);
			trend.getPotentialWeek().add(m);//放在一个list中
		}
		weekIndex = 0;
		for(List<Long> l : new ArrayList<List<Long>>(){{add(market1); add(market2);add(market3); add(market4);}}){
			weekIndex++;
			Market m = new Market();
			m.setDate("week" + weekIndex);
			m.setName("Brand Share");
			Long marketAu = getAverage(l);
			if(marketAu.compareTo(0L) == 0)
				m.setValue("0");
			else
				m.setValue(String.valueOf((Long.parseLong(trend.getBrandWeek().get(weekIndex-1).getValue())*100/marketAu)));
			trend.getBrandLine().add(m);
		}
		return trend;
	}

	@Override
	public AudienceAnalysisRecord getRecordFromDB(int planId, int type) {
		return audienceAnalysisRecordRespository.getAnalysisRecordByPlanId(planId, type);
	}
	
	private Long getAverage(List<Long> list){
		Long total = 0L;
		if(list == null || list.size() == 0)
			return total;
		for(long l : list)
			total += l;
		return total/list.size();
	}

}
