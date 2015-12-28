package org.notepress.security.model;

/**
 * LpAccountRole entity. @author MyEclipse Persistence Tools
 */

public class AccountRole implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 3650526709021532034L;
	private String id;
	private String accountId;
	private String roleId;

	// Constructors

	/** default constructor */
	public AccountRole() {
	}

	/** full constructor */
	public AccountRole(String accountId, String roleId) {
		this.accountId = accountId;
		this.roleId = roleId;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAccountId() {
		return this.accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public String getRoleId() {
		return this.roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

}