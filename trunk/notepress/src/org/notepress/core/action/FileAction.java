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
import org.notepress.core.config.ExtraData;
import org.notepress.core.config.FileExtraUtils;
import org.notepress.core.model.File;
import org.notepress.core.model.FileExtra;
import org.notepress.core.model.FileMeta;
import org.notepress.core.model.Tag;
import org.notepress.core.service.IFileService;
import org.notepress.util.DateUtils;
import org.notepress.util.json.JsonBuilder;
import org.notepress.util.spring.SpringContextUtil;

public class FileAction extends MappingDispatchAction {
	public ActionForward query(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String start = (String) request.getParameter("start");
		int starts = NumberUtils.toInt(start);// 如果start为Null,自动转换为0
		if (starts < 0) {
			throw new Exception("系统错误：开始记录数不能小于0。");
		}
		String folderId = (String) request.getParameter("folderId");

		// 得到service
		IFileService fileService = (IFileService) SpringContextUtil
				.getBean("fileService");

		Object[] result = fileService.query(folderId, starts);

		response.getWriter().println(
				JsonBuilder.builderGridJson((List) result[1],
						(Integer) result[0]));
		return null;
	}

	// 创建文本
	public ActionForward create(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String folderId = request.getParameter("folderId");
		if (StringUtils.isBlank(folderId)) {
			throw new Exception("系统错误：缺少必需的参数。");
		}
		// 得到service
		IFileService fileService = (IFileService) SpringContextUtil
				.getBean("fileService");

		// 从form从拷贝属性到领域模型
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		File file = new File();
		BeanUtils.copyProperties(file, baseForm);
		file.setReleaseDate(DateUtils.parseDate(baseForm.get("releaseDate")));

		List<ExtraData> extraDataList = FileExtraUtils.getFileData();
		for (ExtraData extraData : extraDataList) {
			extraData.setValue(request.getParameter(extraData.getId()));
		}

		FileMeta fileMeta = new FileMeta();
		BeanUtils.copyProperties(fileMeta, baseForm);

		fileMeta.setFileStatus(0);// 初始为未审核
		fileMeta.setFileIp(request.getRemoteAddr());

		fileService.create(file, fileMeta, extraDataList, request
				.getParameter("tag"), folderId);

		// 将故事对象返回到页面上，用于在列表上动态增加行
		request.setAttribute("data", JsonBuilder.builderObjectJson(file));
		return mapping.findForward("success");
	}

	public ActionForward read(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String fileId = request.getParameter("fileId");
		if (StringUtils.isBlank(fileId)) {
			throw new Exception("系统错误：缺少必需的参数。");
		}

		// 得到service
		IFileService fileService = (IFileService) SpringContextUtil
				.getBean("fileService");

		// 根据文件id获取结果，结果是一个数组。
		// 第一个要素是文件对象，第二个要素是文件元素对象，第三个要素是文件额外信息列表，第四个要素是文件标记对象列表
		Object[] object = fileService.read(fileId);

		// 将文件元素对象的id设置为空，因为下面需要将数组中的对象全部转为一个json串，如果有属性名相同的则会导致覆盖前面的
		// 而json串并不需要文件元素对象的id
		FileMeta fileMeta = (FileMeta) object[1];
		fileMeta.setId(null);// 以免和file的id名重复

		String fileJson = JsonBuilder.builderFormJson(object[0], object[1]);

		// 将文件额外信息转换为json
		List fileExtras = (List) object[2];
		String fileExtraJson = "";
		for (Object obj : fileExtras) {
			FileExtra fileExtra = (FileExtra) obj;
			fileExtraJson += "," + fileExtra.getMetaName() + ":\""
					+ fileExtra.getMetaValue() + "\"";
		}

		// 将文件标记信息转换为json
		String fileTagJson = ",tag:'";
		List fileTag = (List) object[3];
		// 循环标记列表，用|将标记名称连接为字符串
		for (Object obj : fileTag) {
			Tag tag = (Tag) obj;
			fileTagJson += tag.getTagAlias() + ";";
		}
		// 去掉最后面的一个|
		if (fileTagJson.endsWith(";")) {
			fileTagJson = StringUtils.substring(fileTagJson, 0, fileTagJson
					.length() - 1);
		}
		fileTagJson += "'";// 补齐引号

		String json = StringUtils.substring(fileJson, 0, fileJson.length() - 2)
				+ fileExtraJson + fileTagJson + "}}";
		response.getWriter().println(json);
		return null;
	}

