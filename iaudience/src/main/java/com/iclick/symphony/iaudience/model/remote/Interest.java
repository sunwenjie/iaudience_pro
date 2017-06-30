package com.iclick.symphony.iaudience.model.remote;

public class Interest extends AttributeBase {

    private String en_name;
    private String zh_cn_name;

    public Interest() {
    }

    public Interest(String key) {
        super(key);
    }

    public String getEn_name() {
        return en_name;
    }

    public void setEn_name(String en_name) {
        this.en_name = en_name;
    }

    public String getZh_cn_name() {
        return zh_cn_name;
    }

    public void setZh_cn_name(String zh_cn_name) {
        this.zh_cn_name = zh_cn_name;
    }

}
