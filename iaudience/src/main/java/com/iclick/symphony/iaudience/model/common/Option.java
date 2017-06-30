package com.iclick.symphony.iaudience.model.common;

import org.apache.commons.lang3.StringUtils;

public class Option {

    private String name;

    private String id;

    private boolean selected;

    public Option(String name, String id) {
        super();
        this.name = name;
        this.id = id;
    }

    private String remark;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setSelectedByName(String value) {
        if (StringUtils.isNotBlank(value) && StringUtils.isNotBlank(this.name)) {
            setSelected(value.equals(this.name));
        } else {
            setSelected(false);
        }

    }

    public void setSelectedById(String value) {
        if (StringUtils.isNotBlank(value) && StringUtils.isNotBlank(this.id)) {
            setSelected(value.equals(this.id));
        } else {
            setSelected(false);
        }

    }

}
