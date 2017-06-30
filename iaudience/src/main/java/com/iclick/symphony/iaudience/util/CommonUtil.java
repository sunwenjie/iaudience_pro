package com.iclick.symphony.iaudience.util;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by wenjie.sun on 2017/5/24.
 */
public class CommonUtil {
    public static final PropertiesLoader properties_zh = new PropertiesLoader("message_zh.properties");
    public static final PropertiesLoader properties_en = new PropertiesLoader("message_en.properties");



    public static String formatDate(Date date) {
        return date != null ? formatDate(date, "yyyy-MM-dd HH:mm:ss") : "";
    }

    public static String formatDate(Date date, String format) {
        if (date != null) {
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            return sdf.format(date);
        } else {
            return "";
        }
    }


    /**
     * 保留2位小数
     *
     * @param num
     * @return
     */
    public static String reserved2Digit(String num) {
        return reserved2Digit(Double.parseDouble(num));
    }

    public static String reserved2Digit(Double num) {
        String format = "0.00";
        return new DecimalFormat(format).format(num);
    }

    public static double format2Number(String num) {
        return format2Number(Double.parseDouble(num));
    }

    public static double format2Number(Double num) {
        return Double.valueOf(new DecimalFormat("#.##").format(num));
    }

    /**
     * 数字千位分割, 保留2位
     *
     * @param num
     * @return
     */
    public static String digSeg(Double num) {
        String format = "#,##0.00";
        return new DecimalFormat(format).format(num);
    }

    /**
     * list去重复
     *
     * @param list
     */
    public static void distinctList(List<String> list) {
        for (int i = list.size() - 1; i >= 0; i--) {
            boolean exist = false;
            for (int j = 0; j < i; j++) {
                if (list.get(i).equalsIgnoreCase(list.get(j))) {
                    list.remove(i);
                    exist = true;
                    break;
                }
            }
            if (exist) {
                continue;
            }
        }
    }

    public static void distinctLongList(List<Long> list) {
        for (int i = list.size() - 1; i >= 0; i--) {
            boolean exist = false;
            for (int j = 0; j < i; j++) {
                if (list.get(i) != null && list.get(i).equals(list.get(j))) {
                    list.remove(i);
                    exist = true;
                    break;
                }
            }
            if (exist) {
                continue;
            }
        }
    }
    /***
     * 获取国家化资源文件，按key获取
     *
     * @param request
     * @param key
     * @return
     */
    public static String getProperty(HttpServletRequest request, String key) {
        LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
        String lang = localeResolver.resolveLocale(request).getLanguage();
        String country = localeResolver.resolveLocale(request).getCountry();
        return getProperty(lang, country, key);
    }

    public static String getProperty(String lang, String country, String key) {
        if (properties_zh == null || properties_en == null || !StringUtils.isNotBlank(key)) {
            return "";
        }
        return ("zh".equalsIgnoreCase(lang) && "CN".equalsIgnoreCase(country)) ? properties_zh.getProperty(key) : properties_en.getProperty(key);
    }

}
