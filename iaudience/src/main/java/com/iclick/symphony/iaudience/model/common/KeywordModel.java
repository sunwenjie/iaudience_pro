package com.iclick.symphony.iaudience.model.common;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.iclick.symphony.iaudience.util.CommonModelUtil;
import com.iclick.symphony.iaudience.util.Constant;

public class KeywordModel {

    private List<Option> regionList;

    private List<Option> ageGroupList;

    private String gender;

    private String regionLab = Constant.RADIO_OFF;

    private String[] region;

    private String ageGroupLab = Constant.RADIO_OFF;

    private String[] ageGroup;

    private String[] keyword;

    private String id;

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

    public List<Option> getRegionList() {
        return regionList;
    }

    public void setRegionList(List<Option> regionList) {
        this.regionList = regionList;
    }

    public List<Option> getAgeGroupList() {
        return ageGroupList;
    }

    public void setAgeGroupList(List<Option> ageGroupList) {
        this.ageGroupList = ageGroupList;
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

    public String getRegionLab() {
        return regionLab;
    }

    public void setRegionLab(String regionLab) {
        this.regionLab = regionLab;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public String getAgeGroupLab() {
        return ageGroupLab;
    }

    public void setAgeGroupLab(String ageGroupLab) {
        this.ageGroupLab = ageGroupLab;
    }

    public void setSelected() {
        if (this.ageGroup != null && this.ageGroupList != null) {
            for (String var : this.ageGroup) {
                for (Option otion : ageGroupList) {
                    if (var.equals(otion.getName())) {
                        otion.setSelected(true);
                        break;
                    }
                }
            }
        }

        if (this.region != null && this.regionList != null) {
            for (String var : this.region) {
                for (Option otion : regionList) {
                    if (var.equals(otion.getId())) {
                        otion.setSelected(true);
                        break;
                    }
                }
            }
        }

    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

}
