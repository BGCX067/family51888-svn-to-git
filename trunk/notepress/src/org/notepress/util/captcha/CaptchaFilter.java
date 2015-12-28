package org.notepress.util.captcha;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CaptchaFilter extends HttpServlet implements Filter {
	/**
	 * 判断用户输入的验证码是否正确
	 */
	private static final long serialVersionUID = -5838154525730151323L;

	public void init(FilterConfig config) throws ServletException {
	}

	public void destroy() {
	}

	public void doFilter(ServletRequest servletRequest,
			ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;

		String j_captcha = request.getParameter("j_captcha");
		String captcha = (String) request.getSession().getAttribute("captcha");
		
		if (!"".equals(captcha) && captcha != null) {
			if (j_captcha.equalsIgnoreCase(captcha)) {
				
				filterChain.doFilter(request, response);
			} else {
				response.getWriter().println(
				"{\"success\":false,\"msg\":\"验证文字不正确！\"}");
			}
		} else {
			response.getWriter().println(
			"{\"success\":false,\"msg\":\"验证文字不正确！\"}");
		}
	}
}