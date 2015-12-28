package com.oa.bean;

import java.io.Serializable;
import java.util.Date;

import accp.bean.User;

/**
 * 账单类
 * @author liangrui
 *
 */
public class Account implements Serializable {
private Long id;
private String usr_id;//报销人
private String acc_type;//账 类型 
private Double acc_money; //金额
private Long sheet_id;//单据编号
private Date acc_time;//时间


public Account(){}




public Account(String usr_id, String acc_type, Double acc_money,
		Long sheet_id, Date acc_time) {
	this.usr_id = usr_id;
	this.acc_type = acc_type;
	this.acc_money = acc_money;
	this.sheet_id = sheet_id;
	this.acc_time = acc_time;
}




public Long getId() {
	return id;
}
public void setId(Long id) {
	this.id = id;
}
public String getUsr_id() {
	return usr_id;
}
public void setUsr_id(String usr_id) {
	this.usr_id = usr_id;
}
public String getAcc_type() {
	return acc_type;
}
public void setAcc_type(String acc_type) {
	this.acc_type = acc_type;
}
public Double getAcc_money() {
	return acc_money;
}
public void setAcc_money(Double acc_money) {
	this.acc_money = acc_money;
}
public Long getSheet_id() {
	return sheet_id;
}
public void setSheet_id(Long sheet_id) {
	this.sheet_id = sheet_id;
}
public Date getAcc_time() {
	return acc_time;
}
public void setAcc_time(Date acc_time) {
	this.acc_time = acc_time;
}


	
}
