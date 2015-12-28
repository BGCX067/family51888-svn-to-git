package com.strongit.itsm.role.model;

import java.util.HashSet;
import java.util.Set;

import com.strongit.framework.model.AbstractModel;
import com.strongit.itsm.resource.model.ResourceModel;

public class RoleModel extends AbstractModel{
	
	private int id;
	
	private String name;
	
	private String descn;
	
	private Set<ResourceModel> resources = new HashSet();

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getVersion() {
		// TODO Auto-generated method stub
		return 0;
	}

	public void setUuid(int uuid) {
		// TODO Auto-generated method stub
		
	}

	public Set<ResourceModel> getResources() {
		return resources;
	}

	public void setResources(Set<ResourceModel> resources) {
		this.resources = resources;
	}

	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

}
