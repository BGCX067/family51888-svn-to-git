package org.notepress.core.model;

import org.notepress.util.hibernate.IModelIntercept;

/**
 * LpStory entity. @author MyEclipse Persistence Tools
 */

public class Story implements java.io.Serializable, IModelIntercept {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1139436973571206688L;
	private String id;
	private String categoryId;
	private String title;
	private String content;
	private String thumbnail;
	private Long createTime;
	private Long updateTime;
	private String creater;

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public Long getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Long updateTime) {
		this.updateTime = updateTime;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public Story(String id, String categoryId, String title, String content,
			String thumbnail, Long createTime, Long updateTime, String creater) {
		this.id = id;
		this.categoryId = categoryId;
		this.title = title;
		this.content = content;
		this.thumbnail = thumbnail;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.creater = creater;
	}

	public Story() {
	}

}