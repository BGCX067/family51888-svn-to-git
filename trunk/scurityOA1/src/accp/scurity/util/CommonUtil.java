package accp.scurity.util;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 基本方法工具类接口
 * 
 * @author shadow
 * @email 124010356@qq.com
 * @create 2012.04.28
 */
public interface CommonUtil {

	/**
	 * 获取客户端IP地址
	 * 
	 * @return String
	 */
	public String getClientIP();

	/**
	 * 获取客户端IP地址
	 * 
	 * @param request
	 * @return String
	 */
	public String getClientIP(HttpServletRequest request);

	/**
	 * 分割字符串为ID
	 * 
	 * @param string
	 * @return List<Serializable>
	 */
	public List<Serializable> toArray(String string);

	/**
	 * 分割字符串
	 * 
	 * @param array
	 * @param regex
	 * @return List<Serializable>
	 */
	public List<Serializable> toArray(String string, String regex);

	/**
	 * 把Object对象数组封装成Map
	 * 
	 * @param keys
	 * @param values
	 * @return Map
	 */
	public Map<String, Object> toMap(Object[] keys, Object[] values);

	/**
	 * 把Object对象封装成Map
	 * 
	 * @param key
	 * @param value
	 * @return Map<String, Object>
	 */
	public Map<String, Object> toMap(Object key, Object value);

	/**
	 * 把Object数组键值对封装入Map
	 * 
	 * @param params
	 * @param keys
	 * @param values
	 * @return Map<String, Object>
	 */
	public Map<String, Object> toMap(Map<String, Object> map, Object[] keys,
			Object[] values);

	/**
	 * 把Object键值对封装入Map
	 * 
	 * @param params
	 * @param keys
	 * @param values
	 * @return Map<String, Object>
	 */
	public Map<String, Object> toMap(Map<String, Object> map, Object key,
			Object value);

	/**
	 * 生成String类型UUID编号
	 * 
	 * @return String
	 */
	public String getUUID();

	/**
	 * 自定义编码强转(odlEncode不设置默认为ISO8859-1)
	 * 
	 * @param string
	 * @param oldEncode
	 * @param newEncode
	 * @return String
	 */
	public String toEncoding(String string, String oldEncode, String newEncode);
}
