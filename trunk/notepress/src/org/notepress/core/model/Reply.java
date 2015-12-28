package org.notepress.core.model;

import org.notepress.util.hibernate.IModelIntercept;

/**
 * LpReply entity. @author MyEclipse Persistence Tools
 */

public class Reply implements java.io.Serializable, IModelIntercept {

	private static final long serialVersionUID = -5351687693332044096L;
	private String id;
	private String fileId;
	private String content;
	private Long createTime;
	private Long updateTime;
	private String creater;

	public Reply() {
	}

	public Reply(String fileId, String content, Long createTime,
			Long updateTime, String creater) {
		super();
		this.fileId = fileId;
		this.content = content;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.creater = creater;
	}

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

	public String getFileId() {
		return this.fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
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

}