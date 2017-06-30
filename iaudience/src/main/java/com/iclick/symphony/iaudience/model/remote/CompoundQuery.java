package com.iclick.symphony.iaudience.model.remote;

import com.alibaba.fastjson.JSON;

public class CompoundQuery {
	private ParamQuery query;

	public ParamQuery getQuery() {
		return query;
	}

	public void setQuery(ParamQuery query) {
		this.query = query;
	}

	public CompoundQuery() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
}
