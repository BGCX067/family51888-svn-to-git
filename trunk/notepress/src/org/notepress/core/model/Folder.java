package org.notepress.core.model;

import org.notepress.util.hibernate.IModelIntercept;

/**
 * LpFolder entity. @author MyEclipse Persistence Tools
 */

public class Folder implements java.io.Serializable, IModelIntercept {

	private static final long serialVersionUID = -3350241057268071869L;
	private String id;
	private String storyId;
	private String title;
	private String thumbnail;
	private String content;
	private Long createTime;
	private Long updateTime;
	private String creater;

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getStoryId() {
		return storyId;
	}

	public void setStoryId(String storyId) {
		this.storyId = storyId;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

}