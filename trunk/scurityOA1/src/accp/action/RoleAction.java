package accp.action;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import accp.bean.Resc;
import accp.bean.Role;
import accp.services.BaseServices;
import accp.services.RoleServices;

import com.opensymphony.xwork2.ActionSupport;
/**
 * 角色管理Action
 * @author liangrui
 * @qq382453602
 *
 */
public class RoleAction extends ActionSupport {
	
	private Role role;//角色对象
	private List<Role> roleList;//角色集合
	private List<Resc> rescList;//资源集合
	private RoleServices roleServices; //业务接口
	private BaseServices<Role,Long> baseRoleServices;//基本role业务
	private BaseServices<Resc,Long> baseRescServices;//基本resc业务
	private String message;//提示信息
	
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<Resc> getRescList() {
		return rescList;
	}

	public void setRescList(List<Resc> rescList) {
		this.rescList = rescList;
	}

	public void setBaseRescServices(BaseServices<Resc, Long> baseRescServices) {
		this.baseRescServices = baseRescServices;
	}

	public void setBaseRoleServices(BaseServices<Role, Long> baseRoleServices) {
		this.baseRoleServices = baseRoleServices;
	}

	public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public RoleServices getRoleServices() {
		return roleServices;
	}

	public void setRoleServices(RoleServices roleServices) {
		this.roleServices = roleServices;
	}

	/**************************************************************
	 **********************  显示所有角色    ***************************
	 **************************************************************/
	public String displayRole() throws Exception {
	System.out.println("开始查询role----");
	roleList=baseRoleServices.getAll(new Role());
	return "showRole";
	}
	
	/**************************************************************
	 *********************转到添加角色的页面***************************
	 **************************************************************/
	public String addRolePage() throws Exception {
	//得到所有资源例表
	rescList=baseRescServices.getAll(new Resc());
	return "addRolePage";
	}
	
	/**************************************************************
	 *********************    添 * 加 * 角 * 色     **********************
	 **************************************************************/
	public String addRoleSave() throws Exception {
	//通过资源id查询出对象 ，如果能把对象传过来就好了！我测试 了下，没能成功，
	//strtus2标签应该有这个功能,不喜欢用struts2标签，报个错找死个人
	Set<Resc> setResc=new HashSet<Resc>();
	//System.out.println(role.getRescs().size());
	Set set=role.getRescs();
	Iterator it=set.iterator();
	while(it.hasNext()){
		Resc resc=baseRescServices.getTInId(new Resc(),Long.valueOf(it.next().toString()));
		setResc.add(resc);
	
	}
	role.setRescs(setResc);//加入拥有的资源
	
	//判断是否加有ROLE_
	String roleName=role.getName();
	if(roleName.length()<=5||!roleName.substring(0,5).equals("ROLE_")){
		role.setName("ROLE_"+roleName);
	}
	//save
	Long count=baseRoleServices.save(role);
	if(count!=null&&count>0){
	message="添加角色"+role.getName()+"成功";
	return "roleSaveOk";
	}else{
	return "error";
	}
	}
	
	/**************************************************************
	 *********************   删 * 除 * 角 * 色        **********************
	 **************************************************************/
	public String deleteRole() throws Exception {
		try {
		baseRoleServices.delete(role);
		} catch (Exception e) {
			return "error";
		}
		message="删除角色"+role.getName()+"成功";
		return "deleteOk";
	}
	/**************************************************************
	 ********************* 转 *到 *修 *改 *角 *色     **********************
	 **************************************************************/
	public String updateRolePage() throws Exception {
	//根据id查询role对象信息
	System.out.println(role.getId());
	role=baseRoleServices.getTInId(new Role(),role.getId());
		
	//查询所有资源
	rescList=baseRescServices.getAll(new Resc());
	return "updatePage";
	}
	
	
	/**************************************************************
	 *********************   修 * 改 * 角 * 色        **********************
	 **************************************************************/
	public String updateRole() throws Exception {
		Set<Resc> setResc=new HashSet<Resc>();
		//System.out.println(role.getRescs().size());
		Set set=role.getRescs();
		Iterator it=set.iterator();
		while(it.hasNext()){
			Resc resc=baseRescServices.getTInId(new Resc(),Long.valueOf(it.next().toString()));
			//System.out.println(resc.getDescn());
			setResc.add(resc);
		
		}
		role.setRescs(setResc);//加入拥有的资源
		
		//判断是否加有ROLE_
		String roleName=role.getName();
		if(roleName.length()<=5||!roleName.substring(0,5).equals("ROLE_")){
			role.setName("ROLE_"+roleName);
		}
		
		try {
		baseRoleServices.update(role);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		message="修改角色"+role.getName()+"成功";
		return "updateOk";
	}
}
