package com.oa.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.access.annotation.Secured;

import com.oa.bean.VoucherChartHtml;


public class OaJdbcDao implements OajdbcDaoInterface {
	//支持jdbc sql
		private JdbcTemplate jdbcTemplate;
		//private DataSource dataSource;
		
		
		public JdbcTemplate getJdbcTemplate() {
			return jdbcTemplate;
		}
		public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
			this.jdbcTemplate = jdbcTemplate;
		}



		//通过注入得得到DataSoruce再  得到simpleJdbcTemplate
		public void setDataSource(DataSource dataSource) {
				//this.dataSource = dataSource;
				this.jdbcTemplate=new JdbcTemplate(dataSource);
				this.jdbcTemplate.setResultsMapCaseInsensitive(true);
		}
		
		
		//ROLE_OA_DepartmentManger ,"ROLE_OA_GeneralManager"
/**===========================显示月份报表比例图 数据============================================**/
//@Secured({"ROLE_FINANCE"}) 
public List<VoucherChartHtml>  getVoucherListChart(String year) {
	String sql="select month(create_time) as createTime,sum(total_account) as totalAccount,year(create_time) as crruntYear from biz_claim_voucher where year(create_time)=? group by month(create_time),year(create_time)";//, year(create_time)
	List<VoucherChartHtml> f;
	f=jdbcTemplate.queryForObject(sql, new Object[]{year},
	                               new RowMapper<List<VoucherChartHtml>>(){

	public List<VoucherChartHtml>  mapRow(ResultSet rs, int arg1) throws SQLException {
			
		if(rs==null){return null;}
		List<VoucherChartHtml> listF=new ArrayList<VoucherChartHtml>();
		//System.out.println("封装中............"+rs.getString("createTime")+"  :  "+rs.getDouble("totalAccount")+"  "+rs.getLong("crruntYear"));
		VoucherChartHtml f1=new VoucherChartHtml();				
		f1.setCreateTime(rs.getLong("createTime"));
		f1.setTotalAccount(rs.getDouble("totalAccount"));
		f1.setCrruntYear(rs.getLong("crruntYear"));
	    listF.add(f1);
	    
		while(rs.next()){
		//System.out.println("封装中............"+rs.getString("createTime")+"  :  "+rs.getDouble("totalAccount")+"  "+rs.getLong("crruntYear"));
		VoucherChartHtml f=new VoucherChartHtml();				
		f.setCreateTime(rs.getLong("createTime"));
		f.setTotalAccount(rs.getDouble("totalAccount"));
		f.setCrruntYear(rs.getLong("crruntYear"));
	    listF.add(f);
		}
		return listF;
	
		}
	});
	
	return f;
	
}

//@Secured({"ROLE_FINANCE"}) //对方法时行保护，只有role——finanace的角色才能调用
public void helloScurity(){
	System.out.println("hello scurity.....your finance");
}
}
