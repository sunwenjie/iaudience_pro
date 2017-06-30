package com.iclick.symphony.iaudience.entity;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.iclick.symphony.iaudience.model.report.ArticleDes;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by wenjie.sun on 2017/6/21.
 */
@Entity
@Table(name = "iau_audience_news")
public class AudienceNews {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "audience_plan_id")
    private int audiencePlanId;

    @Column(name = "type")
    private int type;

    @Column(name = "score")
    private double score;

    @Column(name = "summary")
    private String summary;

    @Column(name = "title")
    private String title;

    @Column(name = "topImg")
    private String topImg;

    @Column(name = "url")
    private String url;

    @Column(name = "meta")
    private String meta;

    @Column(name = "date")
    private String date;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;
    
    @Column(name = "index_sort")
    private String index_sort;
    
    @Column(name = "content")
    private String content;
    
    @Column(name = "name")
    private String name;

    public String getIndex_sort() {
		return index_sort;
	}

	public void setIndex_sort(String index_sort) {
		this.index_sort = index_sort;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getAudiencePlanId() {
        return audiencePlanId;
    }

    public void setAudiencePlanId(int audiencePlanId) {
        this.audiencePlanId = audiencePlanId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
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

    public String getMeta() {
        return meta;
    }

    public void setMeta(String meta) {
        this.meta = meta;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }
    
    public ArticleDes news2Article(){
    	ArticleDes art = new ArticleDes();
    	art.setContent(this.content);
    	art.setDate(date);
    	art.setIndex(index_sort);
    	art.setPic(topImg);
    	art.setTitle(title);
    	art.setUrl(url);
    	return art;
    }
}
