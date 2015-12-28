package com.oa.bean;
/**
 * 用于显示月费报销单比例图    对应jasperreport
 * @author liangrui
 * QQ382453602
 *
 */
public class VoucherChartHtml {
	
	private Long crruntYear;//年份crruntYear
	//private String crruntYear;//年份crruntYear
	private Long createTime;//月份
	private double totalAccount;//金额
	
	
	
	
public Long getCrruntYear() {
		return crruntYear;
	}
	public void setCrruntYear(Long crruntYear) {
		this.crruntYear = crruntYear;
	}
	/*	public String getCrruntYear() {
		return crruntYear;
	}
	public void setCrruntYear(String crruntYear) {
		this.crruntYear = crruntYear;
	}*/
	
	public Long getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}
	public double getTotalAccount() {
		return totalAccount;
	}
	public void setTotalAccount(double totalAccount) {
		this.totalAccount = totalAccount;
	}
	
	
	

}
