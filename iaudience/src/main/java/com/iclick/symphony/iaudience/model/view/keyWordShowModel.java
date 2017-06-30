package com.iclick.symphony.iaudience.model.view;

import com.alibaba.fastjson.JSON;

/**
 * Created by wenjie.sun on 2017/5/27.
 */
public class keyWordShowModel {
    private  String keywords_id;
    private String name;

    public String getKeywords_id() {
        return keywords_id;
    }

    public void setKeywords_id(String keywords_id) {
        this.keywords_id = keywords_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}
