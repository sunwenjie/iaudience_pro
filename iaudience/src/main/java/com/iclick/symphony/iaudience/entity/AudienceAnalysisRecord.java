package com.iclick.symphony.iaudience.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "iau_analysis_record")
public class AudienceAnalysisRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "plan_id", nullable = false)
    private int planId;

    @Column(name = "plan_name", nullable = false)
    private String planName;

    @Column(name = "result_json_1")
    private String resultJson1;

    @Column(name = "result_json_2")
    private String resultJson2;

    @Column(name = "result_json_3")
    private String resultJson3;
    
    @Column(name = "result_json_4")
    private String resultJson4;
    
    @Column(name = "result_json_5")
    private String resultJson5;
    
    @Column(name = "create_by")
    private int createBy;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_time")
    private Date createTime;

    @Column(name = "update_by")
    private int updateBy;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "update_time")
    private Date updateTime;

    @Column(name = "type")
    private int type;
    

    public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

public int getPlanId() {
	return planId;
}

public void setPlanId(int planId) {
	this.planId = planId;
}

public String getPlanName() {
	return planName;
}

public void setPlanName(String planName) {
	this.planName = planName;
}

public String getResultJson1() {
	return resultJson1;
}

public void setResultJson1(String resultJson1) {
	this.resultJson1 = resultJson1;
}

public String getResultJson2() {
	return resultJson2;
}

public void setResultJson2(String resultJson2) {
	this.resultJson2 = resultJson2;
}

public String getResultJson3() {
	return resultJson3;
}

public void setResultJson3(String resultJson3) {
	this.resultJson3 = resultJson3;
}

public String getResultJson4() {
	return resultJson4;
}

public void setResultJson4(String resultJson4) {
	this.resultJson4 = resultJson4;
}

public String getResultJson5() {
	return resultJson5;
}

public void setResultJson5(String resultJson5) {
	this.resultJson5 = resultJson5;
}

public int getCreateBy() {
	return createBy;
}

public void setCreateBy(int createBy) {
	this.createBy = createBy;
}

public Date getCreateTime() {
	return createTime;
}

public void setCreateTime(Date createTime) {
	this.createTime = createTime;
}

public int getUpdateBy() {
	return updateBy;
}

public void setUpdateBy(int updateBy) {
	this.updateBy = updateBy;
}

public Date getUpdateTime() {
	return updateTime;
}

public void setUpdateTime(Date updateTime) {
	this.updateTime = updateTime;
}

  
}
