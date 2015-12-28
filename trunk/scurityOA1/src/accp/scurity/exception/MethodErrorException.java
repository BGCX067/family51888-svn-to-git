package accp.scurity.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * 请求方法错误异常
 * 
 * @author liangrui
 * @email 382453602@qq.com
 * @create 2013.08.17
 */
@SuppressWarnings("serial")
public class MethodErrorException extends AuthenticationException {

	public MethodErrorException(String msg) {
		super(msg);
	}

	public MethodErrorException(String msg, Throwable t) {
		super(msg, t);
	}

}
