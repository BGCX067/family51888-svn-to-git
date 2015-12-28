package com.strongit.framework.servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 过滤没有登录时的页面访问
 * @author lanjh
 *
 */

public class SecurityFilter implements Filter {

	public void destroy() {

	}
	public void init(FilterConfig arg0) throws ServletException {

	}
	//过滤没有登录时的页面访问
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)arg0;
		HttpServletResponse response = (HttpServletResponse)arg1;
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		String path = (String)request.getRequestURI();

		if(path.endsWith("login.do")|| (userId != null && !userId.equals(""))){
			chain.doFilter(request,response);
		}else{
			response.sendRedirect("welcome");
		}
	}

}

