package com.oa.bean;
/**
 * 报销单明细实体类
 * 保存报销单明细信息
 * @author liangrui
 *
 */
public class ClaimVoucherDetail implements java.io.Serializable {
	
private Long id;
private ClaimVoucher bizclaimVoucher;//主单
private String item;//报销项目
private String desc;//费用说明
private Double account;//金额


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
