package com.iclick.symphony.iaudience.model.remote;

import java.util.List;

/**
 * Created by wenjie.sun on 2017/6/29.
 */
public class ClientAttributes {
    private Integer userid;
    private List<Advertiser> advids;

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public List<Advertiser> getAdvids() {
        return advids;
    }

    public void setAdvids(List<Advertiser> advids) {
        this.advids = advids;
    }
}
