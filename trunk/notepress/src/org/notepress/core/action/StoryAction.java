package org.notepress.core.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.MappingDispatchAction;
import org.apache.struts.validator.LazyValidatorForm;
import org.notepress.core.model.Story;
import org.notepress.core.service.IStoryService;
import org.notepress.util.json.JsonBuilder;
import org.notepress.util.spring.SpringContextUtil;

public class StoryAction extends MappingDispatchAction {
	// 转向故事管理首页
	public ActionForward index(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("target");
	}

	// 根据查询参数列出故事列表
	public ActionForward query(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String start = (String) request.getParameter("start");
		int starts = NumberUtils.toInt(start);// 如果start为Null,自动转换为0
		if (starts < 0) {
			throw new Exception("系统错误：开始记录数不能小于0。");
		}
		String title = (String) request.getParameter("title");
		String cagegoryId = (String) request.getParameter("cagegoryId");

		// 得到service
		IStoryService storyService = (IStoryService) SpringContextUtil
				.getBean("storyService");

		Object[] result = storyService.query(title, cagegoryId, starts);

		response.getWriter().println(
				JsonBuilder.builderGridJson((List) result[1],
						(Integer) result[0]));
		return null;
	}

	// 创建故事
	public ActionForward create(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String categoryId = request.getParameter("categoryId");
		if (StringUtils.isBlank(categoryId)) {
			throw new Exception("系统错误：栏目ID为空。");
		}
		// 得到service
		IStoryService storyService = (IStoryService) SpringContextUtil
				.getBean("storyService");

		// 从form从拷贝属性到领域模型
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		Story story = new Story();
		BeanUtils.copyProperties(story, baseForm);

		storyService.create(story);

		// 将故事对象返回到页面上，用于在列表上动态增加行
		request.setAttribute("data", JsonBuilder.builderObjectJson(story));
		return mapping.findForward("success");
	}

	// 读取故事
	public ActionForward read(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String storyId = request.getParameter("storyId");
		if (StringUtils.isBlank(storyId)) {
			throw new Exception("系统错误：故事ID为空。");
		}

		// 得到service
		IStoryService storyService = (IStoryService) SpringContextUtil
				.getBean("storyService");

		// 根据故事ID获取故事对象
		Story story = storyService.read(storyId);

		response.getWriter().println(JsonBuilder.builderFormJson(story));
		return null;
	}

	// 编辑故事
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String storyId = request.getParameter("id");
		if (StringUtils.isBlank(storyId)) {
			throw new Exception("系统错误：故事ID为空。");
		}

		// 得到service
		IStoryService storyService = (IStoryService) SpringContextUtil
				.getBean("storyService");

		// 从form从拷贝属性到领域模型
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		Story story = new Story();
		BeanUtils.copyProperties(story, baseForm);

		storyService.update(story);

		return mapping.findForward("success");
	}

	// 删除栏目
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String storyId = request.getParameter("storyId");
		if (StringUtils.isBlank(storyId)) {
			throw new Exception("系统错误：栏目ID为空。");
		}

		// 得到service
		IStoryService storyService = (IStoryService) SpringContextUtil
				.getBean("storyService");

		// 删除故事
		storyService.delete(storyId);

		return mapping.findForward("success");
	}
}
