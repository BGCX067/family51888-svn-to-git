package com.strongit.framework.exception;

 /**
  * 服务层异常抛出处理
 * @author lanjh
  *
  */
public class ServiceException extends BaseException {

	private String bundle = null;

	private String key = null;

	private Object[] args = null;

	public ServiceException(String key) {
		super("message key is " + key);
		this.key = key;
		this.bundle = null;
	}

	public ServiceException(String key, String bundle) {
		super("message key is " + key + " for " + bundle);
		this.key = key;
		this.bundle = bundle;
	}

	public ServiceException(String key, Object[] args) {
		super("message key is " + key);
		this.key = key;
		this.args = args;
	}

	public ServiceException(String key, String bundle, Object[] args) {
		super("message key is " + key + " for " + bundle);
		this.key = key;
		this.bundle = bundle;
		this.args = args;
	}

	public String getBundle() {
		return this.bundle;
	}

	public String getKey() {
		return this.key;
	}

	public Object[] getArgs() {
		return this.args;
	}

	public boolean isMessage() {
		return (this.bundle == null ? true : false);
	}

}
