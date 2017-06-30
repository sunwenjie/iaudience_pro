package com.iclick.symphony.iaudience.util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

public class CommonModelUtil {
	/**
	 * 把数组变成字符串用逗号分割
	 * 
	 * @param array
	 * @return
	 */
	public static String arrayToStr(String[] array) {
		if (array != null && array.length > 0) {
			return StringUtils.join(array, ",");
		}
		return null;
	}

	/**
	 * 把字符串转数组
	 * 
	 * @param array
	 * @return
	 */
	public static String[] strToArray(String str) {
		if (StringUtils.isNotBlank(str)) {
			return str.split(",");
		}
		return null;
	}

	/**
	 * 把数组变成字符串List
	 * 
	 * @param array
	 * @return
	 */
	public static List<String> arrayToList(String[] array) {
		List<String> wordList = new ArrayList<String>();
		for (String word : array) {
			wordList.add(word);
		}
		return wordList;
	}

	/**
	 * 把字符串List变成数组
	 * 
	 * @param strList
	 * @return array
	 */
	public static String[] listToArray(List<String> strList) {
		String[] wordArry = new String[strList.size()];

		for (int i = 0; i < strList.size(); i++) {
			wordArry[i] = strList.get(i);
		}
		return wordArry;
	}

	/**
	 * 验证输入的字符是否包含特殊字符
	 * 
	 * @param word
	 *            输入的字符
	 * @return 验证结果，true or false
	 */
	public static boolean checkWord(String word) {
		// 特殊字符
		String regEx = "[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";
		Pattern p = Pattern.compile(regEx);
		Matcher m = p.matcher(word);
		return m.matches();
	}

	public static void main(String args[]) {
		List<String> wordList = new ArrayList<String>();
		for (String word : "aa".split(",")) {
			wordList.add(word);
		}
		System.out.println(wordList.size());
		System.out.println(checkWord("a"));
	}
}
