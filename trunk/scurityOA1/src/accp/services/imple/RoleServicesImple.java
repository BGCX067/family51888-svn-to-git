package accp.services.imple;


import accp.bean.Role;

import accp.dao.RoleDao;
import accp.dao.imple.BaseDaoImpl;


import accp.services.RoleServices;
//extends BaseDaoImpl<User,Integer>
public class RoleServicesImple   implements RoleServices  {
   
	private RoleDao roleDao;//角色数据层接口 spring注入实体

	public RoleDao getRoleDao() {
		return roleDao;
	}

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}
   

}
