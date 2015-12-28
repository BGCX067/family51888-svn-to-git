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
 * 基本业务操作实现类
 * 
 * 需做一些业务相关的操作
 * 
 * 判断是否有关系，如果有则不能删除
 * 
 * 修改 也要判断
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

	/***根据数条件 获取对象集合 分页显示**/
	@SuppressWarnings("unchecked")
	public PageBean<T> getTInObjectArrayPage(T t, Map<String, Object> paramenters,
			PageBean<T> pageBean) throws Exception {
		return basedao.getTInObjectArrayPage(t, paramenters, pageBean);
	}


}
