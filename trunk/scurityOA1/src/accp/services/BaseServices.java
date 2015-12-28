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
 * @param <T> ������
 * @param <PK> ���� 
 * �������ݲ��� ҵ��� 
 * �� ��������ʱ���� ����ɾ���ġ���
 */

public interface BaseServices<T,PK extends Serializable > /* extends BaseDao<T,PK>*/{
	
	
public PK save(T t);
public void delete(T t);
public void update(T t);
/***���ݶ��� ��ȡ���󼯺�**/
public List<T> getAll(T t);
/***ͨ��id ��ȡ���󼯺�**/
public T getTInId(T t,PK pk);
/***�������� ��ȡ���󼯺�**/
public List<T> getTInName(T t) throws Exception;
/***����map�������� ��ȡ���󼯺�**/
public List<T> getTInObjectArray(T t,Map<String,Object> paramenters) throws Exception;

/***���������� ��ȡ���󼯺� ��ҳ��ʾ**/
public PageBean<T> getTInObjectArrayPage(T t,Map<String,Object> paramenters,PageBean<T> pageBean) throws Exception;


}
