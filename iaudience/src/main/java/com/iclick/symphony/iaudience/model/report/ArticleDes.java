package com.iclick.symphony.iaudience.model.report;

import com.alibaba.fastjson.JSON;

public class ArticleDes {
    String date;
    String index;
    String title;
    String content;
    String pic;
    String url;
   

	public String getDate() {
		return date;
	}



	public void setDate(String date) {
		this.date = date;
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
}
