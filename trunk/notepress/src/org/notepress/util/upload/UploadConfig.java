package org.notepress.util.upload;

public class UploadConfig {

	private String fileType;
	private long fileSize;// 100kb
	private String fileRootPath;//
	private String fileDicPolicy;// NONE,YEAR(2010),YEAR-MONTH(2010-07)
	private String fileNamePolicy;// NAME-TIME,TIME,NAME

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileRootPath() {
		return fileRootPath;
	}

	public void setFileRootPath(String fileRootPath) {
		this.fileRootPath = fileRootPath;
	}

	public String getFileDicPolicy() {
		return fileDicPolicy;
	}

	public void setFileDicPolicy(String fileDicPolicy) {
		this.fileDicPolicy = fileDicPolicy;
	}

	public String getFileNamePolicy() {
		return fileNamePolicy;
	}

	public void setFileNamePolicy(String fileNamePolicy) {
		this.fileNamePolicy = fileNamePolicy;
	}

}
