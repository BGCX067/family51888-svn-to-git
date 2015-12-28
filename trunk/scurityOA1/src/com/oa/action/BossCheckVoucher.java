package com.oa.action;

import java.io.PrintWriter;
import java.util.ArrayList;
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
import com.oa.bean.CheckResult;
import com.oa.bean.ClaimVoucher;
import com.oa.bean.ClaimVoucherDetail;
import com.oa.service.ClaimVoucherService;
import com.oa.util.Constants;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;
/**
 * 总经理审核报销单的action
 * @author liangrui
 * @qq 382453602
 */
public class BossCheckVoucher extends ActionSupport implements Preparable{
	
	private User currentUser;//当前用户
	private ClaimVoucher claimVoucher;//报销单主单	
	private CheckResult checkResult;//审核信息
	private List<ClaimVoucher> claimVoucherListShow;//报销单集合
	private ClaimVoucherDetail claimVoucherDetail; //报销单明细	
	//interceptro
	private ClaimVoucherService claimVoucherService;//业务操作接口
	private BaseServices<ClaimVoucher,Long> baseVoucherServices;//基本操作业务
	private BaseServices<ClaimVoucherDetail,Long> baseClaimVoucherDetailServices;//基本操作业务
	private BaseServices<CheckResult,Long> baseCheckResultServices;//基本操作业务
	private String message;
//----------------------------------------------------------------------------------------------
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
	
/***========================== init Action =======================================**/
	public void prepare() throws Exception {
		//获取当前用户信息	
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
				    .getAuthentication()
				    .getPrincipal();
		//用户 
		this.currentUser=(User)userDetails;
		System.out.println("当前用户获取完毕: "+this.currentUser.getUsername());
		
	}
	
/***==========================ajax查询报销单信息列表  =======================================**/	
	public String findBossCheckVoucherAjax() throws Exception {
		//根据用户查询报销单
		Map<String,Object> paramters=new HashMap<String,Object>();
		paramters.put(" and nextDealBy=? ", this.currentUser);
		paramters.put(" and status=? order by id desc", Constants.DM_PASsVOUCHER);
		//调用业务接口 开始操作
		claimVoucherListShow=baseVoucherServices.getTInObjectArray(new ClaimVoucher(), paramters);

		//清空不需要的数据
		List<ClaimVoucher> gonsList=new ArrayList<ClaimVoucher>();
		for(ClaimVoucher cv:claimVoucherListShow){
			cv.setNextDealBy(null);
			cv.setBizclaimVoucherDatails(null);
			User u=new User();
			u.setName(cv.getCreator().getName());
			cv.setCreator(u);
			
			gonsList.add(cv);
		}
		//String gosnString="[{}]";
		
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");//去除缓存
		response.setContentType("application/json;charset=utf-8");
		
		Gson gosnVoucher=new Gson();
		String gosnStr="";
		try {
			
		gosnStr=gosnVoucher.toJson(gonsList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//System.out.println("gosn: "+gosnStr);
		PrintWriter out=response.getWriter();
		out.write(gosnStr);
		out.flush();
		out.close();
		return null;
	}

/***==========================查看报销单明细Ajax  =======================================**/	
	public String findCheckVoucherDateilsAjax() throws Exception {
	//通过id获取对象
	claimVoucher=baseVoucherServices.getTInId(new ClaimVoucher(), claimVoucher.getId());
	List<ClaimVoucher> gonsList=new ArrayList<ClaimVoucher>();//gosn 集合	
	List<CheckResult> resultList=null;
	try {		
	//清空不需要的数据
	claimVoucher.setNextDealBy(null);
	User u=new User();
	u.setName(claimVoucher.getCreator().getName());
	claimVoucher.setCreator(u);	  
    @SuppressWarnings("unchecked")
	Iterator<ClaimVoucherDetail> cvIT	=claimVoucher.getBizclaimVoucherDatails().iterator();
	Set detailsSet=new HashSet();
	while(cvIT.hasNext()){
		ClaimVoucherDetail cv=cvIT.next();
		cv.setBizclaimVoucher(null);
		detailsSet.add(cv);
	}
	claimVoucher.setBizclaimVoucherDatails(detailsSet);//添加明细
	gonsList.add(claimVoucher);	//加入集合	
	
	Map<String,Object> paramenters=new HashMap<String,Object>();
	paramenters.put(" and sheetld=? ", claimVoucher.getId());
	//查询部门经理审核的结果 根据报销单id
	 resultList=baseCheckResultServices.getTInObjectArray(new CheckResult(), paramenters);
	 resultList.get(0).getSysEmployee().setRoles(null);
     resultList.get(0).setClainmVoucher(claimVoucher);//得到显示的结果数据
		
	} catch (Exception e) {
	e.printStackTrace();
	}
		
	        //封装ajax
			HttpServletResponse response=ServletActionContext.getResponse();
			response.setHeader("Cache-Control", "no-cache");//去除缓存
			response.setContentType("application/json;charset=utf-8");
			
			Gson gosnVoucher=new Gson();
			String gosnStr="";
			try {
			gosnStr=gosnVoucher.toJson(resultList);
			} catch (Exception e) {
			e.printStackTrace();
			}
			System.out.println("gosn: "+gosnStr);
			PrintWriter out=response.getWriter();
			out.write(gosnStr);
			out.flush();
			out.close();		
			
	return null;
	}
	
	
/***==========================已审核 的报销单 =======================================**/	
	public String findBossHositryAjax() throws Exception {
				Map<String,Object> paramters=new HashMap<String,Object>();
				//准确的查询应该先从审核结果中得到状态，根据用户id得到报销单所有id 再查询出结果 这里为了简单 省略....
				//根据报销单状态得到审核记录
				paramters.put(" and status=? ", Constants.BOSS_PASsVOUCHER);
			    paramters.put(" or status=? ",Constants.BOSScHECK_BACK);
			    paramters.put(" or   status= ? ",Constants.BOSScHECK_RUTNDOWN);
			    paramters.put(" or status=?  and total_account>=5000 ",Constants.FINANCE_PASsVOUCHER);
			   
			   
				//调用业务接口 开始操作
				claimVoucherListShow=baseVoucherServices.getTInObjectArray(new ClaimVoucher(), paramters);

				//清空不需要的数据
				List<ClaimVoucher> gonsList=new ArrayList<ClaimVoucher>();
				for(ClaimVoucher cv:claimVoucherListShow){
					cv.setNextDealBy(null);
					cv.setBizclaimVoucherDatails(null);
					User u=new User();
					u.setName(cv.getCreator().getName());
					cv.setCreator(u);
					
					gonsList.add(cv);
				}
				//String gosnString="[{}]";
				
				HttpServletResponse response=ServletActionContext.getResponse();
				response.setHeader("Cache-Control", "no-cache");//去除缓存
				response.setContentType("application/json;charset=utf-8");
				
				Gson gosnVoucher=new Gson();
				String gosnStr="";
				try {
					
				gosnStr=gosnVoucher.toJson(gonsList);
				} catch (Exception e) {
					e.printStackTrace();
				}
				//System.out.println("gosn: "+gosnStr);
				PrintWriter out=response.getWriter();
				out.write(gosnStr);
				out.flush();
				out.close();
		return null;
	}
	
/***==========================审核 同意报销单  =======================================**/	
	//这个方法需要写在service 里 或者给这个action指定事务 为了演示方便这里暂时省略...
	public String saveCheckVoucherPass() throws Exception {
		//通过id查询出报销单
		claimVoucher=baseVoucherServices.getTInId(new ClaimVoucher(), claimVoucher.getId());
		String saveMessage="";
		//审核信息
		checkResult.setCreateTime(new Date());
		checkResult.setSysEmployee(this.currentUser);//审核人
		checkResult.setResult(Constants.CHECK_PASS);//通过
		checkResult.setStype("boss(总经理)");//类别
		checkResult.setSheetld(claimVoucher.getId());// 报销单id;
		checkResult.setSheetType("报销单");//未知的属性????
		
	    //根据用户查询出财务
	    User nextDealBy=claimVoucherService.getNextUserByDeparmentAndPosition(this.currentUser);
	    //System.out.println("finance: "+nextDealBy.getName());
	 
 try {
	    claimVoucher.setNextDealBy(nextDealBy);//待处理人
	    claimVoucher.setStatus(Constants.BOSS_PASsVOUCHER);//状态
	    baseVoucherServices.update(claimVoucher); //修改报销单
		
		//插入sql  审核信息
	   Long count=baseCheckResultServices.save(checkResult);
	   if(count>0){
		 saveMessage="成功审核报销单 id:"+claimVoucher.getId();
	   }else{
		 saveMessage="审核报销单 id:"+claimVoucher.getId()+" 失败!请联系管理员";
	   }
	   
	} catch (Exception e) {
		e.printStackTrace();
		
	}
      System.out.println(saveMessage);
		 //封装ajax
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");//去除缓存
		PrintWriter out=response.getWriter();
		out.print(saveMessage);
		//out.print(checkResult.getComment()+checkResult.getResult()+checkResult.getStype()+checkResult.getSheetld()+checkResult.getSysEmployee().getName());
		return null;
	}

/**============================拒绝审核的报销单处理===========================================**/	
	public String saveCheckVoucherTurnDown() throws Exception {
		//通过id查询出报销单
				claimVoucher=baseVoucherServices.getTInId(new ClaimVoucher(), claimVoucher.getId());
				String saveMessage="";
				//审核信息
				if(checkResult==null){
					checkResult=new CheckResult();
					}
				checkResult.setCreateTime(new Date());
				checkResult.setSysEmployee(this.currentUser);//审核人
				checkResult.setResult(Constants.BOSScHECK_RUTNDOWN);//拒绝
				checkResult.setStype("boss(总经理)");//类别
				checkResult.setSheetld(claimVoucher.getId());// 报销单id;
				checkResult.setSheetType("报销单");//?????
				  
				claimVoucher.setNextDealBy(null);//待处理人
				claimVoucher.setStatus(Constants.BOSScHECK_RUTNDOWN);//状态
				try {
				baseVoucherServices.update(claimVoucher); //修改报销单
				//插入sql  审核信息
			    Long count=baseCheckResultServices.save(checkResult);
				
			    if(count>0){
					 saveMessage="拒绝审核报销单 id:"+claimVoucher.getId()+" ok ";
				   }else{
					 saveMessage="拒绝审核报销单 id:"+claimVoucher.getId()+" 失败!请联系管理员";
				   }
			   
				 //封装ajax
				HttpServletResponse response=ServletActionContext.getResponse();
				response.setContentType("text/html;charset=utf-8");
				response.setHeader("Cache-Control", "no-cache");//去除缓存
				PrintWriter out=response.getWriter();
				out.print(saveMessage);
				} catch (Exception e) {
					 saveMessage="系统异常";
					e.printStackTrace();
				}
		return null;		
	}
	
/**============================打回审核的报销单处理===========================================**/	
	public String saveCheckVoucherBack() throws Exception {
		//通过id查询出报销单
		claimVoucher=baseVoucherServices.getTInId(new ClaimVoucher(), claimVoucher.getId());
		String saveMessage="";
		//审核信息
		if(checkResult==null){
			checkResult=new CheckResult();
			}
		checkResult.setCreateTime(new Date());
		checkResult.setSysEmployee(this.currentUser);//审核人
		checkResult.setResult(Constants.BOSScHECK_BACK);//打回
		checkResult.setStype("boss(总经理)");//类别
		checkResult.setSheetld(claimVoucher.getId());// 报销单id;
		checkResult.setSheetType("报销单");//?????
		
		claimVoucher.setNextDealBy(claimVoucher.getCreator());//待处理人 为填写报销单的人
		claimVoucher.setStatus(Constants.BOSScHECK_BACK);//状态
		baseVoucherServices.update(claimVoucher); //修改报销单
		//插入sql  审核信息
	    Long count=baseCheckResultServices.save(checkResult);
		
	   if(count>0){
		 saveMessage="打回报销单 id:"+claimVoucher.getId()+" ok ";
	   }else{
		 saveMessage="打回报销单 id:"+claimVoucher.getId()+" 失败!请联系管理员";
	   }
	   
		 //封装ajax
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");//去除缓存
		PrintWriter out=response.getWriter();
		out.print(saveMessage);
		return null;		
	}
	

}
