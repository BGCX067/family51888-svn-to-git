package accp.scurity.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * 验证码错误异�?
 * 
 * @author liangrui
 * @email 382453602@qq.com
 * @create 2013.08.17
 */
@SuppressWarnings("serial")
public class ValidateCodeException extends AuthenticationException {

	public ValidateCodeException(String msg) {
		super(msg);
	}

	public ValidateCodeException(String msg, Throwable t) {
		super(msg, t);
	}
}
