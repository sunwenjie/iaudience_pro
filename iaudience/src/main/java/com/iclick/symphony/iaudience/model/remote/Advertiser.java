package com.iclick.symphony.iaudience.model.remote;

/**
 * Created by wenjie.sun on 2017/6/28.
 */
public class Advertiser {
    private Integer id;
    private String name;
    private Agent agent;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Agent getAgent() {
        return agent;
    }

    public void setAgent(Agent agent) {
        this.agent = agent;
    }
}
