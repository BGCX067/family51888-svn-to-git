package org.notepress.core.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.MappingDispatchAction;
import org.apache.struts.upload.FormFile;
import org.apache.struts.validator.LazyValidatorForm;
import org.notepress.core.service.IFileService;
import org.notepress.core.service.IFolderService;
import org.notepress.core.service.IStoryService;
import org.notepress.util.spring.SpringContextUtil;
import org.notepress.util.upload.UploadConfig;
import org.notepress.util.upload.UploadConfigUtils;

public class ThumbnailAction extends MappingDispatchAction {
	private static final long serialVersionUID = -1713616715400305663L;

	// 删除缩略图
	public ActionForward deleteThumbnail(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// 检查必要的参数
		String id = request.getParameter("id");
		String target = request.getParameter("target");
		if (StringUtils.isBlank(id)) {
			throw new Exception("系统错误：缺少必需的参数。");
		}
		if (target.equals("story")) {
			IStoryService service = (IStoryService) SpringContextUtil
					.getBean("storyService");
			service.updateThumbnail(id, null);
		} else if (target.equals("folder")) {
			IFolderService service = (IFolderService) SpringContextUtil
					.getBean("folderService");
			service.updateThumbnail(id, null);
		} else if (target.equals("file")) {
			IFileService service = (IFileService) SpringContextUtil
					.getBean("fileService");
			service.updateThumbnail(id, null);
		}

		return mapping.findForward("success");
	}

	public ActionForward upload(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Cookie[] cookies = request.getCookies();
		if(cookies!=null)
		{
		    for (int i = 0; i < cookies.length; i++)
		    {
		       Cookie c = cookies[i];    
		       System.out.println(c.getName());
		       System.out.println(c.getValue());
		     
		    } 
		  }
		// 转换form
		LazyValidatorForm baseForm = (LazyValidatorForm) form;

		// 获取id
		String id = (String) baseForm.get("id");
		String target = (String) baseForm.get("target");
		String mediaPath = "";
		// 得到关于文件上传的相关参数
		UploadConfig uploadConfig = UploadConfigUtils.getUploadConfig();

		// struts内置了对上传文件的处理，可直接获取文件字段，将之转化为org.apache.struts.upload.FormFile，FormFile可以获取文件的相关信息。
		// Filedata是swfupload组件上传文件的字段名
		FormFile formFile = (FormFile) baseForm.get("Filedata");
		if (formFile != null) {// 如果meida的id不为空，则表明是进行修改
			String fileName = formFile.getFileName().toLowerCase();// 获取原始文件名并
			// 转为小写

			int dotAt = fileName.lastIndexOf(".");// 从后面查找最后一个.的位置，以便得到文件的扩展名
			String contentType = fileName.substring(dotAt + 1, fileName
					.length());// 获取原始文件的扩展名

			// 如果文件长度为0，则返回错误提示
			if (formFile.getFileData().length == 0) {
				response.getWriter().println("{success:false,msg:'不允许上传空文件！'}");
				return null;
			}

			// 如果文件长度大于配置文件中规定的长度，则返回错误提示
			if (formFile.getFileData().length > uploadConfig.getFileSize()) {
				response.getWriter().println(
						"{success:false,msg:'此文件大小超出服务器限制！'}");
				return null;
			}

			// 如果文件类型不在规定的范围内，则返回错误提示
			if (!checkContentType(contentType, uploadConfig.getFileType())) {// 检查文件类型
				response.getWriter()
						.println("{success:false,msg:'不允许上传此类文件！'}");
				return null;
			}

			// 保存文件到指定的目录，并返回路径
			mediaPath = saveFile(formFile, uploadConfig);

		} else {// 没有文件
			response.getWriter().println("{success:false,msg:'请上传媒体文件！'}");
			return null;
		}

		// 保存文件相关信息到数据库
		try {
			if (target.equals("story")) {
				IStoryService service = (IStoryService) SpringContextUtil
						.getBean("storyService");
				service.updateThumbnail(id, mediaPath);
			} else if (target.equals("folder")) {
				IFolderService service = (IFolderService) SpringContextUtil
						.getBean("folderService");
				service.updateThumbnail(id, mediaPath);
			} else if (target.equals("file")) {
				IFileService service = (IFileService) SpringContextUtil
						.getBean("fileService");
				service.updateThumbnail(id, mediaPath);
			}

			response.getWriter().println(
					"{success:true,msg:'" + mediaPath + "'}");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("{success:false,msg:'保存文件时发生错误！'}");
		}

		return null;
	}

	/**
	 * 将上传的文件保存到指定的目录
	 * 
	 * @param item
	 *            FileItem
	 * @param uploadConfig
	 *            上传的相关配置
	 * @return 文件保存后的url地址
	 * @throws Exception
	 *             任何异常
	 */
	private String saveFile(FormFile formFile, UploadConfig uploadConfig)
			throws Exception {

		Calendar calendar = Calendar.getInstance();

		// 根据文件上传配置产生目录名
		String fileDic = File.separator + "";
		if (uploadConfig.getFileDicPolicy().equals("YEAR-MONTH")) {// 年-月
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM");
			fileDic += simpleDateFormat.format(calendar.getTime());
		} else if (uploadConfig.getFileDicPolicy().equals("YEAR")) {
			fileDic += calendar.get(Calendar.YEAR) + "";
		} else {
			fileDic = "";
		}

		// 根据文件上传配置产生文件名
		String fileName = "";
		if (uploadConfig.getFileNamePolicy().equals("TIME-NAME")) {
			fileName = calendar.getTimeInMillis() + "-"
					+ formFile.getFileName();
		} else if (uploadConfig.getFileNamePolicy().equals("TIME")) {
			fileName = calendar.getTimeInMillis() + "";
		} else {
			fileName = formFile.getFileName() + "";
		}

		// 产生绝对目录名
		String fileFullPath = System.getProperty("notepress.root")
				+ uploadConfig.getFileRootPath() + fileDic;

		// 创建目录对象
		File dir = new File(fileFullPath);
		File file = new File(fileFullPath, fileName);
		// 如果目录已存在，则保存文件
		if (dir.isDirectory()) {
			if (file.exists()) {
				fileName = calendar.getTimeInMillis() + "-" + fileName;
				file = new File(fileFullPath, fileName);
			}
			writeFile(formFile.getFileData(), file);
		} else {// 如果不存在，则创建目录
			if (dir.mkdirs()) {// 目录创建成功
				writeFile(formFile.getFileData(), file);
			} else {// 目录创建失败
				throw new Exception("创建目录失败");
			}
		}
		System.out.println(file.getCanonicalPath());
		String fileUrl = (File.separator + uploadConfig.getFileRootPath()
				+ fileDic + File.separator + fileName).replace(File.separator,
				"/");
		// 返回文件的url路径。例如"/file/2010-01/file-20001011100.gif"
		return fileUrl;
	}

	private void writeFile(byte[] data, File file) throws IOException {
		OutputStream bos = new FileOutputStream(file);
		bos.write(data);
		bos.close();
	}

	private boolean checkContentType(String contentType, String allowContentType) {
		return allowContentType.indexOf("*." + contentType) >= 0;
	}
}
