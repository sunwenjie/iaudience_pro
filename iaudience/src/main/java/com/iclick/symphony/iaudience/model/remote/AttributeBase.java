package com.iclick.symphony.iaudience.model.remote;

public class AttributeBase {

    private Float doc_percent;
    private Long doc_count;
    private String key;

    public AttributeBase() {
        // TODO Auto-generated constructor stub
    }

    public AttributeBase(String key) {
        this.key = key;
    }

    public AttributeBase(String key, Float doc_percent, Long doc_count) {
        this.key = key;
        this.doc_percent = doc_percent;
        this.doc_count = doc_count;
    }

    public Float getDoc_percent() {
        return doc_percent;
    }

    public void setDoc_percent(Float doc_percent) {
        this.doc_percent = doc_percent;
    }

    public Long getDoc_count() {
        return doc_count;
    }

    public void setDoc_count(Long doc_count) {
        this.doc_count = doc_count;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    @Override
    public String toString() {
        return key + "\t" + doc_count + "\t" + doc_percent;
    }

}
