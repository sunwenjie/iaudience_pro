package com.iclick.symphony.iaudience.entity;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by wenjie.sun on 2017/5/17.
 */
@Entity
@Table(name = "iau_audience_plan")
@NamedQuery(name = "AudiencePlan.findAll", query = "SELECT i FROM AudiencePlan  i")
public class AudiencePlan implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "client_id")
    private int clientId;

    @Column(name = "name")
    private String name;

    @Column(name = "category_id")
    private int categoryId;

    @OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.EAGER, mappedBy = "audiencePlan")
    private Set<Brand> brands;

    @OneToOne(cascade = { CascadeType.ALL }, fetch = FetchType.EAGER)
    @JoinColumn(name = "advanced_setting_id",referencedColumnName = "id")
    private AdvancedSetting advancedSetting;

    @Column(name = "is_deleted")
    private boolean isDeleted;

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

    @Column(name = "analyse_status")
    private int analyseStatus;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }



    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Set<Brand> getBrands() {
        return brands;
    }

    public void setBrands(Set<Brand> brands) {
        this.brands = brands;
    }

    public AdvancedSetting getAdvancedSetting() {
        return advancedSetting;
    }

    public void setAdvancedSetting(AdvancedSetting advancedSetting) {
        this.advancedSetting = advancedSetting;
    }

    public boolean getDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean deleted) {
		this.isDeleted = deleted;
	}

	public int getCreateBy() {
        return createBy;
    }

    public void setCreateBy(int createBy) {
        this.createBy = createBy;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
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

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public int getAnalyseStatus() {
        return analyseStatus;
    }

    public void setAnalyseStatus(int analyseStatus) {
        this.analyseStatus = analyseStatus;
    }

    public Brand addBrand(Brand brand) {
        if (getBrands() == null) {
            setBrands(new HashSet<>());
        }
        getBrands().add(brand);
        brand.setAudiencePlan(this);

        return brand;
    }

    public Brand removeBrand(Brand brand) {
        getBrands().remove(brand);
        brand.setAudiencePlan(null);
        return brand;
    }
    
    public Brand getMasterBrand(){
    	for(Brand brand : this.brands){
    		if(!brand.isCompetitor())
    			return brand;
    	}
    	return null;
    }

}

