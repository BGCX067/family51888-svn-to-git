package accp.scurity.handler;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;


/**
 * spring security登录成功处理
 * 
 * @author shadow
 * @email 124010356@qq.com
 * @create 2012.04.28
 */
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	//private UserService userService;

	private String indexUrl; // 登陆成功跳转路径



	public String getIndexUrl() {
		return indexUrl;
	}

	public void setIndexUrl(String indexUrl) {
		this.indexUrl = indexUrl;
	}

	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		 accp.bean.User user = (accp.bean.User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		 accp.bean.User vo = getUpdateVO(user, request);
		 //登陆之后 更改用户信息
		//this.userService.LoginForUpdate(vo);
		
		//response.setContentType("text/plain");
		//response.getWriter().print("success");
		 if(indexUrl!=null&&!"".equals(indexUrl)){
		// request.setAttribute("message","");
		 response.sendRedirect(indexUrl);
		 }else{
		 response.setContentType("text/plain");
		 response.getWriter().print("success");
		 }
	}

	private accp.bean.User getUpdateVO(accp.bean.User user, HttpServletRequest request) {
		accp.bean.User vo = new accp.bean.User();

		// �?��登录时间
		//vo.setLastdate(new Date());
		// �?��登录IP
		//String lastip = accp.scurity.util.BaseSupport.CommonUtil.getClientIP(request);
		//vo.setLastip(lastip);
		// 登录次数
	/*	int count = user.getLogincount() + 1;
		vo.setLogincount(count);*/

		vo.setId(user.getId());
		vo.setPassword(user.getPassword());
		vo.setName(user.getName());
		vo.setStatus(user.getStatus());
		vo.setEnabled(user.getStatus()==1?true:false);
		vo.setName(user.getName());
		
		return vo;
	}
}
