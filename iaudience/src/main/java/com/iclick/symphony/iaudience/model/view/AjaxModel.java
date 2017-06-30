package com.iclick.symphony.iaudience.model.view;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;

public class AjaxModel {

    private static String SUCCESS = "success";
    
    private static String FAILURE = "failure";
    
    private Map<String, String> errorMessage;
    
    private String status = SUCCESS;

    private String errorMsg = "";
    
    private JSONObject returnDate;
    
    public JSONObject getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(JSONObject returnDate) {
        this.returnDate = returnDate;
    }

    public Map<String, String> getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(Map<String, String> errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void addErrorMessage(String key, String e) {
        if (this.errorMessage == null) {
            this.errorMessage = new HashMap<>();
        }
        this.errorMessage.put(key, e);
        setFailure();
        Iterator<String> iter = errorMessage.values().iterator();
        while (iter.hasNext()) {
            errorMsg += iter.next();
        }
    }

    public void setSuccess() {
        this.status = SUCCESS;
    }

    public void setFailure() {
        this.status = FAILURE;
    }

    public boolean isFailure() {
        return this.errorMessage != null && !this.errorMessage.isEmpty();
    }
}
