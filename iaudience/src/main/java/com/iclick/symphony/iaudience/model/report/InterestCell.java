package com.iclick.symphony.iaudience.model.report;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;

public class InterestCell extends BaseCell {
    List<String> sub;
    Double percent;
    
    public Double getPercent() {
		return percent;
	}

	public void setPercent(Double percent) {
		this.percent = percent;
	}

	public List<String> getSub() {
        return sub;
    }

    public void setSub(List<String> sub) {
        this.sub = sub;
    }

    public void addSub(String e) {
        if(this.sub==null){
            this.sub = new ArrayList<String>();
        }
        sub.add(e);
    }
    
    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

}
