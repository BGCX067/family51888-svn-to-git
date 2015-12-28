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
	//得到类
	public BaseDaoImpl(){
		/**
		 *  得到泛型的类
		 *  即  BaseDaoImpl<Users>  得到Users 
		 *  类的超类>>>现在类型的 论据
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
		// 根据对象 得到对像集合
		String objName=t.getClass().getSimpleName();//得到 对象名
		//System.out.println(objName);
		return this.getHibernateTemplate().find("from "+objName);
	}

    /********************通过id获取对象****************************/
	public T getTInId(T t,PK pk) {
	    /*String objName=clas.getClass().getSimpleName();//得到 对象名
		System.out.println(clas +" : "+objName +" PK: "+pk);*/
		return (T) this.getHibernateTemplate().get(t.getClass(),pk);
			
	}
	
    /************************************************************
     *通过传送过来的对象值做为条件   查询 
     *并得到反回的集合 
     ************************************************************/
	@SuppressWarnings("unchecked")
	public List<T> getTInName(T t) throws Exception {
	//得到对象的字段 就是查询条件
	String objName=t.getClass().getSimpleName();
	//拼接条件
	StringBuffer hql=new StringBuffer("from "+objName);
	
	hql.append(" where 1=1");
	Field [] objFileds =t.getClass().getDeclaredFields();
	
	Object [] SqlParamter = null;
	List<Object> SqlParamters=new ArrayList<Object>();
	for(int i=0;i<objFileds.length;i++){
		Field fileld=objFileds[i];
		fileld.setAccessible(true);//可进入的
		Object objT=fileld.get(t);
	
		//得到值
		if(!"".equals(objT)&&null!=objT){
			
			if(fileld.getName().equals("id")){
			if(Integer.parseInt(objT.toString())>0){//不为0
			//如果是id则 则直接处理
			return	this.getHibernateTemplate().
					find("from "+objName +" where id="+objT);
			}
			}else if(objT instanceof Set){//如果是集合
			//可以断续追加对象 条件
			}else if(objT instanceof Boolean){//boolean user ????
				//可以断续追加对象 条件 
				}
			else{
			System.out.println(fileld.getName()+" value: "+objT);
			hql.append(" and "+fileld.getName()+"=?");
			SqlParamters.add(objT);
			
			//SqlParamter[i]=objT;
			}
		}
	}
	//如果没有任条件的对象 ，则返回所有数据
	if(null==SqlParamters||SqlParamters.size()<=0){
	return this.getHibernateTemplate().find("from "+objName);
	}
	//把集合中的数据 转入数组
	SqlParamter=new Object[SqlParamters.size()];
	for(int i=0;i<SqlParamters.size();i++){
		SqlParamter[i]=SqlParamters.get(i);
	}
	//excute
	System.err.println(hql.toString());
	return this.getHibernateTemplate().find(hql.toString(),SqlParamter);
	}

/**=====================================根据Map条件 获取对象集合======================**/
    @SuppressWarnings("unchecked")
	public List<T> getTInObjectArray(T t,Map<String,Object> paramenters) throws Exception {
		//获取查询的类名称
		String objName=t.getClass().getSimpleName();
		StringBuffer hql=new StringBuffer("from "+objName+" where 1=1 ");
		Object[] paraObj =new Object[paramenters.size()];//条件值数组
		//追加条件
		if(paramenters!=null&&paramenters.size()>0){
			int i=0;
			for(Entry<String, Object> entry:paramenters.entrySet()){
				hql.append(entry.getKey());//条件语句    +"=? "
				paraObj[i]=entry.getValue();//得到条件值
				i++;
			}
		}
		System.out.println("hql: "+hql.toString());
		//start find
		 List<T> list=this.getHibernateTemplate().find(hql.toString(),paraObj);
		
		// System.out.println(list.size());
		 return list;
	}
/**======================根据Map条件 获取对象集合 分页显示======================**/	
	@SuppressWarnings("unchecked")
	public PageBean<T> getTInObjectArrayPage(T t,Map<String,Object> paramenters,PageBean<T> pageBean) throws Exception {
		//获取查询的类名称
		String objName=t.getClass().getSimpleName();
		StringBuffer hql=new StringBuffer("from "+objName+" where 1=1 ");
		Object[] paraObj =new Object[paramenters.size()];//条件值数组
		//追加条件
		if(paramenters!=null&&paramenters.size()>0){
			int i=0;
			for(Entry<String, Object> entry:paramenters.entrySet()){
				hql.append(entry.getKey());//条件语句    +"=? "
				paraObj[i]=entry.getValue();//得到条件值
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
		pageBean.setTotalCount(scrollableResults.getRowNumber()+1);//得到总记录数
		}else{
			pageBean.setTotalCount(0);
		}*/
		
		//设条件值
		for(int i=0;i<paraObj.length;i++){
			query.setParameter(i, paraObj[i]);
		}
		//获得总行数
		pageBean.setTotalCount(query.list().size());//得到总记录数
		//分页
		int startRom=(pageBean.getCurrentPage()-1)*pageBean.getPageSize();
		query.setFirstResult(startRom);//开始行
		query.setMaxResults(pageBean.getPageSize());//页大小
		
		//开始查询
		 pageBean.setBeanList(query.list());//获得分页后的集合数据
		 System.out.println("sizze : "+query.list().size());
		 return pageBean;
	}

}
