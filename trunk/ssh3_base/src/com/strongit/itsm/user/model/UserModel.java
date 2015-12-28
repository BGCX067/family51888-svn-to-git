package com.strongit.itsm.user.model;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.strongit.framework.model.AbstractModel;
import com.strongit.framework.util.ConvertUtils;
import com.strongit.itsm.role.model.RoleModel;

@SuppressWarnings("serial")
public class UserModel extends AbstractModel{

	private int id;
	private String username;
	private String  password;
	private int status;
	private String descn;
	
	private Set<RoleModel> roles = new HashSet();
	
	public int getVersion() {
		// TODO Auto-generated method stub
		return 0;
	}
	public void setUuid(int uuid) {
		// TODO Auto-generated method stub
		
	}
	public int getUuid() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDescn() {
		return descn;
	}
	public void setDescn(String descn) {
		this.descn = descn;
	}
	public Set<RoleModel> getRoles() {
		return roles;
	}
	public void setRoles(Set<RoleModel> roles) {
		this.roles = roles;
	}
	
	@SuppressWarnings("unchecked")
	public List<Long> getRoleIds() {
		return ConvertUtils.convertElementPropertyToList(roles, "id");
	}
	
	
}
