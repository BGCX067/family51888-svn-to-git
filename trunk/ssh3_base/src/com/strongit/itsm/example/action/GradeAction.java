package com.strongit.itsm.example.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.strongit.framework.util.Page;
import com.strongit.itsm.example.form.GradeForm;
import com.strongit.itsm.example.model.GradeModel;
import com.strongit.itsm.example.service.ebi.GradeEbi;
/**
 * 班级管理
 * @author lanjh
 *
 */
public class GradeAction extends DispatchAction {

	private GradeEbi gradeEbi;

	public ActionForward listGrade(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Page<GradeModel> page = new Page<GradeModel>();

		page.setAutoCount(true);//自动查询所有记录
		page.setPageSize(10);//设置页面大小
		int pageNo = request.getParameter("pageNo") != null ? Integer
				.valueOf(request.getParameter("pageNo")) : 1;//获取页号
		page.setPageNo(pageNo);//设置页号
		page.setOrderBy("uuid");//设置order关键字
		page.setOrder("desc");//设置order顺序

		page = gradeEbi.find(page, " from GradeModel ");

		request.setAttribute("page", page);

		return mapping.findForward("listGrade");
	}

	public ActionForward beforeaddGrade(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		return mapping.findForward("addGrade");
	}

	public ActionForward addGrade(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String message = null;
		GradeForm gradeForm = (GradeForm) form;

		GradeModel model = new GradeModel();

		org.springframework.beans.BeanUtils.copyProperties(gradeForm, model);

		if (gradeEbi.create(model) != null) {
			message = "增加成功!";
		} else {
			message = "增加失败!";
		}
		request.setAttribute("message", message);

		return listGrade(mapping, form, request, response);
	}

	public ActionForward deleteGrade(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String message = null;
		GradeModel model = gradeEbi.findUniqueByProperty("uuid", request
				.getParameter("uuid") != null ? Integer.valueOf(request
				.getParameter("uuid")) : 1);

		if (gradeEbi.delete(model)!=null) {
			message = "删除成功!";
		} else {
			message = "删除失败!";
		}
		request.setAttribute("message", message);
		return listGrade(mapping, form, request, response);
	}

	public ActionForward beforeUpdateGrade(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		GradeModel model = gradeEbi.findUniqueByProperty("uuid", request
				.getParameter("uuid") != null ? Integer.valueOf(request
				.getParameter("uuid")) : 1);

		request.setAttribute("model", model);

		return mapping.findForward("updateGrade");
	}

	public ActionForward updateGrade(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String message = null;
		GradeForm gradeForm = (GradeForm) form;

		GradeModel model = new GradeModel();

		// String[] arg = {"snum"}; //忽略次属性的赋值
		// org.springframework.beans.BeanUtils.copyProperties(gradeForm,
		// model,arg);

		org.springframework.beans.BeanUtils.copyProperties(gradeForm, model);

		if (gradeEbi.update(model)!=null) {
			message = "修改成功!";
		} else {
			message = "修改失败!";
		}
		request.setAttribute("message", message);

		return listGrade(mapping, form, request, response);
	}

	public GradeEbi getGradeEbi() {
		return gradeEbi;
	}

	public void setGradeEbi(GradeEbi gradeEbi) {
		this.gradeEbi = gradeEbi;
	}

}
