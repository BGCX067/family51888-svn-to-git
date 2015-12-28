package org.notepress.core.service;

import java.util.List;

import org.notepress.core.model.Story;

public interface IStoryService {

	/**
	 * 创建一个故事
	 * 
	 * @param story
	 *            故事
	 * @throws Exception
	 *             任何异常
	 */
	public void create(Story story) throws Exception;

	/**
	 * 读取一个故事
	 * 
	 * @param id
	 *            故事id
	 * @return 故事
	 * @throws Exception
	 *             任何异常
	 */
	public Story read(String id) throws Exception;

	/**
	 * 修改一个故事
	 * 
	 * @param story
	 *            故事
	 * @throws Exception
	 *             任何异常
	 */
	public void update(Story story) throws Exception;

	/**
	 * 删除一个故事,一切以故事id为外键的记录均会自动删除。
	 * 
	 * @param id
	 *            故事id
	 * @throws Exception
	 *             任何异常
	 */
	public void delete(String id) throws Exception;

	/**
	 * 根据故事标题和栏目查询故事列表
	 * 
	 * @param title
	 *            故事标题
	 * @param categoryId
	 *            栏目
	 * @param start
	 *            开始记录数
	 * @return 故事vo列表
	 */
	public Object[] query(String title, String categoryId, int start)
			throws Exception;

	public void updateThumbnail(String storyId, String thumbnail)
			throws Exception;

	public List list(String categoryId) throws Exception;

}