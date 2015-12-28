package accp.action;


import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import accp.bean.Department;
import accp.bean.Position;
import accp.bean.Role;
import accp.bean.User;
import accp.services.BaseServices;
import accp.services.RoleServices;
import accp.services.UserServices;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;
/**
 * 用户管理Action
 * @author liangrui
 * @qq382453602
 *
 */
public class UserAction extends ActionSupport implements Preparable{
	private User user;
	private List<User> listUser;//用户集合
	private List<Role> roleList;//角色集合
	private List<Department> departmentList; //部门集合
	private List<Position> positionList; //职位集合
	private UserServices services;//用户接口
	private BaseServices<User,Long> baseUserServices;//基本user业务
	private BaseServices<Role,Long> baseRoleServices;//基本role业务
	private BaseServices<Department,Long> baseDepartmentServices;//基本部门业务
	private BaseServices<Position,Long> basePositionServices;//基本职位业务
		
	private String enabled;//是否生效
	
	
	public List<Department> getDepartmentList() {
		return departmentList;
	}

	public void setDepartmentList(List<Department> departmentList) {
		this.departmentList = departmentList;
	}

	public List<Position> getPositionList() {
		return positionList;
	}

	public void setPositionList(List<Position> positionList) {
		this.positionList = positionList;
	}

	public void setBaseDepartmentServices(
			BaseServices<Department, Long> baseDepartmentServices) {
		this.baseDepartmentServices = baseDepartmentServices;
	}

	public void setBasePositionServices(
			BaseServices<Position, Long> basePositionServices) {
		this.basePositionServices = basePositionServices;
	}

	public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}

	public void setBaseUserServices(BaseServices<User, Long> baseUserServices) {
		this.baseUserServices = baseUserServices;
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

	public UserServices getServices() {
		return services;
	}

	public List<User> getListUser() {
		return listUser;
	}

	public void setListUser(List<User> listUser) {
		this.listUser = listUser;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		
		this.user = user;
		
	}

	public void setServices(UserServices services) {
		this.services = services;
	}
	
	/***========================== init Action =======================================**/
	public void prepare() throws Exception {
		//获取当前用户信息	
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
				    .getAuthentication()
				    .getPrincipal();
		//用户 
		this.user=(User)userDetails;
		System.out.println("当前用户获取完毕: "+this.user.getUsername());
		
	}	
	

/************************连接到admin.jsp页面***********************************/
	public String fowaredAdmin() throws Exception {
		System.out.println("获取u p中-------....");
		printUserInfo();
		System.out.println("转到admin.jsp面面");
		return "adminPage";
	}
/************************打印信息：用户名***********************************/	
	public void printUserInfo(){
		System.out.println("获取principal 中");
		String userName="";
		//获取安全上下文内容
		/*SecurityContext sc=SecurityContextHolder.getContext();
		Authentication atc=sc.getAuthentication();//获取认证对象
		//获取主体对象
		Object obj=atc.getPrincipal();
		
		if(obj instanceof UserDetails){
		//获取用户详细内容对象
		UserDetails ud=(UserDetails)obj;
		userName=ud.getUsername();
		}else{
		userName=obj.toString();
		}*/
		//api 原代码
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			userName = ((UserDetails)principal).getUsername();
		} else {
			userName = principal.toString();
		}
		System.out.println("u: "+userName);
	}
/************************hello***********************************/
	public String hello() throws Exception {
		System.out.println("开始调用方法....");
		String moedth=services.sayHello("刘备");
		System.out.println(moedth);
		return "indexs";
	}	
/************************bye***********************************/
	public String bye() throws Exception {
		
		System.out.println("开始调用方法..");
		
		String moedth=services.sayBye("张飞");
		System.out.println(moedth);
		return "indexs";
	}

