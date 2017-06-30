package com.iclick.symphony.iaudience.model.report;

import com.alibaba.fastjson.JSON;

public class CloudTag {
    String text;
    double weight;
   

    public String getText() {
		return text;
	}


	public void setText(String text) {
		this.text = text;
	}


	public double getWeight() {
		return weight;
	}


	public void setWeight(double weight) {
		this.weight = weight;
	}


	@Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}
