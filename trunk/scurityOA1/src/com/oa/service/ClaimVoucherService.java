package com.oa.service;


import accp.bean.User;



public interface ClaimVoucherService  {
	
	//����Ա������ְλ��ѯ��������
	User getNextUserByDeparmentAndPosition(User user);

/**===========================��ʾ�·ݱ������ͼ ����============================================**/
	//public Map<String, Object> getVoucherListChart(String year);
	
	/*public VoucherDetailsMangers getVoucherDetailsMangers() ;

	public void setVoucherDetailsMangers(VoucherDetailsMangers voucherDetailsMangers);*/
	
	
}
