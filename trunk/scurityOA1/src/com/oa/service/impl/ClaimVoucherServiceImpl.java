package com.oa.service.impl;


import accp.bean.User;
import com.oa.dao.ClaimVoucherDao;
import com.oa.service.ClaimVoucherService;


public class ClaimVoucherServiceImpl implements ClaimVoucherService {
	
	private ClaimVoucherDao claimVoucherDao;

	public ClaimVoucherDao getClaimVoucherDao() {
		return claimVoucherDao;
	}

	public void setClaimVoucherDao(ClaimVoucherDao claimVoucherDao) {
		this.claimVoucherDao = claimVoucherDao;
	}

	
/**=========================================================================**/
	public User getNextUserByDeparmentAndPosition(User user) {
		//根据员工部门职位查询待处理人
		String userDeparment=user.getDepartment_id().getName();
		String uName=user.getPosition_id().getName_cn();//得到员工的职位
		String userPositionName="";

		if(uName.equals("员工")){userPositionName="部门经理";}
		else if(uName.equals("部门经理")){userPositionName="总经理";}
		else if(uName.equals("总经理")){userPositionName="财务";userDeparment="财务部";}
		//付款之后 只有管理员才能删除记录
		else if(uName.equals("财务")){userPositionName="管理员"; userDeparment="IT部";}
		
		return claimVoucherDao.getNextUserByDeparmentAndPositions(userDeparment, userPositionName);
	}
	
/**===========================明细集合管理============================================**/
/*
private	VoucherDetailsMangers voucherDetailsMangers=new VoucherDetailsMangers();

public VoucherDetailsMangers getVoucherDetailsMangers() {
	return voucherDetailsMangers;
}

public void setVoucherDetailsMangers(VoucherDetailsMangers voucherDetailsMangers) {
	this.voucherDetailsMangers = voucherDetailsMangers;
}
	*/

	

}
