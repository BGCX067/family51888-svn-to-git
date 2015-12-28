package org.notepress.core.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.notepress.core.model.Media;
import org.notepress.core.service.IMediaService;
import org.notepress.util.hibernate.HibernateDaoSupport;
import org.notepress.util.hibernate.QueryString;
import org.notepress.util.security.UserUtil;

public class MediaServiceImpl extends HibernateDaoSupport implements
		IMediaService {

	public void create(Media media) throws Exception {
		this.createEntity(media);
	}

	public Object[] query(String title, int start) throws Exception {

		QueryString queryString = new QueryString();
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("creater", UserUtil.getUserName());

		queryString.setSelect(" select a");
		queryString.setFrom(" from Media a ");

		queryString.setWhere("where a.creater=:creater");
		if (title != null) {
			parameters.put("title", title);
			queryString.appendWhere(" and a.title=:title");
		}

		return this.findEntity(queryString, parameters,
				HibernateDaoSupport.LIMIT, start);
	}

	public Media read(String id) throws Exception {
		return (Media) this.findEntityById(Media.class, id);
	}

	public void update(Media media) throws Exception {
		// 获取指定的media数据
		Media mediaPO = (Media) this.findEntityById(Media.class, media.getId());

		mediaPO.setTitle(media.getTitle());
		mediaPO.setExcerpt(media.getExcerpt());

		if (media.getMediaPath() != null) {
			mediaPO.setMediaPath(media.getMediaPath());
			mediaPO.setMediaType(media.getMediaType());
		}

		this.updateEntity(mediaPO);
	}

	public void delete(String id) throws Exception {
		this.deleteEntity(Media.class, id);
	}
}
