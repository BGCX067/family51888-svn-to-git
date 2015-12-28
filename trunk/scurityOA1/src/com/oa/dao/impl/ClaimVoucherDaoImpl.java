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

	/*//֧��jdbc sql
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private DataSource dataSource;
	
	
	//ͨ��ע��õõ�DataSoruce��  �õ�simpleJdbcTemplate
	public void setDataSource(DataSource dataSource) {
			this.dataSource = dataSource;
			//ʹ��Simple ��ʽ ����
			this.simpleJdbcTemplate=new SimpleJdbcTemplate(dataSource);
			
	}
	
    public void setSimpleJdbcTemplate(SimpleJdbcTemplate simpleJdbcTemplate) {
		this.simpleJdbcTemplate = simpleJdbcTemplate;
	}
*/
   

	//����Ա������ְλ��ѯ��������=======================================================================
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
