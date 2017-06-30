package com.iclick.symphony.iaudience.model.common;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.iclick.symphony.iaudience.util.CommonModelUtil;

public class AnalysisModel {
	private String startDay;
	private Long allMarket;
	
	private String endDay;
	
	private boolean isCompetitor;

	private String gender;
	private String mainBrandName;

	public String getMainBrandName() {
		return mainBrandName;
	}

	public void setMainBrandName(String mainBrandName) {
		this.mainBrandName = mainBrandName;
	}

	private String[] region;

    private String[] ageGroup;

    private String[] keyword;
    private String[] interest;

    private String id;
    
    private String productId;
    
    private int brandId;
    
    public Long getAllMarket() {
		return allMarket;
	}

	public void setAllMarket(Long allMarket) {
		this.allMarket = allMarket;
	}

    public boolean isCompetitor() {
		return isCompetitor;
	}

	public void setCompetitor(boolean isCompetitor) {
		this.isCompetitor = isCompetitor;
	}
	
    public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public int getBrandId() {
		return brandId;
	}

	public void setBrandId(int brandId) {
		this.brandId = brandId;
	}

	private int planId;
    
    List<String> otherBrandList = new ArrayList<String>();
    
    public List<String> getOtherBrandList() {
		return otherBrandList;
	}

	public void setOtherBrandList(List<String> otherBrandList) {
		this.otherBrandList = otherBrandList;
	}


    public String getStartDay() {
		return startDay;
	}

	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}

	public String getEndDay() {
		return endDay;
	}

	public void setEndDay(String endDay) {
		this.endDay = endDay;
	}

    public int getPlanId() {
		return planId;
	}

	public void setPlanId(int planId) {
		this.planId = planId;
	}

	private String name;

    private String regionStr;

    private String ageGroupStr;

    private Integer userId;
    
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUrlLocation() {
        return urlLocation;
    }

    public void setUrlLocation(String urlLocation) {
        this.urlLocation = urlLocation;
    }

    private String keywordStr;

    private String errorMsg;

    private String resultJson;
    private String urlLocation;

    public String getResultJson() {
        return resultJson;
    }

    public void setResultJson(String resultJson) {
        this.resultJson = resultJson;
    }

    public String[] getKeyword() {
        return keyword;
    }

    public void setKeyword(String[] keyword) {
        this.keyword = keyword;
    }

    public String getKeywordStr() {
        return keywordStr;
    }

    public void setKeywordStr(String keywordStr) {
        this.keywordStr = keywordStr;
        this.keyword = CommonModelUtil.strToArray(keywordStr);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRegionStr() {
        return regionStr;
    }

    public void setRegionStr(String regionStr) {
        this.regionStr = regionStr;
        this.region = CommonModelUtil.strToArray(regionStr);
    }

    public String getAgeGroupStr() {
        return ageGroupStr;
    }

    public void setAgeGroupStr(String ageGroupStr) {
        this.ageGroupStr = ageGroupStr;
        this.ageGroup = CommonModelUtil.strToArray(ageGroupStr);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String[] getRegion() {
        return region;
    }

    public void setRegion(String[] region) {
        this.region = region;
        this.regionStr = CommonModelUtil.arrayToStr(region);
    }

    public String[] getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(String[] ageGroup) {
        this.ageGroup = ageGroup;
        this.ageGroupStr = CommonModelUtil.arrayToStr(ageGroup);
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public String[] getInterest() {
		return interest;
	}

	public void setInterest(String[] interest) {
		this.interest = interest;
	}

	@Override
    public String toString() {
        return JSON.toJSONString(this);
    }

}
