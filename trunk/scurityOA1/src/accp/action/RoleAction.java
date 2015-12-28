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
 * ��ɫ����Action
 * @author liangrui
 * @qq382453602
 *
 */
public class RoleAction extends ActionSupport {
	
	private Role role;//��ɫ����
	private List<Role> roleList;//��ɫ����
	private List<Resc> rescList;//��Դ����
	private RoleServices roleServices; //ҵ��ӿ�
	private BaseServices<Role,Long> baseRoleServices;//����roleҵ��
	private BaseServices<Resc,Long> baseRescServices;//����rescҵ��
	private String message;//��ʾ��Ϣ
	
	
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
	 **********************  ��ʾ���н�ɫ    ***************************
	 **************************************************************/
	public String displayRole() throws Exception {
	System.out.println("��ʼ��ѯrole----");
	roleList=baseRoleServices.getAll(new Role());
	return "showRole";
	}
	
	/**************************************************************
	 *********************ת����ӽ�ɫ��ҳ��***************************
	 **************************************************************/
	public String addRolePage() throws Exception {
	//�õ�������Դ����
	rescList=baseRescServices.getAll(new Resc());
	return "addRolePage";
	}
	
	/**************************************************************
	 *********************    �� * �� * �� * ɫ     **********************
	 **************************************************************/
	public String addRoleSave() throws Exception {
	//ͨ����Դid��ѯ������ ������ܰѶ��󴫹����ͺ��ˣ��Ҳ��� ���£�û�ܳɹ���
	//strtus2��ǩӦ�����������,��ϲ����struts2��ǩ����������������
	Set<Resc> setResc=new HashSet<Resc>();
	//System.out.println(role.getRescs().size());
	Set set=role.getRescs();
	Iterator it=set.iterator();
	while(it.hasNext()){
		Resc resc=baseRescServices.getTInId(new Resc(),Long.valueOf(it.next().toString()));
		setResc.add(resc);
	
	}
	role.setRescs(setResc);//����ӵ�е���Դ
	
	//�ж��Ƿ����ROLE_
	String roleName=role.getName();
	if(roleName.length()<=5||!roleName.substring(0,5).equals("ROLE_")){
		role.setName("ROLE_"+roleName);
	}
	//save
	Long count=baseRoleServices.save(role);
	if(count!=null&&count>0){
	message="��ӽ�ɫ"+role.getName()+"�ɹ�";
	return "roleSaveOk";
	}else{
	return "error";
	}
	}
	
	/**************************************************************
	 *********************   ɾ * �� * �� * ɫ        **********************
	 **************************************************************/
	public String deleteRole() throws Exception {
		try {
		baseRoleServices.delete(role);
		} catch (Exception e) {
			return "error";
		}
		message="ɾ����ɫ"+role.getName()+"�ɹ�";
		return "deleteOk";
	}
	/**************************************************************
	 ********************* ת *�� *�� *�� *�� *ɫ     **********************
	 **************************************************************/
	public String updateRolePage() throws Exception {
	//����id��ѯrole������Ϣ
	System.out.println(role.getId());
	role=baseRoleServices.getTInId(new Role(),role.getId());
		
	//��ѯ������Դ
	rescList=baseRescServices.getAll(new Resc());
	return "updatePage";
	}
	
	
	/**************************************************************
	 *********************   �� * �� * �� * ɫ        **********************
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
		role.setRescs(setResc);//����ӵ�е���Դ
		
		//�ж��Ƿ����ROLE_
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
		message="�޸Ľ�ɫ"+role.getName()+"�ɹ�";
		return "updateOk";
	}
}
