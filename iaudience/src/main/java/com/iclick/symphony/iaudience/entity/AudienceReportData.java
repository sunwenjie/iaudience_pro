package com.iclick.symphony.iaudience.entity;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by wenjie.sun on 2017/5/18.
 */
@Entity
@Table(name = "iau_audience_report_data")
@NamedQuery(name = "AudienceReportData.findAll", query = "SELECT i FROM AudienceReportData  i")
public class AudienceReportData implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "type")
    private int type;

    @Column(name = "ref_id")
    private int refId;

    @Column(name = "audience_plan_id")
    private int audiencePlanId;

    @Column(name = "total")
    private Long total;

    @Column(name = "date")
    private String date;
    
    @Column(name = "ref_name")
    private String refName;
    
    @Column(name = "create_time")
    private Date createTime;

	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getRefId() {
        return refId;
    }

    public void setRefId(int refId) {
        this.refId = refId;
    }


    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
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

    public int getAudiencePlanId() {
        return audiencePlanId;
    }

    public void setAudiencePlanId(int audiencePlanId) {
        this.audiencePlanId = audiencePlanId;
    }

    public String getRefName() {
		return refName;
	}

	public void setRefName(String refName) {
		this.refName = refName;
	}

	@Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}
