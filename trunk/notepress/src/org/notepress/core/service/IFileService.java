package org.notepress.core.service;

import java.util.List;

import org.notepress.core.config.ExtraData;
import org.notepress.core.model.File;
import org.notepress.core.model.FileMeta;
import org.notepress.core.model.Tag;
import org.notepress.util.hibernate.HibernatePager;

public interface IFileService {

	/**
	 * 创建新的文本
	 * 
	 * @param file
	 *            文件
	 * @param extraData
	 *            文本的额外信息
	 * @param folderId
	 *            文件夹id
	 * @throws Exception
	 *             任何异常
	 */
	public abstract void create(File file, FileMeta fileMeta,
			List<ExtraData> extraDataList, String tag, String folderId)
			throws Exception;

	/**
	 * 读取文本信息、文本元素信息、文本额外信息
	 * 
	 * @param textId
	 *            文本id
	 * @return 一个对象数组，Object[0]是File，object[1]是FileMeta;
	 *         object[2]里是一个FileExtra的list。
	 * @throws Exception
	 */
	public abstract Object[] read(String textId) throws Exception;

	public abstract void update(File file, FileMeta fileMeta,
			List<ExtraData> extraDataList, String tag) throws Exception;

	public abstract void delete(String fileId) throws Exception;

	public abstract void updateStatus(String fileId, Integer status)
			throws Exception;

	public abstract void updateAttr(String fileId, Integer status)
			throws Exception;

	/**
	 * 
	 * @param folderId
	 * @param start
	 * @return
	 * @throws Exception
	 */
	public abstract Object[] query(String folderId, int start) throws Exception;

	public abstract void updateThumbnail(String fileId, String thumbnail)
			throws Exception;

	public void recommend(String fileId, Integer recommend) throws Exception;

	public void top(String fileId, Integer topTime) throws Exception;

	public void updateCount(String fileId) throws Exception;

	public void updateDownloadAmount(String fileId) throws Exception;

	public List findFileByStoryId(String storyId, String flag) throws Exception;

	public HibernatePager findPagerFileByFolderId(String folderId, String pageNo)
			throws Exception;

	public List findFile(String flag) throws Exception;

	public List findFileByTagName(String tagName) throws Exception;

	public Tag readTag(String id) throws Exception;
}
