package accp.scurity.util;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;


/**
 * 基本方法工具类实现类
 * 
 * @author shadow
 * @email 124010356@qq.com
 * @create 2012.04.28
 */
public class CommonUtilImpl implements CommonUtil {

	public String getClientIP() {
		return overshot(BaseSupport.ContextUtil.getRequest());
	}

	public String getClientIP(HttpServletRequest request) {
		return overshot(request);
	}

	/**
	 * 获取客户IP地址
	 * 
	 * @param request
	 * @return String
	 */
	private String overshot(HttpServletRequest request) {
		String ipAddress = null;
		// ipAddress = this.getRequest().getRemoteAddr();
		ipAddress = request.getHeader("x-forwarded-for");
		if (ipAddress == null || ipAddress.length() == 0
				|| "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("Proxy-Client-IP");
		}
		if (ipAddress == null || ipAddress.length() == 0
				|| "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ipAddress == null || ipAddress.length() == 0
				|| "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getRemoteAddr();
			if (ipAddress.equals("127.0.0.1")) {
				// 根据网卡取本机配置的IP
				InetAddress inet = null;
				try {
					inet = InetAddress.getLocalHost();
				} catch (UnknownHostException e) {
					e.printStackTrace();
				}
				ipAddress = inet.getHostAddress();
			}

		}

		// 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
		if (ipAddress != null && ipAddress.length() > 15) { // "***.***.***.***".length()
			// = 15
			if (ipAddress.indexOf(",") > 0) {
				ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
			}
		}
		return ipAddress;
	}

	public List<Serializable> toArray(String string) {
		return handleString2Array(string, ",");
	}

	public List<Serializable> toArray(String string, String regex) {
		return handleString2Array(string, regex);
	}

	private List<Serializable> handleString2Array(String array, String regex) {
		List<Serializable> list = new ArrayList<Serializable>();
		Serializable[] strings = StringUtils.split(array, regex);
		for (Serializable string : strings)
			list.add(string);
		return list;
	}

	public Map<String, Object> toMap(Object[] keys, Object[] values) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (null == keys || null == values || keys.length <= 0
				|| values.length <= 0 || keys.length != values.length)
			return map;
		for (int i = 0, len = values.length; i < len; i++)
			map.put(keys[i].toString(), values[i]);
		return map;
	}

	public Map<String, Object> toMap(Map<String, Object> map, Object[] keys,
			Object[] values) {
		if (null == keys || null == values || keys.length <= 0
				|| values.length <= 0 || keys.length != values.length)
			return map;
		for (int i = 0, len = values.length; i < len; i++)
			map.put(keys[i].toString(), values[i]);
		return map;
	}

	public Map<String, Object> toMap(Map<String, Object> map, Object key,
			Object value) {
		if (null == key || null == value || "".equals(key))
			return map;
		map.put(key.toString(), value);
		return map;
	}

	public Map<String, Object> toMap(Object key, Object value) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (null == key || null == value || "".equals(key))
			return map;
		map.put(key.toString(), value);
		return map;
	}

	public String getUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	public String toEncoding(String string, String oldEncode, String newEncode) {
		if (null == oldEncode || "".equals(oldEncode))
			oldEncode = "ISO8859_1";
		try {
			return new String(string.getBytes(oldEncode), newEncode);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "";
		}
	}

}
