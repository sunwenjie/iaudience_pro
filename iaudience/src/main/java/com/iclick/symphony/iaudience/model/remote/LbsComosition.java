package com.iclick.symphony.iaudience.model.remote;

import java.util.List;

import com.alibaba.fastjson.JSON;

public class LbsComosition {
	private List<District> district;
	private List<Street> street;
	private List<Poi> poi;
	private Total total ;
	public LbsComosition() {

	}

	public List<Street> getStreet() {
		return street;
	}

	public void setStreet(List<Street> street) {
		this.street = street;
	}

	public List<Poi> getPoi() {
		return poi;
	}

	public void setPoi(List<Poi> poi) {
		this.poi = poi;
	}

	public Total getTotal() {
		return total;
	}

	public void setTotal(Total total) {
		this.total = total;
	}

	public List<District> getDistrict() {
		return district;
	}

	public void setDistrict(List<District> district) {
		this.district = district;
	}

	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
	
}
