package com.oa.bean;
/**
 * ��������ϸʵ����
 * ���汨������ϸ��Ϣ
 * @author liangrui
 *
 */
public class ClaimVoucherDetail implements java.io.Serializable {
	
private Long id;
private ClaimVoucher bizclaimVoucher;//����
private String item;//������Ŀ
private String desc;//����˵��
private Double account;//���


public ClaimVoucherDetail(){
	
}

public ClaimVoucherDetail(ClaimVoucher bizclaimVoucher, String item,
		String desc, Double account) {
	this.bizclaimVoucher = bizclaimVoucher;
	this.item = item;
	this.desc = desc;
	this.account = account;
}

public Long getId() {
	return id;
}

public void setId(Long id) {
	this.id = id;
}

public ClaimVoucher getBizclaimVoucher() {
	return bizclaimVoucher;
}

public void setBizclaimVoucher(ClaimVoucher bizclaimVoucher) {
	this.bizclaimVoucher = bizclaimVoucher;
}

public String getItem() {
	return item;
}

public void setItem(String item) {
	this.item = item;
}

public String getDesc() {
	return desc;
}

public void setDesc(String desc) {
	this.desc = desc;
}

public Double getAccount() {
	return account;
}

public void setAccount(Double account) {
	this.account = account;
}






}
