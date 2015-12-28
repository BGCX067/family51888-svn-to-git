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
 * �û� daoImpl ʵ���࣬�̳�BaseDaoImplʵ����  
 * ��ʵ��UserDao�ӿ� ���������������д
 * �����Ĳ�������BaseDao�е���
 * @author liangrui
 * @qq 382453602
 */
public  class UserDaoImpl extends BaseDaoImpl<User,Long> implements UserDao  {

	/***ajax�ж��Ƿ����ظ�����***/
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
