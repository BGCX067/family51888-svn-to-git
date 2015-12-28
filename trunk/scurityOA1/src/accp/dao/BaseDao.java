package accp.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.oa.util.PageBean;

/**
 * 
 * @author liangrui
 * @qq 382453602
 * @param <T> 泛型类
 * @param <PK> 主健 
 * 基本数据操作 代业务层 数据层 什么层层的 
 * 都 可以来这时调用 增、删、改、查
 */
public interface BaseDao<T,PK extends Serializable> {
	
public PK save(T t);
public void delete(T t);
public void update(T t);
/***根据对象 获取对象集合**/
public List<T> getAll(T t);
/***通过id 获取对象集合**/
public T getTInId(T t,PK pk);
/***根据对象条件 获取对象集合**/
public List<T> getTInName(T t) throws Exception;

/***根据数条件 获取对象集合**/
public List<T> getTInObjectArray(T t,Map<String,Object> paramenters) throws Exception;


/***根据数条件 获取对象集合 分页显示**/
public PageBean getTInObjectArrayPage(T t,Map<String,Object> paramenters,PageBean<T> pageBean) throws Exception;

}
