package com.iclick.symphony.iaudience.model.remote;

import com.alibaba.fastjson.JSON;

import java.util.List;

public class ArticleComposition {
	List<Article> articles;
	private String query;
	
	public ArticleComposition() {
	}


	public List<Article> getArticles() {
		return articles;
	}


	public void setArticles(List<Article> articles) {
		this.articles = articles;
	}


	public String getQuery() {
		return query;
	}


	public void setQuery(String query) {
		this.query = query;
	}


	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
}
