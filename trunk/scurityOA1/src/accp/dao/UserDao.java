package accp.dao;

import accp.bean.Resc;
import accp.bean.User;
import accp.dao.imple.BaseDaoImpl;
/**
 * 用户类接口 继承BaseDao接口
 * @author liangrui
 *
 */
public interface UserDao extends BaseDao<User,Long>   {

	/***ajax判断是否有重复名字***/
	boolean getAjaxIsUserName(String name);
	
	/***update password***/
	boolean updatePassword(Long id,String oldPass,String newPAss);
}
