package com.iclick.symphony.iaudience.model.remote;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.iclick.symphony.iaudience.model.report.BaseCell;
import com.iclick.symphony.iaudience.model.report.InterestCell;
import com.iclick.symphony.iaudience.util.MappingUtils;

public class AudienceComposition {
	private List<Age> age;
	private List<Gender> gender;

	
	private List<City> city;
	private List<Province> province;
	private List<Device> device;
    private List<Keyword> keyword;
	private List<Interest> interest;
	private List<Interest> raw_interest;
	
	private Long total;

    public List<Keyword> getKeyword() {
        return keyword;
    }

    public void setKeyword(List<Keyword> keyword) {
        this.keyword = keyword;
    }
	public int getCreatetime() {
		return createtime;
	}

	public void setCreatetime(int createtime) {
		this.createtime = createtime;
	}

	private int createtime;

	public List<Age> getAge() {
		return age;
	}

	public void setAge(List<Age> age) {
		this.age = age;
	}

	public List<Gender> getGender() {
		return gender;
	}

	public void setGender(List<Gender> gender) {
		this.gender = gender;
	}

	public List<City> getCity() {
		return city;
	}

	public void setCity(List<City> city) {
		this.city = city;
	}

	public List<Province> getProvince() {
		return province;
	}

	public void setProvince(List<Province> province) {
		this.province = province;
	}

	public List<Device> getDevice() {
		return device;
	}

	public void setDevice(List<Device> device) {
		this.device = device;
	}

	public List<Interest> getInterest() {
		return interest;
	}

	public void setInterest(List<Interest> interest) {
		this.interest = interest;
	}


	public List<Interest> getRaw_interest() {
		return raw_interest;
	}

	public void setRaw_interest(List<Interest> raw_interest) {
		this.raw_interest = raw_interest;
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}
	
	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
	
	public Map<String, Long> getAgeMap(){
		Map<String, Long> ageMap = new HashMap<>();
		ageMap.put("18-24", 0L);
		ageMap.put("25-34", 0L);
		ageMap.put("35-44", 0L);
		ageMap.put("45-54", 0L);
		ageMap.put("55-64", 0L);
		ageMap.put("65+", 0L);
		for(int i = 0; i < this.age.size(); i++){
			ageMap.put(age.get(i).getKey(), age.get(i).getDoc_count());
		}
		return ageMap;
	}
	
	public Map<String, Long> getGenerMap(){
		Map<String, Long> map = new HashMap<>();
		map.put("m", 0L);
		map.put("f", 0L);
		for(int i = 0; i < this.gender.size(); i++){
			map.put(gender.get(i).getKey(), gender.get(i).getDoc_count());
		}
		return map;
	}
	
	public List<BaseCell> getProvinceList(String language){
		Locale locale = new Locale(language);
		Map<String, String> mapping = MappingUtils.getProvinceMapping(locale);
		List<BaseCell> list = new ArrayList<>();
		for(int i = 0; i < this.province.size(); i++){
			String key = province.get(i).getKey();
			BaseCell cell = new BaseCell();
			cell.setName(mapping.get(key));
			cell.setValue(province.get(i).getDoc_count());
			list.add(cell);
		}
		return list;
	}
	
	public Map<String, InterestCell> getInterestMap(String language){
		Map<String, InterestCell> map = new HashMap<>();
		Map<String, Long> sortMap = new HashMap<>();
		Long totalInterest = 0L;
		for(int i = 0; i < this.raw_interest.size(); i++){
			if(raw_interest.get(i).getKey().length() > 3)continue;
			InterestCell cell = new InterestCell();
			List<String> sub = new ArrayList<>();
			String name;
			if(language.equals("zh"))
				name = raw_interest.get(i).getZh_cn_name();
			else
				name = raw_interest.get(i).getEn_name();
			cell.setName(name);
			cell.setPercent(Math.round(raw_interest.get(i).getDoc_percent()*10000)/100.0);
			//cell.setValue((long)Math.round(raw_interest.get(i).getDoc_percent()*100));
			cell.setValue(raw_interest.get(i).getDoc_count());
			totalInterest += cell.getValue();
			cell.setSub(sub);
			map.put(raw_interest.get(i).getKey(), cell);
			sortMap.put(raw_interest.get(i).getKey(), cell.getValue());
		}
		Long totalOther = 0L;
		List<String> otherKeys = new ArrayList<>();
		if(map.size() > 5){
			List<Map.Entry<String, Long>> sortList = new ArrayList<Map.Entry<String, Long>>(sortMap.entrySet());
			Collections.sort(sortList, new Comparator<Map.Entry<String, Long>>() {
			    public int compare(Map.Entry<String, Long> o1, Map.Entry<String, Long> o2) {
			        return (o2.getValue().compareTo(o1.getValue()));
			    }
			});
			for(Map.Entry<String, Long> fmap : sortList.subList(5, 10)){
				otherKeys.add(fmap.getKey());
				totalOther += fmap.getValue();
			}
			for(Map.Entry<String, Long> fmap : sortList.subList(5, sortList.size())){
				map.remove(fmap.getKey());
			}
		}
		Object[] setArray = map.keySet().toArray();
		List<String> subOther = new ArrayList<>();
		for(int i = 0; i < this.raw_interest.size(); i++){
			String name;
			if(language.equals("zh"))
				name = raw_interest.get(i).getZh_cn_name();
			else
				name = raw_interest.get(i).getEn_name();
			if(otherKeys.indexOf(raw_interest.get(i).getKey()) >= 0)
				subOther.add(name);
			if(raw_interest.get(i).getKey().length() != 4)continue;
			InterestCell cell = (InterestCell) map.get(raw_interest.get(i).getKey().substring(0, 2));
			if(cell == null || cell.getSub().size() >= 5)continue;
			List<String> sub = cell.getSub();
			sub.add(name);
			cell.setSub(sub);
		}
		for(int i = 0; i < setArray.length; i++){
			map.get(setArray[i]).setValue(map.get(setArray[i]).getValue()*100/totalInterest);
			map.put(map.get(setArray[i]).getName(), map.get(setArray[i]));
			map.remove(setArray[i]);
		}
		if(subOther.size() > 0){
			InterestCell cell = new InterestCell();
			cell.setName("Other Related Interests");
			cell.setSub(subOther);
			cell.setValue(totalOther*100/totalInterest);
			map.put("_other", cell);
		}
		return map;
	}
	
}
