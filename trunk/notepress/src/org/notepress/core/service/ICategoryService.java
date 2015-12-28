package org.notepress.core.service;

import java.util.List;

import org.notepress.core.model.Category;

public interface ICategoryService {
	/**
	 * 创建一个故事
	 * 
	 * @param category
	 *            栏目
	 * @throws Exception
	 *             任何异常
	 */
	public void create(Category category) throws Exception;

	/**
	 * 读取一个栏目
	 * 
	 * @param id
	 *            栏目id
	 * @return 栏目
	 * @throws Exception
	 *             任何异常
	 */
	public Category read(String id) throws Exception;

	/**
	 * 修改一个栏目
	 * 
	 * @param category
	 *            栏目
	 * @throws Exception
	 *             任何异常
	 */
	public void update(Category category) throws Exception;

	/**
	 * 删除一个栏目
	 * 
	 * @param id
	 *            栏目id
	 * @throws Exception
	 *             如果栏目下还有子栏目，将抛出异常
	 */
	public void delete(String id) throws Exception;

	/**
	 * 根据父栏目id查询子栏目
	 * 
	 * @param parentId
	 *            父栏目id
	 * @return 子栏目列表
	 * @throws Exception
	 *             任何异常
	 */
	public List<Category> query(String parentId) throws Exception;

	/**
	 * 查询所有有子节点的父栏目id。其实现方法是group by父栏目id字段
	 * 
	 * @return 所有有子节点的父栏目id
	 * @throws Exception
	 *             任何异常
	 */
	public List<String> queryAllParentId() throws Exception;
}
