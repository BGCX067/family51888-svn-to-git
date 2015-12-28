package accp.services;



import org.springframework.security.access.annotation.Secured;
import accp.bean.User;
import accp.dao.BaseDao;
import accp.dao.imple.BaseDaoImpl;

/**
 * 
 * @author liangrui
 * �û������ӿ�
 *
 */


public interface UserServices   {
	
	//ע�ⷽʽ�Է�����������
	@Secured({"ROLE_USER,ROLE_ADMIN"})
	String sayHello(String name);
	
	//ֻ����admin�û�����
	@Secured("ROLE_ADMIN")
	String sayBye(String name);

	/***ajax�ж��Ƿ����ظ�����***/
	boolean getAjaxIsUserName(String name);
	
	/***login***/
	User getLogin(User u);
	
	/***register***/
	User saveUser(User u);
	
	/***update password***/
	boolean updatePassword(Long id,String oldPass,String newPAss);
}
