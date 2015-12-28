package accp.dao.imple;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import accp.bean.Resc;
import accp.bean.User;
import accp.dao.BaseDao;
import accp.dao.UserDao;

/**
 * 用户 daoImpl 实现类，继承BaseDaoImpl实现类  
 * 并实现UserDao接口 特殊操作可在这里写
 * 基本的操作都在BaseDao中调用
 * @author liangrui
 * @qq 382453602
 */
public  class UserDaoImpl extends BaseDaoImpl<User,Long> implements UserDao  {

	/***ajax判断是否有重复名字***/
	public boolean getAjaxIsUserName(String name) {
		String hql="from User where username=?";
		List list=this.getHibernateTemplate().find(hql,new Object[]{name});
		
		if(null==list||list.size()<=0){
			return false;
		}else {
			//System.out.println("ajax U:"+((User)list.get(0)).getUsername());
			return true;
			}
	}

/***=======================update password====================================***/
	public boolean updatePassword(Long id,String oldPass, String newPAss) {
		String hql="update User set password=? where id=? and password=?";
		int coutn=0;
		
		try {
		System.out.println("messssssssss "+newPAss+" id: "+id+oldPass);
		Session session=this.getHibernateTemplate().getSessionFactory().openSession();
		Query query=session.createQuery(hql);
		query.setParameter(0, newPAss);
		query.setParameter(1, id);
		query.setParameter(2, oldPass);
		 coutn=query.executeUpdate();
		
		//this.getHibernateTemplate().update(hql, new Object[]{newPAss,id,oldPass});
		
	} catch (Exception e) {
		e.printStackTrace();
		return false;
	}
		
		if(coutn>0){
			return true;
		}else{return false;}
		
	}
	
	

	


	
	
}
