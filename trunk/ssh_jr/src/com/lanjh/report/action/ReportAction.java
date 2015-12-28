package com.lanjh.report.action;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.dbcp.BasicDataSource;

import com.lanjh.report.ReportResult;
import com.lanjh.report.service.IReportService;
import com.lanjh.servlet.ServiceLoader;
import com.opensymphony.xwork2.ActionSupport;

public class ReportAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	
	// 报表名称
	private String name;
	
	// 类型
	private String type;
	
	// 指定生成的报表文件的格式,如果不指定,（默认生成PDF文件）XLS：excel格式，HTML：html格式，CSV，XML
	private String format;
	
    private Connection connection;  //数据源连接   
    @Resource(name="dataSource")   
    private BasicDataSource dataSource;   //数据源 
    
    private Map<String,Object> para;     //传递的参数   
    
    private ReportResult result = null;
    
	@Override
	public String execute() throws Exception {
		try{
			if(name!=null&&name.length()>0){
				if(para == null ){
					para = new HashMap<String,Object>();
				}
				IReportService iReportService = (IReportService)ServiceLoader.getBean(name);
				result = iReportService.doService(type,para,format);
			}else{
				System.out.println("报表名称为空。");
			}
			
			if(result.getList()== null && result.getList().size() == 0){
				this.connection = dataSource.getConnection();   
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
        
        return SUCCESS;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		if(format!=null&&format.length()>0){
			this.format = format.toUpperCase();
		}
	}

	public Connection getConnection() {
		return connection;
	}

	public void setConnection(Connection connection) {
		this.connection = connection;
	}

	public BasicDataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(BasicDataSource dataSource) {
		this.dataSource = dataSource;
	}

	public Map<String, Object> getPara() {
		return para;
	}

	public void setPara(Map<String, Object> para) {
		this.para = para;
	}

	public ReportResult getResult() {
		return result;
	}

	public void setResult(ReportResult result) {
		this.result = result;
	}   
}
