package com.iclick.symphony.iaudience.util;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.iclick.symphony.iaudience.clients.AudienceRestClient;

public class AudienceRestJsonUtil {
    static String PROVINCE = "province";
    static String CITY = "city";
    static String GENDER = "gender";
    static String AGE = "age";
    static String DEVICE = "device";
    static String KEYWORD = "keyword";
    static String INTEREST = "interest";
    static String RAW_INTEREST = "raw_interest";
    static String AGGS_FIELDS = "aggs_fields";

    static String NODE_BRAND = "brand";
    static String NODE_COMPETITOR = "competitor";

    static public JSONObject getAudienceJSON(final String[] province, final String[] city, final String[] gender,
            final String[] age, final String[] device, final String[] keyword, final String[] interest,
            final String[] rawInterset, final String[] aggs) {

        JSONObject result = new JSONObject();

        createJSONObjectNodeByArray(result, PROVINCE, province);
        createJSONObjectNodeByArray(result, CITY, city);
        createJSONObjectNodeByArray(result, GENDER, gender);
        createJSONObjectNodeByArray(result, AGE, age);
        createJSONObjectNodeByArray(result, DEVICE, device);
        createJSONObjectNodeByArray(result, KEYWORD, keyword);
        createJSONObjectNodeByArray(result, INTEREST, interest);
        createJSONObjectNodeByArray(result, RAW_INTEREST, rawInterset);

        if (ArrayUtils.isNotEmpty(aggs)) {
            result.put(AGGS_FIELDS, aggs);
        }
        return result;
    }

    static private void createJSONObjectNodeByArray(final JSONObject parent, final String key, final String[] parame) {
        if (parame == null || parame.length == 0 || parent == null || StringUtils.isBlank(key)) {
            return;
        }

        JSONArray tempArray = new JSONArray();
        String temp;
        JSONObject jobject = null;
        for (int i = 0; i < parame.length; i++) {
            temp = parame[i];
            if (StringUtils.isNotBlank(temp)) {
                jobject = new JSONObject();
                jobject.put("key", temp);
                tempArray.add(jobject);
            }
        }
        if (tempArray.size() >= 0) {
            parent.put(key, tempArray);
        }

    }

    static public JSONObject getIaudienceComparesionParame(final String[] brandKeyword,
            final String[] otherBrandKeyword) {

        JSONObject parame = new JSONObject();
        String[] provinces = null;
        String[] citys = null;
        String[] genders = null;
        String[] ages = null;
        String[] devices = null;
        // String[] keywords = null;
        String[] interests = null;
        String[] rawIntersets = null;
        String[] aggss = { AGE, GENDER, INTEREST, DEVICE, CITY, PROVINCE, RAW_INTEREST };

        JSONObject brandJSONObject = AudienceRestJsonUtil.getAudienceJSON(provinces, citys, genders, ages, devices,
                brandKeyword, interests, rawIntersets, aggss);

        parame.put(NODE_BRAND, brandJSONObject);

        JSONObject brandOtherJSONObject = AudienceRestJsonUtil.getAudienceJSON(provinces, citys, genders, ages, devices,
                otherBrandKeyword, interests, rawIntersets, aggss);

        parame.put(NODE_COMPETITOR, brandOtherJSONObject);

        parame.put(AGGS_FIELDS, aggss);

        return parame;

        // JSONObject resultJSONObject =
        // audienceRestClient.getIaudienceComparesion(brandJSONObject);

    }

    public static void main(String[] args) {
        //
        // String[] provinces = null;
        // String[] citys = null;
        // String[] genders = null;
        // String[] ages = null;
        // String[] devices = null;
        // String[] keywords = { "肯德基" };
        // String[] interests = null;
        // String[] rawIntersets = null;
        // String[] aggss = { "age", "gender", "interest", "device", "city",
        // "province", "raw_interest" };
        //
        // // brand
        // JSONObject brandJSONObject =
        // AudienceRestUtil.getAudienceJSON(provinces, citys, genders, ages,
        // devices,
        // keywords, interests, rawIntersets, aggss);
        String[] brand = { "肯德基" };
        String[] otherB = { "麦当劳", "汉堡王" };
        JSONObject brandJSONObject = AudienceRestJsonUtil.getIaudienceComparesionParame(brand, otherB);

        System.out.println(brandJSONObject.toJSONString());
    }
}
