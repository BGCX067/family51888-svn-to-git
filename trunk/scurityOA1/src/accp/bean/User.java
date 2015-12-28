package accp.bean;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;


import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;




/**
 * User entity. @author MyEclipse Persistence Tools
 */

public class User implements UserDetails , java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private long id;
	//private String username;//登陆名 账号
	private String name;//姓名
	private Position position_id;//员工职位
	private Department department_id; //所在部门
	//private String password;//密码
	private Integer status;//状态
	private String descn;//描术
	/**一个用户对应多个角色**/
	private Set roles = new HashSet(0);//角色集合
	

/*	private Set bizClaimVouchersForNextDealSn = new HashSet(0);
    private Set sysDepartments = new HashSet(0);
    private Set bizClaimVouchersForCreateSn = new HashSet(0);
    private Set bizCheckResults = new HashSet(0);*/


	// Constructors

	/** default constructor */
	public User() {
	}

	/** full constructor */
	public User(String username, String name, Position position_id,
			Department department_id, String password, Integer status,
			String descn, Set roles) {
		this.username = username;
		this.name = name;
		this.position_id = position_id;
		this.department_id = department_id;
		this.password = password;
		this.status = status;
		this.descn = descn;
		this.roles = roles;
	}
	
	
	
	//
	public User(long id, Position position_id, Department department_id) {
		super();
		this.id = id;
		this.position_id = position_id;
		this.department_id = department_id;
	}

	// Property accessors
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	/*public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}*/

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Position getPosition_id() {
		return position_id;
	}

	public void setPosition_id(Position position_id) {
		this.position_id = position_id;
	}

	public Department getDepartment_id() {
		return department_id;
	}

	public void setDepartment_id(Department department_id) {
		this.department_id = department_id;
	}
	
	

	// ===========以下属性为安全架构属性===========

	private String username; // 账号
	private String password; // 密码
	private boolean accountNonExpired = true; // 账号是否过期
	private boolean accountNonLocked = true; // 账号是否锁定
	private boolean credentialsNonExpired = true; // 
	private boolean enabled = true; // 是否可用
	private Collection<? extends GrantedAuthority> authorities; // 权限集合

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

	public boolean isAccountNonExpired() {
		return accountNonExpired;
	}

	public void setAccountNonExpired(boolean accountNonExpired) {
		this.accountNonExpired = accountNonExpired;
	}

	public boolean isAccountNonLocked() {
		return accountNonLocked;
	}

	public void setAccountNonLocked(boolean accountNonLocked) {
		this.accountNonLocked = accountNonLocked;
	}

	public boolean isCredentialsNonExpired() {
		return credentialsNonExpired;
	}

	public void setCredentialsNonExpired(boolean credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		enabled=this.status==1?true:false;
		this.enabled = enabled;
	}

	public void setAuthorities(
			Collection<? extends GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	// 获取当前登录用户详细信息必须重写hashCode和equals方法
	public int hashCode() {
		return this.getUsername().hashCode();
	}

	public boolean equals(Object object) {
		boolean flag = false;
		if (object instanceof UserDetails) {
			UserDetails user = (UserDetails) object;
			if (user.getUsername().equals(this.getUsername()))
				flag = true;
		}
		return flag;
	}

}