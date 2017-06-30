package com.iclick.symphony.iaudience.model.view;

import com.alibaba.fastjson.JSON;

import java.util.List;

/**
 * Created by wenjie.sun on 2017/6/30.
 */
public class AgentModel {
    private Integer agentId;
    private List<ClientModel> clients;

    public Integer getAgentId() {
        return agentId;
    }

    public void setAgentId(Integer agentId) {
        this.agentId = agentId;
    }

    public List<ClientModel> getClients() {
        return clients;
    }

    public void setClients(List<ClientModel> clients) {
        this.clients = clients;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}
