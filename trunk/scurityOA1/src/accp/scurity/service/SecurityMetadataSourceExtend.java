package accp.scurity.service;

import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

public interface SecurityMetadataSourceExtend extends
		FilterInvocationSecurityMetadataSource {

	/**
	 * 初始化操
	 */
	public void init();

	/**
	 * 加载资源
	 */
	public void load();

	/**
	 * 刷新资源
	 */
	public void expireNow();
}
