package accp.scurity.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;

import accp.scurity.exception.MethodErrorException;
import accp.scurity.exception.ValidateCodeException;


/**
 * spring security登录失败处理
 * 
 * @author shadow
 * @email 124010356@qq.com
 * @create 2012.04.28
 */
public class LoginFailureHandler implements AuthenticationFailureHandler {

	public void onAuthenticationFailure(HttpServletRequest request,
			HttpServletResponse response, AuthenticationException ex)
			throws IOException, ServletException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		if (ex instanceof UsernameNotFoundException) {
			// 账号错误
			request.setAttribute("message","账户输入有误！请重新输入...");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		
		} else if (ex instanceof BadCredentialsException) {
			// 密码错误
			request.setAttribute("message","密码错误码！请重新输入...");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
			
			//response.getWriter().print("s 用户/密码错误,请重新输?");
		} else if (ex instanceof ValidateCodeException) {
			// 验证码错�?
			response.getWriter().print(ex.getMessage());
		} else if (ex instanceof MethodErrorException) {
			// 请求方法错误
			response.getWriter().print(ex.getMessage());
		} else if (ex instanceof SessionAuthenticationException) {
			// 登陆超时错误
			response.sendRedirect(request.getContextPath() + "/error/maximum.jsp");
		} else {
			// 未知异常错误
			response.getWriter().print("未知异常错误,请联系相关技术人�?");
		}
	}
}
