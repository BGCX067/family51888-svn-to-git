package org.notepress.util.hibernate;

import java.io.Serializable;

import org.hibernate.CallbackException;
import org.hibernate.type.Type;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class UserInterceptor extends org.hibernate.EmptyInterceptor {

	private static final long serialVersionUID = 5456043427928970422L;

	public boolean onSave(Object entity, Serializable id, Object[] state,
			String[] propertyNames, Type[] types) throws CallbackException {
		Authentication authentication = SecurityContextHolder.getContext()
				.getAuthentication();// 取得用户信息
		if (authentication != null && entity instanceof IModelIntercept) {
			long ct = System.currentTimeMillis();// 当前系统时间
			UserDetails userDetails = (UserDetails) authentication
					.getPrincipal();// 取得用户信息
			String user = userDetails.getUsername();

			for (int i = 0; i < propertyNames.length; i++) {
				if ("createTime".equals(propertyNames[i])
						|| "updateTime".equals(propertyNames[i])) {
					state[i] = ct;
				} else if ("creater".equals(propertyNames[i])) {
					state[i] = user;
				}
			}
			return true;
		}
		return false;
	}

	public boolean onFlushDirty(Object entity, Serializable id,
			Object[] currentState, Object[] previousState,
			String[] propertyNames, Type[] types) throws CallbackException {
		Authentication authentication = SecurityContextHolder.getContext()
				.getAuthentication();// 取得用户信息
		if (authentication != null && entity instanceof IModelIntercept) {
			long ct = System.currentTimeMillis();// 当前系统时间
			for (int i = 0; i < propertyNames.length; i++) {
				if ("updateTime".equals(propertyNames[i])) {
					currentState[i] = ct;
				}
			}
			return true;
		}
		return false;
	}
}
