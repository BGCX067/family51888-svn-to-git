package accp.scurity.util;

import java.util.List;

/**
 * AC多模匹配敏感字符工具类接�?
 * 
 * @author shadow
 * @email 124010356@qq.com
 * @create 2012.04.28
 */
public interface AcUtil {

	/**
	 * 匹配敏感字符
	 * 
	 * @param filter
	 *            敏感字符组合
	 * @param word
	 *            �?���?��的文�?
	 * @param regex
	 *            敏感字符组合的切割正�?
	 * @return String 返回格式[333],[world]
	 */
	public String contrast(String filter, String word, String regex);

	/**
	 * 匹配敏感字符
	 * 
	 * @param filter
	 *            敏感字符组合
	 * @param word
	 *            �?���?��的文�?
	 * @return String 返回格式[333],[world]
	 */
	public String contrast(String[] filters, String word);

	/**
	 * 匹配敏感字符
	 * 
	 * @param filter
	 *            敏感字符组合
	 * @param word
	 *            �?���?��的文�?
	 * @return String 返回格式[333],[world]
	 */
	public String contrast(List<String> filters, String word);

}
