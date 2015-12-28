package com.oa.dao;

import java.util.Map;

import accp.bean.User;
import accp.dao.BaseDao;

import com.oa.bean.ClaimVoucher;

public interface ClaimVoucherDao extends BaseDao<ClaimVoucher,Long> {

	//根据员工部门职位查询待处理人
	User getNextUserByDeparmentAndPositions(String userDeparment,String userPositionName);

/**===========================显示月份报表比例图 数据============================================**/
	//@{ROLE_CEO}
	//public Map<String, Object> getVoucherListChart(String year);
}
