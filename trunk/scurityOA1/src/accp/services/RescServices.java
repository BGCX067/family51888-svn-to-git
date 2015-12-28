package accp.services;

import accp.bean.Role;

public interface RescServices    {
	
	//根据资源id 查询出所有角色
	public Role getRoleByRescid(Long rescId);

}
