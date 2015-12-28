package accp.dao.imple;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import accp.util.GenericsUtils;

import org.hibernate.Query;
import org.hibernate.ScrollableResults;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.oa.bean.ClaimVoucher;
import com.oa.bean.ClaimVoucherDetail;
import com.oa.util.PageBean;

import accp.dao.BaseDao;


public class BaseDaoImpl<T,PK extends Serializable> extends HibernateDaoSupport implements BaseDao<T, PK> {

	private  Class clas ;
	//�õ���
	public BaseDaoImpl(){
		/**
		 *  �õ����͵���
		 *  ��  BaseDaoImpl<Users>  �õ�Users 
		 *  ��ĳ���>>>�������͵� �۾�
		 */
		clas = GenericsUtils.getSuperClassGenricType(getClass());
		
	}
	
	
	public PK save(T t) {
		//System.out.println("T:" +t.getClass().getSimpleName());
		//System.out.println(((ClaimVoucher)t).getBizclaimVoucherDatails().size());
		return (PK) this.getHibernateTemplate().save(t);
		
	}

	public void delete(T t) {
		this.getHibernateTemplate().delete(t);
	}

	public void update(T t) {
		this.getHibernateTemplate().update(t);
	
	}

	public List<T> getAll(T t) {
		// ���ݶ��� �õ����񼯺�
		String objName=t.getClass().getSimpleName();//�õ� ������
		//System.out.println(objName);
		return this.getHibernateTemplate().find("from "+objName);
	}

    /********************ͨ��id��ȡ����****************************/
	public T getTInId(T t,PK pk) {
	    /*String objName=clas.getClass().getSimpleName();//�õ� ������
		System.out.println(clas +" : "+objName +" PK: "+pk);*/
		return (T) this.getHibernateTemplate().get(t.getClass(),pk);
			
	}
	
    /************************************************************
     *ͨ�����͹����Ķ���ֵ��Ϊ����   ��ѯ 
     *���õ����صļ��� 
     ************************************************************/
	@SuppressWarnings("unchecked")
	public List<T> getTInName(T t) throws Exception {
	//�õ�������ֶ� ���ǲ�ѯ����
	String objName=t.getClass().getSimpleName();
	//ƴ������
	StringBuffer hql=new StringBuffer("from "+objName);
	
	hql.append(" where 1=1");
	Field [] objFileds =t.getClass().getDeclaredFields();
	
	Object [] SqlParamter = null;
	List<Object> SqlParamters=new ArrayList<Object>();
	for(int i=0;i<objFileds.length;i++){
		Field fileld=objFileds[i];
		fileld.setAccessible(true);//�ɽ����
		Object objT=fileld.get(t);
	
		//�õ�ֵ
		if(!"".equals(objT)&&null!=objT){
			
			if(fileld.getName().equals("id")){
			if(Integer.parseInt(objT.toString())>0){//��Ϊ0
			//�����id�� ��ֱ�Ӵ���
			return	this.getHibernateTemplate().
					find("from "+objName +" where id="+objT);
			}
			}else if(objT instanceof Set){//����Ǽ���
			//���Զ���׷�Ӷ��� ����
			}else if(objT instanceof Boolean){//boolean user ????
				//���Զ���׷�Ӷ��� ���� 
				}
			else{
			System.out.println(fileld.getName()+" value: "+objT);
			hql.append(" and "+fileld.getName()+"=?");
			SqlParamters.add(objT);
			
			//SqlParamter[i]=objT;
			}
		}
	}
	//���û���������Ķ��� ���򷵻���������
	if(null==SqlParamters||SqlParamters.size()<=0){
	return this.getHibernateTemplate().find("from "+objName);
	}
	//�Ѽ����е����� ת������
	SqlParamter=new Object[SqlParamters.size()];
	for(int i=0;i<SqlParamters.size();i++){
		SqlParamter[i]=SqlParamters.get(i);
	}
	//excute
	System.err.println(hql.toString());
	return this.getHibernateTemplate().find(hql.toString(),SqlParamter);
	}

/**=====================================����Map���� ��ȡ���󼯺�======================**/
    @SuppressWarnings("unchecked")
	public List<T> getTInObjectArray(T t,Map<String,Object> paramenters) throws Exception {
		//��ȡ��ѯ��������
		String objName=t.getClass().getSimpleName();
		StringBuffer hql=new StringBuffer("from "+objName+" where 1=1 ");
		Object[] paraObj =new Object[paramenters.size()];//����ֵ����
		//׷������
		if(paramenters!=null&&paramenters.size()>0){
			int i=0;
			for(Entry<String, Object> entry:paramenters.entrySet()){
				hql.append(entry.getKey());//�������    +"=? "
				paraObj[i]=entry.getValue();//�õ�����ֵ
				i++;
			}
		}
		System.out.println("hql: "+hql.toString());
		//start find
		 List<T> list=this.getHibernateTemplate().find(hql.toString(),paraObj);
		
		// System.out.println(list.size());
		 return list;
	}
/**======================����Map���� ��ȡ���󼯺� ��ҳ��ʾ======================**/	
	@SuppressWarnings("unchecked")
	public PageBean<T> getTInObjectArrayPage(T t,Map<String,Object> paramenters,PageBean<T> pageBean) throws Exception {
		//��ȡ��ѯ��������
		String objName=t.getClass().getSimpleName();
		StringBuffer hql=new StringBuffer("from "+objName+" where 1=1 ");
		Object[] paraObj =new Object[paramenters.size()];//����ֵ����
		//׷������
		if(paramenters!=null&&paramenters.size()>0){
			int i=0;
			for(Entry<String, Object> entry:paramenters.entrySet()){
				hql.append(entry.getKey());//�������    +"=? "
				paraObj[i]=entry.getValue();//�õ�����ֵ
				i++;
			}
		}
		System.out.println("hql: "+hql.toString());
		//start find
		Session session=getSession(false);
		Query query=session.createQuery(hql.toString());
		
	/*	ScrollableResults scrollableResults =query.scroll();
		scrollableResults.last();
		if(scrollableResults.getRowNumber()>=0){
		pageBean.setTotalCount(scrollableResults.getRowNumber()+1);//�õ��ܼ�¼��
		}else{
			pageBean.setTotalCount(0);
		}*/
		
		//������ֵ
		for(int i=0;i<paraObj.length;i++){
			query.setParameter(i, paraObj[i]);
		}
		//���������
		pageBean.setTotalCount(query.list().size());//�õ��ܼ�¼��
		//��ҳ
		int startRom=(pageBean.getCurrentPage()-1)*pageBean.getPageSize();
		query.setFirstResult(startRom);//��ʼ��
		query.setMaxResults(pageBean.getPageSize());//ҳ��С
		
		//��ʼ��ѯ
		 pageBean.setBeanList(query.list());//��÷�ҳ��ļ�������
		 System.out.println("sizze : "+query.list().size());
		 return pageBean;
	}

}
