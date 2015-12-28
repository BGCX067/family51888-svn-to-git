package accp.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import accp.services.UserServices;
import accp.services.imple.UserServicesImple;

public class GetUserInfo extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
             
	}
//doPost(request,response);
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		System.out.println("servlet 获取principal 中");
		String userName="";
		         //api 原代码
				Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				if (principal instanceof UserDetails) {
					userName = ((UserDetails)principal).getUsername();
				} else {
					userName = principal.toString();
				}
				
		System.out.println("u: "+userName);
		out.print(userName);
		
		System.out.println("开始调用方法..");
		UserServices services=new UserServicesImple();
		//String moedth=services.sayHello("刘备");
		String moedth=services.sayBye("张飞");
		System.out.println(moedth);
	
		
		out.flush();
		out.close();
	}
	

}
