package com.iclick.symphony.iaudience.model.remote;

import com.alibaba.fastjson.JSON;

public class ComparisonComposition {
	private AudienceComposition brand;
	private AudienceComposition competitor;
	private AudienceComposition brand_competitor;
	
	public AudienceComposition getBrand() {
		return brand;
	}
	public void setBrand(AudienceComposition brand) {
		this.brand = brand;
	}
	public AudienceComposition getCompetitor() {
		return competitor;
	}
	public void setCompetitor(AudienceComposition competitor) {
		this.competitor = competitor;
	}
	public AudienceComposition getBrand_competitor() {
		return brand_competitor;
	}
	public void setBrand_competitor(AudienceComposition brand_competitor) {
		this.brand_competitor = brand_competitor;
	}
	
	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
	
}
