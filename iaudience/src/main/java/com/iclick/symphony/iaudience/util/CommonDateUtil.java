package com.iclick.symphony.iaudience.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public  class CommonDateUtil {
	
	private static final DateFormat datetimeFormater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	private static final DateFormat datetimeFormaterDd = new SimpleDateFormat("yyyyMMdd");

	private static final DateFormat datetimeFormaterDd2 = new SimpleDateFormat("yyyy/MM/dd");

	private static final DateFormat datetimeFormaterDd3 = new SimpleDateFormat("yyyy-MM-dd");
	
	
	/**
	 * convert the date format to yyyy-MM-dd HH:mm:ss
	 * @param time
	 * @return formated time 
	 */
	public static String toDateYYYYMMDDHHMMSS(Date time) {
		if (time != null) {
			return datetimeFormater.format(time);
		}

		return null;

	}

	/**
	 * convert the date format to yyyyMMdd
	 * @param time
	 * @return formated time
	 */
	public static String toDateYYYYMMDD(Date time) {
		if (time != null) {
			return datetimeFormaterDd.format(time);
		}

		return null;

	}

	/**
	 * convert the date format to yyyy/MM/dd
	 * @param time
	 * @return formated time
	 */
	public static String toDateYYYYMMDD2(Date time) {
		if (time != null) {
			return datetimeFormaterDd2.format(time);
		}

		return null;

	}
	/**
	 * convert the date format to yyyy-MM-dd
	 * @param time
	 * @return formated time
	 */
	public static String toDateYYYYMMDD3(Date time) {
		if (time != null) {
			return datetimeFormaterDd3.format(time);
		}

		return null;

	}

	public static void main(String[] args) throws ParseException {
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		String str = "20170622";
		System.out.println(df.parse(str));
	}

	
}
