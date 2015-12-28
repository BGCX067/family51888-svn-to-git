package org.notepress.security.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.MappingDispatchAction;
import org.apache.struts.validator.LazyValidatorForm;
import org.notepress.security.model.Account;
import org.notepress.security.service.IAccountService;
import org.notepress.util.spring.SpringContextUtil;

public class AccountAction extends MappingDispatchAction {
	public ActionForward duplicateAccount(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String json = "";
		// 检查必要的参数
		String accountName = request.getParameter("accountName");
		if (StringUtils.isBlank(accountName)) {
			json = "{\"duplicate\":false}";
		} else {
			IAccountService accountService = (IAccountService) SpringContextUtil
					.getBean("accountService");

			json = accountService.duplicateAccount(accountName);
		}
		response.getWriter().println(json);
		return null;
	}

	public ActionForward duplicateEmail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String json = "";
		// 检查必要的参数
		String email = request.getParameter("email");
		if (StringUtils.isBlank(email)) {
			json = "{\"duplicate\":false}";
		} else {
			IAccountService accountService = (IAccountService) SpringContextUtil
					.getBean("accountService");

			json = accountService.duplicateEmail(email);
		}
		response.getWriter().println(json);
		return null;
	}

	public ActionForward createAccount(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数

		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		Account account = new Account();
		BeanUtils.copyProperties(account, baseForm);

		// 得到service
		IAccountService accountService = (IAccountService) SpringContextUtil
				.getBean("accountService");
		account.setAccountStatus(1);
		account.setCreateIp(request.getRemoteAddr());
		account.setCreateTime(System.currentTimeMillis());
		response.getWriter().println(accountService.create(account));
		return null;
	}

	/**
	 * 判断是否为XMLHttpRequest请求
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return 如果是XMLHttpRequest请求，返回true，否则返回false
	 */
	private boolean isXMLHttpRequest(HttpServletRequest request) {
		return request.getHeader("x-requested-with") != null;
	}

	public ActionForward loginSelect(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String error = request.getParameter("error");// 错误信息

		if (error == null) {
			response.getWriter().println("{\"success\":true}");
		} else if (error.equals("1")) {
			response.getWriter().println(
					"{\"success\":false,\"msg\":\"账户名称或密码不正确！\"}");
		} 

		return null;
	}
}
