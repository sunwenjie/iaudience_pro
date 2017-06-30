package com.iclick.symphony.iaudience.model;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;

public class Interest {

	@JSONField(name = "name")
	private String name;
    @JSONField(name = "audience_id")
	private String audienceId;
    @JSONField(name = "parent_id")
   	private String parentId;

    private List<Interest> children = new ArrayList<Interest>();

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAudienceId() {
        return audienceId;
    }

    public void setAudienceId(String audienceId) {
        this.audienceId = audienceId;
    }

    public List<Interest> getChildren() {
        return children;
    }

    public void setChildren(List<Interest> children) {
        this.children = children;
    }
    
    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

}
