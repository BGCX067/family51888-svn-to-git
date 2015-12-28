package org.notepress.core.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.apache.struts.upload.FormFile;
import org.apache.struts.validator.LazyValidatorForm;
import org.notepress.core.model.Media;
import org.notepress.core.service.IMediaService;
import org.notepress.util.json.JsonBuilder;
import org.notepress.util.spring.SpringContextUtil;
import org.notepress.util.upload.UploadConfig;
import org.notepress.util.upload.UploadConfigUtils;

public class MediaAction extends MappingDispatchAction {
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

		// 得到service
		IMediaService mediaService = (IMediaService) SpringContextUtil
				.getBean("mediaService");

		Object[] result = mediaService.query(title, starts);

		response.getWriter().println(
				JsonBuilder.builderGridJson((List) result[1],
						(Integer) result[0]));
		return null;
	}

	private Media doMediaFile(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 转换form
		LazyValidatorForm baseForm = (LazyValidatorForm) form;

		// 将form的内容拷贝到media对象
		Media media = new Media();
		BeanUtils.copyProperties(media, baseForm);
		media.setTitle(URLDecoder.decode(media.getTitle(), "UTF-8"));
		media.setExcerpt(URLDecoder.decode(media.getExcerpt(), "UTF-8"));

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
			String mediaPath = saveFile(formFile, uploadConfig);

			if (media.getId() != null) {
				IMediaService mediaService = (IMediaService) SpringContextUtil
						.getBean("mediaService");
				Media mediaPO = mediaService.read(media.getId());
				deleteFile(System.getProperty("notepress.root")
						+ mediaPO.getMediaPath());
			}

			media.setMediaPath(mediaPath);
			media.setMediaType(contentType);
			return media;
		} else {// 没有文件
			if (media.getId() == null) {// media的id为空，表明是创建
				response.getWriter().println("{success:false,msg:'请上传媒体文件！'}");
				return null;
			} else {// media的id为空，表明是修改
				return media;
			}
		}
	}

	public ActionForward upload(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Media media = doMediaFile(mapping, form, request, response);
		if (media == null) {
			return null;
		} else {
			// 保存文件相关信息到数据库
			try {
				IMediaService mediaService = (IMediaService) SpringContextUtil
						.getBean("mediaService");
				if (media.getId() == null) {
					mediaService.create(media);
				} else {
					mediaService.update(media);
				}

				response.getWriter().println(
						"{success:true,msg:'" + media.getMediaPath() + "'}");
			} catch (Exception e) {
				e.printStackTrace();
				response.getWriter()
						.println("{success:false,msg:'保存文件时发生错误！'}");
			}
		}

		return null;
	}

	public ActionForward read(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 检查必要的参数
		String mediaId = request.getParameter("mediaId");
		if (StringUtils.isBlank(mediaId)) {
			throw new Exception("系统错误：媒体ID为空。");
		}

		// 得到service
		IMediaService mediaService = (IMediaService) SpringContextUtil
				.getBean("mediaService");

		// 根据故事ID获取故事对象
		Media media = mediaService.read(mediaId);

		response.getWriter().println(JsonBuilder.builderFormJson(media));
		return null;
	}

	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String mediaId = request.getParameter("mediaId");
		if (StringUtils.isBlank(mediaId)) {
			throw new Exception("系统错误：媒体ID为空。");
		}
		// 得到service
		IMediaService mediaService = (IMediaService) SpringContextUtil
				.getBean("mediaService");
		Media media = mediaService.read(mediaId);
		deleteFile(System.getProperty("notepress.root") + media.getMediaPath());
		mediaService.delete(mediaId);
		return mapping.findForward("success");
	}

	private void deleteFile(String filePath) throws Exception {
		File file = new File(filePath);
		if (file.exists()) {
			file.delete();
		}
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
