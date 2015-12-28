package org.notepress.security.model;

/**
 * LpRoleFunction entity. @author MyEclipse Persistence Tools
 */

public class RoleFunction implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 2611072209029260429L;
	private String id;
	private String roleId;
	private String functionId;

	// Constructors

	/** default constructor */
	public RoleFunction() {
	}

	/** full constructor */
	public RoleFunction(String roleId, String functionId) {
		this.roleId = roleId;
		this.functionId = functionId;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRoleId() {
		return this.roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getFunctionId() {
		return this.functionId;
	}

	public void setFunctionId(String functionId) {
		this.functionId = functionId;
	}

}