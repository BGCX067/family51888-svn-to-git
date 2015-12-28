package com.strongit.framework.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
/**
 * 全局控制页面跳转类
 * @author lanjh
 *
 */
public class PubAction extends Action {
	
	private String prefix;
	private String suffix;

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String page = request.getParameter("toPage");
		request.getRequestDispatcher(prefix + page + suffix).forward(request,response);
		
		return null;
	}

	

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}
	
	

}