	// 编辑文本
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String fileId = request.getParameter("id");
		if (StringUtils.isBlank(fileId)) {
			throw new Exception("系统错误：缺少必需的参数。");
		}
		// 得到service
		IFileService fileService = (IFileService) SpringContextUtil
				.getBean("fileService");

		// 从form从拷贝属性到领域模型
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		File file = new File();
		BeanUtils.copyProperties(file, baseForm);
		file.setReleaseDate(DateUtils.parseDate(baseForm.get("releaseDate")));

		List<ExtraData> extraDataList = FileExtraUtils.getFileData();
		for (ExtraData extraData : extraDataList) {
			extraData.setValue(request.getParameter(extraData.getId()));
		}

		FileMeta fileMeta = new FileMeta();
		BeanUtils.copyProperties(fileMeta, baseForm);

		fileMeta.setFileIp(request.getRemoteAddr());

		fileService.update(file, fileMeta, extraDataList, request
				.getParameter("tag"));

		// 将故事对象返回到页面上，用于在列表上动态增加行
		request.setAttribute("data", JsonBuilder.builderObjectJson(file));
		return mapping.findForward("success");
	}

	// 删除文本
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String fileId = request.getParameter("fileId");
		if (StringUtils.isBlank(fileId)) {
			throw new Exception("系统错误：缺少必需的参数。");
		}

		// 得到service
		IFileService fileService = (IFileService) SpringContextUtil
				.getBean("fileService");

		// 删除文本
		fileService.delete(fileId);

		return mapping.findForward("success");
	}

	// 改变文本状态
	public ActionForward updateStatus(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String fileId = request.getParameter("fileId");
		if (StringUtils.isBlank(fileId)) {
			throw new Exception("系统错误：缺少必需的参数。");
		}
		int fileStatus = NumberUtils.toInt(request.getParameter("fileStatus"));
		if (!(fileStatus == 0 || fileStatus == 1 || fileStatus == 2
				|| fileStatus == 3 || fileStatus == 4)) {
			throw new Exception("系统错误：未知的状态值。");
		}

		// 得到service
		IFileService fileService = (IFileService) SpringContextUtil
				.getBean("fileService");

		// 发布文本
		fileService.updateStatus(fileId, fileStatus);

		return mapping.findForward("success");
	}

	// 改变文本状态
	public ActionForward updateAttr(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String fileId = request.getParameter("fileId");
		if (StringUtils.isBlank(fileId)) {
			throw new Exception("系统错误：缺少必需的参数。");
		}
		int fileAttr = NumberUtils.toInt(request.getParameter("fileAttr"));
		if (!(fileAttr == 0 || fileAttr == 1 || fileAttr == 2)) {
			throw new Exception("系统错误：未知的状态值。");
		}

		// 得到service
		IFileService fileService = (IFileService) SpringContextUtil
				.getBean("fileService");

		// 发布文本
		fileService.updateAttr(fileId, fileAttr);

		return mapping.findForward("success");
	}

	// 改变文本状态
	public ActionForward recommend(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String fileId = request.getParameter("fileId");
		if (StringUtils.isBlank(fileId)) {
			throw new Exception("系统错误：缺少必需的参数。");
		}
		int recommend = NumberUtils.toInt(request.getParameter("recommend"));
		if (!(recommend == 0 || recommend == 1)) {
			throw new Exception("系统错误：未知的状态值。");
		}

		// 得到service
		IFileService fileService = (IFileService) SpringContextUtil
				.getBean("fileService");

		// 发布文本
		fileService.recommend(fileId, recommend);

		return mapping.findForward("success");
	}

	// 改变文本状态
	public ActionForward top(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String fileId = request.getParameter("fileId");
		if (StringUtils.isBlank(fileId)) {
			throw new Exception("系统错误：缺少必需的参数。");
		}
		int top = NumberUtils.toInt(request.getParameter("top"));
		if (!(top == 0 || top == 1 || top == 2 || top == 3 || top == 7
				|| top == 30 || top == 90 || top == 180 || top == 365)) {
			throw new Exception("系统错误：未知的状态值。");
		}

		// 得到service
		IFileService fileService = (IFileService) SpringContextUtil
				.getBean("fileService");

		// 发布文本
		fileService.top(fileId, top);

		return mapping.findForward("success");
	}
}
