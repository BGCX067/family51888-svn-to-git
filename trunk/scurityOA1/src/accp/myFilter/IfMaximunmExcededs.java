package accp.myFilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import accp.exception.IfMaximumExceeded;

public class IfMaximunmExcededs implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub

	}

	private  String errorPage;
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		System.out.println("hello ifmaxFilter...");
		try {
		chain.doFilter(request, response);
		} catch (Exception e) {
			if(e instanceof IfMaximumExceeded){//如是是我自定义的异常发生
			//request.setAttribute("IfMaximumExceeded", e);//存储业务异常信息类   
			if("".equals(errorPage))errorPage="/error/maximum.jsp";
			request.getRequestDispatcher(errorPage).forward(request, response);	
			}
		}
		

	}

	public void init(FilterConfig config) throws ServletException {
		errorPage=config.getInitParameter("errorPage");

	}

}
