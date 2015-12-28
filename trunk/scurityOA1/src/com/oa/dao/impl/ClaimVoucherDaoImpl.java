package com.oa.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import accp.bean.User;
import accp.dao.imple.BaseDaoImpl;
import com.oa.bean.ClaimVoucher;
import com.oa.dao.ClaimVoucherDao;

public class ClaimVoucherDaoImpl extends BaseDaoImpl<ClaimVoucher,Long> implements ClaimVoucherDao {

	/*//支持jdbc sql
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private DataSource dataSource;
	
	
	//通过注入得得到DataSoruce再  得到simpleJdbcTemplate
	public void setDataSource(DataSource dataSource) {
			this.dataSource = dataSource;
			//使用Simple 方式 更好
			this.simpleJdbcTemplate=new SimpleJdbcTemplate(dataSource);
			
	}
	
    public void setSimpleJdbcTemplate(SimpleJdbcTemplate simpleJdbcTemplate) {
		this.simpleJdbcTemplate = simpleJdbcTemplate;
	}
*/
   

	//根据员工部门职位查询待处理人=======================================================================
	public User getNextUserByDeparmentAndPositions(String userDeparment,String userPositionName) {
		String hql="from User u where u.department_id.name=? and u.position_id.name_cn=?";
	
    	return (User) this.getHibernateTemplate().
		                         find(hql,new Object[]
				                 {userDeparment,
				                 userPositionName}).get(0);
	/*	for(User  u:listUser){
			System.out.println(u.getName()+" "+u.getPosition_id().getName_cn());
		}*/
		//return listUser.get(0);
	}

}
