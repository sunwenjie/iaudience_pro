package com.iclick.symphony.iaudience.model.report;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by steven on 2017/3/28.
 */

public class AudienceSummaryModle {
    
    private String audienceId;
    
    private String parentId;
    
    private String name;
    
    private int audienceSize;
    
    private float weeklyGrowthRate;
    
    private float monthGrowthRate;
    
    private int type;

    private int eventSize;
    
    private float eventRate;
    
    private int convSize;
    
    private float convRate;

    
    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    private List<AudienceSummaryModle> children = new ArrayList<>();

    public List<AudienceSummaryModle> getChildren() {
        return children;
    }

    public void setChildren(List<AudienceSummaryModle> children) {
        this.children = children;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAudienceId() {
        return audienceId;
    }

    public void setAudienceId(String audienceId) {
        this.audienceId = audienceId;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public double getAudienceSize() {
        return audienceSize;
    }

    public void setAudienceSize(int audienceSize) {
        this.audienceSize = audienceSize;
    }

    public float getWeeklyGrowthRate() {
        return weeklyGrowthRate;
    }

    public void setWeeklyGrowthRate(float weeklyGrowthRate) {
        this.weeklyGrowthRate = weeklyGrowthRate;
    }

    public float getMonthGrowthRate() {
        return monthGrowthRate;
    }

    public void setMonthGrowthRate(float monthGrowthRate) {
        this.monthGrowthRate = monthGrowthRate;
    }

    public int getEventSize() {
        return eventSize;
    }

    public void setEventSize(int eventSize) {
        this.eventSize = eventSize;
    }

    public float getEventRate() {
        return eventRate;
    }

    public void setEventRate(float eventRate) {
        this.eventRate = eventRate;
    }

    public int getConvSize() {
        return convSize;
    }

    public void setConvSize(int convSize) {
        this.convSize = convSize;
    }

    public float getConvRate() {
        return convRate;
    }

    public void setConvRate(float convRate) {
        this.convRate = convRate;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this,SerializerFeature.DisableCircularReferenceDetect);
    }

}
