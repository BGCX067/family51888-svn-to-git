package accp.scurity.util;

/**
 * 加密工具类接�?
 * 
 * @author shadow
 * @email 124010356@qq.com
 * @create 2012.04.28
 */
public interface Encoder {

	/**
	 * 默认密码
	 */
	public final static String DEFAULT_PASSWORD = "123456";

	/**
	 * 加密字符�?
	 * 
	 * @param password
	 *            密码
	 * @return String
	 */
	public String encrypt(String password);

	/**
	 * 加密字符�?
	 * 
	 * @param password
	 *            密码
	 * @param salt
	 *            盐�?
	 * @return String
	 */
	public String encrypt(String password, String salt);

	/**
	 * 解密字符�?
	 * 
	 * @param password
	 *            密码
	 * @param key
	 *            钥匙
	 * @return String
	 */
	public String decrypt(String password, String key);
}
