package org.notepress.security.authentication;

import java.util.Collection;
import java.util.Map;

import org.notepress.security.service.IFunctionService;
import org.notepress.util.spring.SpringContextUtil;
import org.springframework.security.access.ConfigAttribute;

public class SecutiryMetadataSourceProvider {
	private static IFunctionService functionService;
	// 存储资源和角色的对应关系，key是资源的url，value是可访问此url的角色集合
	private static Map<String, Collection<ConfigAttribute>> securityMetadataSource;
	static {
		try {
			System.out.println("开始缓存角色与资源缓存...");
			functionService = (IFunctionService) SpringContextUtil
					.getBean("functionService");
			securityMetadataSource = functionService.findRoleUrl();
			System.out.println("成功缓存角色与资源缓存...");
		} catch (Exception e) {
			System.out.println("缓存角色与资源时发生错误，详细错误如下：");
			e.printStackTrace();
		}
	}

	public static void loadSecurityMetadataSource() throws Exception {
		securityMetadataSource = functionService.findRoleUrl();
		System.out.println("更新角色与资源缓存...");
	}

	public static Map<String, Collection<ConfigAttribute>> getSecurityMetadataSource() {
		return securityMetadataSource;
	}
}
