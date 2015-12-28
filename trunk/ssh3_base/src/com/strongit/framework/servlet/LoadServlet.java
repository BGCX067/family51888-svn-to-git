package com.strongit.framework.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.logicalcobwebs.proxool.ProxoolFacade;

/**
 * 
 * <p>Title: 解决错误 Exception in thread "HouseKeeper" 
 * java.lang.NullPointerException</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) Strongit 2011</p>
 * <p>Company: </p>
 * @author lanjinghui@foxmail.com
 * @version 1.0
 */
public class LoadServlet extends HttpServlet {
	public void init() throws ServletException {
	}

	public void destroy() {
		//此处添加处理    
		ProxoolFacade.shutdown();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
