package com.oa.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import accp.bean.User;
import accp.services.BaseServices;

import com.google.gson.Gson;
import com.oa.bean.Biz_claim_voucher;
import com.oa.bean.CheckResult;
import com.oa.bean.ClaimVoucher;
import com.oa.bean.ClaimVoucherDetail;
import com.oa.bean.VoucherChartHtml;
import com.oa.jdbc.OaJdbcDao;
import com.oa.service.ClaimVoucherService;
import com.oa.util.Constants;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

/**
 * 财务处理报销单的action
 * 
 * @author liangrui
 * @qq 382453602
 */
public class FinanceCheckVoucher extends ActionSupport implements Preparable {

	private User currentUser;// 当前用户
	private ClaimVoucher claimVoucher;// 报销单主单
	private CheckResult checkResult;// 审核信息
	private List<ClaimVoucher> claimVoucherListShow;// 报销单集合
	private ClaimVoucherDetail claimVoucherDetail; // 报销单明细
	// interceptro
	private ClaimVoucherService claimVoucherService;// 业务操作接口
	private BaseServices<ClaimVoucher, Long> baseVoucherServices;// 基本操作业务
	private BaseServices<ClaimVoucherDetail, Long> baseClaimVoucherDetailServices;// 基本操作业务
	private BaseServices<CheckResult, Long> baseCheckResultServices;// 基本操作业务
	private String message;

	// ----------------------------------------------------------------------------------------------
	public User getCurrentUser() {
		return currentUser;
	}

	public void setCurrentUser(User currentUser) {
		this.currentUser = currentUser;
	}

	public ClaimVoucher getClaimVoucher() {
		return claimVoucher;
	}

	public void setClaimVoucher(ClaimVoucher claimVoucher) {
		this.claimVoucher = claimVoucher;
	}

	public CheckResult getCheckResult() {
		return checkResult;
	}

	public void setCheckResult(CheckResult checkResult) {
		this.checkResult = checkResult;
	}

	public List<ClaimVoucher> getClaimVoucherListShow() {
		return claimVoucherListShow;
	}

	public void setClaimVoucherListShow(List<ClaimVoucher> claimVoucherListShow) {
		this.claimVoucherListShow = claimVoucherListShow;
	}

	public ClaimVoucherDetail getClaimVoucherDetail() {
		return claimVoucherDetail;
	}

	public void setClaimVoucherDetail(ClaimVoucherDetail claimVoucherDetail) {
		this.claimVoucherDetail = claimVoucherDetail;
	}

	public void setClaimVoucherService(ClaimVoucherService claimVoucherService) {
		this.claimVoucherService = claimVoucherService;
	}

	public void setBaseVoucherServices(
			BaseServices<ClaimVoucher, Long> baseVoucherServices) {
		this.baseVoucherServices = baseVoucherServices;
	}

	public void setBaseClaimVoucherDetailServices(
			BaseServices<ClaimVoucherDetail, Long> baseClaimVoucherDetailServices) {
		this.baseClaimVoucherDetailServices = baseClaimVoucherDetailServices;
	}

	public void setBaseCheckResultServices(
			BaseServices<CheckResult, Long> baseCheckResultServices) {
		this.baseCheckResultServices = baseCheckResultServices;
	}

	/***
	 * ========================== init Action
	 * =======================================
	 **/
	public void prepare() throws Exception {
		// 获取当前用户信息
		UserDetails userDetails = (UserDetails) SecurityContextHolder
				.getContext().getAuthentication().getPrincipal();
		// 用户
		this.currentUser = (User) userDetails;
		System.out.println("当前用户获取完毕: " + this.currentUser.getUsername());

	}

