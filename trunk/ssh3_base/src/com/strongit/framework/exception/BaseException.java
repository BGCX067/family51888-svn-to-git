package com.strongit.framework.exception;

/**
 * 异常处理
 * @author lanjh
 *
 */
public class BaseException extends RuntimeException {

	public BaseException() {
	}

	public BaseException(String message) {
		super(message);
	}

	public BaseException(Throwable t) {
		super(t);
	}

	public BaseException(String message, Throwable t) {
		super(message, t);
	}

}
