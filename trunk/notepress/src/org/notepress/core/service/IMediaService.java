package org.notepress.core.service;

import org.notepress.core.model.Media;

public interface IMediaService {
	/**
	 * 创建一个媒体
	 * 
	 * @param media
	 *            媒体
	 * @throws Exception
	 *             任何异常
	 */
	public void create(Media media) throws Exception;

	/**
	 * 分页查询
	 * 
	 * @param title
	 *            媒体标题
	 * @param start
	 *            开始记录
	 * @return 分页对象
	 * @throws Exception
	 *             任何异常
	 */
	public Object[] query(String title, int start) throws Exception;

	/**
	 * 读取一个媒体
	 * 
	 * @param id
	 *            媒体id
	 * @return 媒体
	 * @throws Exception
	 *             任何异常
	 */
	public Media read(String id) throws Exception;

	/**
	 * 修改一个媒体
	 * 
	 * @param story
	 *            媒体
	 * @throws Exception
	 *             任何异常
	 */
	public void update(Media media) throws Exception;

	public void delete(String id) throws Exception;
}
