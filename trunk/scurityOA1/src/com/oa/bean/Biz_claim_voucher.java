package com.oa.bean;

import java.util.Date;

/**
 * �������ر�����xls��Ӧjasperreport
 * @author liangrui
 * QQ382453602
 *
 */

public class Biz_claim_voucher {

	 private Long id;
	 private String creatorUser;//��������ָ���ֶ� �����ݿ��޹�
	 private Date createTime;//�����
	 private String event ;//����
	 private Double totalAccount;//�ܽ��
	 private String status;//״̬    δ�ύ >���ύ>|δ����>���ž���������>|δ����>�ܾ���������>|δ����>�Ѹ���
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
