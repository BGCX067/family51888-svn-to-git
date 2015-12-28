package org.notepress.core.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.notepress.core.config.ExtraData;
import org.notepress.core.model.File;
import org.notepress.core.model.FileExtra;
import org.notepress.core.model.FileMeta;
import org.notepress.core.model.Tag;
import org.notepress.core.service.IFileService;
import org.notepress.util.hibernate.HibernateDaoSupport;
import org.notepress.util.hibernate.HibernatePager;
import org.notepress.util.hibernate.QueryString;

public class FileServiceImpl extends HibernateDaoSupport implements
		IFileService {

	public void create(File file, FileMeta fileMeta,
			List<ExtraData> extraDataList, String tag, String folderId)
			throws Exception {
		// 创建文本
		String fileId = this.createEntity(file);

		// 创建文本元素
		fileMeta.setFileId(fileId);
		fileMeta.setAgreeAmount(0);
		fileMeta.setClickAmount(0);
		fileMeta.setOpposeAmount(0);
		fileMeta.setHideVote(0);
		fileMeta.setDownloadAmount(0);
		fileMeta.setFileStatus(0);
		fileMeta.setFileAttr(0);
		fileMeta.setRecommend(0);
		this.createEntity(fileMeta);

		// 循环创建标记
		tag = tag.replaceAll("；", ";");
		String[] tagArray = tag.split(";");
		for (String tagName : tagArray) {
			Tag fileTag = new Tag();
			fileTag.setFileId(fileId);
			fileTag.setTagAlias(tagName.trim());
			fileTag.setTagName(tagName.trim());
			this.createEntity(fileTag);
		}

		// 循环创建文本额外数据
		for (ExtraData extraData : extraDataList) {
			FileExtra fem = new FileExtra();
			fem.setFileId(fileId);
			fem.setMetaName(extraData.getId());
			fem.setMetaValue(extraData.getValue());
			this.createEntity(fem);
		}
	}

	public void delete(String fileId) throws Exception {
		File file = (File) this.findEntityById(File.class, fileId);
		java.io.File iofile = new java.io.File(System
				.getProperty("notepress.root")
				+ file.getThumbnail());
		if (iofile.exists()) {
			iofile.delete();
		}
		this.deleteEntity(File.class, fileId);

	}

	public void updateStatus(String fileId, Integer status) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("fileId", fileId);
		parameters.put("fileStatus", status);
		String queryString = "update FileMeta set fileStatus=:fileStatus where fileId=:fileId";
		this.updateEntity(queryString, parameters);
	}

	public void updateAttr(String fileId, Integer status) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("fileId", fileId);
		parameters.put("fileAttr", status);
		String queryString = "update FileMeta set fileAttr=:fileAttr where fileId=:fileId";
		this.updateEntity(queryString, parameters);
	}

	public void recommend(String fileId, Integer recommend) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("fileId", fileId);
		parameters.put("recommend", recommend);
		String queryString = "update FileMeta set recommend=:recommend where fileId=:fileId";
		this.updateEntity(queryString, parameters);
	}

	public void top(String fileId, Integer topTime) throws Exception {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR, topTime);
		Map<String, Object> parameters = new HashMap<String, Object>();

		parameters.put("fileId", fileId);
		parameters.put("topTime", calendar.getTimeInMillis());
		String queryString = "update FileMeta set topTime=:topTime where fileId=:fileId";
		this.updateEntity(queryString, parameters);
	}

	public Object[] query(String folderId, int start) throws Exception {
		QueryString queryString = new QueryString();
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("folderId", folderId);

		queryString
				.setSelect("select new org.notepress.core.vo.FileVo(a.id,a.title,a.thumbnail,a.size,a.author,a.source,b.fileStatus,b.fileAttr,b.recommend,a.releaseDate,a.updateTime)");
		queryString.setFrom("from File a,FileMeta b");
		queryString.setWhere("where a.folderId = :folderId and a.id=b.fileId");

		return this.findEntity(queryString, parameters,
				HibernateDaoSupport.LIMIT, start);
	}

	public Object[] read(String textId) throws Exception {
		Object[] result = new Object[4];
		// 读取文件、文件元素
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("fileId", textId);
		String queryString = "from File a,FileMeta b where a.id = :fileId and a.id=b.fileId";

		List list = this.findEntity(queryString, parameters);

		if (list.size() != 0) {
			result[0] = ((Object[]) list.get(0))[0];
			result[1] = ((Object[]) list.get(0))[1];

			// 读取文件额外信息
			queryString = "from FileExtra where fileId=:fileId";
			result[2] = this.findEntity(queryString, parameters);

			// 读取文件标记信息
			queryString = "from Tag where fileId=:fileId";
			result[3] = this.findEntity(queryString, parameters);
		}

		return result;
	}

	public void update(File file, FileMeta fileMeta,
			List<ExtraData> extraDataList, String tag) throws Exception {
		// 获取数据库中的file
		File filePo = (File) this.findEntityById(File.class, file.getId());

		// 将数据库中的file相关字段赋予给页面上的file
		file.setCreater(filePo.getCreater());
		file.setCreateTime(filePo.getCreateTime());

		this.updateEntity(file);

		// 编辑文本元素，所需积分，花费积分，回复状态，ip
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters = new HashMap<String, Object>();
		parameters.put("fileId", file.getId());
		parameters.put("accessScore", fileMeta.getAccessScore());
		parameters.put("accessCost", fileMeta.getAccessCost());
		parameters.put("replyStatus", fileMeta.getReplyStatus());
		parameters.put("fileIp", fileMeta.getFileIp());

		String queryString = "update FileMeta set accessScore=:accessScore,accessCost=:accessCost,replyStatus=:replyStatus,fileIp=:fileIp where fileId = :fileId";
		this.updateEntity(queryString, parameters);

		// 删除文件所有标记
		parameters = new HashMap<String, Object>();
		parameters.put("fileId", file.getId());
		queryString = "delete Tag where fileId = :fileId";
		this.updateEntity(queryString, parameters);

		// 循环创建标记
		tag = tag.replaceAll("；", ";");
		String[] tagArray = tag.split(";");
		for (String tagName : tagArray) {
			Tag fileTag = new Tag();
			fileTag.setFileId(file.getId());
			fileTag.setTagAlias(tagName.trim());
			fileTag.setTagName(tagName.trim());
			this.createEntity(fileTag);
		}

		// 循环编辑文本额外数据
		for (ExtraData extraData : extraDataList) {
			parameters = new HashMap<String, Object>();
			parameters.put("fileId", file.getId());
			parameters.put("metaName", extraData.getId());
			parameters.put("metaValue", extraData.getValue());
			queryString = "update FileExtra set metaValue=:metaValue where fileId=:fileId and metaName=:metaName";
			this.updateEntity(queryString, parameters);
		}

	}

	@Override
	public void updateThumbnail(String fileId, String thumbnail)
			throws Exception {
		if (StringUtils.isBlank(thumbnail)) {
			File file = (File) this.findEntityById(File.class, fileId);
			java.io.File iofile = new java.io.File(System
					.getProperty("notepress.root")
					+ file.getThumbnail());
			if (iofile.exists()) {
				iofile.delete();
			}
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本
		parameters.put("id", fileId);
		parameters.put("thumbnail", thumbnail);
		String queryString = "update File set thumbnail=:thumbnail where id = :id";
		this.updateEntity(queryString, parameters);
	}

	public List findFileByStoryId(String storyId, String flag) throws Exception {
		if (StringUtils.isBlank(storyId) || StringUtils.isBlank(flag)) {
			throw new Exception("缺少参数");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本
		parameters.put("id", storyId);
		String queryString = "select c from Story a,Folder b,File c,FileMeta d where a.id=b.storyId and b.id=c.folderId and a.id = :id and c.id=d.fileId and d.fileStatus=1 ";

		if (flag.equals("new")) {
			queryString = queryString + " order by c.updateTime desc";
		} else if (flag.equals("hot")) {
			queryString = queryString + " order by d.clickAmount desc";
		} else if (flag.equals("download")) {
			queryString = queryString + " order by d.downloadAmount desc";
		}
		HibernatePager hp = this.findPagerEntity(queryString, parameters, 5, 1);
		return hp.getResult();
	}

	public List findFileByTagName(String tagName) throws Exception {
		if (StringUtils.isBlank(tagName)) {
			throw new Exception("缺少参数");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本
		parameters.put("tagName", tagName);
		String queryString = "select a from File a,Tag b,FileMeta c where a.id=b.fileId and b.tagName = :tagName and a.id=c.fileId and c.fileStatus=1 order by a.updateTime desc";

		HibernatePager hp = this
				.findPagerEntity(queryString, parameters, 20, 1);
		return hp.getResult();
	}

	public List findFile(String flag) throws Exception {

		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本

		String queryString = "select c from Story a,Folder b,File c,FileMeta d where a.id=b.storyId and b.id=c.folderId and c.id=d.fileId and d.fileStatus=1 ";

		if (flag.equals("new")) {
			queryString = queryString + " order by c.updateTime desc";
		} else if (flag.equals("hot")) {
			queryString = queryString + " order by d.clickAmount desc";
		} else if (flag.equals("download")) {
			queryString = queryString + " order by d.downloadAmount desc";
		}
		HibernatePager hp = this
				.findPagerEntity(queryString, parameters, 10, 1);
		return hp.getResult();
	}

	public HibernatePager findPagerFileByFolderId(String folderId, String pageNo)
			throws Exception {
		if (StringUtils.isBlank(folderId)) {
			throw new Exception("缺少参数");
		}
		int page = NumberUtils.toInt(pageNo);

		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本
		parameters.put("id", folderId);
		QueryString queryString = new QueryString();
		queryString.setSelect("select b ");
		queryString.setFrom("from Folder a,File b,FileMeta c ");
		queryString
				.setWhere("where a.id=b.folderId and a.id = :id and b.id=c.fileId and c.fileStatus=1");
		queryString.setOrder("order by b.updateTime desc");

		return this.findPagerEntity(queryString, parameters, 10, page);
	}

	public void updateCount(String fileId) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本
		parameters.put("id", fileId);
		String queryString = "update FileMeta set clickAmount=clickAmount+1 where fileId = :id";
		this.updateEntity(queryString, parameters);
	}

	public void updateDownloadAmount(String fileId) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本
		parameters.put("id", fileId);
		String queryString = "update FileMeta set downloadAmount=downloadAmount+1 where fileId = :id";
		this.updateEntity(queryString, parameters);
	}

	public Tag readTag(String id) throws Exception {
		return (Tag) this.findEntityById(Tag.class, id);
	}
}
