package com.oa.service;


import accp.bean.User;



public interface ClaimVoucherService  {
	
	//根据员工部门职位查询待处理人
	User getNextUserByDeparmentAndPosition(User user);

/**===========================显示月份报表比例图 数据============================================**/
	//public Map<String, Object> getVoucherListChart(String year);
	
	/*public VoucherDetailsMangers getVoucherDetailsMangers() ;

	public void setVoucherDetailsMangers(VoucherDetailsMangers voucherDetailsMangers);*/
	
	
}
