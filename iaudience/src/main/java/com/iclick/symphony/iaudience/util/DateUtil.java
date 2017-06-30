package com.iclick.symphony.iaudience.util;

import org.apache.commons.lang3.time.DateFormatUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * 
 * @author Ckex.zha <br/>
 *         2016年6月1日上午11:16:52
 */
public class DateUtil extends org.apache.commons.lang3.time.DateUtils {

  private static final EncryUtil enc = new EncryUtil();

  public static final String milli_pattern = "yyyy-MM-dd HH:mm:ss:SSS";

  public static final String def_pattern = "yyyy-MM-dd HH:mm:ss";
  
  public static final String MINUTE_PATTERN = "yyyy-MM-dd-HH-mm";
  
  public static final String day_pattern = "yyyy-MM-dd";

  public static final String hour_minute_pattern = "HH:mm";

  public static final String[] patterns = new String[] {def_pattern, day_pattern};
  
  public static final String TIME_ZONE_DEFAULT = "Asia/Shanghai";
  
  public static final String beginTime = " 00:00:00";
  public static final String endTime = " 23:59:59";

  public static String nowStr() {
    return nowStr(def_pattern);
  }
  
  public static String nowStr(String pattern) {
    return DateFormatUtils.format(getCalendar(), pattern);
  }
  
  public static String nowDayStr() {
    return nowStr(day_pattern);
  }
  
  public static Date now() {
    return new Date();
  }

  public static Calendar getCalendar() {
    return Calendar.getInstance();
  }
  
  public static Calendar getCalendar(TimeZone zone) {
    Calendar now = Calendar.getInstance(zone);
    now.set(Calendar.MILLISECOND, zone.getOffset(System.currentTimeMillis()));
    return now;
  }

  public static int getNowHourTimeZone(Date date, TimeZone zone) {
    return getNowHour(date, "yyyyMMddHH", zone);
  }
  
  public static int getNowHour(Date date, String format) {
    SimpleDateFormat sdf = new SimpleDateFormat(format);
    String hourStr = sdf.format(date);
    return Integer.parseInt(hourStr);
  }
  
  public static int getNowHour(Date date, String format, TimeZone zone) {
    SimpleDateFormat sdf = new SimpleDateFormat(format);
    sdf.setTimeZone(zone);
    String hourStr = sdf.format(date);
    return Integer.parseInt(hourStr);
  }

  public static int getNowHour(Date date) {
    return getNowHour(date, "yyyyMMddHH");
  }
  
  public static int getNowHour() {
    return getNowHour(now());
  }

  public static int getNowHour(TimeZone zone) {
    return getNowHourTimeZone(now(), zone);
  }
  
  public static int getMinute() {
    return getMinute(getCalendar());
  }
  
  public static int getMinute(TimeZone zone) {
    return getMinute(getCalendar(zone));
  }

  private static int getMinute(Calendar cal) {
    return cal.get(Calendar.MINUTE);
  }

  /**
   * 对称解密时间戳,如果不能正常解析,返回 -1.
   * 
   * @param str The string to decrypt.
   * @return The decrypted long value. Returns -1 if there was an error.
   */
  public static final long decTs(String str) {
    try {
      String decryptStr = enc.decrypt(str);
      return Long.valueOf(decryptStr);
    } catch (Exception ex) {
      ex.printStackTrace();
      return -1L;
    }
  }

  /**
   * @return 对当前系统时间(毫秒)的加密码字符串.
   */
  public static String getTsEnc() {
    try {
      return enc.encrypt(String.valueOf(System.currentTimeMillis()));
    } catch (Exception ex) {
      ex.printStackTrace();
      return "";
    }
  }

  public static String format(Date date) {
    return format(date, def_pattern);
  }

  public static String format(Date date, String sdfStr) {
    if (date == null) {
      return null;
    }
    SimpleDateFormat sdf = new SimpleDateFormat(sdfStr);
    return sdf.format(date);
  }

  // time zone ==============
  public static String nowDayStrTimeZone(TimeZone zone) {
    return nowStrTimeZone(day_pattern, zone);
  }
  
  public static String nowStrTimeZone(String pattern, TimeZone zone) {
    Calendar calendar = getCalendar();
    calendar.set(Calendar.MILLISECOND, zone.getOffset(calendar.getTimeInMillis()));
    return format(calendar.getTime(), pattern);
  }
  // time zone ================
  
