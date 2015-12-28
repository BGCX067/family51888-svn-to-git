package org.notepress.security.model;

import org.notepress.util.hibernate.IModelIntercept;

/**
 * LpAccount entity. @author MyEclipse Persistence Tools
 */

public class Account implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 6384420252268520102L;
	private String id;
	private String accountName;
	private String accountAlias;
	private String email;
	private String password;
	private Integer accountStatus;
	private String createIp;
	private Long createTime;

	// Constructors

	/** default constructor */
	public Account() {
	}

	/** full constructor */
	public Account(String accountName, String password, Integer accountStatus,
			String createIp, Long createTime) {
		this.accountName = accountName;
		this.password = password;
		this.accountStatus = accountStatus;
		this.createIp = createIp;
		this.createTime = createTime;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAccountName() {
		return this.accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public Integer getAccountStatus() {
		return this.accountStatus;
	}

	public void setAccountStatus(Integer accountStatus) {
		this.accountStatus = accountStatus;
	}

	public String getCreateIp() {
		return this.createIp;
	}

	public void setCreateIp(String createIp) {
		this.createIp = createIp;
	}

	public Long getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return this.password;
	}

	public String getAccountAlias() {
		return accountAlias;
	}

	public void setAccountAlias(String accountAlias) {
		this.accountAlias = accountAlias;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}