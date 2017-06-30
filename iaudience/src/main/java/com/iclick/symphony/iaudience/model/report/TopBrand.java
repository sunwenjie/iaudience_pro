package com.iclick.symphony.iaudience.model.report;

import java.util.List;

import com.alibaba.fastjson.JSON;

public class TopBrand {
   List<ArticleDes> articles;
   
	public List<ArticleDes> getArticles() {
	return articles;
}
    private String date;
    private String index;
    private String title;
    private String content;
    private String pic;
    private double score;
   

	public double getScore() {
		return score;
	}



	public void setScore(double score) {
		this.score = score;
	}


	public String getIndex() {
		return index;
	}



	public void setIndex(String index) {
		this.index = index;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



public void setArticles(List<ArticleDes> articles) {
	this.articles = articles;
}


	public String getDate() {
		return date;
	}



	public void setDate(String date) {
		this.date = date;
	}




	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public String getPic() {
		return pic;
	}



	public void setPic(String pic) {
		this.pic = pic;
	}



	@Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}
