package accp.dao;

import accp.bean.Resc;
import accp.bean.User;
import accp.dao.imple.BaseDaoImpl;
/**
 * �û���ӿ� �̳�BaseDao�ӿ�
 * @author liangrui
 *
 */
public interface UserDao extends BaseDao<User,Long>   {

	/***ajax�ж��Ƿ����ظ�����***/
	boolean getAjaxIsUserName(String name);
	
	/***update password***/
	boolean updatePassword(Long id,String oldPass,String newPAss);
}
