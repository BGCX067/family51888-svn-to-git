package accp.services.imple;


import accp.bean.Role;
import accp.dao.RescDao;
import accp.services.RescServices;


public class RescServicesImple implements RescServices {
    
	private RescDao rescDao;//��Դ���ݲ�ӿ� springע��ʵ��

	public RescDao getRescDao() {
		return rescDao;
	}
	
	public void setRescDao(RescDao rescDao) {
		this.rescDao = rescDao;
	}

	//������Դid ��ѯ�����н�ɫ
	public Role getRoleByRescid(Long rescId) {
		// TODO Auto-generated method stub
		return rescDao.getRoleByRescid(rescId);
	}
   
}
