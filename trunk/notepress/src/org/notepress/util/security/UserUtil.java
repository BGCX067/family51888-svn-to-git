package org.notepress.util.security;

import org.notepress.security.model.Account;
import org.notepress.security.service.IAccountService;
import org.notepress.util.spring.SpringContextUtil;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class UserUtil {
	/**
	 * 获取当前登录用户名
	 * 
	 * @return 当前登录用户名
	 */
	public static String getUserName() {
		try {
			Authentication authentication = SecurityContextHolder.getContext()
					.getAuthentication();// 取得用户信息
			UserDetails userDetails = (UserDetails) authentication
					.getPrincipal();// 取得用户信息
			return userDetails.getUsername();
		} catch (Exception e) {
			return null;
		}
	}

	public static Account getAccount(String userName) {
		IAccountService accountService = (IAccountService) SpringContextUtil
				.getBean("accountService");
		try {
			return accountService.read(userName);
		} catch (Exception e) {
			return null;
		}
	}

}
