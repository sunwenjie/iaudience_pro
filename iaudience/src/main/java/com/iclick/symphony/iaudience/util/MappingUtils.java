package com.iclick.symphony.iaudience.util;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class MappingUtils {

    private static String[] provinces = { "1156110001,北京,BeiJing", "1156120001,天津,TianJin", "1156130001,河北,HeBei",
            "1156140001,山西,ShanXi", "1156150001,内蒙古,NeiMeng", "1156210001,辽宁,LiaoNing", "1156220001,吉林,JiLin",
            "1156230001,黑龙江,Heilongjiang", "1156310001,上海,Shanghai", "1156320001,江苏,Jiangsu", "1156330001,浙江,Zhejiang",
            "1156340001,安徽,AnHui", "1156350001,福建,FuJian", "1156360001,江西,JiangXi", "1156370001,山东,ShanDong",
            "1156410001,河南,HeNan", "1156420001,湖北,HuBei", "1156430001,湖南,HuNan", "1156440001,广东,GuangGong",
            "1156450001,广西,GuangXi", "1156460001,海南,HaiNan", "1156500001,重庆,ChongQing", "1156510001,四川,SiChuan",
            "1156520001,贵州,GuiZhou", "1156530001,云南,YunNan", "1156540001,西藏,XiZang", "1156610001,陕西,ShanXi1",
            "1156620001,甘肃,GanSu", "1156630001,青海,QingHai", "1156640001,宁夏,NingXia", "1156650001,新疆,XinJiang",
            "1158000001,台湾,TaiWan", "1344000001,香港,HongKong", "1446000001,澳门,Macao" };

    private static final Map<String, String> ID_CH_MAPPING = new HashMap<>();

    private static final Map<String, String> ID_EN_MAPPING = new HashMap<>();

    private static final Map<String, String> NAME_MAPIPNG = new HashMap<>();

    static {
        for (String p : provinces) {
            String[] array = p.split(",");
            ID_CH_MAPPING.put(array[0], array[1]);
            ID_EN_MAPPING.put(array[0], array[2]);
            NAME_MAPIPNG.put(array[1], array[2]);
        }

    }

    public static Map<String, String> getProvinceMapping(Locale locale) {
        if (Locale.ENGLISH.equals(locale)) {
            return ID_EN_MAPPING;
        }

        if (Locale.CHINESE.equals(locale) || Locale.SIMPLIFIED_CHINESE.equals(locale)) {
            return ID_CH_MAPPING;
        }
        return ID_EN_MAPPING;
    }

    public static Map<String, String> getProvinceEnZHMapping() {
        return NAME_MAPIPNG;
    }

    public static void main(String[] args) {
        // TODOAuto-generatedmethodstub

    }

}
