package accp.dao.imple;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import accp.bean.Resc;
import accp.bean.Role;
import accp.dao.RescDao;
/**
 * ��Դ ����ʵ������
 * ���������������д
 * �����Ĳ�������BaseDao�е���
 * @author liangrui
 * @QQ 382453602
 */
public class RescDaoImpl  extends BaseDaoImpl<Resc,Long> implements RescDao {

	//������Դid ��ѯ�����н�ɫ
	public Role getRoleByRescid(Long rescId) {
		@SuppressWarnings("unchecked")
		List<Role> list=this.getHibernateTemplate().find("from Role where Role.resc.id=?",new Object[]{rescId});
		System.out.println("listSize: "+list.size());
		return list.get(0);
	}

}
