package org.notepress.core.vo;

import org.notepress.core.model.File;

public class FileVo extends File {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1269469301225252854L;
	private Integer fileStatus;
	private Integer fileAttr;
	private Integer recommend;

	public Integer getFileStatus() {
		return fileStatus;
	}

	public void setFileStatus(Integer fileStatus) {
		this.fileStatus = fileStatus;
	}

	public FileVo(String id, String title, String thumbnail, String size,
			String author, String source, Integer fileStatus, Integer fileAttr,
			Integer recommend, Long releaseDate, Long updateTime) {

		this.setId(id);
		this.setTitle(title);
		this.setThumbnail(thumbnail);
		this.setSize(size);
		this.setAuthor(author);
		this.setSource(source);
		this.setFileStatus(fileStatus);
		this.setFileAttr(fileAttr);
		this.setRecommend(recommend);
		this.setReleaseDate(releaseDate);
		this.setUpdateTime(updateTime);
	}

	public Integer getFileAttr() {
		return fileAttr;
	}

	public void setFileAttr(Integer fileAttr) {
		this.fileAttr = fileAttr;
	}

	public Integer getRecommend() {
		return recommend;
	}

	public void setRecommend(Integer recommend) {
		this.recommend = recommend;
	}
}
