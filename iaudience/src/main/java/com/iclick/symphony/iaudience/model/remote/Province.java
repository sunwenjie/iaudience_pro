package com.iclick.symphony.iaudience.model.remote;

public class Province extends AttributeBase {
    private String name_zh_cn;
    private String name_en_us;
    public String getName_zh_cn() {
		return name_zh_cn;
	}

	public void setName_zh_cn(String name_zh_cn) {
		this.name_zh_cn = name_zh_cn;
	}

	public String getName_en_us() {
		return name_en_us;
	}

	public void setName_en_us(String name_en_us) {
		this.name_en_us = name_en_us;
	}

	public Province(String key) {
        super(key);
        // TODO Auto-generated constructor stub
    }
    
    public Province() {
        super();
    }
}
