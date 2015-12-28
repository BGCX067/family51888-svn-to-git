package accp.services.imple;

import java.io.Serializable;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;


import accp.bean.Resc;
import accp.bean.Role;
import accp.bean.User;
import accp.dao.UserDao;
import accp.dao.imple.BaseDaoImpl;
import accp.services.UserServices;
/**
 * 
 * @author liangrui
 * �����������Ե���BaseDaoʱ�ķ���
 * �û�ҵ�����
 * extends BaseDaoImpl<User,Integer>
 *
 */

public class UserServicesImple implements UserServices {
	
	private UserDao userDao;//�û����ݲ�ӿ�
	
	
	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public String sayHello(String name) {
		System.out.println("������!!!");
		return "hello:"+name;
	}

	public String sayBye(String name) {
		// TODO Auto-generated method stub
		return "bay:"+name;
	}

	/**************ajax�ж��Ƿ����ظ�����*********************/
	public boolean getAjaxIsUserName(String name) {
	return userDao.getAjaxIsUserName(name);
	}
	
	/***************************�û���½***************************/
	public User getLogin(User u) {
		// TODO Auto-generated method stub
		//List<User> list=super.getAll(u);
		List list=userDao.getAll(u);
		
		if(null==list||list.size()<=0){
		return null;
		}else {
		return (User) list.get(0);
		}
		
	}
	
	/***register***/
	public User saveUser(User u){
		try {
		
		userDao.save(u);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return u;
	}

	/***update password***/
	public boolean updatePassword(Long id,String oldPass, String newPAss) {
		return userDao.updatePassword(id, oldPass, newPAss);
	}
	
}
