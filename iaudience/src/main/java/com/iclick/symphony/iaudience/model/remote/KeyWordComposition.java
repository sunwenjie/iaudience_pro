package com.iclick.symphony.iaudience.model.remote;

import java.util.List;

import com.alibaba.fastjson.JSON;

public class KeyWordComposition {
	private List<Keyword> cn_en;
	private String word;
	
	public KeyWordComposition() {
	}


	public List<Keyword> getCn_en() {
		return cn_en;
	}


	public void setCn_en(List<Keyword> cn_en) {
		this.cn_en = cn_en;
	}


	public String getWord() {
		return word;
	}


	public void setWord(String word) {
		this.word = word;
	}


	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
}
