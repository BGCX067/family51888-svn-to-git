package com.oa.bean;

import java.util.Date;

import accp.bean.User;
/**
 * ��˽����
 * @author liangrui
 *
 */
public class CheckResult implements java.io.Serializable {
	private Long id;
	private User sysEmployee;//�����
	private String sheetType;//��������  xxxxxxxxxxxxx
	private Long sheetld;//���ݱ�� 
	private Date createTime;//�������
	private String stype;//������  dm boss
	private String result;//��˽��  pass rutn back
	private String comment;//������
	
	private ClaimVoucher clainmVoucher;//����ajaxȡ���� ��ʾ���� �����ݿ��޹�
	
	public CheckResult(){}


	public CheckResult(User sysEmployee, String sheetType, Long sheetld,
			Date createTime, String stype, String result, String comment) {
	
		this.sysEmployee = sysEmployee;
		this.sheetType = sheetType;
		this.sheetld = sheetld;
		this.createTime = createTime;
		this.stype = stype;
		this.result = result;
		this.comment = comment;
	}


	
	public ClaimVoucher getClainmVoucher() {
		return clainmVoucher;
	}


	public void setClainmVoucher(ClaimVoucher clainmVoucher) {
		this.clainmVoucher = clainmVoucher;
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public User getSysEmployee() {
		return sysEmployee;
	}


	public void setSysEmployee(User sysEmployee) {
		this.sysEmployee = sysEmployee;
	}


	public String getSheetType() {
		return sheetType;
	}


	public void setSheetType(String sheetType) {
		this.sheetType = sheetType;
	}


	public Long getSheetld() {
		return sheetld;
	}


	public void setSheetld(Long sheetld) {
		this.sheetld = sheetld;
	}


	public Date getCreateTime() {
		return createTime;
	}


	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}


	public String getStype() {
		return stype;
	}


	public void setStype(String stype) {
		this.stype = stype;
	}


	public String getResult() {
		return result;
	}


	public void setResult(String result) {
		this.result = result;
	}


	public String getComment() {
		return comment;
	}


	public void setComment(String comment) {
		this.comment = comment;
	}
	
	
	
	

}
