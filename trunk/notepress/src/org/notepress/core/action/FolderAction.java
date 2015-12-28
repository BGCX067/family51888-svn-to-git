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
import org.notepress.core.model.Folder;
import org.notepress.core.service.IFolderService;
import org.notepress.util.json.JsonBuilder;
import org.notepress.util.spring.SpringContextUtil;

public class FolderAction extends MappingDispatchAction {

	// 创建文件夹
	public ActionForward create(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String storyId = request.getParameter("storyId");
		if (StringUtils.isBlank(storyId)) {
			throw new Exception("系统错误：故事ID为空。");
		}
		// 得到service
		IFolderService folderService = (IFolderService) SpringContextUtil
				.getBean("folderService");

		// 从form从拷贝属性到领域模型
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		Folder folder = new Folder();
		BeanUtils.copyProperties(folder, baseForm);

		folderService.create(folder);

		// 将故事对象返回到页面上，用于在列表上动态增加行
		request.setAttribute("data", JsonBuilder.builderObjectJson(folder));
		return mapping.findForward("success");
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
		String storyId = (String) request.getParameter("storyId");

		// 得到service
		IFolderService folderService = (IFolderService) SpringContextUtil
				.getBean("folderService");

		Object[] result = folderService.query(storyId, starts);

		response.getWriter().println(
				JsonBuilder.builderGridJson((List) result[1],
						(Integer) result[0]));
		return null;
	}

	// 读取文件夹
	public ActionForward read(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String folderId = request.getParameter("folderId");
		if (StringUtils.isBlank(folderId)) {
			throw new Exception("系统错误：文件夹ID为空。");
		}

		// 得到service
		IFolderService folderService = (IFolderService) SpringContextUtil
				.getBean("folderService");

		// 根据故事ID获取故事对象
		Folder folder = folderService.read(folderId);

		response.getWriter().println(JsonBuilder.builderFormJson(folder));
		return null;
	}

	// 创建文件夹
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String folderId = request.getParameter("id");
		if (StringUtils.isBlank(folderId)) {
			throw new Exception("系统错误：文件夹ID为空。");
		}
		// 得到service
		IFolderService folderService = (IFolderService) SpringContextUtil
				.getBean("folderService");

		// 从form从拷贝属性到领域模型
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		Folder folder = new Folder();
		BeanUtils.copyProperties(folder, baseForm);

		folderService.update(folder);

		return mapping.findForward("success");
	}

	// 删除文件夹
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String folderId = request.getParameter("folderId");
		if (StringUtils.isBlank(folderId)) {
			throw new Exception("系统错误：文件夹ID为空。");
		}

		// 得到service
		IFolderService folderService = (IFolderService) SpringContextUtil
				.getBean("folderService");

		// 删除故事
		folderService.delete(folderId);

		return mapping.findForward("success");
	}
}
