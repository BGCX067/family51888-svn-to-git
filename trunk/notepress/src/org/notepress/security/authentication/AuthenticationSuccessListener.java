package org.notepress.security.authentication;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import org.notepress.util.security.UserUtil;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.userdetails.UserDetails;

public class AuthenticationSuccessListener implements
		HttpSessionAttributeListener {

	@Override
	public void attributeAdded(HttpSessionBindingEvent se) {
		String sessionName = se.getName();
		if (sessionName.equals("SPRING_SECURITY_CONTEXT")) {
			SecurityContext securityContext = (SecurityContext) se.getSession()
					.getAttribute("SPRING_SECURITY_CONTEXT");
			Authentication authentication = securityContext.getAuthentication();
			UserDetails userDetails = (UserDetails) authentication
					.getPrincipal();// 取得用户信息
			se.getSession().setAttribute("account",
					UserUtil.getAccount(userDetails.getUsername()));
			//System.out.println("用户名："+userDetails.getUsername());
		}
	}

	public void attributeRemoved(HttpSessionBindingEvent se) {

	}

	public void attributeReplaced(HttpSessionBindingEvent se) {
		String sessionName = se.getName();
		if (sessionName.equals("SPRING_SECURITY_CONTEXT")) {
			SecurityContext securityContext = (SecurityContext) se.getSession()
					.getAttribute("SPRING_SECURITY_CONTEXT");
			Authentication authentication = securityContext.getAuthentication();
			UserDetails userDetails = (UserDetails) authentication
					.getPrincipal();// 取得用户信息
			se.getSession().setAttribute("account",
					UserUtil.getAccount(userDetails.getUsername()));
			//System.out.println("用户名："+userDetails.getUsername());
		}
	}

}
