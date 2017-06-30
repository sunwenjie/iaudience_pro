package com.iclick.symphony.iaudience.model.view;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.iclick.symphony.iaudience.util.CommonModelUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wenjie.sun on 2017/5/23.
 */
public class AdvancedSettingModel {
    private Integer advancedSettingId;
    private String keyWords;
    private String city;
    private String location;

    public Integer getAdvancedSettingId() {
        return advancedSettingId;
    }

    public void setAdvancedSettingId(Integer advancedSettingId) {
        this.advancedSettingId = advancedSettingId;
    }

    public String getKeyWords() {
        return keyWords;
    }

    public void setKeyWords(String keyWords) {
        this.keyWords = keyWords;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @JSONField(serialize = false)
    public String getKeyWordsShow(){
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
    @JSONField(serialize = false)
    public String[] getLocationShow(){
        String[] locationArray = CommonModelUtil.strToArray(getLocation());
        return locationArray;
    }
}