	/***
	 * ==========================ajax查询报销单信息列表
	 * =======================================
	 **/
	public String findfinanceCheckVoucherAjax() throws Exception {
		// 根据用户查询报销单
		Map<String, Object> paramters = new HashMap<String, Object>();
		paramters.put(" and nextDealBy=? ", this.currentUser);
		// 经理 或 总经理 审批的
		paramters.put(" and status=? ", Constants.DM_PASsVOUCHER);
		paramters.put(" or status=? ", Constants.BOSS_PASsVOUCHER);
		// paramters.put(" and total_account>=? ", 5000);//总经理审批的都是大于5000的
		// 调用业务接口 开始操作
		claimVoucherListShow = baseVoucherServices.getTInObjectArray(
				new ClaimVoucher(), paramters);

		// 清空不需要的数据
		List<ClaimVoucher> gonsList = new ArrayList<ClaimVoucher>();
		for (ClaimVoucher cv : claimVoucherListShow) {
			cv.setNextDealBy(null);
			cv.setBizclaimVoucherDatails(null);
			User u = new User();
			u.setName(cv.getCreator().getName());
			cv.setCreator(u);
			gonsList.add(cv);
		}
		// String gosnString="[{}]";
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");// 去除缓存
		response.setContentType("application/json;charset=utf-8");
		Gson gosnVoucher = new Gson();
		String gosnStr = "";
		try {
			gosnStr = gosnVoucher.toJson(gonsList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// System.out.println("gosn: "+gosnStr);
		PrintWriter out = response.getWriter();
		out.write(gosnStr);
		out.flush();
		out.close();
		return null;
	}

	/***
	 * ==========================查看报销单明细Ajax
	 * =======================================
	 **/
	public String findCheckVoucherDateilsAjax() throws Exception {
		// 通过id获取对象
		claimVoucher = baseVoucherServices.getTInId(new ClaimVoucher(),
				claimVoucher.getId());
		// List<ClaimVoucher> gonsList=new ArrayList<ClaimVoucher>();//gosn 集合
		List<CheckResult> resultList = null;
		// List<CheckResult> bossResultList=null;
		try {
			// 清空不需要的数据
			claimVoucher.setNextDealBy(null);
			User u = new User();
			u.setName(claimVoucher.getCreator().getName());
			claimVoucher.setCreator(u);
			@SuppressWarnings("unchecked")
			Iterator<ClaimVoucherDetail> cvIT = claimVoucher
					.getBizclaimVoucherDatails().iterator();
			Set detailsSet = new HashSet();
			while (cvIT.hasNext()) {
				ClaimVoucherDetail cv = cvIT.next();
				cv.setBizclaimVoucher(null);
				detailsSet.add(cv);
			}
			claimVoucher.setBizclaimVoucherDatails(detailsSet);// 添加明细
			// gonsList.add(claimVoucher); //加入集合

			Map<String, Object> paramenters = new HashMap<String, Object>();
			paramenters.put(" and sheetld=? ", claimVoucher.getId());
			// 查询审核的结果 根据报销单id==========================================
			resultList = baseCheckResultServices.getTInObjectArray(
					new CheckResult(), paramenters);
			System.out.println(resultList.size());

			for (int i = 0; i < resultList.size(); i++) {
				System.out.println("zy: " + resultList.get(i).getStype());
				resultList.get(i).getSysEmployee().setRoles(null);
				if (i == 0) {
					resultList.get(i).setClainmVoucher(claimVoucher);// 得到显示的结果数据
				} else {
					resultList.get(i).setClainmVoucher(null);// 清空多余数据
				}
			}

			/*
			 * resultList.get(0).getSysEmployee().setRoles(null);
			 * resultList.get(0).setClainmVoucher(claimVoucher);//得到显示的结果数据
			 */// 查询总经理审核结果============================================================
				// bossResultList=
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 封装ajax
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");// 去除缓存
		response.setContentType("application/json;charset=utf-8");

		Gson gosnVoucher = new Gson();
		String gosnStr = "";
		try {
			gosnStr = gosnVoucher.toJson(resultList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("gosn: " + gosnStr);
		PrintWriter out = response.getWriter();
		out.write(gosnStr);
		out.flush();
		out.close();

		return null;
	}

	/***
	 * ==========================已审核 的报销单 Ajax
	 * =======================================
	 **/
	public String findfinanceHositryAjax() throws Exception {
		// 根据用户查询报销单
		Map<String, Object> paramters = new HashMap<String, Object>();
		// paramters.put("nextDealBy", this.currentUser);
		paramters.put(" and status=? ", Constants.FINANCE_PASsVOUCHER);
		// paramters.put("status", "BOSS已审核");
		// 调用业务接口 开始操作
		claimVoucherListShow = baseVoucherServices.getTInObjectArray(
				new ClaimVoucher(), paramters);

		// 清空不需要的数据
		List<ClaimVoucher> gonsList = new ArrayList<ClaimVoucher>();
		for (ClaimVoucher cv : claimVoucherListShow) {
			cv.setNextDealBy(null);
			cv.setBizclaimVoucherDatails(null);
			User u = new User();
			u.setName(cv.getCreator().getName());
			cv.setCreator(u);

			gonsList.add(cv);
		}
		// String gosnString="[{}]";

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");// 去除缓存
		response.setContentType("application/json;charset=utf-8");

		Gson gosnVoucher = new Gson();
		String gosnStr = "";
		try {

			gosnStr = gosnVoucher.toJson(gonsList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// System.out.println("gosn: "+gosnStr);
		PrintWriter out = response.getWriter();
		out.write(gosnStr);
		out.flush();
		out.close();
		return null;
	}

	/***
	 * ==========================审核 同意报销单
	 * =======================================
	 **/
	// 这个方法需要写在service 里 或者给这个action指定事务 为了演示方便这里暂时省略...
	public String saveCheckVoucherPass() throws Exception {
		// 通过id查询出报销单
		claimVoucher = baseVoucherServices.getTInId(new ClaimVoucher(),
				claimVoucher.getId());
		String saveMessage = "";
		// 审核信息
		checkResult.setCreateTime(new Date());
		checkResult.setSysEmployee(this.currentUser);// 审核人
		checkResult.setResult(Constants.CHECK_PASS);// 通过
		checkResult.setStype("finance(财务)");// 类别
		checkResult.setSheetld(claimVoucher.getId());// 报销单id;
		checkResult.setSheetType("报销单");// 未知的属性????

		// 根据用户查询出待处理人
		User nextDealBy = claimVoucherService
				.getNextUserByDeparmentAndPosition(this.currentUser);
		// System.out.println("finance: "+nextDealBy.getName());

		try {
			claimVoucher.setNextDealBy(nextDealBy);// 待处理人
			claimVoucher.setStatus(Constants.FINANCE_PASsVOUCHER);// 状态
			baseVoucherServices.update(claimVoucher); // 修改报销单

			// 插入sql 审核信息
			Long count = baseCheckResultServices.save(checkResult);
			if (count > 0) {
				saveMessage = "成功付款报销单 id:" + claimVoucher.getId();
			} else {
				saveMessage = "付款报销单 id:" + claimVoucher.getId() + " 失败!请联系管理员";
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		System.out.println(saveMessage);
		// 封装ajax
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");// 去除缓存
		PrintWriter out = response.getWriter();
		out.print(saveMessage);
		// out.print(checkResult.getComment()+checkResult.getResult()+checkResult.getStype()+checkResult.getSheetld()+checkResult.getSysEmployee().getName());
		return null;
	}

	/***
	 * ==========================下载已付款的报销单
	 * =======================================
	 **/
	List<Biz_claim_voucher> downLoadVoucherList;

	public List<Biz_claim_voucher> getDownLoadVoucherList() {
		return downLoadVoucherList;
	}

	// 为提高下载性能应该再单独写sql，这里暂省略...............
	public String getVoucehrXLS() throws Exception {
		if (downLoadVoucherList == null) {
			downLoadVoucherList = new ArrayList<Biz_claim_voucher>();
		}

		Map<String, Object> paramters = new HashMap<String, Object>();
		paramters.put(" and status=? ", Constants.FINANCE_PASsVOUCHER);
		// paramters.put("status", "BOSS已审核");
		// 调用业务接口 开始操作
		claimVoucherListShow = baseVoucherServices.getTInObjectArray(
				new ClaimVoucher(), paramters);

		// 清空不需要的数据
		for (ClaimVoucher cv : claimVoucherListShow) {
			Biz_claim_voucher c = new Biz_claim_voucher();
			c.setId(cv.getId());
			c.setCreateTime(cv.getCreateTime());
			c.setCreatorUser(cv.getCreator().getName());// 获取姓名
			c.setEvent(cv.getEvent());
			c.setStatus(cv.getStatus());
			c.setTotalAccount(cv.getTotalAccount());
			System.out.println(c.getCreatorUser());
			downLoadVoucherList.add(c);
		}

		return "showXls";
	}

	/***
	 * ==========================查看月份报销费用单比例图=======================================**/

	private OaJdbcDao oaJdbcDao;

	public void setOaJdbcDao(OaJdbcDao oaJdbcDao) {
		this.oaJdbcDao = oaJdbcDao;
	}

	List<VoucherChartHtml> displayChartNew = new ArrayList<VoucherChartHtml>();

	public List<VoucherChartHtml> getDisplayChartNew() {
		return displayChartNew;
	}

	public void setDisplayChartNew(List<VoucherChartHtml> displayChartNew) {
		this.displayChartNew = displayChartNew;
	}

	private String yearFind;// 按年份查询

	// Map<String, Double> voucherCahrtMap;

	public void setYearFind(String yearFind) {
		this.yearFind = yearFind;
	}
//=======================================================================
	public String getVoucehrChartHtml() throws Exception {
		if ("".equals(yearFind) || "" == yearFind || null == yearFind) {
			Calendar cc = Calendar.getInstance();
			yearFind = cc.get(Calendar.YEAR) + "";// 得到年份
		}
      System.out.println("yearFind: "+yearFind);
		// 调用业务接口 开始操作
    try {
    displayChartNew = oaJdbcDao.getVoucherListChart(yearFind);
	} catch (Exception e) {
	 displayChartNew = new ArrayList<VoucherChartHtml>();
	 e.printStackTrace();
	}
    
	return "dispalyJasperChart";
	}
	
	
/***==========================fusiong =======================================**/	
	private String pieDate;
	private String columBarDate;
	
	public String getColumBarDate() {
		return columBarDate;
	}

	public void setColumBarDate(String columBarDate) {
		this.columBarDate = columBarDate;
	}

	public String getPieDate() {
		return pieDate;
	}

	public void setPieDate(String pieDate) {
		this.pieDate = pieDate;
	}


	public String displayFusionChar() throws Exception {
		
	if ("".equals(yearFind) || "" == yearFind || null == yearFind) {
			Calendar cc = Calendar.getInstance();
			yearFind = cc.get(Calendar.YEAR) + "";// 得到年份
		}
      System.out.println("yearFind: "+yearFind);
		// 调用业务接口 开始操作
    try {
    displayChartNew = oaJdbcDao.getVoucherListChart(yearFind);
    
     //数据 XML
    StringBuffer columBar=new StringBuffer();
    columBar.append("<chart caption='"+displayChartNew.get(0).getCrruntYear()+"年度/月报销单费用' xAxisName='年度/月报销单费用' yAxisName='年度报表' showValues='1' decimals='0' formatNumberScale='0' baseFontSize='20' clickURL='www.baidu.com'>");
 
    for(VoucherChartHtml chart:displayChartNew){
    columBar.append("<set label='"+chart.getCreateTime()+"月' value='"+chart.getTotalAccount()+"' />");
    }
    columBar.append("</chart>");
    
	//pie3D 
	StringBuffer pie=new StringBuffer();
	pie.append("<chart caption='"+displayChartNew.get(0).getCrruntYear()+"年度/月报销单费用' palette='4' decimals='1' enableSmartLabels='1' enableRotation='0' bgColor='99CCFF,FFFFFF' bgAlpha='40,100' bgRatio='0,100' bgAngle='360' showBorder='1' startingAngle='70' baseFontSize='20' showPercentValues='1' showValues='1'>");
	
	 for(VoucherChartHtml chart:displayChartNew){
		 if(chart.getCreateTime()==9){
			 pie.append("<set label='"+chart.getCreateTime()+"月' value='"+chart.getTotalAccount()+"' isSliced='1' />"); 
		 }else{ 
			 pie.append("<set label='"+chart.getCreateTime()+"月' value='"+chart.getTotalAccount()+"' />");
		 }   
	 }
	pie.append("</chart>");
	
   // System.out.println(columBar.toString());	
    columBarDate= columBar.toString();	
    pieDate= pie.toString();
	
	} catch (Exception e) {
	 displayChartNew = new ArrayList<VoucherChartHtml>();
	 e.printStackTrace();
	}
    
		return "fusionChar";
	}
		
	

}
