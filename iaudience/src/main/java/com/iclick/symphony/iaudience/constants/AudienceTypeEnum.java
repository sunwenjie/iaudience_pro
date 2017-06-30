/**
 * 
 */
package com.iclick.symphony.iaudience.constants;

/**
 * @author Steven
 *
 */
public enum AudienceTypeEnum {
    INTEREST(1, "interest"), CUSTOM(2, "custom"), RETARGETING(3, "retargeting"), SEARCH_RETARGETING(4, "s_retargeting");
    private int value;
    private String code;

    private AudienceTypeEnum(int value, String code) {
        this.value = value;
        this.code = code;
    }

    public int getValue() {
        return value;
    }

    public String getCode() {
        return code;
    }

    public static AudienceTypeEnum findByValue(int value) {
        for (AudienceTypeEnum t : AudienceTypeEnum.values()) {
            if (t.getValue() == value) {
                return t;
            }
        }
        return null;
    }

}
