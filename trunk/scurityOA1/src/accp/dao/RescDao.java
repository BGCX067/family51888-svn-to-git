package accp.dao;

import accp.bean.Resc;
import accp.bean.Role;

public interface RescDao extends BaseDao<Resc,Long>  {
	//根据资源id 查询出所有角色
	public Role getRoleByRescid(Long rescId);

}