  /**
   * 返回7天前时间 yyyy-MM-dd.
   * */
  public static String beforSevenDay() {
    Calendar now = getCalendar();
    now.set(Calendar.DATE, now.get(Calendar.DATE) - 6);
    String day = DateFormatUtils.format(now, day_pattern);
    return day;
  }
  
  public static String beforSevenDay(TimeZone zone) {
    Calendar now = getCalendar(zone);
    now.set(Calendar.DATE, now.get(Calendar.DATE) - 6);
    String day = format(now.getTime(), day_pattern);
    return day;
  }

  /**
   * 返回昨天时间 yyyy-MM-dd.
   * */
  public static String yesterday() {
    Calendar now = getCalendar();
    now.set(Calendar.DATE, now.get(Calendar.DATE) - 1);
    String day = DateFormatUtils.format(now, day_pattern);
//    String day = DateFormatUtils.format(now, "yyyyMMdd");
    return day;
  }
  
  public static String yesterday(TimeZone zone) {
    Calendar now = getCalendar(zone);
    now.set(Calendar.DATE, now.get(Calendar.DATE) - 1);
    String day = format(now.getTime(), day_pattern);
    return day;
  }

  /**
   * 返回8天前时间 yyyy-MM-dd.
   * */
  public static String beforEightDay() {
    Calendar now = getCalendar();
    now.set(Calendar.DATE, now.get(Calendar.DATE) - 7);
    String day = DateFormatUtils.format(now, day_pattern);
    return day;
  }
  
  public static String beforEightDay(TimeZone zone) {
    Calendar now = getCalendar(zone);
    now.set(Calendar.DATE, now.get(Calendar.DATE) - 7);
    String day = format(now.getTime(), day_pattern);
    return day;
  }

  /**
   * 返回9天前时间 yyyy-MM-dd.
   * */
  public static String beforNineDay() {
    Calendar now = getCalendar();
    now.set(Calendar.DATE, now.get(Calendar.DATE) - 8);
    String day = DateFormatUtils.format(now, day_pattern);
    return day;
  }
  
  public static String beforNineDay(TimeZone zone) {
    Calendar now = getCalendar(zone);
    now.set(Calendar.DATE, now.get(Calendar.DATE) - 8);
    String day = format(now.getTime(), day_pattern);
    return day;
  }
  
  public static String beforeSixtyMinutes() {
    Calendar now = getCalendar();
    now.set(Calendar.MINUTE, now.get(Calendar.MINUTE) - 59);
    String minute = DateFormatUtils.format(now, hour_minute_pattern);
    return minute;
  }
  
  public static String beforeSixtyMinutes(TimeZone zone) {
    Calendar now = getCalendar(zone);
    now.set(Calendar.MINUTE, now.get(Calendar.MINUTE) - 59);
    String minute = format(now.getTime(), hour_minute_pattern);
    return minute;
  }

  /**
   * 返回这个月月初时间 yyyy-MM-dd.
   * */
  public static String firstDayOfMonth() {
    Calendar now = getCalendar();
    now.set(Calendar.DAY_OF_MONTH, 1);
    String day = DateFormatUtils.format(now, day_pattern);
    return day;
  }
  
  public static String firstDayOfMonth(TimeZone zone) {
    Calendar now = getCalendar(zone);
    now.set(Calendar.DAY_OF_MONTH, 1);
    String day = format(now.getTime(), day_pattern);
    return day;
  }

  /**
   * 返回上个月月初时间 yyyy-MM-dd.
   * */
  public static String firstDayOfLastMonth() {
    Calendar now = getCalendar();
    now.set(Calendar.DAY_OF_MONTH, 1);
    now.add(Calendar.MONTH, -1);
    String day = DateFormatUtils.format(now, day_pattern);
    return day;
  }
  
  public static String firstDayOfLastMonth(TimeZone zone) {
    Calendar now = getCalendar(zone);
    now.set(Calendar.DAY_OF_MONTH, 1);
    now.add(Calendar.MONTH, -1);
    String day = format(now.getTime(), day_pattern);
    return day;
  }

  /**
   * 返回上个月月末时间 yyyy-MM-dd.
   * */
  public static String lastDayOfLastMonth() {
    Calendar now = getCalendar();
    now.set(Calendar.DAY_OF_MONTH, 0);
    String day = DateFormatUtils.format(now, day_pattern);
    return day;
  }
  
