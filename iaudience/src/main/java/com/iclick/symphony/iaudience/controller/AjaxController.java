package com.iclick.symphony.iaudience.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.iclick.symphony.iaudience.clients.AudienceRestClient;
import com.iclick.symphony.iaudience.constants.ReportDataTypeEnum;
import com.iclick.symphony.iaudience.entity.AudienceAnalysisRecord;
import com.iclick.symphony.iaudience.entity.Product;
import com.iclick.symphony.iaudience.model.common.AnalysisModel;
import com.iclick.symphony.iaudience.model.common.KeywordModel;
import com.iclick.symphony.iaudience.model.remote.LbsComosition;
import com.iclick.symphony.iaudience.model.report.*;
import com.iclick.symphony.iaudience.model.view.UserModel;
import com.iclick.symphony.iaudience.service.AudienceAnalysisRecordService;
import com.iclick.symphony.iaudience.service.AudiencePlanService;
import com.iclick.symphony.iaudience.service.AudienceReportDataService;
import com.iclick.symphony.iaudience.util.AudienceRestUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.RequestContext;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by wenjie.sun on 2017/5/25.
 */
@Controller
@SessionAttributes("clientId")
@RequestMapping(value = "/ajax")
public class AjaxController {
	
    @Resource
    private AudiencePlanService audiencePlanService;
    @Resource
    private AudienceReportDataService audienceReportDataService;
    @Autowired
	private AudienceAnalysisRecordService audienceAnalysisRecordService;
	@Autowired
	private AudienceRestClient audienceRestClient;
	
    protected Logger log = LoggerFactory.getLogger(this.getClass());


