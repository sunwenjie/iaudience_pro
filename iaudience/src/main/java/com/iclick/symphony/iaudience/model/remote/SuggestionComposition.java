package com.iclick.symphony.iaudience.model.remote;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.iclick.symphony.iaudience.model.report.CloudTag;

public class SuggestionComposition {
	
	private List<SuggestionKey> br;
	private List<SuggestionKey> cn;
	private List<SuggestionKey> cn_en;
	private List<SuggestionKey> en;
	private String word;
	public List<SuggestionKey> getBr() {
		return br;
	}
	public void setBr(List<SuggestionKey> br) {
		this.br = br;
	}
	public List<SuggestionKey> getCn() {
		return cn;
	}
	public void setCn(List<SuggestionKey> cn) {
		this.cn = cn;
	}
	public List<SuggestionKey> getCn_en() {
		return cn_en;
	}
	public void setCn_en(List<SuggestionKey> cn_en) {
		this.cn_en = cn_en;
	}
	public List<SuggestionKey> getEn() {
		return en;
	}
	public void setEn(List<SuggestionKey> en) {
		this.en = en;
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
	
	public List<Map<String, String>> getKeyordList(){
		List<Map<String, String>> keywords = new ArrayList<>();
		for(SuggestionKey k : cn){
			Map<String, String> map = new HashMap<>();
			map.put("text", k.getKey());
			map.put("weight", k.getScore().toString());
			keywords.add(map);
		}
		return keywords;
	}
	
	public List<CloudTag> keyword2CloudTag(){
		List<CloudTag> list = new ArrayList<>();
		for(SuggestionKey k : cn){
			CloudTag tag = new CloudTag();
			tag.setText(k.getKey());
			tag.setWeight(k.getScore());
			list.add(tag);
		}
		return list;
	}
}
