package com.oa.dao;

import java.util.Map;

import accp.bean.User;
import accp.dao.BaseDao;

import com.oa.bean.ClaimVoucher;

public interface ClaimVoucherDao extends BaseDao<ClaimVoucher,Long> {

	//����Ա������ְλ��ѯ��������
	User getNextUserByDeparmentAndPositions(String userDeparment,String userPositionName);

/**===========================��ʾ�·ݱ������ͼ ����============================================**/
	//@{ROLE_CEO}
	//public Map<String, Object> getVoucherListChart(String year);
}
