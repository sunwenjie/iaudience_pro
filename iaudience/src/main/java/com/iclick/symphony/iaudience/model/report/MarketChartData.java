package com.iclick.symphony.iaudience.model.report;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

public class MarketChartData {
	// 气泡图
	private List<BubbleChart> bubble;

	// 城市图
	private List<AudienceChart> result;

	// 城市图 报表的国际化
	private Map<String, String> geoMapping;

	// 用于保存返回的原始结果集
	private List<String> resultStrList;
	
	private Map<String, Long> top5brand;

	private Map<String, Long> top5products;

	public List<BubbleChart> getBubble() {
		return bubble;
	}

	public void setBubble(List<BubbleChart> bubble) {
		this.bubble = bubble;
	}

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

	public Map<String, Long> getTop5brand() {
		return top5brand;
	}

	public void setTop5brand(Map<String, Long> top5brand) {
		this.top5brand = top5brand;
	}

	public Map<String, Long> getTop5products() {
		return top5products;
	}

	public void setTop5products(Map<String, Long> top5products) {
		this.top5products = top5products;
	}
	
	public MarketChartData(){
		
	}
	
	@Override
	public String toString() {
		return JSON.toJSONString(this, SerializerFeature.DisableCircularReferenceDetect);
	}

}