  public static String lastDayOfLastMonth(TimeZone zone) {
    Calendar now = getCalendar(zone);
    now.set(Calendar.DAY_OF_MONTH, 0);
    String day = format(now.getTime(), day_pattern);
    return day;
  }

  /**
   * 字符串转Date yyyy-MM-dd.
   * */
  public static Date getDate(String str) {
    Date date = null;
    try {
      date = parseDate(str, patterns);
    } catch (ParseException pe) {
      pe.printStackTrace();
    }
    return date;
  }

  /**
   * 字符串转Date yyyy-MM-dd.
   * */
  public static String getStr(Date date) {
    if (date == null) {
      return null;
    }
    return DateFormatUtils.format(date, day_pattern);

  }

  /**
   * 字符串转Date HH:mm.
   * */
  public static String getHourMinute(Date date) {
    if (date == null) {
      return null;
    }
    return DateFormatUtils.format(date, hour_minute_pattern);
  }

  public static boolean isValidFormat(String format, String value) {
    Date date = null;
    try {
      SimpleDateFormat sdf = new SimpleDateFormat(format);
      date = sdf.parse(value);
      if (!value.equals(sdf.format(date))) {
        date = null;
      }
    } catch (ParseException ex) {
      ex.printStackTrace();
    }
    return date != null;
  }
  
  /**
   * Gets all the supported time zone IDs; sorted by GMT time.
   * 
   * @return A list of supported time zone IDs.
   */
  public static String[] getAllTimeZones() {
    List<TimeZone> sortedTimeZoneList = new ArrayList<>();
    String[] ids = TimeZone.getAvailableIDs();
    for (String id : ids) {
      if (DateUtil.supportedTimeZoneList(id)) {
        sortedTimeZoneList.add(TimeZone.getTimeZone(id));
      }
    }
    Collections.sort(sortedTimeZoneList, new Comparator<TimeZone>() {
      public int compare(TimeZone s1, TimeZone s2) {
        return s1.getRawOffset() - s2.getRawOffset();
      }
    }); // Need to sort the GMT timezone here after getTimeZone() method call
    
    String[] ret = new String[sortedTimeZoneList.size()];
    for (int i = 0; i < sortedTimeZoneList.size(); i++) {
      TimeZone instance = sortedTimeZoneList.get(i);
      ret[i] = instance.getID();
    }
    return ret;
  }
  
  /**
   * Supported time zones for UI display.
   * 
   * @param timeZoneId TimeZone id
   * @return whether or not to display on UI
   */
  private static boolean supportedTimeZoneList(String timeZoneId) {
    String[] timeZones = new String[] {
      "Pacific/Midway",
      "US/Hawaii",
      "US/Alaska",
      "US/Pacific",
      "America/Tijuana",
      "US/Arizona",
      "America/Chihuahua",
      "US/Mountain",
      "America/Guatemala",
      "US/Central",
      "America/Mexico_City",
      "Canada/Saskatchewan",
      "America/Bogota",
      "US/Eastern",
      "US/East-Indiana",
      "Canada/Eastern",
      "America/Caracas",
      "America/Manaus",
      "America/Santiago",
      "Canada/Newfoundland",
      "Brazil/East",
      "America/Buenos_Aires",
      "America/Godthab",
      "America/Montevideo",
      "Atlantic/South_Georgia",
      "Atlantic/Azores",
      "Atlantic/Cape_Verde",
      "Africa/Casablanca",
      "Europe/London",
      "Europe/Berlin",
      "Europe/Belgrade",
      "Europe/Brussels",
      "Europe/Warsaw",
      "Africa/Algiers",
      "Asia/Amman",
      "Europe/Athens",
      "Asia/Beirut",
      "Africa/Cairo",
      "Africa/Harare",
      "Europe/Helsinki",
      "Asia/Jerusalem",
      "Europe/Minsk",
      "Africa/Windhoek",
      "Asia/Baghdad",
      "Asia/Kuwait",
      "Europe/Moscow",
      "Africa/Nairobi",
      "Asia/Tbilisi",
      "Asia/Tehran",
      "Asia/Muscat",
      "Asia/Baku",
      "Asia/Yerevan",
      "Asia/Kabul",
      "Asia/Yekaterinburg",
      "Asia/Karachi",
      "Asia/Calcutta",
      "Asia/Colombo",
      "Asia/Katmandu",
      "Asia/Novosibirsk",
      "Asia/Dhaka",
      "Asia/Rangoon",
      "Asia/Bangkok",
      "Asia/Krasnoyarsk",
      "Asia/Hong_Kong",
      "Asia/Irkutsk",
      "Asia/Kuala_Lumpur",
      "Australia/Perth",
      "Asia/Taipei",
      "Asia/Shanghai",
      "Asia/Tokyo",
      "Asia/Seoul",
      "Asia/Yakutsk",
      "Australia/Adelaide",
      "Australia/Darwin",
      "Australia/Brisbane",
      "Australia/Sydney",
      "Pacific/Guam",
      "Australia/Hobart",
      "Asia/Vladivostok",
      "Asia/Magadan",
      "Pacific/Auckland",
      "Pacific/Chatham",
      "Pacific/Fiji",
      "Pacific/Tongatapu",
      "Pacific/Kiritimati",
      "Pacific/Norfolk",
      "Antarctica/Macquarie",
      "Australia/Lord_Howe",
      "Australia/Eucla",
      "Pacific/Marquesas"
    };
    
    return Arrays.asList(timeZones).contains(timeZoneId);
  }
  
