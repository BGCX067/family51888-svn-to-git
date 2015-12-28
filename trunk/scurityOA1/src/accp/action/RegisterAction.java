package accp.action;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;


import accp.bean.Role;
import accp.bean.User;
import accp.services.BaseServices;
import accp.services.RoleServices;
import accp.services.UserServices;

import com.opensymphony.xwork2.ActionSupport;

public class RegisterAction extends ActionSupport {
	
	private User user;
	private UserServices services;//用户接口
	//private RoleServices roleServices;//角色接口
	private String enabled;//是否生效
	private BaseServices<User,Long> baseUserServices;//基本user业务
	private BaseServices<Role,Long> baseRoleServices;//基本role业务
	

	
	public BaseServices<User, Long> getBaseUserServices() {
		return baseUserServices;
	}

	public void setBaseUserServices(BaseServices<User, Long> baseUserServices) {
		this.baseUserServices = baseUserServices;
	}

	public BaseServices<Role, Long> getBaseRoleServices() {
		return baseRoleServices;
	}

	public void setBaseRoleServices(BaseServices<Role, Long> baseRoleServices) {
		this.baseRoleServices = baseRoleServices;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}


	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public UserServices getServices() {
		return services;
	}

	public void setServices(UserServices services) {
		this.services = services;
	}
	/****************************register***************************/
	
	public String register() throws Exception {
		try {
			//加密密码
			Md5PasswordEncoder md5 = new Md5PasswordEncoder();
			String passwordMD5=md5.encodePassword(user.getPassword(), user.getUsername());
			//System.out.println("md5+alt后 :"+passwordMD5);
			user.setPassword(passwordMD5);
			
		    //封装角色集合
		   Set<Role> rolesSet=new HashSet<Role>();
		   //取到权限的对象
		   Set set=user.getRoles();
		   Iterator it=set.iterator();
		  
			while(it.hasNext()){
				//根据id查询对象
				Long roleID=Long.valueOf(it.next().toString());
				//System.out.println(roleID);
				Role role=baseRoleServices.getTInId(new Role(),roleID);
				rolesSet.add(role);
			}
			//是否生效
			if(null==enabled){
				user.setStatus(0);
			}else{
				user.setStatus(1);
			}
			
		    user.setRoles(rolesSet);//将角色加入用户对象里
			System.out.println("开始注册......");
			System.out.println(user.getDepartment_id().getId());
			System.out.println(user.getPosition_id().getId());
			/*System.out.println("stop----");
			int i=10/0;*/
			
			Long userID =baseUserServices.save(user);
			
			if(null==userID||userID<=0)return "error";
			
			} catch (Exception e) {
			e.printStackTrace();
			return "error";
			}
			return "ok";
			
		}
	
	
		
}
