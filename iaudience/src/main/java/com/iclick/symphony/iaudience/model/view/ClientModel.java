package com.iclick.symphony.iaudience.model.view;

import com.alibaba.fastjson.JSON;

/**
 * Created by wenjie.sun on 2017/6/27.
 */
public class ClientModel {
    private Integer clientId;
    private String clientName;
    public Integer getClientId() {
        return clientId;
    }

    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}
