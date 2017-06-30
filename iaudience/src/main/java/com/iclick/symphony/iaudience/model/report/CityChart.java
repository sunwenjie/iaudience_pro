package com.iclick.symphony.iaudience.model.report;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSON;
import com.iclick.symphony.iaudience.model.remote.AudienceComposition;
import com.iclick.symphony.iaudience.model.remote.ComparisonComposition;

public class CityChart {

    private List<CityChartRow> cityChartRow;

    private String label;

    public List<CityChartRow> getCityChartRow() {
        return cityChartRow;
    }

    public void setCityChartRow(List<CityChartRow> cityChartRow) {
        this.cityChartRow = cityChartRow;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

    static public CityChart fromBrand(ComparisonComposition comparisonComposition, String label) {
        return from(comparisonComposition, label, "brand");
    }

    static public CityChart fromCompetitor(ComparisonComposition comparisonComposition, String label) {
        return from(comparisonComposition, label, "competitor");
    }

    static public CityChart fromBrandCamparison(ComparisonComposition comparisonComposition, String label) {
        return from(comparisonComposition, label, "brand_camparison");
    }

    static private CityChart from(ComparisonComposition comparisonComposition, String label, String type) {
        CityChart cityChart = null;
        if (comparisonComposition == null) {
            return cityChart;
        }
        if (StringUtils.isBlank(type)) {
            return cityChart;
        }
        AudienceComposition audienceComposition = null;
        if ("brand".equals(type)) {
            audienceComposition = comparisonComposition.getBrand();
        }

        if ("competitor".equals(type)) {
            audienceComposition = comparisonComposition.getCompetitor();
        }

        if ("brand_camparison".equals(type)) {
            audienceComposition = comparisonComposition.getBrand_competitor();
        }

        cityChart = new CityChart();
        cityChart.setCityChartRow(CityChartRow.fromProvince(audienceComposition.getProvince()));

        cityChart.setLabel(label);

        return cityChart;
    }

}
