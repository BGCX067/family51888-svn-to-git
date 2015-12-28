package com.strongit.framework.model;

import java.io.Serializable;
import java.util.Date;

public class StrongLogInfo implements Serializable{


	private String uuid;

	private String logUserName; //操作用户

	private String logOrgId; //操作组织机构

	private String logOrgName; //操作组织机构名称

	private String logContent; //日志记录内容

	private String logIp; //操作员IP

	private Date logDate;//日志记录日期
	
	private String remark; //备注

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getLogUserName() {
		return logUserName;
	}

	public void setLogUserName(String logUserName) {
		this.logUserName = logUserName;
	}

	public String getLogOrgId() {
		return logOrgId;
	}

	public void setLogOrgId(String logOrgId) {
		this.logOrgId = logOrgId;
	}

	public String getLogOrgName() {
		return logOrgName;
	}

	public void setLogOrgName(String logOrgName) {
		this.logOrgName = logOrgName;
	}

	public String getLogContent() {
		return logContent;
	}

	public void setLogContent(String logContent) {
		this.logContent = logContent;
	}

	public String getLogIp() {
		return logIp;
	}

	public void setLogIp(String logIp) {
		this.logIp = logIp;
	}

	public Date getLogDate() {
		return logDate;
	}

	public void setLogDate(Date logDate) {
		this.logDate = logDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
