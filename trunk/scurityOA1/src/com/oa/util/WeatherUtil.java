package com.oa.util;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Hashtable;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;



public class WeatherUtil {
	// 编码
		private String enCoding ="utf-8";
		// 目标url
		private String targetWebserviceUri="http://www.webxml.com.cn/WebServices/WeatherWebService.asmx";
		//private String targetWebserviceUri = "http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx?wsdl";
	private WeatherUtil(){};
	
	public static WeatherUtil getInstancce(){
		return new WeatherUtil();
	}
	
	 /**     
	    * 对服务器端返回的XML进行解析     
	    * WeatherObj 常量
	    * @param city 用户输入的城市名称     
	    * @return 字符串 用,分割     
	   * @throws Exception 
	    */    
	public Hashtable<String,Object> getWea(String city) throws Exception{
		
	Hashtable<String,Object> weathers=new Hashtable<String,Object>();
	Document doc=null;
	
	DocumentBuilderFactory  dbf=DocumentBuilderFactory.newInstance();
	DocumentBuilder db=dbf.newDocumentBuilder();
	
	
	InputStream is=getResponseSOAP(city);//获取流
	
	doc=db.parse(is); //获取 xml文档
	
	NodeList nl=doc.getElementsByTagName("string");//获取所有节点
   //循环读取 并放入hashtable
	//System.out.println("元素Length:"+nl.getLength());
	
   for(int i =0;i<nl.getLength();i++){
	   Node n = nl.item(i);
	   String nodeValue=n.getFirstChild().getNodeValue();
	  // System.out.println(i+":  "+nodeValue);
	   if(i !=11){
		
		   weathers.put(WeatherObj.input.get(i), nodeValue) ;
	   }
   }
		   
   return weathers;
	
	  
		
		
	}
	
	/**
	 * 封装xml
	 */
	public String getRequestSOAP(String city){
		
		 StringBuffer sb = new StringBuffer();
			sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			sb.append("<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">");
			sb.append("<soap:Body>");
			sb.append("<getWeatherbyCityName xmlns=\"http://WebXml.com.cn/\">");
			sb.append(" <theCityName>"+city+"</theCityName>");
			sb.append("</getWeatherbyCityName>");
			sb.append("</soap:Body>");
			sb.append("</soap:Envelope>");
			
			return sb.toString();
		
	}
	
	/**
	 * @throws MalformedURLException 
	 * 获得流
	 */
 private InputStream getResponseSOAP(String city) throws Exception{
	String requestSOAP=getRequestSOAP(city);
	
	   // 创建url
	   URL  url= new URL(targetWebserviceUri);
	 
	   if(url.openConnection()==null){
		   System.out.println("返回了空 url.openConnection()");
		   return null;
	   }else{
	   //得到url 的链接
	   URLConnection conn = url.openConnection();
	 
	   conn.setUseCaches(false);
	   conn.setDoInput(true);
	   conn.setDoOutput(true);
	   // 设置请求的头信息
	   conn.setRequestProperty("Content-Type", "text/xml; charset="+enCoding);
	   conn.setRequestProperty("Content-Length", requestSOAP.length()+"");
	   conn.setRequestProperty("SOAPAction", "http://WebXml.com.cn/getWeatherbyCityName");
	   
	 OutputStream os = conn.getOutputStream();       
     OutputStreamWriter osw = new OutputStreamWriter(os, enCoding);       
     osw.write(requestSOAP);   
     osw.flush();       
     osw.close(); 
     return conn.getInputStream() ;
	   }
	  
	}
 
 
}
