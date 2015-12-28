package com.oa.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import accp.bean.User;
import accp.services.BaseServices;

import com.google.gson.Gson;
import com.oa.bean.ClaimVoucher;
import com.oa.bean.ClaimVoucherDetail;
import com.oa.service.ClaimVoucherService;
import com.oa.util.Constants;
import com.oa.util.PageBean;
import com.oa.util.VocherDetailsManger;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;
/**
 * 员工操作报销单的action
 * @author liangrui
 * @qq 382453602
 */
public class ClaimVoucherAction extends ActionSupport implements Preparable {
	private static final long serialVersionUID = 1L;
	private User currentUser;//当前用户
	private ClaimVoucher claimVoucher;//报销单主单	
	private List<ClaimVoucher> claimVoucherListShow;//报销单集合
	private ClaimVoucherDetail claimVoucherDetail; //报销单明细	
	private ClaimVoucherService claimVoucherService;//业务操作接口
	private BaseServices<ClaimVoucher,Long> baseVoucherServices;//基本操作业务
	private BaseServices<ClaimVoucherDetail,Long> baseClaimVoucherDetailServices;//基本操作业务
	
	private String message;//操作信息

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


	public ClaimVoucherDetail getClaimVoucherDetail() {
		return claimVoucherDetail;
	}


	public void setClaimVoucherDetail(ClaimVoucherDetail claimVoucherDetail) {
		this.claimVoucherDetail = claimVoucherDetail;
	}

	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public ClaimVoucher getClaimVoucher() {
		return claimVoucher;
	}


	public void setClaimVoucher(ClaimVoucher claimVoucher) {
		this.claimVoucher = claimVoucher;
	}

	public List<ClaimVoucher> getClaimVoucherListShow() {
		return claimVoucherListShow;
	}


	public void setClaimVoucherListShow(List<ClaimVoucher> claimVoucherListShow) {
		this.claimVoucherListShow = claimVoucherListShow;
	}

	/**************************************************************
	 **********************  init Action     ***********************
	 **************************************************************/
	public void prepare() throws Exception {
		//获取当前用户信息	
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
				    .getAuthentication()
				    .getPrincipal();
		//用户 
		this.currentUser=(User)userDetails;
		//System.out.println("当前用户获取完毕: "+this.currentUser.getUsername());
	}
	
	/**************************************************************
	 **********************action查询报销单信息  分页显示  *****************
	 **************************************************************/
	//private int currentPage;//当前页数
	private PageBean<ClaimVoucher> pageResult;//分页数据
	
