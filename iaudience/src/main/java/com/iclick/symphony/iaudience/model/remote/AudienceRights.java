package com.iclick.symphony.iaudience.model.remote;

import com.alibaba.fastjson.JSON;

/**
 * Created by wenjie.sun on 2017/6/29.
 */
public class AudienceRights {
    private Integer ret_code;
    private AudienceRightRetMsg ret_msg;
    private Integer error_code;

    public Integer getRet_code() {
        return ret_code;
    }

    public void setRet_code(Integer ret_code) {
        this.ret_code = ret_code;
    }

    public AudienceRightRetMsg getRet_msg() {
        return ret_msg;
    }

    public void setRet_msg(AudienceRightRetMsg ret_msg) {
        this.ret_msg = ret_msg;
    }

    public Integer getError_code() {
        return error_code;
    }

    public void setError_code(Integer error_code) {
        this.error_code = error_code;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}
