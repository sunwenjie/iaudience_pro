package com.iclick.symphony.iaudience.model.report;

import com.alibaba.fastjson.JSON;

public class BubbleChart {

    private int[] sets;
    private String label;
    private Long size;
    private int ranking;
    private String overlap;

    public String getOverlap() {
        return overlap;
    }

    public void setOverlap(String overlap) {
        this.overlap = overlap;
    }

    public int[] getSets() {
        return sets;
    }

    public void setSets(int[] sets) {
        this.sets = sets;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public int getRanking() {
        return ranking;
    }

    public void setRanking(int ranking) {
        this.ranking = ranking;
    }
    
    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

}
