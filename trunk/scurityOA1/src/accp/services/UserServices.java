package accp.services;



import org.springframework.security.access.annotation.Secured;
import accp.bean.User;
import accp.dao.BaseDao;
import accp.dao.imple.BaseDaoImpl;

/**
 * 
 * @author liangrui
 * 用户服务层接口
 *
 */


public interface UserServices   {
	
	//注解方式对方法加以限制
	@Secured({"ROLE_USER,ROLE_ADMIN"})
	String sayHello(String name);
	
	//只允许admin用户调用
	@Secured("ROLE_ADMIN")
	String sayBye(String name);

	/***ajax判断是否有重复名字***/
	boolean getAjaxIsUserName(String name);
	
	/***login***/
	User getLogin(User u);
	
	/***register***/
	User saveUser(User u);
	
	/***update password***/
	boolean updatePassword(Long id,String oldPass,String newPAss);
}
