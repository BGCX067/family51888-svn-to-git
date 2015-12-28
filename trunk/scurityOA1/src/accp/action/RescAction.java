package accp.action;

import java.util.List;
import accp.bean.Resc;
import accp.bean.Role;
import accp.services.BaseServices;
import accp.services.RescServices;


import com.opensymphony.xwork2.ActionSupport;

/**
 * 资源管理Action
 * @author liangrui
 * @qq382453602
 *
 */

public class RescAction extends ActionSupport {

	private Resc resc;
	private List<Resc> rescList;//资源集合
	private List<Role> roleList;//角色集合
	private RescServices rescServices;//资源接口
	private BaseServices<Resc,Long> baseRescServices;//基本resc业务
	private BaseServices<Role,Long> baseRoleServices;//基本role业务
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

	/*******************显示所有资源列表****************************/
	public String displayResc() throws Exception {
		rescList=baseRescServices.getAll(new Resc());
		return "displayAll";
	}
	

	/*******************保存资源********************************/
	public String addResc() throws Exception {
		Long rescID=baseRescServices.save(resc);
		if(null==rescID||rescID<=0){
		return "error";
		}
		this.message="保存资源"+resc.getName()+"成功!";
		return "saveOK";
	}
	
	/*******************保存资源********************************/
	public String deleteResc() throws Exception {
		
		try {
		baseRescServices.delete(resc);
		} catch (Exception e) {
		return "error";
		}
		this.message="保删除源"+resc.getName()+"成功!";
		return "deleteOK";
	}
	
	/*******************跳转到修改资源页面*************************/
	public String updateRescPage() throws Exception {
		//通过id查询出对象
		resc=baseRescServices.getTInId(new Resc(),resc.getId());
		return "updatePage";
	}
	
	/*******************修改资源********************************/
	public String updateRescSave() throws Exception {
		try {
		baseRescServices.update(resc);
		} catch (Exception e) {
		return "error";
		}
		this.message="修改资源"+resc.getName()+"成功!";
		return "updateOK";
	}
	
	
}
