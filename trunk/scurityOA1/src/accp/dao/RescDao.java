package accp.dao;

import accp.bean.Resc;
import accp.bean.Role;

public interface RescDao extends BaseDao<Resc,Long>  {
	//������Դid ��ѯ�����н�ɫ
	public Role getRoleByRescid(Long rescId);

}
