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
 * �û�����Action
 * @author liangrui
 * @qq382453602
 *
 */
public class UserAction extends ActionSupport implements Preparable{
	private User user;
	private List<User> listUser;//�û�����
	private List<Role> roleList;//��ɫ����
	private List<Department> departmentList; //���ż���
	private List<Position> positionList; //ְλ����
	private UserServices services;//�û��ӿ�
	private BaseServices<User,Long> baseUserServices;//����userҵ��
	private BaseServices<Role,Long> baseRoleServices;//����roleҵ��
	private BaseServices<Department,Long> baseDepartmentServices;//��������ҵ��
	private BaseServices<Position,Long> basePositionServices;//����ְλҵ��
		
	private String enabled;//�Ƿ���Ч
	
	
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
		//��ȡ��ǰ�û���Ϣ	
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
				    .getAuthentication()
				    .getPrincipal();
		//�û� 
		this.user=(User)userDetails;
		System.out.println("��ǰ�û���ȡ���: "+this.user.getUsername());
		
	}	
	

/************************���ӵ�admin.jspҳ��***********************************/
	public String fowaredAdmin() throws Exception {
		System.out.println("��ȡu p��-------....");
		printUserInfo();
		System.out.println("ת��admin.jsp����");
		return "adminPage";
	}
/************************��ӡ��Ϣ���û���***********************************/	
	public void printUserInfo(){
		System.out.println("��ȡprincipal ��");
		String userName="";
		//��ȡ��ȫ����������
		/*SecurityContext sc=SecurityContextHolder.getContext();
		Authentication atc=sc.getAuthentication();//��ȡ��֤����
		//��ȡ�������
		Object obj=atc.getPrincipal();
		
		if(obj instanceof UserDetails){
		//��ȡ�û���ϸ���ݶ���
		UserDetails ud=(UserDetails)obj;
		userName=ud.getUsername();
		}else{
		userName=obj.toString();
		}*/
		//api ԭ����
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
		System.out.println("��ʼ���÷���....");
		String moedth=services.sayHello("����");
		System.out.println(moedth);
		return "indexs";
	}	
/************************bye***********************************/
	public String bye() throws Exception {
		
		System.out.println("��ʼ���÷���..");
		
		String moedth=services.sayBye("�ŷ�");
		System.out.println(moedth);
		return "indexs";
	}

/************************ajax�ж��Ƿ����û���**********************************/
    public String ajaxIsUser() throws Exception {
	//System.out.println("ajax���ˣ���ʼ�ж�...........: "+user.getUsername());
	boolean b=services.getAjaxIsUserName(user.getUsername());
	//��ȡ��Ӧ����
	HttpServletResponse response=ServletActionContext.getResponse();
	PrintWriter out = response.getWriter();
	String bb="";
	if(b)bb="true";else bb="false";
	System.out.println("b: "+bb);
	out.print(bb);
	
	return null;
    }
/************************��ʾ�����û���Ϣ**********************************/
    public String showUserInfo() throws Exception {
    	listUser=baseUserServices.getAll(new User());
		return "showUser";
	}
    
/**************************ɾ���û�****************************************/
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
/**************************�޸��û� ��ѯ��Ϣ ����ʾ************************************/
    public String  updateUser() throws Exception {
    	try {
    	user=baseUserServices.getTInId(user,user.getId());
    	//��ѯ��ɫ
    	roleList=baseRoleServices.getAll(new Role());
    	
        
		} catch (Exception e) {
			return "error";
		}
		return "updateEidt";
	}
    
    
/**************************�����޸ĺ���û�************************************/
    public String  updateSave() throws Exception {
    	try {
		Md5PasswordEncoder md5 = new Md5PasswordEncoder();
		String passwordMD5=md5.encodePassword(user.getPassword(), user.getUsername());
	    user.setPassword(passwordMD5);
	    //��װ��ɫ����
	    Set<Role> rolesSet=new HashSet<Role>();
	    //ȡ��Ȩ�޵Ķ���
	    Set set=user.getRoles();
	    Iterator it=set.iterator();
		while(it.hasNext()){
			//����id��ѯ����
			Long roleID=Long.valueOf(it.next().toString());
			//System.out.println(roleID);
			Role role=baseRoleServices.getTInId(new Role(),roleID);
			rolesSet.add(role);
		}
    	user.setRoles(rolesSet);//����ɫ�����û�������
		//�Ƿ���Ч
		if(null==enabled){
			user.setStatus(0);
		}else{
			user.setStatus(1);
		}
		//System.out.println(user.getId()+user.getUsername()+user.getPassword());
	   	//ͨ���������Ľ�ɫid��ȡ��ɫ����
		baseUserServices.update(user);
		} catch (Exception e) {
			return "error";
		}
		return "updateOk";
	}
/*********************ͨ�Զ���������ѯ****************************/
    public String  searchUser() throws Exception {
    	if(null!=user){
    	listUser=baseUserServices.getTInName(user);
    	}
    	return "showUser";
    }
    
 /*************************��ʾ���н�ɫ*************************/
    public String displayRole() throws Exception {
    	System.out.println("��ʼ��ѯrole----");
    	roleList=baseRoleServices.getAll(new Role());
    	//��ѯ����
        departmentList=baseDepartmentServices.getAll(new Department());
    	//��ѯְλ
        positionList=basePositionServices.getAll(new Position());
    	return "addUsersAndShowRole";
    	}

/**************************ajax ��������************************************/
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
	     response.setHeader("Cache-control","no-cache");//ȥ������
	     response.setContentType("text/html;charset=utf-8");
	     PrintWriter out=response.getWriter();
		
		String message="û��ִ�в���!";
		Md5PasswordEncoder md5 = new Md5PasswordEncoder();String passwordMD5=md5.encodePassword(passNew,this.user.getUsername());	
		String passwordOldMD5=md5.encodePassword(passOld,this.user.getUsername());	
		//Ӧ��д����֤�����xml ������ʡ��.......
		if(passNew.length()<6||passNew.length()>12){message="���볤��Ϊ6-12";}
		//�ȽϾ�����
		else if(!passwordOldMD5.equals(this.getUser().getPassword())){
			message="����ľ����벻��ȷ!";
		}else{
		//�޸�
		String passwordNewMD5=md5.encodePassword(passNew,this.user.getUsername());	
		boolean b=services.updatePassword(this.getUser().getId(),this.user.getPassword(), passwordNewMD5);
    	if(b){message="���Ŀ���ɹ�!";}else{message="���Ŀ���ʧ��!";}
		}
     out.print(message);
	 return null;
    }
    
    
}