  /**
   * Used by a custom tag to display string on the UI.
   * 
   * @param timeZoneId TimeZone id
   * @param locale the current locale of the user
   * @return Time Zone string
   */
  public static String displayTimeZone(String timeZoneId, Locale locale) {
    TimeZone tz = TimeZone.getTimeZone(timeZoneId); // defaults to GMT if timeZoneId cannot be found.
    long hours = TimeUnit.MILLISECONDS.toHours(tz.getRawOffset());
    long minutes = TimeUnit.MILLISECONDS.toMinutes(tz.getRawOffset()) - TimeUnit.HOURS.toMinutes(hours);
    // avoid -4:-30 issue
    minutes = Math.abs(minutes);

    if (locale.getLanguage().equals("zh")) {
      locale = Locale.SIMPLIFIED_CHINESE;
    } else {
      locale = Locale.ENGLISH;
    }
    String result = "";
    if (hours > 0) {
      result = String.format("(GMT+%d:%02d) %s", hours, minutes, 
          tz.getDisplayName(tz.inDaylightTime(new Date()), TimeZone.LONG, locale) + " - " + tz.getID());
    } else {
      result = String.format("(GMT%d:%02d) %s", hours, minutes, 
          tz.getDisplayName(tz.inDaylightTime(new Date()), TimeZone.LONG, locale) + " - " + tz.getID());
    }

    return result;
  }
  
  public static String getTimeZoneDate(Date time, TimeZone zone, String outPattern) {
    long offset = zone.getOffset(System.currentTimeMillis());
    
    long timeZoneTime = time.getTime() + offset;
    
    SimpleDateFormat sdf = new SimpleDateFormat(outPattern);
    
    return sdf.format(new Date(timeZoneTime));
  }
  
  public static void main(String[] args) {
    List<TimeZone> sortedTimeZoneList = new ArrayList<>();
    String[] ids = TimeZone.getAvailableIDs();
    for (String id : ids) {
      TimeZone tz = TimeZone.getTimeZone(id);
      if (!sortedTimeZoneList.contains(tz.getDisplayName(tz.inDaylightTime(new Date()), TimeZone.LONG, Locale.ENGLISH))) {
        sortedTimeZoneList.add(TimeZone.getTimeZone(id));
      }
    }
    Collections.sort(sortedTimeZoneList, new Comparator<TimeZone>() {
      public int compare(TimeZone s1, TimeZone s2) {
        return s1.getRawOffset() - s2.getRawOffset();
      }
    }); // Need to sort the GMT timezone here after getTimeZone() method call
    
    String[] ret = new String[sortedTimeZoneList.size()];
    for (int i = 0; i < sortedTimeZoneList.size(); i++) {
      TimeZone instance = sortedTimeZoneList.get(i);
      ret[i] = instance.getID();
    }

    for (int i = 0; i < ret.length; i++) {
      System.out.println(displayTimeZone(ret[i], Locale.ENGLISH));
    }
  }
}