	public PageBean<ClaimVoucher> getPageResult() {
		return pageResult;
	}
	public void setPageResult(PageBean<ClaimVoucher> pageResult) {
		this.pageResult = pageResult;
	}
	public String findActionVoucher() throws Exception {
		//根据用户查询报销单
		Map<String,Object> paramters=new HashMap<String,Object>();		
		PageBean<ClaimVoucher> pagebean=new PageBean<ClaimVoucher>();
		pagebean.setPageSize(5);//页大小 
		//pagebean.setCurrentPage(currentPage);//当前页
		
		paramters.put(" and creator=? order by id desc", this.currentUser);
		//调用业务接口 开始操作
		pageResult=baseVoucherServices.getTInObjectArrayPage(new ClaimVoucher(), paramters,pagebean);

		//清空不需要的数据
		List<ClaimVoucher> gonsList=new ArrayList<ClaimVoucher>();
		for(ClaimVoucher cv:pageResult.getBeanList()){
			cv.setNextDealBy(null);
			cv.setBizclaimVoucherDatails(null);
			User u=new User();
			u.setName(cv.getCreator().getName());
			cv.setCreator(u);
			
			gonsList.add(cv);
		}
		//得需要的数据
		pageResult.setBeanList(gonsList);
		//当前面
		System.out.println("pageResult.getStartIndex() : "+pageResult.getStartIndex());
		pageResult.setStartIndex(pageResult.getStartIndex());
				
		return "showVoucher";
	}

	
	/**************************************************************
	 **********************ajax查询报销单信息 分页显示   ******************
	 **************************************************************/
	public String findAjaxVoucher() throws Exception {
		//根据用户查询报销单
		Map<String,Object> paramters=new HashMap<String,Object>();
		
		//PageBean<ClaimVoucher> pagebean=new PageBean<ClaimVoucher>();
		//pagebean.setPageSize(5);//页大小 
		//pagebean.setCurrentPage(currentPage);//当前页
		
		paramters.put(" and creator=? order by id desc", this.currentUser);
		//调用业务接口 开始操作
		PageBean<ClaimVoucher> pageResultNew=baseVoucherServices.getTInObjectArrayPage(new ClaimVoucher(), paramters,pageResult);

		//清空不需要的数据
		List<ClaimVoucher> gonsList=new ArrayList<ClaimVoucher>();
		for(ClaimVoucher cv:pageResultNew.getBeanList()){
			cv.setNextDealBy(null);
			cv.setBizclaimVoucherDatails(null);
			User u=new User();
			u.setName(cv.getCreator().getName());
			cv.setCreator(u);
			System.out.println("cv id  "+cv.getId());
			gonsList.add(cv);
		}
		//得需要的数据
		pageResultNew.setBeanList(gonsList);
		/*if(pageResult.getStartIndex()<=0){
			pageResult.setStartIndex(1);
		}*/
		
		pageResultNew.setStartIndex(pageResultNew.getStartIndex());
		//String gosnString="[{}]";
		
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");//去除缓存
		response.setContentType("application/json;charset=utf-8");
		
		Gson gosnVoucher=new Gson();
		String gosnStr2="";
		try {
		gosnStr2=gosnVoucher.toJson(pageResultNew);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("gosn2: "+gosnStr2);
		PrintWriter out=response.getWriter();
		out.write(gosnStr2);
		
		
		out.flush();
		out.close();
		return null;
	}

	/**************************************************************
	 ****************  保存完整报销单 并插入到数据库中     *******************
	 **************************************************************/
	@SuppressWarnings("unchecked")
	public String addVoucher() throws Exception {
	//转换报销单明细集合
	double totalAcc=0;//总金额
	Set<ClaimVoucherDetail> detailSet=new HashSet<ClaimVoucherDetail>();
	if(VocherDetailsManger.getDetailsMap().containsKey(currentUser.getUsername())){
    for(ClaimVoucherDetail dateil:VocherDetailsManger.getDetailsMap().get(currentUser.getUsername())){
	    totalAcc+=(double)dateil.getAccount();
	    dateil.setBizclaimVoucher(claimVoucher);//关联主单
	    detailSet.add(dateil);
    }
	}
    if(detailSet==null||detailSet.size()<=0){return "error";}//如果没有明细
    //添加默认的一些属性
   
    //根据员工部门职位查询待处理人
    User nextDealBy=claimVoucherService.getNextUserByDeparmentAndPosition(this.currentUser);
    claimVoucher.setNextDealBy(nextDealBy);//待处理人
    claimVoucher.setCreator(this.currentUser);//填表人
    claimVoucher.setTotalAccount((Double)totalAcc);//总金额
    
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");// hh:mm:ss
    String StrDate=sdf.format(new Date());
    Date dateNew=sdf.parse(StrDate);
    System.out.println("str: "+StrDate+"date: "+dateNew);
    
    claimVoucher.setCreateTime(dateNew);//填表日期
    claimVoucher.setStatus("未提交");
    
    try {
    claimVoucher.getBizclaimVoucherDatails().add(detailSet);//加入主报销单
    //调用业务层 保存报销单
    Long count=baseVoucherServices.save(claimVoucher);
    if(count<=0)return "error";
    } catch (Exception e) {
		e.printStackTrace();
	}
    
    //明细关联主单 
    for(ClaimVoucherDetail dateil:detailSet){
	  dateil.setBizclaimVoucher(claimVoucher);
	  baseClaimVoucherDetailServices.save(dateil);
    }
    
    //remove list
    VocherDetailsManger.removeDetailsMap(currentUser.getUsername());
	System.out.println("addVoucherOK");
	return "addVoucherOK";
	}
	
	/**************************************************************
	 ******************* 保存一个报销单明细  ajax************************
	 **************************************************************/
	public String saveOnVoucher() throws Exception {
		//保存一条记录，先保存在集合中
        //claimVoucher.addDetailsList(claimVoucherDetail);
        VocherDetailsManger.addDetailsMap(currentUser.getUsername(),claimVoucherDetail);
	
	    //设置格试 转换Gson格式
		HttpServletResponse response=ServletActionContext.getResponse();
		Gson gson=new Gson();
		String gsonSet=gson.toJson(VocherDetailsManger.getDetailsMap().get(currentUser.getUsername()));
		response.setHeader("Cache-Control", "no-cache");//去除缓存
		response.setContentType("application/json;charset=utf-8");
		PrintWriter output=response.getWriter();
		output.write(gsonSet);
		output.flush();
		output.close();
		
		return null;
	}
	
	/**************************************************************
	 ******************* 删除一个报销单明细  ajax************************
	 **************************************************************/
	private Integer setIndex;
	public void setSetIndex(Integer setIndex) {
		this.setIndex = setIndex;
	}

	public String deleteOnVoucher() throws Exception {
		HttpServletResponse response=ServletActionContext.getResponse();
		if(VocherDetailsManger.getDetailsMap().get(currentUser.getUsername()).size()>0&&setIndex!=null){
			VocherDetailsManger.getDetailsMap().get(currentUser.getUsername()).remove((int)setIndex);
		//转换Gson格式
		Gson gson=new Gson();
		String gsonSet=gson.toJson(VocherDetailsManger.getDetailsMap().get(currentUser.getUsername()));
		response.setHeader("Cache-Control", "no-cache");//去除缓存
		response.setContentType("application/json;charset=utf-8");
		PrintWriter output=response.getWriter();
		output.write(gsonSet);
		output.flush();
		output.close();
		}
		return null;
	}
	
	/**************************************************************
	 ********************** 提交完整报销单ajax  ***********************
	 **************************************************************/
	public String saveSubmitVoucherAjax() throws Exception {
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");//去除缓存
		response.setContentType("text/html;charset=utf-8");
		PrintWriter output=response.getWriter();
		
	     try {		
		//获取对象，如果提高速度，另写一个更新hql条件只是id
		claimVoucher=baseVoucherServices.getTInId(new ClaimVoucher(),claimVoucher.getId());
		//update 
		claimVoucher.setStatus("已提交");
		baseVoucherServices.update(claimVoucher);
	    } catch (Exception e) {
	     message="提交失败 ID:"+claimVoucher.getId();
	     output.print(message);
		 return null;
	    }		
		message="提交成功 ID:"+claimVoucher.getId();			
		output.print(message);
		output.flush();
		output.close();
		return null;
	}
	/**************************************************************
	 **********************  删除报销单  ajax  ************************
	 **************************************************************/
	public String deleteVoucherAjax() throws Exception {
		//System.out.println("id: "+claimVoucher.getId());		
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");//去除缓存
		response.setContentType("text/html;charset=utf-8");
		PrintWriter output=response.getWriter();
//获取状态 如果已经付款则不能随意删除 只要管理员才能删除------------------------------------
		ClaimVoucher claimV	=baseVoucherServices.getTInId(new ClaimVoucher(),claimVoucher.getId());
		
		if(Constants.FINANCE_PASsVOUCHER.equals(claimV.getStatus())){
		message="已领完款的报销单你无权删除！";
		}else{
		/*ClaimVoucher claimV=new ClaimVoucher();
		claimV.setId(claimVoucher.getId());*/
		
		try {
			baseVoucherServices.delete(claimV);
		} catch (Exception e) {
			// TODO: handle exception
			message="删除失败 ID:"+claimVoucher.getId();
			output.print(message);
		    e.printStackTrace();
		    return null;
		}
		message="删除成功 ID:"+claimVoucher.getId();	
		}	
		
		output.print(message);
		output.flush();
		output.close();
		return null;
	}
	
	/**************************************************************
	 **********************  修改报销单    ***************************
	 **************************************************************/

	public String updateVoucher() throws Exception {
		try {
			baseVoucherServices.update(claimVoucher);
		} catch (Exception e) {
			// TODO: handle exception
			message="更新失败";
			return "error";
		}
		
		message="更新成功:"+claimVoucher.getId();
		return "updateOK";
	}

	
	
	

	
	

}
