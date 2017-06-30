package com.iclick.symphony.iaudience.constants;

/**
 * Created by wenjie.sun on 2017/6/23.
 */
public enum ReportDataTypeEnum {

    MARKET(1,"market"),
    INTERNET(2,"internet"),
    BRAND(3,"brand"),
    COMPETITOR(4,"competitor"),
    PRODUCT(5,"product"),
    COMPETITORS(6,"competitors"),
    POTENTIAL(7,"potential"),
    MARKETSHARE(8,"marketShare");

    private int value;
    private String type;

    ReportDataTypeEnum(int value, String type) {
        this.value = value;
        this.type = type;
    }

    public int getValue() {
        return value;
    }


    public String getType() {
        return type;
    }

    public static ReportDataTypeEnum findByValue(int value) {
        for (ReportDataTypeEnum t : ReportDataTypeEnum.values()) {
            if (t.getValue() == value) {
                return t;
            }
        }
        return null;
    }

    public static ReportDataTypeEnum findByType(String type) {
        for (ReportDataTypeEnum t : ReportDataTypeEnum.values()) {
            if (t.getType().equalsIgnoreCase(type)) {
                return t;
            }
        }
        return null;
    }


}
