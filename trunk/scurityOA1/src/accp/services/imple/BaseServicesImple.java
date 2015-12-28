package accp.services.imple;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.oa.util.PageBean;

import accp.dao.BaseDao;
import accp.dao.imple.BaseDaoImpl;
import accp.services.BaseServices;
import accp.util.GenericsUtils;

/**
 * ����ҵ�����ʵ����
 * 
 * ����һЩҵ����صĲ���
 * 
 * �ж��Ƿ��й�ϵ�����������ɾ��
 * 
 * �޸� ҲҪ�ж�
 * 
 */
public class BaseServicesImple<T,PK extends Serializable> /*extends BaseDaoImpl<T,PK>*/ implements BaseServices<T, PK> {
  
	
	private BaseDao<T,PK> basedao;
	
	public BaseDao<T, PK> getBasedao() {
		return basedao;
	}

	public void setBasedao(BaseDao<T, PK> basedao) {
		this.basedao = basedao;
	}

	public PK save(T t) {
		return basedao.save(t);
	}

	public void delete(T t) {
		basedao.delete(t);
	}

	public void update(T t) {
		basedao.update(t);
	}

	public List<T> getAll(T t) {
		
		
		return basedao.getAll(t);
	}

	public T getTInId(T t, PK pk) 
	{
	//clas
	//System.out.println(t.getClass()+" : "+t.getClass().getSimpleName());
	return (T) basedao.getTInId(t,pk);
	}

	public List<T> getTInName(T t) throws Exception {
	return basedao.getTInName(t);
	}

	public List<T> getTInObjectArray(T t,Map<String,Object> paramenters) throws Exception {
		return basedao.getTInObjectArray(t, paramenters);
	}

	/***���������� ��ȡ���󼯺� ��ҳ��ʾ**/
	@SuppressWarnings("unchecked")
	public PageBean<T> getTInObjectArrayPage(T t, Map<String, Object> paramenters,
			PageBean<T> pageBean) throws Exception {
		return basedao.getTInObjectArrayPage(t, paramenters, pageBean);
	}


}
