package com.iclick.symphony.iaudience.model.report;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.iclick.symphony.iaudience.entity.EventInfo;

import java.util.List;

public class AudienceModle {

    private List<AudienceSummaryModle> interestSummaryList;

    private List<AudienceSummaryModle> customSummaryList;

    private List<AudienceSummaryModle> retargetingList;

    private List<AudienceSummaryModle> searchRetargetingList;
    
    private List<EventInfo> eventInfoList;

    private AudienceSummaryModle interestSummaryTotal;

    private AudienceSummaryModle cuntomSummaryTotal;

    private AudienceSummaryModle retargetingSummaryTotal;

    private AudienceSummaryModle searchRetargetingSummaryTotal;

    public List<AudienceSummaryModle> getInterestSummaryList() {
        return interestSummaryList;
    }

    public void setInterestSummaryList(List<AudienceSummaryModle> interestSummaryList) {
        this.interestSummaryList = interestSummaryList;
    }

    public List<AudienceSummaryModle> getCustomSummaryList() {
        return customSummaryList;
    }

    public void setCustomSummaryList(List<AudienceSummaryModle> customSummaryList) {
        this.customSummaryList = customSummaryList;
    }

    public AudienceSummaryModle getInterestSummaryTotal() {
        return interestSummaryTotal;
    }

    public void setInterestSummaryTotal(AudienceSummaryModle interestSummaryTotal) {
        this.interestSummaryTotal = interestSummaryTotal;
    }

    public AudienceSummaryModle getCuntomSummaryTotal() {
        return cuntomSummaryTotal;
    }

    public void setCuntomSummaryTotal(AudienceSummaryModle cuntomSummaryTotal) {
        this.cuntomSummaryTotal = cuntomSummaryTotal;
    }

    public AudienceSummaryModle getRetargetingSummaryTotal() {
        return retargetingSummaryTotal;
    }

    public void setRetargetingSummaryTotal(AudienceSummaryModle retargetingSummaryTotal) {
        this.retargetingSummaryTotal = retargetingSummaryTotal;
    }

    public AudienceSummaryModle getSearchRetargetingSummaryTotal() {
        return searchRetargetingSummaryTotal;
    }

    public void setSearchRetargetingSummaryTotal(AudienceSummaryModle searchRetargetingSummaryTotal) {
        this.searchRetargetingSummaryTotal = searchRetargetingSummaryTotal;
    }

    public List<AudienceSummaryModle> getRetargetingList() {
        return retargetingList;
    }

    public void setRetargetingList(List<AudienceSummaryModle> retargetingList) {
        this.retargetingList = retargetingList;
    }

    public List<AudienceSummaryModle> getSearchRetargetingList() {
        return searchRetargetingList;
    }

    public void setSearchRetargetingList(List<AudienceSummaryModle> searchRetargetingList) {
        this.searchRetargetingList = searchRetargetingList;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this,SerializerFeature.DisableCircularReferenceDetect);
    }


	public List<EventInfo> getEventInfoList() {
		return eventInfoList;
	}

	public void setEventInfoList(List<EventInfo> eventInfoList) {
		this.eventInfoList = eventInfoList;
	}

}
