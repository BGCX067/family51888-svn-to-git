package com.strongit.itsm.resource.model;

import com.strongit.framework.model.AbstractModel;

public class ResourceModel extends AbstractModel{
	
	private int id ;
	private String name;
	private String resType;
	private String resString;
	private String priority;
	private String descn;

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

	public String getResType() {
		return resType;
	}

	public void setResType(String resType) {
		this.resType = resType;
	}

	public String getResString() {
		return resString;
	}

	public void setResString(String resString) {
		this.resString = resString;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getDescn() {
		return descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	public int getVersion() {
		// TODO Auto-generated method stub
		return 0;
	}

	public void setUuid(int uuid) {
		// TODO Auto-generated method stub
		
	}

}
