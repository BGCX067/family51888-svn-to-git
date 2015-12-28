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
		//����Ա������ְλ��ѯ��������
		String userDeparment=user.getDepartment_id().getName();
		String uName=user.getPosition_id().getName_cn();//�õ�Ա����ְλ
		String userPositionName="";

		if(uName.equals("Ա��")){userPositionName="���ž���";}
		else if(uName.equals("���ž���")){userPositionName="�ܾ���";}
		else if(uName.equals("�ܾ���")){userPositionName="����";userDeparment="����";}
		//����֮�� ֻ�й���Ա����ɾ����¼
		else if(uName.equals("����")){userPositionName="����Ա"; userDeparment="IT��";}
		
		return claimVoucherDao.getNextUserByDeparmentAndPositions(userDeparment, userPositionName);
	}
	
/**===========================��ϸ���Ϲ���============================================**/
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
