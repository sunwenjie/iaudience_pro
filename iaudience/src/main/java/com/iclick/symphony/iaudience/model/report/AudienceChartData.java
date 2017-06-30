package com.iclick.symphony.iaudience.model.report;

import com.alibaba.fastjson.JSON;

import java.util.List;
import java.util.Map;

public class AudienceChartData {

	private Map<String, Long> age_group;

	private Long audience;

	private Long allMarket;
	
	private Map<String, Long> product_share;
	
	private Map<String, Long> top5brand;
	
	private Map<String, Long> top5products;
	
	private Map<String, Long> market_share;

	private Map<String, Long> device;

	private Map<String, Long> gender;

	private Map<String, InterestCell> interest;
	
	private Map<String, InterestCell> interestEN;

	private Map<String, InterestCell> interestZH;

	private List<BaseCell> regions;
	
	private List<BaseCell> regionsEN;

	private List<BaseCell> regionsZH;

	private List<BaseCell> regionAll;

//	// 气泡图
//	private List<BubbleChart> bubble;
	
	public Map<String, InterestCell> getInterestEN() {
		return interestEN;
	}
	public void setInterestEN(Map<String, InterestCell> interestEN) {
		this.interestEN = interestEN;
	}
	public Map<String, InterestCell> getInterestZH() {
		return interestZH;
	}
	public void setInterestZH(Map<String, InterestCell> interestZH) {
		this.interestZH = interestZH;
	}
	public List<BaseCell> getRegionsEN() {
		return regionsEN;
	}
	public void setRegionsEN(List<BaseCell> regionsEN) {
		this.regionsEN = regionsEN;
	}
	public List<BaseCell> getRegionsZH() {
		return regionsZH;
	}
	public void setRegionsZH(List<BaseCell> regionsZH) {
		this.regionsZH = regionsZH;
	}

	private List<CloudTag> cloud_tag;
	
	private MixTrend  mixTrend;
	
	public MixTrend getMixTrend() {
		return mixTrend;
	}
	public void setMixTrend(MixTrend mixTrend) {
		this.mixTrend = mixTrend;
	}
	public List<CloudTag> getCloud_tag() {
		return cloud_tag;
	}
	public void setCloud_tag(List<CloudTag> cloud_tag) {
		this.cloud_tag = cloud_tag;
	}
//	public List<BubbleChart> getBubble() {
//		return bubble;
//	}
//	public void setBubble(List<BubbleChart> bubble) {
//		this.bubble = bubble;
//	}

	public Map<String, InterestCell> getInterest() {
		return interest;
	}
	public void setInterest(Map<String, InterestCell> interest) {
		this.interest = interest;
	}
	
	public Long getAllMarket() {
		return allMarket;
	}

	public void setAllMarket(Long allMarket) {
		this.allMarket = allMarket;
	}

	public Map<String, Long> getProduct_share() {
		return product_share;
	}

	public void setProduct_share(Map<String, Long> product_share) {
		this.product_share = product_share;
	}


	public Map<String, Long> getMarket_share() {
		return market_share;
	}

	public void setMarket_share(Map<String, Long> market_share) {
		this.market_share = market_share;
	}


	public List<BaseCell> getRegionAll() {
		return regionAll;
	}

	public void setRegionAll(List<BaseCell> regionAll) {
		this.regionAll = regionAll;
	}

	public Map<String, Long> getAge_group() {
		return age_group;
	}

	public void setAge_group(Map<String, Long> age_group) {
		this.age_group = age_group;
	}

	public Long getAudience() {
		return audience;
	}

	public void setAudience(Long audience) {
		this.audience = audience;
	}

	public Map<String, Long> getDevice() {
		return device;
	}

	public void setDevice(Map<String, Long> device) {
		this.device = device;
	}

	public Map<String, Long> getGender() {
		return gender;
	}

	public void setGender(Map<String, Long> gender) {
		this.gender = gender;
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

	public List<BaseCell> getRegions() {
		return regions;
	}
	public void setRegions(List<BaseCell> regions) {
		this.regions = regions;
	}
	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
}
