package com.iclick.symphony.iaudience.model.view;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.iclick.symphony.iaudience.model.report.Market;
import com.iclick.symphony.iaudience.model.report.TopBrand;

public class BrandProductTrend {
	private List<Market> brandAudience;
	private List<Market> brandShare;
	private Map<Integer, List<Market>> top5ProductsAudience;
	private List<Market> top5ProductsAudienceList;
	private List<TopBrand> topBrandList;
	private Long marketAudience;
	

	private List<Market> potentialWeek = new ArrayList<>();
	private List<Market> brandWeek = new ArrayList<>();
	private List<Market> brandLine = new ArrayList<>();
	
	public List<Market> getPotentialWeek() {
		return potentialWeek;
	}
	public void setPotentialWeek(List<Market> potentialWeek) {
		this.potentialWeek = potentialWeek;
	}
	public List<Market> getBrandWeek() {
		return brandWeek;
	}
	public void setBrandWeek(List<Market> brandWeek) {
		this.brandWeek = brandWeek;
	}
	public List<Market> getBrandLine() {
		return brandLine;
	}
	public void setBrandLine(List<Market> brandLine) {
		this.brandLine = brandLine;
	}
	public Long getMarketAudience() {
		return marketAudience;
	}
	public void setMarketAudience(Long marketAudience) {
		this.marketAudience = marketAudience;
	}
	public List<Market> getTop5ProductsAudienceList() {
		return top5ProductsAudienceList;
	}
	public void setTop5ProductsAudienceList(List<Market> top5ProductsAudienceList) {
		this.top5ProductsAudienceList = top5ProductsAudienceList;
	}
	public List<TopBrand> getTopBrandList() {
		return topBrandList;
	}
	public void setTopBrandList(List<TopBrand> topBrandList) {
		this.topBrandList = topBrandList;
	}
	public List<Market> getBrandAudience() {
		return brandAudience;
	}
	public void setBrandAudience(List<Market> brandAudience) {
		this.brandAudience = brandAudience;
	}
	public List<Market> getBrandShare() {
		return brandShare;
	}
	public void setBrandShare(List<Market> brandShare) {
		this.brandShare = brandShare;
	}
	public Map<Integer, List<Market>> getTop5ProductsAudience() {
		return top5ProductsAudience;
	}
	public void setTop5ProductsAudience(Map<Integer, List<Market>> top5ProductsAudience) {
		this.top5ProductsAudience = top5ProductsAudience;
	}
}
