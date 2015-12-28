package org.notepress.core.model;

/**
 * LpFileMeta entity. @author MyEclipse Persistence Tools
 */

public class FileExtra implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 264302201074267830L;
	private String id;
	private String fileId;
	private String metaName;
	private String metaValue;

	// Constructors

	/** default constructor */
	public FileExtra() {
	}

	/** full constructor */
	public FileExtra(String fileId, String metaName, String metaValue) {
		this.fileId = fileId;
		this.metaName = metaName;
		this.metaValue = metaValue;
	}

	// Property accessors

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

	public String getMetaName() {
		return this.metaName;
	}

	public void setMetaName(String metaName) {
		this.metaName = metaName;
	}

	public String getMetaValue() {
		return this.metaValue;
	}

	public void setMetaValue(String metaValue) {
		this.metaValue = metaValue;
	}

}