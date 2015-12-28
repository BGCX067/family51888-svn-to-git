package accp.scurity.util;

import org.springframework.security.authentication.encoding.ShaPasswordEncoder;


/**
 * SHA加密工具实现�?不支持�?转算�?
 * 
 * @author shadow
 * @email 124010356@qq.com
 * @create 2012.04.28
 */
public class SHAEncoder implements Encoder {

	public String decrypt(String password, String key) {
		//不支持该方法抛出UnsupportedOperationException异常
		throw new UnsupportedOperationException("Not supported the mehtod");
	}

	/**
	 * 不添加盐值加�?
	 */
	public String encrypt(String password) {
		//使用SPRING SECURITY3里的SHA实现�?
		return new ShaPasswordEncoder().encodePassword(password, null);
	}

	/**
	 * 添加盐�?加密
	 */
	public String encrypt(String password, String salt) {
		//使用SPRING SECURITY3里的SHA实现�?
		return new ShaPasswordEncoder().encodePassword(password, salt);
	}

}
