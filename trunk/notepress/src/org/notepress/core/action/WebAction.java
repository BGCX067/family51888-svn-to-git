package org.notepress.core.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.MappingDispatchAction;
import org.notepress.core.model.Category;
import org.notepress.core.model.File;
import org.notepress.core.model.Folder;
import org.notepress.core.model.Reply;
import org.notepress.core.model.ReplyMeta;
import org.notepress.core.model.Story;
import org.notepress.core.service.ICategoryService;
import org.notepress.core.service.IFileService;
import org.notepress.core.service.IFolderService;
import org.notepress.core.service.IReplyService;
import org.notepress.core.service.IStoryService;
import org.notepress.core.vo.FileDownloadUrl;
import org.notepress.util.DateUtils;
import org.notepress.util.HtmlUtils;
import org.notepress.util.hibernate.HibernatePager;
import org.notepress.util.spring.SpringContextUtil;

public class WebAction extends MappingDispatchAction {

	// 根据查询参数列出故事列表
	public ActionForward index(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		try {
			// 得到service
			IFileService fileService = (IFileService) SpringContextUtil
					.getBean("fileService");

			// 最新的文件
			List newFileList = fileService.findFile("new");

			request.setAttribute("newFileList", newFileList);
			return mapping.findForward("target");
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("error");
		}
	}

	// 根据查询参数列出故事列表
	public ActionForward categoryIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数

		String categoryId = (String) request.getParameter("categoryId");
		if (StringUtils.isBlank(categoryId)) {
			return mapping.findForward("error");
		}
		try {
			// 得到service
			IStoryService storyService = (IStoryService) SpringContextUtil
					.getBean("storyService");
			ICategoryService categoryService = (ICategoryService) SpringContextUtil
					.getBean("categoryService");
			List result = storyService.list(categoryId);
			Category category = categoryService.read(categoryId);

			request.setAttribute("storyList", result);
			request.setAttribute("category", category);
			return mapping.findForward("target");
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("error");
		}
	}

	// 根据查询参数列出故事列表
	public ActionForward storyIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数

		String storyId = (String) request.getParameter("storyId");
		if (StringUtils.isBlank(storyId)) {
			return mapping.findForward("error");
		}
		try {
			// 得到service
			IStoryService storyService = (IStoryService) SpringContextUtil
					.getBean("storyService");
			IFolderService folderService = (IFolderService) SpringContextUtil
					.getBean("folderService");
			IFileService fileService = (IFileService) SpringContextUtil
					.getBean("fileService");
			// 故事的详细信息
			Story story = storyService.read(storyId);

			// 最新的文件
			List newFileList = fileService.findFileByStoryId(storyId, "new");

			// 最热的文件
			List hotFileList = fileService.findFileByStoryId(storyId, "hot");

			// 文件夹列表
			List folderList = folderService.findFolderByStoryId(storyId);

			request.setAttribute("story", story);
			request.setAttribute("newFileList", newFileList);
			request.setAttribute("hotFileList", hotFileList);
			request.setAttribute("folderList", folderList);
			return mapping.findForward("target");
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("error");
		}
	}

	// 根据查询参数列出故事列表
	public ActionForward folderIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数

		String folderId = (String) request.getParameter("folderId");
		String pageNo = (String) request.getParameter("pageNo");
		if (StringUtils.isBlank(folderId)) {
			return mapping.findForward("error");
		}
		if (StringUtils.isBlank(pageNo)) {
			pageNo = "1";
		}
		try {
			// 得到service
			IStoryService storyService = (IStoryService) SpringContextUtil
					.getBean("storyService");
			IFolderService folderService = (IFolderService) SpringContextUtil
					.getBean("folderService");
			IFileService fileService = (IFileService) SpringContextUtil
					.getBean("fileService");
			Folder folder = folderService.read(folderId);
			Story story = storyService.read(folder.getStoryId());

			// 文件夹列表
			List folderList = folderService.findFolderByStoryId(story.getId());

			// 文件夹列表
			HibernatePager hp = fileService.findPagerFileByFolderId(folderId,
					pageNo);

			request.setAttribute("story", story);
			request.setAttribute("folder", folder);

			request.setAttribute("fileList", hp);
			request.setAttribute("folderList", folderList);
			return mapping.findForward("target");
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("error");
		}
	}

	// 根据查询参数列出故事列表
	public ActionForward fileIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数

		String fileId = (String) request.getParameter("fileId");
		if (StringUtils.isBlank(fileId)) {
			return mapping.findForward("error");
		}

		try {
			// 得到service
			IFileService fileService = (IFileService) SpringContextUtil
					.getBean("fileService");
			IReplyService replyService = (IReplyService) SpringContextUtil
					.getBean("replyService");
			// 更新点击数
			fileService.updateCount(fileId);

			Object[] obj = fileService.read(fileId);

			List urlList = new ArrayList();
			// 文件的下载地址
			String downloadUrlString = ((File) obj[0]).getUrl();
			// 如果不为空，说明是文件下载，那么需要处理下载地址
			if (!StringUtils.isBlank(downloadUrlString)) {
				String[] urlStringArray = downloadUrlString.split("\n");// 回车符，一行表示一个下载地址
				for (String urlString : urlStringArray) {
					// 查找第一个'-'，'-'前是下载名，空格后是下载地址
					int i = urlString.indexOf("-");
					FileDownloadUrl fdu = new FileDownloadUrl(urlString
							.substring(i + 1, urlString.length()), urlString
							.substring(0, i));
					urlList.add(fdu);
				}
			}
			List replyList = replyService.queryByFileId(fileId);// 评论列表
			request.setAttribute("file", obj[0]);
			request.setAttribute("urlList", urlList);
			request.setAttribute("fileMeta", obj[1]);
			request.setAttribute("fileExtra", obj[2]);
			request.setAttribute("tagList", obj[3]);
			request.setAttribute("replyList", replyList);

			return mapping.findForward("target");
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("error");
		}
	}

	// 根据查询参数列出故事列表
	public ActionForward tagIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数

		String tagName = (String) request.getParameter("tagName");
		if (StringUtils.isBlank(tagName)) {
			return mapping.findForward("error");
		}

		try {
			// 得到service
			IFileService fileService = (IFileService) SpringContextUtil
					.getBean("fileService");

			List fileList = fileService.findFileByTagName(tagName);

			request.setAttribute("fileList", fileList);

			return mapping.findForward("target");
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("error");
		}
	}

}
