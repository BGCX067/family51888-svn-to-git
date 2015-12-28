package com.strongit.itsm.user.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.strongit.framework.util.Page;
import com.strongit.itsm.user.form.UserForm;
import com.strongit.itsm.user.model.UserModel;
import com.strongit.itsm.user.service.impl.IUserService;

public class UserAction extends DispatchAction {

	private IUserService userService;

	public ActionForward listUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Page<UserModel> page = new Page<UserModel>();

		page.setAutoCount(true);//自动查询所有记录
		page.setPageSize(10);//设置页面大小
		int pageNo = request.getParameter("pageNo") != null ? Integer
				.valueOf(request.getParameter("pageNo")) : 1;//获取页号
		page.setPageNo(pageNo);//设置页号
		page.setOrderBy("id");//设置order关键字
		page.setOrder("desc");//设置order顺序

		page = userService.find(page, " from UserModel ");

		request.setAttribute("page", page);

		return mapping.findForward("listUser");
	}

	public ActionForward checkUserName(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		PrintWriter out = null;
		String message = "";
		response.setContentType("text/plain;charset=UTF-8");

		String newUserName = request.getParameter("username");
		String oldUserName = request.getParameter("oldUserName");

		out = response.getWriter();
		if (isPropertyUnique("username", newUserName, oldUserName)) {
			message = "true";
		} else {
			message = "false";
		}
		out.write(message);
		out.flush();

		return null;
	}

	public boolean isPropertyUnique(final String propertyName,
			final Object newValue, final Object oldValue) {

		if (newValue == null || newValue.equals(oldValue)) {
			return true;
		}
		Object object = userService
				.findUniqueByProperty(propertyName, newValue);
		return (object == null);
	}

	public ActionForward beforeaddUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		return mapping.findForward("addUser");
	}

	public ActionForward addUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String message = null;
		UserForm UserForm = (UserForm) form;

		UserModel model = new UserModel();

		org.springframework.beans.BeanUtils.copyProperties(UserForm, model);

		if (userService.create(model) != null) {
			message = "增加成功!";
		} else {
			message = "增加失败!";
		}
		request.setAttribute("message", message);

		return listUser(mapping, form, request, response);
	}

	public ActionForward deleteUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String message = null;
		UserModel model = userService.findUniqueByProperty("id", request
				.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 1);

		if (userService.delete(model) != null) {
			message = "删除成功!";
		} else {
			message = "删除失败!";
		}
		request.setAttribute("message", message);
		return listUser(mapping, form, request, response);
	}

	public ActionForward beforeUpdateUser(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		UserModel model = userService.findUniqueByProperty("id", request
				.getParameter("id") != null ? Integer.valueOf(request
				.getParameter("id")) : 1);

		request.setAttribute("model", model);

		return mapping.findForward("updateUser");
	}

	public ActionForward updateUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String message = null;
		UserForm UserForm = (UserForm) form;

		UserModel model = new UserModel();

		//		 String[] arg = {"uuid","version"}; //忽略次属性的赋值
		//		 org.springframework.beans.BeanUtils.copyProperties(UserForm,
		//		 model,arg);

		org.springframework.beans.BeanUtils.copyProperties(UserForm, model);

		if (userService.update(model) != null) {
			message = "修改成功!";
		} else {
			message = "修改失败!";
		}
		request.setAttribute("message", message);

		return listUser(mapping, form, request, response);
	}

	public IUserService getUserService() {
		return userService;
	}

	public void setUserService(IUserService userService) {
		this.userService = userService;
	}
}
