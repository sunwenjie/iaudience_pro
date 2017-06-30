package com.iclick.symphony.iaudience.model.remote;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.ArrayUtils;

import com.alibaba.fastjson.JSON;

public class AudienceAttributes {

    private List<Age> age;
    private List<Gender> gender;

    private List<City> city;
    private List<Province> province;

    private List<Device> device;

    private List<Keyword> keyword;

    private List<Interest> interest;
    private List<Interest> raw_interest;

    private List<String> aggs_fields;

    public List<Age> getAge() {
        return age;
    }

    public void setAge(String[] ages) {
        if (ArrayUtils.isNotEmpty(ages)) {
            List<Age> list = new ArrayList<Age>();
            for (String age : ages) {
                list.add(new Age(age));
            }
            this.age = list;
        }
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

    public void setGender(String[] genders) {
        if (ArrayUtils.isNotEmpty(genders)) {
            List<Gender> list = new ArrayList<Gender>();
            for (String gender : genders) {
                list.add(new Gender(gender));
            }
            this.gender = list;
        }
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

    public void setProvince(String[] provinces) {
        if (ArrayUtils.isNotEmpty(provinces)) {
            List<Province> list = new ArrayList<>();
            for (String province : provinces) {
                list.add(new Province(province));
            }
            this.province = list;
        }
    }

    public void setDevice(List<Device> device) {
        this.device = device;
    }

    public List<Keyword> getKeyword() {
        return keyword;
    }

    public void setKeyword(List<Keyword> keyword) {
        this.keyword = keyword;
    }

    public void setKeyword(String[] keywords) {
        if (ArrayUtils.isNotEmpty(keywords)) {
            List<Keyword> list = new ArrayList<Keyword>();
            for (String keyword : keywords) {
                list.add(new Keyword(keyword));
            }
            this.keyword = list;
        }
    }

    public List<Interest> getInterest() {
        return interest;
    }

    public void setInterest(List<Interest> interest) {
        this.interest = interest;
    }

    public void setInterest(String[] interests) {
        if (ArrayUtils.isNotEmpty(interests)) {
            List<Interest> list = new ArrayList<>();
            for (String interest : interests) {
                list.add(new Interest(interest));
            }
            this.interest = list;
        }
    }

    public List<Interest> getRaw_interest() {
        return raw_interest;
    }

    public void setRaw_interest(List<Interest> raw_interest) {
        this.raw_interest = raw_interest;
    }

    public List<String> getAggs_fields() {
        return aggs_fields;
    }

    public void setAggs_fields(List<String> aggs_fields) {
        this.aggs_fields = aggs_fields;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

}
