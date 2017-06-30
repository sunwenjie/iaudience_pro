package com.iclick.symphony.iapps.constants;

public enum CurrencyUnitEnum {
    CNY(1,"￥","人民币"),HKD(2,"HK$","港币"),USD(3,"US$","美元");
    
    private int value;
    private String symbol;
    private String zhName;
    
    private CurrencyUnitEnum(int value,String symbol,String zhName){
        this.value = value;
        this.symbol = symbol;
        this.zhName = zhName;
    }

    public int getValue() {
        return value;
    }

    public String getSymbol() {
        return symbol;
    }

    public String getZhName() {
        return zhName;
    }
    
    public static CurrencyUnitEnum findByValue(Integer value){
        if(value != null){
            for(CurrencyUnitEnum u : CurrencyUnitEnum.values()){
                if(u.getValue() == value){
                    return u;
                }
            }
        }
       
        return null;
    }
}
