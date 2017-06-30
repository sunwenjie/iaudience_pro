package com.iclick.symphony.iaudience.model.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

public class ChartData {

	// 城市图
	private List<AudienceChart> result;

	// 城市图 报表的国际化
	private Map<String, String> geoMapping;

	// 用于保存返回的原始结果集
	private List<String> resultStrList;

	public List<String> getResultStrList() {
		return resultStrList;
	}

	public void setResultStrList(List<String> resultStrList) {
		this.resultStrList = resultStrList;
	}

	public Map<String, String> getGeoMapping() {
		return geoMapping;
	}

	public void setGeoMapping(Map<String, String> geoMapping) {
		this.geoMapping = geoMapping;
	}

	public List<AudienceChart> getResult() {
		return result;
	}

	public void setResult(List<AudienceChart> result) {
		this.result = result;
	}

	@Override
	public String toString() {
		return JSON.toJSONString(this, SerializerFeature.DisableCircularReferenceDetect);
	}

	public static void main(String[] args) {
		ChartData chartData = new ChartData();
		chartData.doTest();
	}

	public String doTest() {

		ChartData chartData = new ChartData();
		List<AudienceChart> result = new ArrayList<>();
		List<BubbleChart> bubbleList = new ArrayList<BubbleChart>();
		BubbleChart bubble = new BubbleChart();
		int[] sets = { 0 };
		bubble.setLabel("Estee Lauder");
		bubble.setSets(sets);
		bubble.setSize(37348L);
		bubble.setRanking(0);
		bubbleList.add(bubble);
		// bubble.setOverlap(overlap);
		AudienceChart marketChart = new AudienceChart();

		// AudienceChartData data = new AudienceChartData();
		Map<String, Long> age_group = new HashMap<>();
		age_group.put("18-24", 100L);
		age_group.put("25-34", 130L);

		Map<String, Long> device = new HashMap<>();
		device.put("Mobile", 867L);
		device.put("PC", 1246L);
		device.put("Tablet", 174L);

		Map<String, Long> gender = new HashMap<>();
		gender.put("female", 22L);
		gender.put("male", 37L);

		Map<String, InterestCell> interest = new HashMap();
		InterestCell cell0 = new InterestCell();
		InterestCell cell1 = new InterestCell();
		InterestCell cell2 = new InterestCell();
		InterestCell cell3 = new InterestCell();
		InterestCell cell4 = new InterestCell();
		cell0.setName("Arts & Entertainment");
		cell0.setValue(21L);
		cell1.setName("Cooking & Recipes");
		cell1.setValue(21L);
		cell2.setName("Female Fashion");
		cell2.setValue(21L);
		cell3.setName("Restaurants");
		cell3.setValue(21L);
		cell4.setName("Food & Drink");
		cell4.setValue(21L);
		List<String> sub = new ArrayList<String>();
		sub.add("Arts");
		sub.add("aaaaa");
		cell0.setSub(sub);
		cell1.setSub(sub);
		cell2.setSub(sub);
		cell3.setSub(sub);
		cell4.setSub(sub);
		interest.put("Arts & Entertainment", cell0);
		interest.put("Cooking & Recipes", cell1);
		interest.put("Female Fashion", cell2);
		interest.put("Restaurants", cell3);
		interest.put("Food & Drink", cell4);

		Map<String, Long> product_share = new HashMap<>();
		product_share.put("Stay-in-Place Makeup", 3333L);
		product_share.put("Prefectionist", 12246L);
		product_share.put("Advanced Night Cream", 222L);
		product_share.put("Resilience Lift", 10000L);

		Map<String, Long> top5brand = new HashMap<>();
		top5brand.put("a3", 3341L);
		top5brand.put("a2", 3241L);
		top5brand.put("a4", 3141L);
		top5brand.put("v1", 3041L);
		top5brand.put("v2", 2541L);

		Map<String, Long> top5products = new HashMap<>();
		top5products.put("a3", 3341L);
		top5products.put("a2", 3241L);
		top5products.put("a4", 3141L);
		top5products.put("v1", 3041L);
		top5products.put("v2", 2541L);

		Map<String, Long> market_share = new HashMap<>();
		market_share.put("market", 666L);
		market_share.put("market_show", 333L);

		List<BaseCell> regions = new ArrayList<BaseCell>();
		BaseCell b1 = new BaseCell();
		b1.setName("北京");
		b1.setValue(123L);
		regions.add(b1);
		BaseCell b2 = new BaseCell();
		b2.setName("天津");
		b2.setValue(123L);
		regions.add(b2);
		BaseCell b3 = new BaseCell();
		b3.setName("上海");
		b3.setValue(123L);
		regions.add(b3);
		BaseCell b4 = new BaseCell();
		b4.setName("重庆");
		b4.setValue(123L);
		regions.add(b4);

		BaseCell b5 = new BaseCell();
		b5.setName("河北");
		b5.setValue(123L);
		regions.add(b5);
		BaseCell b6 = new BaseCell();
		b6.setName("河南");
		b6.setValue(123L);
		regions.add(b6);
		BaseCell b7 = new BaseCell();
		b7.setName("云南");
		b7.setValue(123L);
		regions.add(b7);

		BaseCell b8 = new BaseCell();
		b8.setName("辽宁");
		b8.setValue(33L);
		regions.add(b8);

		BaseCell b9 = new BaseCell();
		b9.setName("其他");
		b9.setValue(55L);
		regions.add(b9);

		MarketChartData Mdata = new MarketChartData();
		// Mdata.setResult(result);;
		List<AudienceChart> marketResult = new ArrayList<>();
		AudienceChart subMarket = new AudienceChart();
		AudienceChartData marketCharData = new AudienceChartData();

		//
		marketCharData.setAge_group(age_group);
		//
		marketCharData.setAudience(11234L);
		// allMarket
		marketCharData.setAllMarket(34567L);

		marketCharData.setDevice(device);

		marketCharData.setGender(gender);
		// product_share
		marketCharData.setProduct_share(product_share);

		// market_share
		marketCharData.setMarket_share(market_share);
		// interest
		// regionsjj
		marketCharData.setInterestEN(interest);
		// regions
		marketCharData.setRegionsZH(regions);

		// bubble
		Mdata.setBubble(bubbleList);
		// top5brand
		Mdata.setTop5brand(top5brand);
		// top5products
		Mdata.setTop5products(top5products);
		
		subMarket.setData(marketCharData);
		subMarket.setId("all");
		subMarket.setType("allBrand");

		marketResult.add(subMarket);

		Mdata.setResult(marketResult);

		marketChart.setId("1");
		marketChart.setName("market");
		marketChart.setType("1");
		marketChart.setData(Mdata);

		AudienceChart shareChart = new AudienceChart();
		AudienceChartData shareData = new AudienceChartData();
		shareChart.setId("2");
		shareChart.setName("share");
		shareChart.setType("1");

		MixTrend mix = new MixTrend();
		mix.setDataPeriod("Period: 2017/05/20 - 2017/06/19");
		Map<String, List<Market>> result1 = new HashMap<String, List<Market>>();
		Market market = new Market();
		market.setDate("2017-05-20");
		market.setName("Market Audience");
		market.setValue("11");
		Market market1 = new Market();
		market1.setDate("2017-05-21");
		market1.setName("Market Audience");
		market1.setValue("21");

		Market marketShare = new Market();
		marketShare.setDate("2017-05-20");
		marketShare.setName("Market Share");
		marketShare.setValue("91");
		Market marketShare1 = new Market();
		marketShare1.setDate("2017-05-20");
		marketShare1.setName("Market Share");
		marketShare1.setValue("91");

		List<Market> marketA = new ArrayList<Market>();
		marketA.add(market);
		marketA.add(market1);

		List<Market> marketS = new ArrayList<Market>();
		marketS.add(marketShare);
		marketS.add(marketShare1);
		result1.put("Market Audience", marketA);
		result1.put("Market Share", marketS);
		mix.setResult(result1);

		List<TopBrand> topBrands = new ArrayList<TopBrand>();
		TopBrand brand1 = new TopBrand();
		ArticleDes article = new ArticleDes();
		article.setDate("2017/05/21 12:15");
		article.setIndex("A");
		article.setTitle("How to Build a Beauty Brand in the Digital Age");
		article.setContent("The Business of Fashion");
		article.setPic("");

		List<ArticleDes> articles = new ArrayList<ArticleDes>();
		articles.add(article);

		brand1.setDate("2017/05/21");
		brand1.setArticles(articles);

		// TopBrand brand1 = new TopBrand();
		// TopBrand brand1 = new TopBrand();
		// TopBrand brand1 = new TopBrand();
		// TopBrand brand1 = new TopBrand();
		// TopBrand brand1 = new TopBrand();
		// TopBrand brand1 = new TopBrand();
		// TopBrand brand1 = new TopBrand();
		topBrands.add(brand1);
		mix.setTopBrands(topBrands);
		List<CloudTag> cloud_tags = new ArrayList<CloudTag>();
		CloudTag tag = new CloudTag();
		tag.setText("Variety & Entertainment");
		tag.setWeight(20);
		cloud_tags.add(tag);

		CloudTag tag1 = new CloudTag();
		tag1.setText("Psychology");
		tag1.setWeight(50);
		cloud_tags.add(tag1);

		shareData.setMixTrend(mix);
		shareData.setProduct_share(product_share);
		shareData.setCloud_tag(cloud_tags);
		shareData.setAudience(11204L);
		shareData.setAllMarket(223490L);
		shareData.setProduct_share(product_share);

		shareChart.setData(shareData);

		result.add(marketChart);
		result.add(shareChart);

		chartData.setResult(result);
		System.out.println(chartData.toString());
		return chartData.toString();

	}
}
