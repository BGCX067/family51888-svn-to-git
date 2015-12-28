package org.notepress.core.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.MappingDispatchAction;
import org.apache.struts.validator.LazyValidatorForm;
import org.notepress.core.model.Category;
import org.notepress.core.service.ICategoryService;
import org.notepress.util.json.AsyncTreeModel;
import org.notepress.util.json.JsonBuilder;
import org.notepress.util.spring.SpringContextUtil;

public class CategoryAction extends MappingDispatchAction {

	// 转向栏目管理首页
	public ActionForward index(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("target");
	}

	// 根据节点id返回下级节点的json，这个json是异步树形菜单所需要的。
	public ActionForward query(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String parentId = request.getParameter("node");
		if (StringUtils.isBlank(parentId)) {
			parentId = "0";// 0表示是根目录。
		}

		// 得到service
		ICategoryService categoryService = (ICategoryService) SpringContextUtil
				.getBean("categoryService");
		// 得到所有的父id
		List<String> allParentId = categoryService.queryAllParentId();

		// 得到指定父id的子节点
		List<Category> categoryList = categoryService.query(parentId);
		List data = new ArrayList();

		// 循环这些子节点，生成异步树形菜单的节点模型
		for (Category category : categoryList) {
			AsyncTreeModel atm = new AsyncTreeModel();

			atm.setId(category.getId());
			atm.setText(category.getCategoryName());

			boolean isLeaf = true;
			// 将当前节点的id与所有父id进行比较，如果有相同的，则表示此节点不是叶子节点
			for (String pid : allParentId) {
				if (category.getId().equals(pid)) {
					isLeaf = false;
					break;
				}
			}
			if (isLeaf) {
				atm.setLeaf(true);
				atm.setIconCls("np-column-file");
			} else {
				atm.setLeaf(false);
				atm.setIconCls("np-column-folder");
			}
			// 将节点模型增加到list中
			data.add(atm);
		}
		// 根据节点模型的list构造相应的json,并返回到页面上。
		response.getWriter().println(JsonBuilder.builderAsyncTreeJson(data));
		return null;
	}

	// 创建子栏目
	public ActionForward create(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String categoryParentId = request.getParameter("categoryParentId");
		if (StringUtils.isBlank(categoryParentId)) {
			throw new Exception("系统错误：上级栏目ID为空。");
		}

		ICategoryService categoryService = (ICategoryService) SpringContextUtil
				.getBean("categoryService");

		// 从form从拷贝属性到领域模型
		Category category = new Category();
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		BeanUtils.copyProperties(category, baseForm);

		// 得到父栏目
		Category parentCategory = categoryService.read(categoryParentId);
		// 子栏目的类型与父栏目是一致的
		category.setCategoryType(parentCategory.getCategoryType());

		// 创建子栏目
		categoryService.create(category);

		// 将栏目对象返回到页面上，用于在树形节点上动态增加节点
		request.setAttribute("data", JsonBuilder.builderObjectJson(category));
		return mapping.findForward("success");
	}

	// 读取栏目
	public ActionForward read(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String categoryId = request.getParameter("categoryId");
		if (StringUtils.isBlank(categoryId)) {
			throw new Exception("系统错误：栏目ID为空。");
		}

		ICategoryService categoryService = (ICategoryService) SpringContextUtil
				.getBean("categoryService");

		// 根据栏目ID获取栏目对象
		Category category = categoryService.read(categoryId);
		response.getWriter().println(JsonBuilder.builderFormJson(category));
		return null;
	}

	// 编辑栏目
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String categoryId = request.getParameter("id");
		if (StringUtils.isBlank(categoryId)) {
			throw new Exception("系统错误：栏目ID为空。");
		}

		ICategoryService categoryService = (ICategoryService) SpringContextUtil
				.getBean("categoryService");

		// 从form从拷贝属性到领域模型
		Category category = new Category();
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		BeanUtils.copyProperties(category, baseForm);

		// 编辑栏目
		categoryService.update(category);

		return mapping.findForward("success");
	}

	// 删除栏目
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String categoryId = request.getParameter("categoryId");
		if (StringUtils.isBlank(categoryId)) {
			throw new Exception("系统错误：栏目ID为空。");
		}

		ICategoryService categoryService = (ICategoryService) SpringContextUtil
				.getBean("categoryService");

		// 从form从拷贝属性到领域模型
		Category category = new Category();
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		BeanUtils.copyProperties(category, baseForm);

		// 删除栏目
		categoryService.delete(categoryId);

		return mapping.findForward("success");
	}
}
