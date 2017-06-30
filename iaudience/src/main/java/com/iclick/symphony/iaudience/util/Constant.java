package com.iclick.symphony.iaudience.util;

import java.util.LinkedHashMap;
import java.util.Map;

public class Constant {

	public static final String RADIO_OFF = "0";
	public static final String RADIO_ON = "1";
	public static final String[] DEFAULT_ARRAY_VALUE = new String[] { "" };
	public static final String BLANK = "";
	public static final Map<String,String> RECENCY_ZH = new LinkedHashMap<String,String>();
	public static final Map<String,String> RECENCY_EN = new LinkedHashMap<String,String>();

	public static final Map<String,String> LOGIC_ZH = new LinkedHashMap<>();
	public static final Map<String,String> LOGIC_EN = new LinkedHashMap<>();

	public static final int UNSTART = 0;
	public static final int RUNNING = 1;
	public static final int COMPLETE = 2;




	static {
		RECENCY_ZH.put("All","所有时间");
		RECENCY_ZH.put("14DAYS","过去14天");
		RECENCY_ZH.put("1MONTHS","过去1个月");
		RECENCY_ZH.put("2MONTHS","过去2个月");
		RECENCY_ZH.put("3MONTHS","过去3个月");
		RECENCY_ZH.put("4MONTHS","过去4个月");
		RECENCY_ZH.put("5MONTHS","过去5个月");
		RECENCY_ZH.put("6MONTHS","过去6个月");
		RECENCY_ZH.put("7MONTHS","过去7个月");
		RECENCY_ZH.put("8MONTHS","过去8个月");
		RECENCY_ZH.put("9MONTHS","过去9个月");
		RECENCY_ZH.put("10MONTHS","过去10个月");
		RECENCY_ZH.put("11MONTHS","过去11个月");
		RECENCY_ZH.put("12MONTHS","过去12个月");

		RECENCY_EN.put("All","All Period");
		RECENCY_EN.put("14DAYS","Last 14 days");
		RECENCY_EN.put("1MONTHS","Last month");
		RECENCY_EN.put("2MONTHS","Last 2 months");
		RECENCY_EN.put("3MONTHS","Last 3 months");
		RECENCY_EN.put("4MONTHS","Last 4 months");
		RECENCY_EN.put("5MONTHS","Last 5 months");
		RECENCY_EN.put("6MONTHS","Last 6 months");
		RECENCY_EN.put("7MONTHS","Last 7 months");
		RECENCY_EN.put("8MONTHS","Last 8 months");
		RECENCY_EN.put("9MONTHS","Last 9 months");
		RECENCY_EN.put("10MONTHS","Last 10 months");
		RECENCY_EN.put("11MONTHS","Last 11 months");
		RECENCY_EN.put("12MONTHS","Last 12 months");

		LOGIC_ZH.put("or","或");
		LOGIC_ZH.put("and","与");
		LOGIC_ZH.put("not","非");

		LOGIC_EN.put("or","Or");
		LOGIC_EN.put("and","And");
		LOGIC_EN.put("not","Not");

	}



    public static final String[] AGEGROUP = { "0-17", "18-24", "25-34", "35-44", "45-54", "55-64" };



}
