package org.notepress.core.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.notepress.core.model.Folder;
import org.notepress.core.service.IFolderService;
import org.notepress.util.hibernate.HibernateDaoSupport;
import org.notepress.util.hibernate.QueryString;

public class FolderServiceImpl extends HibernateDaoSupport implements
		IFolderService {

	public void create(Folder folder) throws Exception {
		this.createEntity(folder);
	}

	public Object[] query(String storyId, int start) throws Exception {

		QueryString queryString = new QueryString();
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("storyId", storyId);
		queryString.setSelect("select b ");
		queryString.setFrom(" from Story a,Folder b ");
		queryString.setWhere(" where a.id=b.storyId and a.id=:storyId");

		return this.findEntity(queryString, parameters,
				HibernateDaoSupport.LIMIT, start);
	}

	public Folder read(String id) throws Exception {
		return (Folder) this.findEntityById(Folder.class, id);
	}

	public void update(Folder folder) {
		Folder folderPO = (Folder) this.findEntityById(Folder.class, folder
				.getId());

		folderPO.setTitle(folder.getTitle());
		folderPO.setContent(folder.getContent());

		this.updateEntity(folderPO);
	}

	public void delete(String id) throws Exception {
		Folder folder = read(id);
		File file = new File(System.getProperty("notepress.root")
				+ folder.getThumbnail());
		if (file.exists()) {
			file.delete();
		}
		this.deleteEntity(Folder.class, id);
	}

	public void updateThumbnail(String folderId, String thumbnail)
			throws Exception {
		if (StringUtils.isBlank(thumbnail)) {
			Folder folder = read(folderId);
			File file = new File(System.getProperty("notepress.root")
					+ folder.getThumbnail());
			if (file.exists()) {
				file.delete();
			}
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本
		parameters.put("id", folderId);
		parameters.put("thumbnail", thumbnail);
		String queryString = "update Folder set thumbnail=:thumbnail where id = :id";
		this.updateEntity(queryString, parameters);
	}

	public List findFolderByStoryId(String storyId) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
		// 编辑文本
		parameters.put("id", storyId);
		String queryString = "select b from Story a,Folder b where a.id=b.storyId  and a.id = :id";
		return this.findEntity(queryString, parameters);
	}
}
