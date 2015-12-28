package accp.services;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.oa.util.PageBean;

import accp.dao.BaseDao;
import accp.dao.imple.BaseDaoImpl;

/**
 * 
 * @author liangrui
 * @qq 382453602
 * @param <T> 泛型类
 * @param <PK> 主健 
 * 基本数据操作 业务层 
 * 都 可以来这时调用 增、删、改、查
 */

public interface BaseServices<T,PK extends Serializable > /* extends BaseDao<T,PK>*/{
	
	
public PK save(T t);
public void delete(T t);
public void update(T t);
/***根据对象 获取对象集合**/
public List<T> getAll(T t);
/***通过id 获取对象集合**/
public T getTInId(T t,PK pk);
/***根据名称 获取对象集合**/
public List<T> getTInName(T t) throws Exception;
/***根据map集合条件 获取对象集合**/
public List<T> getTInObjectArray(T t,Map<String,Object> paramenters) throws Exception;

/***根据数条件 获取对象集合 分页显示**/
public PageBean<T> getTInObjectArrayPage(T t,Map<String,Object> paramenters,PageBean<T> pageBean) throws Exception;


}
