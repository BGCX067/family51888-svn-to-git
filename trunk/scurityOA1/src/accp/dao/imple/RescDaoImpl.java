package accp.dao.imple;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import accp.bean.Resc;
import accp.bean.Role;
import accp.dao.RescDao;
/**
 * 资源 操作实现现类
 * 特殊操作可在这里写
 * 基本的操作都在BaseDao中调用
 * @author liangrui
 * @QQ 382453602
 */
public class RescDaoImpl  extends BaseDaoImpl<Resc,Long> implements RescDao {

	//根据资源id 查询出所有角色
	public Role getRoleByRescid(Long rescId) {
		@SuppressWarnings("unchecked")
		List<Role> list=this.getHibernateTemplate().find("from Role where Role.resc.id=?",new Object[]{rescId});
		System.out.println("listSize: "+list.size());
		return list.get(0);
	}

}
