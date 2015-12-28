package org.notepress.core.model;

/**
 * LpTag entity. @author MyEclipse Persistence Tools
 */

public class Tag implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -6474863383782575846L;
	private String id;
	private String fileId;
	private String tagName;
	private String tagAlias;

	// Constructors

	/** default constructor */
	public Tag() {
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTagName() {
		return this.tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public String getTagAlias() {
		return this.tagAlias;
	}

	public void setTagAlias(String tagAlias) {
		this.tagAlias = tagAlias;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public Tag(String fileId, String tagName, String tagAlias) {
		super();
		this.fileId = fileId;
		this.tagName = tagName;
		this.tagAlias = tagAlias;
	}

}