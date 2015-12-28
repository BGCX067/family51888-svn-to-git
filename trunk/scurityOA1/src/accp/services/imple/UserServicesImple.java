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
 * 基本操做可以调用BaseDao时的方法
 * 用户业务处理层
 * extends BaseDaoImpl<User,Integer>
 *
 */

public class UserServicesImple implements UserServices {
	
	private UserDao userDao;//用户数据层接口
	
	
	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public String sayHello(String name) {
		System.out.println("进来了!!!");
		return "hello:"+name;
	}

	public String sayBye(String name) {
		// TODO Auto-generated method stub
		return "bay:"+name;
	}

	/**************ajax判断是否有重复名字*********************/
	public boolean getAjaxIsUserName(String name) {
	return userDao.getAjaxIsUserName(name);
	}
	
	/***************************用户登陆***************************/
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
