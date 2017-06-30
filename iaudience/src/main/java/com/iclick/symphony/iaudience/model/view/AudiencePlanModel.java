package com.iclick.symphony.iaudience.model.view;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wenjie.sun on 2017/5/19.
 */
public class AudiencePlanModel {
    private Integer planId;
    private Integer clientId;
    private String name;
    private Integer categoryId;
    private String categoryName;
    private Integer userId;
    private List<BrandModel> brandModelList = new ArrayList<>();
    private AdvancedSettingModel advancedSettingModel;

    //初始化加载的所有兴趣标签
    private String interestLab;

//    初始化地市集合
    private List<City> cityArray = new ArrayList<>();

//    删除brandIds集合
    private String[] deleteBrandIds;
//    删除productIds集合
    private String[] deleteProductIds;

//  分析进度
    private Integer analyseStatus;


    public Integer getPlanId() {
        return planId;
    }

    public void setPlanId(Integer planId) {
        this.planId = planId;
    }

    public Integer getClientId() {
        return clientId;
    }

    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public List<BrandModel> getBrandModelList() {
        return brandModelList;
    }

    public void setBrandModelList(List<BrandModel> brandModelList) {
        this.brandModelList = brandModelList;
    }

    public AdvancedSettingModel getAdvancedSettingModel() {
        return advancedSettingModel;
    }

    public void setAdvancedSettingModel(AdvancedSettingModel advancedSettingModel) {
        this.advancedSettingModel = advancedSettingModel;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getInterestLab() {
        return interestLab;
    }

    public void setInterestLab(String interestLab) {
        this.interestLab = interestLab;
    }

    public List<City> getCityArray() {
        return cityArray;
    }

    public void setCityArray(List<City> cityArray) {
        this.cityArray = cityArray;
    }

    public String[] getDeleteBrandIds() {
        return deleteBrandIds;
    }

    public void setDeleteBrandIds(String[] deleteBrandIds) {
        this.deleteBrandIds = deleteBrandIds;
    }

    public String[] getDeleteProductIds() {
        return deleteProductIds;
    }

    public void setDeleteProductIds(String[] deleteProductIds) {
        this.deleteProductIds = deleteProductIds;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Integer getAnalyseStatus() {
        return analyseStatus;
    }

    public void setAnalyseStatus(Integer analyseStatus) {
        this.analyseStatus = analyseStatus;
    }

    public BrandModel ownBrandModel(){
        List<BrandModel> brandModelList = this.getBrandModelList();
        BrandModel ownBrand = null;
        if (brandModelList != null){
            for (BrandModel brandModel : brandModelList){
                if (!(Boolean.parseBoolean(brandModel.getCompetitor()))){
                    ownBrand = brandModel;
                    break;
                }

            }
        }
        return ownBrand;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this, SerializerFeature.DisableCircularReferenceDetect);
    }
}