	@ResponseBody
	@RequestMapping(value = "/getKeywords", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getSuggestionKeyWords(@RequestParam("keyWord") String keyWord) {
		String resultKeyWord = "";
		// 解析接口返回值
		JSONObject json = audienceRestClient.getIaudiencesuggestion(keyWord);
		if (json.containsKey("cn_en")) {
			JSONArray array = json.getJSONArray("cn_en");
			List<String> row = new ArrayList<String>();
			for (int i = 0; i < array.size(); i++) {
				JSONObject result = array.getJSONObject(i);
				row.add(result.getString("key"));
			}
			resultKeyWord = JSONObject.toJSONString(row);
		}
		log.info(resultKeyWord);
		return resultKeyWord;
	}

    @RequestMapping(value = "/addCompetitor",method = RequestMethod.POST)
    public String addCompetitor(HttpServletRequest request,Model model){
        Integer maxCompetitorIndex = Integer.parseInt(request.getParameter("maxCompetitorIndex"));
        model.addAttribute("index", request.getParameter("index"));
        model.addAttribute("maxCompetitorIndex", maxCompetitorIndex);
        return "audiencePlan/competitor";
    }

    @RequestMapping(value = "/addProduct",method = RequestMethod.POST)
    public String addProduct(HttpServletRequest request, Model model){
        String categoryId = request.getParameter("categoryId");
        Integer maxProductIndex = Integer.parseInt(request.getParameter("maxProductIndex"));
        String dataId = request.getParameter("dataId");
        String type = request.getParameter("type");

        RequestContext requestContext = new RequestContext(request);
        Locale locale = requestContext.getLocale();
        if (StringUtils.isNotBlank(categoryId)) {
            List<String> selectCategoryNames = audiencePlanService.getSelectCategoryNames(Integer.valueOf(categoryId), locale);
            model.addAttribute("categoryNames",selectCategoryNames);
        }

        model.addAttribute("brandIndex",request.getParameter("brandIndex"));
        model.addAttribute("index", request.getParameter("index"));
        model.addAttribute("maxProductIndex", maxProductIndex);
        if (StringUtils.isNotBlank(dataId) && StringUtils.isNotBlank(type)){
            List<Product> productList = audiencePlanService.getProductList(Integer.valueOf(dataId),type);
            model.addAttribute("productList",productList);
            return "audiencePlan/importProduct";
        }
        return "audiencePlan/product";
    }

    @ResponseBody
    @RequestMapping(value = "/getSelectCategoryNames",method = RequestMethod.GET)
    public String getSelectCategoryNames(HttpServletRequest request){
        RequestContext requestContext = new RequestContext(request);
        Locale locale = requestContext.getLocale();
        String categoryId = request.getParameter("categoryId");
        List<String> selectCategoryNames = audiencePlanService.getSelectCategoryNames(Integer.valueOf(categoryId),locale);
        return JSON.toJSONString(selectCategoryNames);
    }


    @ResponseBody
    @RequestMapping(value = "/invokeChartApi",method = RequestMethod.GET)
    public String invokeChartApi(HttpServletRequest request){
        int id = Integer.valueOf(request.getParameter("audiencePlanId"));
        Map<String,Object> map = new HashMap();
        map.put("success",true);
        audienceReportDataService.invokeChartApi(id);
        return JSON.toJSONString(map);
    }

    @ResponseBody
    @RequestMapping(value = "/getReportData",method = RequestMethod.GET)
    public String getReportData(HttpServletRequest request){
        int audiencePlanId = Integer.valueOf(request.getParameter("audiencePlanId"));
        int typeValue = ReportDataTypeEnum.findByType(request.getParameter("type")).getValue();
        MixTrend mixTrend =  audienceReportDataService.getLastMonthMixThrendData(audiencePlanId,typeValue);
        System.out.println("=====mixThrendString:"+mixTrend.toString());
        return mixTrend.toString();
    }



	@ResponseBody
	@RequestMapping(value = "/getLbsAjax", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public JSONObject getLbsData(HttpServletRequest request, KeywordModel model) {
		String result = "";
		String parames = AudienceRestUtil.getLbsParame(model.getKeyword(), model.getRegion()[0]);
		result = audienceRestClient.getLbsComparesion(parames);

		LbsComosition lbsComposition = JSON.parseObject(result, LbsComosition.class);
		JSONObject returnObj = JSONObject.parseObject(lbsComposition.toString());
		return returnObj;

	}

	@RequestMapping("/getReportDataAjax")
	@ResponseBody
	public JSONObject getReportData(HttpServletRequest request, AnalysisModel model) {
		RequestContext requestContext = new RequestContext(request);
		Locale locale = requestContext.getLocale();
		ChartData returnData = new ChartData();
		 List<AudienceChart> returnResult =  new ArrayList<AudienceChart>();
		int id = model.getPlanId();
		int type = ReportDataTypeEnum.MARKET.getValue();
		List<AudienceChart> chartList = new ArrayList<AudienceChart>();
		// List<String> resultStrList = new ArrayList<String>();
		String result = "{}";
		if (id != 0) {
			AudienceAnalysisRecord record = audienceAnalysisRecordService.getAudienceAnalysisRecordByPlanId(id, type);
			if (record != null) {
				result = record.getResultJson1();
				ChartData data = JSON.parseObject(result, ChartData.class);
				for (AudienceChart chart : data.getResult()) {
					if ("market".equals(chart.getName())) {
						MarketChartData marketData = JSON.parseObject(chart.getData().toString(), MarketChartData.class) ;
						for (AudienceChart mChart : marketData.getResult()) {
							AudienceChartData subChart = JSON.parseObject(mChart.getData().toString(),AudienceChartData.class);
							if (Locale.ENGLISH.equals(locale)) {
								subChart.setInterest(subChart.getInterestEN());
								subChart.setRegions(subChart.getRegionsEN());
								
							} else {
								subChart.setInterest(subChart.getInterestZH());
								subChart.setRegions(subChart.getRegionsZH());
							}
							mChart.setData(subChart);
							chartList.add(mChart);
							
						}
						marketData.setResult(chartList);
						chart.setData(marketData);
					}
					returnResult.add(chart);
					
				}
				returnData.setResult(returnResult);
			}
		}

		JSONObject returnObj = JSONObject.parseObject(returnData.toString());

		return returnObj;

	}


	@ResponseBody
	@RequestMapping(value = "/getClients", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public JSONObject getClients(HttpServletRequest request, Model model) {
		UserModel user = (UserModel) model.asMap().get("user");
		Integer currentClientId = (Integer) model.asMap().get("clientId");
		Map<String,Object>  map = audiencePlanService.getClientsShow(user.getId(),currentClientId);
		JSONObject returnObj = JSONObject.parseObject(map.toString());
		return returnObj;

	}



}

