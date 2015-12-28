package accp.bean;

import java.util.HashSet;
import java.util.Set;

/**
 * Resc entity. @author MyEclipse Persistence Tools
 */

public class Resc implements java.io.Serializable {

	// Fields

	private long id;
	private String name;
	private String resType;
	private String resString;
	private Integer priority;
	private String descn;
	private Set roles = new HashSet(0);

	// Constructors

	/** default constructor */
	public Resc() {
	}

	/** full constructor */
	public Resc(String name, String resType, String resString,
			Integer priority, String descn, Set roles) {
		this.name = name;
		this.resType = resType;
		this.resString = resString;
		this.priority = priority;
		this.descn = descn;
		this.roles = roles;
	}

	// Property accessors

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getResType() {
		return this.resType;
	}

	public void setResType(String resType) {
		this.resType = resType;
	}

	public String getResString() {
		return this.resString;
	}

	public void setResString(String resString) {
		this.resString = resString;
	}

	public Integer getPriority() {
		return this.priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public String getDescn() {
		return this.descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	public Set getRoles() {
		return this.roles;
	}

	public void setRoles(Set roles) {
		this.roles = roles;
	}

}