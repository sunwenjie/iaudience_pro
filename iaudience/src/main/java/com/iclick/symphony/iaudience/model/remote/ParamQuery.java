package com.iclick.symphony.iaudience.model.remote;

import java.util.List;

import com.alibaba.fastjson.JSON;

public class ParamQuery {


	private List<AudienceAttributes> must;
	private List<AudienceAttributes> must_not;
	private List<AudienceAttributes> should;

	public List<AudienceAttributes> getMust() {
		return must;
	}

	public void setMust(List<AudienceAttributes> must) {
		this.must = must;
	}

	public List<AudienceAttributes> getMust_not() {
		return must_not;
	}

	public void setMust_not(List<AudienceAttributes> must_not) {
		this.must_not = must_not;
	}

	public List<AudienceAttributes> getShould() {
		return should;
	}

	public void setShould(List<AudienceAttributes> should) {
		this.should = should;
	}


	public ParamQuery() {}


	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
}
