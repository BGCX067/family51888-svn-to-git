package accp.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.oa.util.PageBean;

/**
 * 
 * @author liangrui
 * @qq 382453602
 * @param <T> ������
 * @param <PK> ���� 
 * �������ݲ��� ��ҵ��� ���ݲ� ʲô���� 
 * �� ��������ʱ���� ����ɾ���ġ���
 */
public interface BaseDao<T,PK extends Serializable> {
	
public PK save(T t);
public void delete(T t);
public void update(T t);
/***���ݶ��� ��ȡ���󼯺�**/
public List<T> getAll(T t);
/***ͨ��id ��ȡ���󼯺�**/
public T getTInId(T t,PK pk);
/***���ݶ������� ��ȡ���󼯺�**/
public List<T> getTInName(T t) throws Exception;

/***���������� ��ȡ���󼯺�**/
public List<T> getTInObjectArray(T t,Map<String,Object> paramenters) throws Exception;


/***���������� ��ȡ���󼯺� ��ҳ��ʾ**/
public PageBean getTInObjectArrayPage(T t,Map<String,Object> paramenters,PageBean<T> pageBean) throws Exception;

}
