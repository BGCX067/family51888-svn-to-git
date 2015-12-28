package accp.services.imple;


import accp.bean.Role;
import accp.dao.RescDao;
import accp.services.RescServices;


public class RescServicesImple implements RescServices {
    
	private RescDao rescDao;//次源数据层接口 spring注入实体

	public RescDao getRescDao() {
		return rescDao;
	}
	
	public void setRescDao(RescDao rescDao) {
		this.rescDao = rescDao;
	}

	//根据资源id 查询出所有角色
	public Role getRoleByRescid(Long rescId) {
		// TODO Auto-generated method stub
		return rescDao.getRoleByRescid(rescId);
	}
   
}
