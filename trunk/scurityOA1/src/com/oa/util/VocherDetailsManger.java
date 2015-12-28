package com.oa.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


import accp.bean.User;

import com.oa.bean.ClaimVoucherDetail;
/**
 * ��ϸ������ ����
 * @author liangrui
 *
 */
public  class VocherDetailsManger {
	
	//��ϸ����
	private static Map<String,List<ClaimVoucherDetail>> detailsMap=new HashMap<String,List<ClaimVoucherDetail>>();
	
//get==========================================================================
	public static Map<String, List<ClaimVoucherDetail>> getDetailsMap() {
		return detailsMap;
	}

//add==========================================================================
	public static void addDetailsMap(String userName,ClaimVoucherDetail detail){
		if(detailsMap.containsKey(userName)){//����еĻ�
		List<ClaimVoucherDetail> listDetils=detailsMap.get(userName);//ȡ��list
		
		
		ClaimVoucherDetail de=new ClaimVoucherDetail();
		de.setItem(detail.getItem());
		de.setAccount(detail.getAccount());
		de.setDesc(detail.getDesc());
		//��������
		//de.setBizclaimVoucher(details.getBizclaimVoucher());
		
		listDetils.add(de);//���뼯��
		detailsMap.put(userName, listDetils);
		}else{
			//��һ��
			List<ClaimVoucherDetail> listDetils=new LinkedList<ClaimVoucherDetail>();
						
			ClaimVoucherDetail de=new ClaimVoucherDetail();
			de.setItem(detail.getItem());
			de.setAccount(detail.getAccount());
			de.setDesc(detail.getDesc());
			//��������
			//de.setBizclaimVoucher(details.getBizclaimVoucher());
			
			listDetils.add(de);//���뼯��
			detailsMap.put(userName, listDetils);
		}
	}
		
//remove================================================================
		public static void removeDetailsMap(String username){
			detailsMap.remove(username);
		}
	
	
}
