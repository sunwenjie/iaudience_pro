package com.iclick.symphony.iaudience.model.report;

import java.util.Date;

/**
 * Created by wenjie.sun on 2017/3/28.
 */

public class InterestSummary {
    private int audienceId;
    private String nameEn;
    private String name;
    private int parentAudienceId;
    private int audienceSize;
    private float weeklyGrowthRate;
    private float monthGrowthRate;
    private int type;
    private Date createTime;

    private ChildrenInterestSummary childrenInterestSummary = new ChildrenInterestSummary();

    public int getAudienceId() {
        return audienceId;
    }

    public void setAudienceId(int audienceId) {
        this.audienceId = audienceId;
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getParentAudienceId() {
        return parentAudienceId;
    }

    public void setParentAudienceId(int parentAudienceId) {
        this.parentAudienceId = parentAudienceId;
    }

    public int getAudienceSize() {
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

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    // 先序遍历，拼接JSON字符串
    public String toString() {
        StringBuffer result = new StringBuffer("{");
        if (nameEn.indexOf("'") != -1)
            nameEn = nameEn.replaceAll("\'", "&#39;");
        result.append("audience_id:" + audienceId).append(",");
        result.append("audience_size:" + audienceSize).append(",");
        result.append("monthly_growth_rate:" + monthGrowthRate).append(",");
        result.append("name:'" + name).append("',");
        result.append("name_en:'" + nameEn).append("',");
        result.append("parent_audience_id:" + parentAudienceId).append(",");
        result.append("weekly_growth_rate:" + weeklyGrowthRate).append(",");
        result.append("bshare_id:" + audienceId).append(",");
        result.append("bshare_audience_id:" + audienceId).append(",");

        if (childrenInterestSummary != null && childrenInterestSummary.getSize() != 0) {
            result.append("children:" + childrenInterestSummary.toString());
        } else {
            result.append("children:[]");
        }

        return result + "}";
    }

    // 兄弟兴趣标签横向排序
    public void sortChildrenInterestSummary() {
        if (childrenInterestSummary != null && childrenInterestSummary.getSize() != 0) {
            childrenInterestSummary.sortChildrenInterestSummary();
        }
    }

    // 添加孩子兴趣标签
    public void addChildInterestSummary(InterestSummary interestSummary) {
        this.childrenInterestSummary.addChildInterestSummary(interestSummary);
    }
}
