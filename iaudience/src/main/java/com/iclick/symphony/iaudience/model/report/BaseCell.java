package com.iclick.symphony.iaudience.model.report;

public class BaseCell implements Comparable<BaseCell> {

    private String id;
    private String name;
    private Long value;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getValue() {
        return value;
    }

    public void setValue(Long value) {
        this.value = value;
    }

    @Override
    public int compareTo(BaseCell baseCell) {
        if (this.getValue() < baseCell.getValue()) {
            return 1;
        } else {
            return -1;
        }
    }

}
