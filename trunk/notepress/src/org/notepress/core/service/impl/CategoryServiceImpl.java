package org.notepress.core.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.notepress.core.model.Category;
import org.notepress.core.service.ICategoryService;
import org.notepress.util.error.ErrorUtils;
import org.notepress.util.hibernate.HibernateDaoSupport;

public class CategoryServiceImpl extends HibernateDaoSupport implements
		ICategoryService {

	public void create(Category category) throws Exception {
		this.createEntity(category);
	}

	public Category read(String id) throws Exception {
		return (Category) this.findEntityById(Category.class, id);
	}

	public void update(Category category) throws Exception {
		Category categoryPO = (Category) this.findEntityById(Category.class,
				category.getId());

		categoryPO.setCategoryName(category.getCategoryName());
		categoryPO.setCategorySort(category.getCategorySort());

		this.updateEntity(categoryPO);
	}

	public void delete(String id) throws Exception {
		// HQL参数Map
		Map<String, String> values = new HashMap<String, String>();
		values.put("parentId", id);

		// 查找指定ID是否还有下级栏目
		String queryString = "select count(*) from Category where categoryParentId = :parentId";
		List result = this.findEntity(queryString, values);
		Object obj = result.get(0);
		// 如果还有下级，则不允许删除
		if ((Long) obj > 0) {
			throw new Exception(ErrorUtils.getError().getNpe001());
		} else {
			this.deleteEntity(Category.class, id);
		}
	}

	public List<Category> query(String parentId) throws Exception {
		// HQL参数Map
		Map<String, String> values = new HashMap<String, String>();
		values.put("parentId", parentId);// 机构ID集合

		// 查询指定ID的下级栏目
		String queryString = "from Category where categoryParentId = :parentId order by categorySort,categoryName";
		return this.findEntity(queryString, values);
	}

	public List<String> queryAllParentId() throws Exception {
		String queryString = "select categoryParentId from Category group by categoryParentId";
		return this.findEntity(queryString);
	}
}
