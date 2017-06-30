package com.iclick.symphony.iaudience.model.view;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.iclick.symphony.iaudience.util.CommonModelUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wenjie.sun on 2017/5/19.
 */
public class BrandModel {
    private Integer brandId;
    private String name;
    private String competitor;
    private String keyWords;
    private List<ProductModel> productModelList = new ArrayList<>();

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCompetitor() {
        return competitor;
    }

    public void setCompetitor(String competitor) {
        this.competitor = competitor;
    }

    public String getKeyWords() {
        return keyWords;
    }

    public void setKeyWords(String keyWords) {
        this.keyWords = keyWords;
    }

    @JSONField(serialize = false)
    public String getKeyWordsShow() {
        String[] keyWordArray = CommonModelUtil.strToArray(keyWords);
        List<keyWordShowModel> keywordModelList = new ArrayList<>();
        if (keyWordArray != null){
            for (String keyword : keyWordArray){
                keyWordShowModel keywordModel = new keyWordShowModel();
                keywordModel.setName(keyword);
                keywordModelList.add(keywordModel);
            }
        }

        return JSON.toJSONString(keywordModelList);
    }


    public List<ProductModel> getProductModelList() {
        return productModelList;
    }

    public void setProductModelList(List<ProductModel> productModelList) {
        this.productModelList = productModelList;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}
