package accp.action;

import java.util.List;
import accp.bean.Resc;
import accp.bean.Role;
import accp.services.BaseServices;
import accp.services.RescServices;


import com.opensymphony.xwork2.ActionSupport;

/**
 * ��Դ����Action
 * @author liangrui
 * @qq382453602
 *
 */

public class RescAction extends ActionSupport {

	private Resc resc;
	private List<Resc> rescList;//��Դ����
	private List<Role> roleList;//��ɫ����
	private RescServices rescServices;//��Դ�ӿ�
	private BaseServices<Resc,Long> baseRescServices;//����rescҵ��
	private BaseServices<Role,Long> baseRoleServices;//����roleҵ��
	private String message;
	
	
	
	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public Resc getResc() {
		return resc;
	}


	public void setResc(Resc resc) {
		this.resc = resc;
	}

	public List<Resc> getRescList() {
		return rescList;
	}


	public void setRescList(List<Resc> rescList) {
		this.rescList = rescList;
	}


	public List<Role> getRoleList() {
		return roleList;
	}


	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}


	public RescServices getRescServices() {
		return rescServices;
	}
	
    public void setRescServices(RescServices rescServices) {
		this.rescServices = rescServices;
	}


	public BaseServices<Resc, Long> getBaseRescServices() {
		return baseRescServices;
	}

	public void setBaseRescServices(BaseServices<Resc, Long> baseRescServices) {
		this.baseRescServices = baseRescServices;
	}

	public BaseServices<Role, Long> getBaseRoleServices() {
		return baseRoleServices;
	}


	public void setBaseRoleServices(BaseServices<Role, Long> baseRoleServices) {
		this.baseRoleServices = baseRoleServices;
	}

	/*******************��ʾ������Դ�б�****************************/
	public String displayResc() throws Exception {
		rescList=baseRescServices.getAll(new Resc());
		return "displayAll";
	}
	

	/*******************������Դ********************************/
	public String addResc() throws Exception {
		Long rescID=baseRescServices.save(resc);
		if(null==rescID||rescID<=0){
		return "error";
		}
		this.message="������Դ"+resc.getName()+"�ɹ�!";
		return "saveOK";
	}
	
	/*******************������Դ********************************/
	public String deleteResc() throws Exception {
		
		try {
		baseRescServices.delete(resc);
		} catch (Exception e) {
		return "error";
		}
		this.message="��ɾ��Դ"+resc.getName()+"�ɹ�!";
		return "deleteOK";
	}
	
	/*******************��ת���޸���Դҳ��*************************/
	public String updateRescPage() throws Exception {
		//ͨ��id��ѯ������
		resc=baseRescServices.getTInId(new Resc(),resc.getId());
		return "updatePage";
	}
	
	/*******************�޸���Դ********************************/
	public String updateRescSave() throws Exception {
		try {
		baseRescServices.update(resc);
		} catch (Exception e) {
		return "error";
		}
		this.message="�޸���Դ"+resc.getName()+"�ɹ�!";
		return "updateOK";
	}
	
	
}
