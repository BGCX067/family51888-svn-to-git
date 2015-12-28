package com.oa.jdbc;

import java.util.List;
import java.util.Map;

import org.springframework.security.access.annotation.Secured;

import com.oa.bean.VoucherChartHtml;

public interface OajdbcDaoInterface {
	//@Secured({"ROLE_FINANCE"}) 
	public  List<VoucherChartHtml>  getVoucherListChart(String year);
	public void helloScurity();
}