/************************ajax判断是否有用户名**********************************/
    public String ajaxIsUser() throws Exception {
	//System.out.println("ajax来了！开始行动...........: "+user.getUsername());
	boolean b=services.getAjaxIsUserName(user.getUsername());
	//获取响应对象
	HttpServletResponse response=ServletActionContext.getResponse();
	PrintWriter out = response.getWriter();
	String bb="";
	if(b)bb="true";else bb="false";
	System.out.println("b: "+bb);
	out.print(bb);
	
	return null;
    }
/************************显示所有用户信息**********************************/
    public String showUserInfo() throws Exception {
    	listUser=baseUserServices.getAll(new User());
		return "showUser";
	}
    
/**************************删除用户****************************************/
    public String deleteUser() throws Exception {
    	try {
    	System.out.println("du: id "+user.getId());
    	baseUserServices.delete(user);
		} catch (Exception e) {
		e.printStackTrace();
		return "error";
		}
		return "deleteUserOK";
	}
/**************************修改用户 查询信息 并显示************************************/
    public String  updateUser() throws Exception {
    	try {
    	user=baseUserServices.getTInId(user,user.getId());
    	//查询角色
    	roleList=baseRoleServices.getAll(new Role());
    	
        
		} catch (Exception e) {
			return "error";
		}
		return "updateEidt";
	}
    
    
/**************************保存修改后的用户************************************/
    public String  updateSave() throws Exception {
    	try {
		Md5PasswordEncoder md5 = new Md5PasswordEncoder();
		String passwordMD5=md5.encodePassword(user.getPassword(), user.getUsername());
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
    	user.setRoles(rolesSet);//将角色加入用户对象里
		//是否生效
		if(null==enabled){
			user.setStatus(0);
		}else{
			user.setStatus(1);
		}
		//System.out.println(user.getId()+user.getUsername()+user.getPassword());
	   	//通过传过来的角色id获取角色对象
		baseUserServices.update(user);
		} catch (Exception e) {
			return "error";
		}
		return "updateOk";
	}
/*********************通对对象条件查询****************************/
    public String  searchUser() throws Exception {
    	if(null!=user){
    	listUser=baseUserServices.getTInName(user);
    	}
    	return "showUser";
    }
    
 /*************************显示所有角色*************************/
    public String displayRole() throws Exception {
    	System.out.println("开始查询role----");
    	roleList=baseRoleServices.getAll(new Role());
    	//查询部门
        departmentList=baseDepartmentServices.getAll(new Department());
    	//查询职位
        positionList=basePositionServices.getAll(new Position());
    	return "addUsersAndShowRole";
    	}

/**************************ajax 更改密码************************************/
    private String passNew;
    private String passOld;
    public void setPassNew(String passNew) {
	this.passNew = passNew;
    }

	public void setPassOld(String passOld) {
		this.passOld = passOld;
	}

	public String  updatePasswordAjax() throws Exception {
		 //ajax
	     HttpServletResponse response=ServletActionContext.getResponse();
	     response.setHeader("Cache-control","no-cache");//去除缓存
	     response.setContentType("text/html;charset=utf-8");
	     PrintWriter out=response.getWriter();
		
		String message="没有执行操作!";
		Md5PasswordEncoder md5 = new Md5PasswordEncoder();String passwordMD5=md5.encodePassword(passNew,this.user.getUsername());	
		String passwordOldMD5=md5.encodePassword(passOld,this.user.getUsername());	
		//应该写在验证框架里xml 这里暂省略.......
		if(passNew.length()<6||passNew.length()>12){message="密码长度为6-12";}
		//比较旧密码
		else if(!passwordOldMD5.equals(this.getUser().getPassword())){
			message="输入的旧密码不正确!";
		}else{
		//修改
		String passwordNewMD5=md5.encodePassword(passNew,this.user.getUsername());	
		boolean b=services.updatePassword(this.getUser().getId(),this.user.getPassword(), passwordNewMD5);
    	if(b){message="更改口令成功!";}else{message="更改口令失败!";}
		}
     out.print(message);
	 return null;
    }
    
    
}
