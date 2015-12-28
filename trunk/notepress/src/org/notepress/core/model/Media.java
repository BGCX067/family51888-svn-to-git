package org.notepress.core.model;

import org.notepress.util.hibernate.IModelIntercept;

/**
 * LpFile entity. @author MyEclipse Persistence Tools
 */

public class Media implements java.io.Serializable, IModelIntercept {
	private static final long serialVersionUID = 8656805131098861549L;
	private String id;
	private String mediaType;
	private String mediaPath;
	private String title;
	private String excerpt;
	private Long createTime;
	private Long updateTime;
	private String creater;

	public String getMediaType() {
		return mediaType;
	}

	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}

	public String getMediaPath() {
		return mediaPath;
	}

	public void setMediaPath(String mediaPath) {
		this.mediaPath = mediaPath;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getExcerpt() {
		return excerpt;
	}

	public void setExcerpt(String excerpt) {
		this.excerpt = excerpt;
	}

	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public Long getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Long updateTime) {
		this.updateTime = updateTime;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}