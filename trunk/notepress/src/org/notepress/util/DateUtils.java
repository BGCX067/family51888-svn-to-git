package org.notepress.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期工具类
 * 
 */
public abstract class DateUtils extends org.apache.commons.lang.time.DateUtils {

	/**
	 * 默认日期格式
	 */
	private static final String[] parsePatterns = new String[] { "yy年MM月dd日",
			"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy/MM/dd HH:mm:ss",
			"yyyy/MM/dd"
	// 这里可以增加更多的日期格式，用得多的放在前面
	};

	/**
	 * 根据日期格式返回毫秒数
	 * 
	 * @param str
	 *            "yyyy-MM-dd","yyyy-MM-dd HH:mm:ss", "yyyy/MM/dd HH:mm:ss",
	 *            "yyyy/MM/dd"
	 * @return 毫秒数
	 * @throws ParseException
	 *             解析异常
	 */
	public static long parseDate(String str) throws ParseException {
		if (str == null) {
			str = "1970-01-01";
		}
		Date date = DateUtils.parseDate(str, parsePatterns);
		return date.getTime();
	}

	public static long parseDate(Object str) throws ParseException {
		return DateUtils.parseDate((String) str);
	}

	public static String formatDate(long ms) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(ms);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sf.format(calendar.getTime());
	}

	/**
	 * 使用给定的日期格式将字符串转换为日期
	 * 
	 * @param str
	 *            要转换的字符串
	 * @param parsePattern
	 *            日期格式字符串
	 * @return 转换后的日期
	 * @throws ParseException
	 *             日期格式不匹配
	 */
	public static Date parseDate(String str, String parsePattern)
			throws ParseException {
		return DateUtils.parseDate(str, new String[] { parsePattern });
	}

}