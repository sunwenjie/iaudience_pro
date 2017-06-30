package com.iclick.symphony.iaudience.model.remote;

import com.alibaba.fastjson.JSON;
import com.iclick.symphony.iaudience.model.remote.Meta;
import com.iclick.symphony.iaudience.model.remote.Site;

public class Article  {
	private String createTime;
	private Double score;
	private String summary;
	private String title;
	private String topImg;
	private String url;
	private Meta meta;
	private Site site;
	
	public String getCreateTime() {
		return createTime;
	}



	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}



	public Double getScore() {
		return score;
	}



	public void setScore(Double score) {
		this.score = score;
	}



	public Meta getMeta() {
		return meta;
	}



	public void setMeta(Meta meta) {
		this.meta = meta;
	}



	public Site getSite() {
		return site;
	}



	public void setSite(Site site) {
		this.site = site;
	}


	public String getSummary() {
		return summary;
	}


	public void setSummary(String summary) {
		this.summary = summary;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getTopImg() {
		return topImg;
	}



	public void setTopImg(String topImg) {
		this.topImg = topImg;
	}



	public String getUrl() {
		return url;
	}



	public void setUrl(String url) {
		this.url = url;
	}
	
	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}


	public Article() {
		super();
	}
}
