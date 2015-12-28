package com.oa.bean;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Vector;

import accp.bean.User;
/**
 * 报销单实体类
 * @author liangrui
 *
 */
public class ClaimVoucher implements Serializable {
	
 private Long id;
 private User nextDealBy;//待处理人
 private User creator;//填表人
 private Date createTime;//填报日期
 private String event ;//事由
 private Double totalAccount;//总金额
 private String status;//状态    未提交 >已提交>|未审批>部门经理已审批>|未审批>总经理已审批>|未付款>已付款
 private Set BizclaimVoucherDatails=new HashSet(0);//明细
 
 //private CheckResult checkResult;//审核结果信息 用于ajax 暂没有在数据库做关联
 
 private String creatorUser;//用于下载指定字段 根数据库无关
 
/*
 
private   List<ClaimVoucherDetail> detailsLis=new Vector<ClaimVoucherDetail>(0);
	

	public synchronized  void addDetailsList(ClaimVoucherDetail details){
		//if(detailsList==null){detailsList=new Vector<ClaimVoucherDetail>();}
		ClaimVoucherDetail de=new ClaimVoucherDetail();
		de.setItem(details.getItem());
		de.setAccount(details.getAccount());
		de.setDesc(details.getDesc());
		//关联主单
		//de.setBizclaimVoucher(details.getBizclaimVoucher());
	
		detailsLis.add(de);//add
	}
	
	
	public synchronized  List<ClaimVoucherDetail> getDetailsLists(){
		return detailsLis;
	}
	
	//remove
	public synchronized void removeDetailsList(){
		detailsLis=null;
	}
	*/
 
 
 
 
 public String getCreatorUser() {
	return creatorUser;
}

public void setCreatorUser(String creatorUser) {
	this.creatorUser = creatorUser;
}

public ClaimVoucher(){
	 
 }

public ClaimVoucher(User nextDealBy, User creator, Date createTime,
		String event, Double totalAccount, String status,
		Set bizclaimVoucherDatails) {
	this.nextDealBy = nextDealBy;
	this.creator = creator;
	this.createTime = createTime;
	this.event = event;
	this.totalAccount = totalAccount;
	this.status = status;
	BizclaimVoucherDatails = bizclaimVoucherDatails;
}



public Long getId() {
	return id;
}

public void setId(Long id) {
	this.id = id;
}

public User getNextDealBy() {
	return nextDealBy;
}

public void setNextDealBy(User nextDealBy) {
	this.nextDealBy = nextDealBy;
}

public User getCreator() {
	return creator;
}

public void setCreator(User creator) {
	this.creator = creator;
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

public Set getBizclaimVoucherDatails() {
	return BizclaimVoucherDatails;
}

public void setBizclaimVoucherDatails(Set bizclaimVoucherDatails) {
	BizclaimVoucherDatails = bizclaimVoucherDatails;
}
 

 




 
 
 

}
