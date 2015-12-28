package org.notepress.core.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.notepress.core.model.Story;
import org.notepress.core.service.IStoryService;
import org.notepress.util.hibernate.HibernateDaoSupport;
import org.notepress.util.hibernate.QueryString;

//@SuppressWarnings("unchecked")
public class StoryServiceImpl extends HibernateDaoSupport implements
		IStoryService {

	public void create(Story story) throws Exception {
		this.createEntity(story);
	}

	public Story read(String id) throws Exception {
		return (Story) this.findEntityById(Story.class, id);
	}

	public void update(Story story) {
		Story storyPO = (Story) this.findEntityById(Story.class, story.getId());
		storyPO.setTitle(story.getTitle());
		storyPO.setContent(story.getContent());

		this.updateEntity(storyPO);
	}

	public void delete(String id) throws Exception {
		Story story = read(id);
		File file = new File(System.getProperty("notepress.root")
				+ story.getThumbnail());
		if (file.exists()) {
			file.delete();
		}
		this.deleteEntity(Story.class, id);

	}

	public List list(String categoryId) throws Exception {
		StringBuffer queryString = new StringBuffer();
		queryString
				.append("select new Story(a.id,b.categoryName, a.title, a.content,a.thumbnail, a.createTime, a.updateTime, a.creater)");
		queryString.append(" from Story a,Category b ");
		queryString.append(" where a.categoryId=b.id and b.id=:categoryId");

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("categoryId", categoryId);

		return this.findEntity(queryString.toString(), parameters);

	}

	public Object[] query(String title, String categoryId, int start) {

		QueryString queryString = new QueryString();
		Map<String, Object> parameters = new HashMap<String, Object>();
		queryString
				.setSelect(" select new Story(a.id,b.categoryName, a.title, a.content,a.thumbnail, a.createTime, a.updateTime, a.creater)");
		queryString.setFrom(" from Story a,Category b ");
		if (categoryId == null) {
			queryString.setWhere(" where a.categoryId=b.id");
		} else {
			parameters.put("categoryId", categoryId);
			queryString
					.setWhere(" where a.categoryId=b.id and b.id=:categoryId");
		}
		if (title != null) {
			parameters.put(" title", title);
			queryString.appendWhere(" and a.title=:title");
		}

		return this.findEntity(queryString, parameters,
				HibernateDaoSupport.LIMIT, start);
	}

	public void updateThumbnail(String storyId, String thumbnail)
			throws Exception {
		if (StringUtils.isBlank(thumbnail)) {
			Story story = read(storyId);
			File file = new File(System.getProperty("notepress.root")
					+ story.getThumbnail());
			if (file.exists()) {
				file.delete();
			}
		}

		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本
		parameters.put("id", storyId);
		parameters.put("thumbnail", thumbnail);
		String queryString = "update Story set thumbnail=:thumbnail where id = :id";
		this.updateEntity(queryString, parameters);
	}

}
