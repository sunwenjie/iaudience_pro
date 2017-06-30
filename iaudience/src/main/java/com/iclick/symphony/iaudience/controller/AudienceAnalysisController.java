package com.iclick.symphony.iaudience.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.iclick.symphony.iaudience.clients.AudienceRestClient;
import com.iclick.symphony.iaudience.constants.ReportDataTypeEnum;
import com.iclick.symphony.iaudience.entity.AudienceAnalysisRecord;
import com.iclick.symphony.iaudience.entity.AudiencePlan;
import com.iclick.symphony.iaudience.model.report.AudienceChart;
import com.iclick.symphony.iaudience.model.report.AudienceChartData;
import com.iclick.symphony.iaudience.model.view.BrandProductTrend;
import com.iclick.symphony.iaudience.service.AudienceAnalysisRecordService;
import com.iclick.symphony.iaudience.service.AudiencePlanService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/audienceAnalysis")
public class AudienceAnalysisController {

	@Value("${profile.name}")
	private String profileName;

	@Value("${profile.num}")
	private int profileNum;

	private static String MARKET_PAGE = "audienceAnalysis/marketAnalysis";
	private static String BRAND_PAGE = "audienceAnalysis/brandAnalysis";

	@Autowired
	private AudienceRestClient audienceRestClient;

	@Autowired
	private AudiencePlanService audiencePlanService;

	@Autowired
	private AudienceAnalysisRecordService audienceAnalysisRecordService;

	@RequestMapping(value = "/marketAnalysis", method = RequestMethod.GET)
	public String toMarketAnalysis(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		AudiencePlan audiencePlan = new AudiencePlan();
		if (StringUtils.isNotEmpty(id)) {
			audiencePlan = audiencePlanService.getAudiencePlanById(Integer.valueOf(id));
		} else {
			int clientId = 1001;
			List<AudiencePlan> planList = audiencePlanService.getAudiencePlanList(clientId);
			if (!planList.isEmpty()) {
				audiencePlan = audiencePlanService.getAudiencePlanList().get(0);
			}
		}
		StringBuilder keyWord = new StringBuilder();

		keyWord.append(audiencePlan.getMasterBrand().getName());
		if (StringUtils.isNoneBlank(audiencePlan.getMasterBrand().getKeyWords())) {
			keyWord.append(",");
			keyWord.append(audiencePlan.getMasterBrand().getKeyWords());
		}

		model.addAttribute("planName", audiencePlan.getName());
		model.addAttribute("planId", audiencePlan.getId());
		model.addAttribute("name", audiencePlan.getMasterBrand().getName());
		model.addAttribute("keyWord", keyWord.toString());
		return MARKET_PAGE;
	}


	@RequestMapping(value = "/brandAnalysis", method = RequestMethod.GET)
	public String toBrandAnalysis(@RequestParam(value = "audiencePlanId", defaultValue = "0") int audiencePlanId, Model model) {
		int clientId =1001;
		List<AudiencePlan> plans = audiencePlanService.getAudiencePlanList(clientId);
		if(plans.size() > 0 && audiencePlanId == 0)
			audiencePlanId = plans.get(0).getId();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(today);
		c.add(Calendar.MONTH, -1);
		String begin = format.format(c.getTime());
		String end = format.format(today);
		BrandProductTrend trend = audienceAnalysisRecordService.getBrandTrendFromDB(audiencePlanId, begin, end);
		AudienceAnalysisRecord record = audienceAnalysisRecordService.getRecordFromDB(audiencePlanId, ReportDataTypeEnum.BRAND.getValue());
		List<AudienceChart> charts = new ArrayList<>();
		//charts = (List<AudienceChart>)JSON.parseObject(record.getResultJson1(), charts.getClass());
		//charts = (List<AudienceChart>)JSONObject.parseArray(record.getResultJson1(), charts.getClass());(AudienceChart)
		JSONArray jsonArray = JSONArray.parseArray(record.getResultJson1());
		for(int i = 0; i < jsonArray.size(); i++){
			charts.add(JSONObject.parseObject(JSONObject.toJSONString(jsonArray.get(i)), AudienceChart.class));
		}
		
		//List<AudienceChart> charts = audienceService.brandAnalysis(planId);
		AudienceChart brandChart = charts.get(0);
		AudienceChartData chartData = JSONObject.parseObject(JSONObject.toJSONString(brandChart.getData()), AudienceChartData.class);
		model.addAttribute("audiencePlans", plans);
		model.addAttribute("audiencePlanId", audiencePlanId);
		model.addAttribute("keyWords", chartData.getCloud_tag());
		model.addAttribute("trend", trend);
		model.addAttribute("brandResult", brandChart);
		model.addAttribute("productResults", charts.subList(1, charts.size()));
		model.addAttribute("period", begin.replaceAll("-", "/") + " - " + end.replaceAll("-", "/"));
		return BRAND_PAGE;
	}

	private void doSearch(Model model) {

		String[] provinces = null;
		String[] citys = null;
		String[] genders = null;
		String[] ages = null;
		String[] devices = null;
		String[] keywords = null;
		String[] interests = null;
		String[] rawIntersets = null;
		String[] aggss = null;
		// JSONObject brandJSONObject=
		// AudienceRestUtil.getAudienceJSON(provinces, citys, genders, ages,
		// devices, keywords, interests, rawIntersets, aggss);

		// JSONObject resultJSONObject =
		// audienceRestClient.getIaudienceComparesion(brandJSONObject);
		// 解析接口返回值

	}

	private boolean doCheck(Model model) {
		model.addAttribute("otherArray", "aaaa");
		return true;
	}
}
