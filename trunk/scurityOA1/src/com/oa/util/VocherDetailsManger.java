package com.oa.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


import accp.bean.User;

import com.oa.bean.ClaimVoucherDetail;
/**
 * 明细报销单 管理
 * @author liangrui
 *
 */
public  class VocherDetailsManger {
	
	//明细集合
	private static Map<String,List<ClaimVoucherDetail>> detailsMap=new HashMap<String,List<ClaimVoucherDetail>>();
	
//get==========================================================================
	public static Map<String, List<ClaimVoucherDetail>> getDetailsMap() {
		return detailsMap;
	}

//add==========================================================================
	public static void addDetailsMap(String userName,ClaimVoucherDetail detail){
		if(detailsMap.containsKey(userName)){//如果有的话
		List<ClaimVoucherDetail> listDetils=detailsMap.get(userName);//取出list
		
		
		ClaimVoucherDetail de=new ClaimVoucherDetail();
		de.setItem(detail.getItem());
		de.setAccount(detail.getAccount());
		de.setDesc(detail.getDesc());
		//关联主单
		//de.setBizclaimVoucher(details.getBizclaimVoucher());
		
		listDetils.add(de);//加入集合
		detailsMap.put(userName, listDetils);
		}else{
			//第一次
			List<ClaimVoucherDetail> listDetils=new LinkedList<ClaimVoucherDetail>();
						
			ClaimVoucherDetail de=new ClaimVoucherDetail();
			de.setItem(detail.getItem());
			de.setAccount(detail.getAccount());
			de.setDesc(detail.getDesc());
			//关联主单
			//de.setBizclaimVoucher(details.getBizclaimVoucher());
			
			listDetils.add(de);//加入集合
			detailsMap.put(userName, listDetils);
		}
	}
		
//remove================================================================
		public static void removeDetailsMap(String username){
			detailsMap.remove(username);
		}
	
	
}
