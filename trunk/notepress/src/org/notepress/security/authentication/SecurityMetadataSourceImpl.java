package org.notepress.security.authentication;

import java.util.Collection;
import java.util.Iterator;
import java.util.Map;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.AntUrlPathMatcher;
import org.springframework.security.web.util.UrlMatcher;

/**
 * 实现SecurityMetadataSource接口，用于定义安全资源的相关方法
 * 
 * @author Administrator
 * 
 */
public class SecurityMetadataSourceImpl implements
		FilterInvocationSecurityMetadataSource {
	private UrlMatcher urlMatcher = new AntUrlPathMatcher();

	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Collection<ConfigAttribute> getAttributes(Object object)
			throws IllegalArgumentException {
		Map<String, Collection<ConfigAttribute>> securityMetadataSource = SecutiryMetadataSourceProvider
				.getSecurityMetadataSource();
		// 获取请求的url
		String requestUrl = ((FilterInvocation) object).getRequestUrl();
		// 获取资源角色集合所有的key
		Iterator<String> iterator = securityMetadataSource.keySet().iterator();
		// 循环这些key，比较请求的url和所有的资源url，如果有相同的，则返回其对应的角色集合
		while (iterator.hasNext()) {
			String sourceUrl = iterator.next();
			if (urlMatcher.pathMatchesUrl(sourceUrl, requestUrl)) {
				return securityMetadataSource.get(sourceUrl);
			}
		}
		return null;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return FilterInvocation.class.isAssignableFrom(clazz);
	}
}
