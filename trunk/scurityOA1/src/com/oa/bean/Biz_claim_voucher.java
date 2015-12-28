package com.oa.bean;

import java.util.Date;

/**
 * 用于下载报销单xls对应jasperreport
 * @author liangrui
 * QQ382453602
 *
 */

public class Biz_claim_voucher {

	 private Long id;
	 private String creatorUser;//用于下载指定字段 根数据库无关
	 private Date createTime;//填报日期
	 private String event ;//事由
	 private Double totalAccount;//总金额
	 private String status;//状态    未提交 >已提交>|未审批>部门经理已审批>|未审批>总经理已审批>|未付款>已付款
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCreatorUser() {
		return creatorUser;
	}
	public void setCreatorUser(String creatorUser) {
		this.creatorUser = creatorUser;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public Double getTotalAccount() {
		return totalAccount;
	}
	public void setTotalAccount(Double totalAccount) {
		this.totalAccount = totalAccount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}


}
