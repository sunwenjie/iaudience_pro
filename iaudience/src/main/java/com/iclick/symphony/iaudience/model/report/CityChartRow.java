package com.iclick.symphony.iaudience.model.report;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.iclick.symphony.iaudience.model.remote.City;
import com.iclick.symphony.iaudience.model.remote.Province;

public class CityChartRow implements Comparable<CityChartRow> {

    private String name;
    private Long value;

    private Float percent;

    public Float getPercent() {
        return percent;
    }

    public void setPercent(Float percent) {
        this.percent = percent;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getValue() {
        return value;
    }

    public void setValue(Long value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

    static public List<CityChartRow> fromCity(List<City> citys) {
        List<CityChartRow> rowList = new ArrayList<>();
        if (citys == null) {
            return rowList;
        }
        CityChartRow row = null;
        for (City city : citys) {
            row = new CityChartRow();
            row.setName(city.getKey());
            row.setValue(city.getDoc_count());
            row.setPercent(city.getDoc_percent());
            rowList.add(row);
        }

        return rowList;
    }

    static public List<CityChartRow> fromProvince(List<Province> rovinces) {
        List<CityChartRow> rowList = new ArrayList<>();
        if (rovinces == null) {
            return rowList;
        }
        CityChartRow row = null;
        for (Province province : rovinces) {
            row = new CityChartRow();
            row.setName(province.getKey());
            row.setValue(province.getDoc_count());
            row.setPercent(province.getDoc_percent());
            rowList.add(row);
        }

        return rowList;
    }

    @Override
    public int compareTo(CityChartRow o) {
        return this.getValue().compareTo(o.getValue());
    }
}
