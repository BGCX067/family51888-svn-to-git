package com.oa.action;

import java.io.PrintWriter;
import java.util.Hashtable;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;
import com.oa.util.WeatherUtil;
import com.opensymphony.xwork2.ActionSupport;

public class WeatherInfo extends ActionSupport {
private String city;
	
	//存放天气信息
	Hashtable<String,Object> weathers=null;//new Hashtable<String,Object>();
	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String execute() throws Exception {
	System.out.println("-----开始查询-------");
	
	if("".equals(city)||null==city){
		city="南昌";
	}
	//得到天气信息
	try {
	weathers=WeatherUtil.getInstancce().getWea(city);
	//ActionContext.getContext().put("weathers", weathers);
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	HttpServletResponse response=ServletActionContext.getResponse();
	response.setHeader("Cache-Control", "no-cache");//去除缓存	
	//PrintWriter out=response.getWriter();
	
	if(weathers!=null&&weathers.size()>0){
	response.setContentType("application/json;charset=utf-8");
	PrintWriter out2=response.getWriter();
	Gson gosnVoucher=new Gson();
	String gosnStr="";
	try {
	gosnStr=gosnVoucher.toJson(weathers);
	} catch (Exception e) {
	e.printStackTrace();
	}
	gosnStr=new String(gosnStr.getBytes(),"gbk");
	System.out.println("gosn: "+gosnStr);
	out2.write(gosnStr);
	}else{
	response.setContentType("text/html;charset=utf-8");
	PrintWriter out=response.getWriter();
	out.print("sorry weather Exception...");
	}
	/*out.flush();
	out.close();*/
	
	return null;
  
	}
}
