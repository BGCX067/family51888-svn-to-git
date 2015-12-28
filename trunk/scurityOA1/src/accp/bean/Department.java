package accp.bean;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
/**
 * ������
 * @author liangrui
 *
 */
public class Department implements Serializable {
	private Long id;
	private String manager_sn;//����_���
	private String name;//����
	//private Set user=new HashSet();//һ�Զ� ���ص㣬�ݲ���
	
	
	public Department(){}
	
	public Department(Long id, String manager_sn, String name) {
		super();
		this.id = id;
		this.manager_sn = manager_sn;
		this.name = name;
	}
	//
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getManager_sn() {
		return manager_sn;
	}
	public void setManager_sn(String manager_sn) {
		this.manager_sn = manager_sn;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	
}
