package com.iclick.symphony.iaudience.model.remote;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.ArrayUtils;

import com.alibaba.fastjson.JSON;

public class LbsAttributes {
	private List<String> keyword;
	private String city;

	public LbsAttributes() {

	}

	public List<String> getKeyword() {
		return keyword;
	}

	public void setKeyword(List<String> keyword) {
		this.keyword = keyword;
	}


    public void setKeyword(String[] keywords) {
        if (ArrayUtils.isNotEmpty(keywords)) {
            List<String> list = new ArrayList<String>();
            for (String keyword : keywords) {
                list.add(keyword);
            }
            this.keyword = list;
        }
        
    }
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
	
	public static void main(String args[]){
		
		LbsAttributes lbs = new LbsAttributes();
		lbs.setCity("101010101");
		lbs.setKeyword(new String[]{"电动汽车"});
		System.out.println(lbs.toString());
	}
}
