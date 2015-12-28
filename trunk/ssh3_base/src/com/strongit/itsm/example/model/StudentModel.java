package com.strongit.itsm.example.model;

import com.strongit.framework.model.AbstractModel;

@SuppressWarnings("serial")
public class StudentModel extends AbstractModel{

	private int uuid;
	private int version;
	private String snum;
	private String sname;
	
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public String getSnum() {
		return snum;
	}
	public void setSnum(String snum) {
		this.snum = snum;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public int getUuid() {
		return uuid;
	}
	public void setUuid(int uuid) {
		this.uuid = uuid;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + uuid;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final StudentModel other = (StudentModel) obj;
		if (uuid != other.uuid)
			return false;
		return true;
	}
	
}
