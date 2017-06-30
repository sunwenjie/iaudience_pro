package com.iclick.symphony.iapps.constants;

public enum PurchargeTypeEnum {
    FREE(0,"free"),ONCE(1,""),NUM(2,"times"),DAY(3,"day"),MONTH(4,"mth"),YEAR(5,"yr");
    private int value;
    private String code;
    
    private PurchargeTypeEnum(int value,String code){
        this.value = value;
        this.code = code;
    }

    public int getValue() {
        return value;
    }

    public String getCode() {
        return code;
    }
    
    public static PurchargeTypeEnum findByValue(int value){
        for(PurchargeTypeEnum t : PurchargeTypeEnum.values()){
            if(t.getValue() == value){
                return t;
            }
        }
        return null;
    }
}
