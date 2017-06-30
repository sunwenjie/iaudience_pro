package com.iclick.symphony.iaudience.model.remote;

import java.util.List;

import com.alibaba.fastjson.JSON;

public class BrandKeywordsComparison {
	private List<String> aggs_fields;
	private AudienceAttributes brand;
	private AudienceAttributes competitor;
	
	public List<String> getAggs_fields() {
		return aggs_fields;
	}
	public void setAggs_fields(List<String> aggs_fields) {
		this.aggs_fields = aggs_fields;
	}
	public AudienceAttributes getBrand() {
		return brand;
	}
	public void setBrand(AudienceAttributes brand) {
		this.brand = brand;
	}
	public AudienceAttributes getCompetitor() {
		return competitor;
	}
	public void setCompetitor(AudienceAttributes competitor) {
		this.competitor = competitor;
	}
	
	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
}
