package accp.bean;

import java.util.HashSet;
import java.util.Set;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */

public class Role implements java.io.Serializable {

	// Fields

	private long id;
	private String name;
	private String descn;
	/**一个角色对应多个用户**/
	private Set users = new HashSet(0);//用户集合
	/**一个角色对应多个资源**/
	private Set rescs = new HashSet(0);//资源集合

	// Constructors

	/** default constructor */
	public Role() {
	}

	/** full constructor */
	public Role(String name, String descn, Set users, Set rescs) {
		this.name = name;
		this.descn = descn;
		this.users = users;
		this.rescs = rescs;
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

	public String getDescn() {
		return this.descn;
	}

	public void setDescn(String descn) {
		this.descn = descn;
	}

	public Set getUsers() {
		return this.users;
	}

	public void setUsers(Set users) {
		this.users = users;
	}

	public Set getRescs() {
		return this.rescs;
	}

	public void setRescs(Set rescs) {
		this.rescs = rescs;
	}

}