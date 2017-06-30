package com.iclick.symphony.iaudience.model.remote;

import java.util.List;

public class Site {
	
	private String brief;
	private List<String> classify;
	private String name;
	private String rank;
	
	public String getBrief() {
		return brief;
	}
	public void setBrief(String brief) {
		this.brief = brief;
	}
	public List<String> getClassify() {
		return classify;
	}
	public void setClassify(List<String> classify) {
		this.classify = classify;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}

	public Site() {
		
	}

}
