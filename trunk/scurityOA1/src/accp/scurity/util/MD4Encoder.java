package accp.scurity.util;

import org.springframework.security.authentication.encoding.Md4PasswordEncoder;


/**
 * MD4加密工具实现�?不支持�?转算�?
 * 
 * @author shadow
 * @email 124010356@qq.com
 * @create 2012.04.28
 */
public class MD4Encoder implements Encoder {

	public String decrypt(String password, String key) {
		//不支持该方法抛出UnsupportedOperationException异常
		throw new UnsupportedOperationException("Not supported the mehtod");
	}

	public String encrypt(String password) {
		//使用SPRING SECURITY3里的MD4实现�?
		return new Md4PasswordEncoder().encodePassword(password, null);
	}

	public String encrypt(String password, String salt) {
		//使用SPRING SECURITY3里的MD4实现�?
		return new Md4PasswordEncoder().encodePassword(password, salt);
	}

}
