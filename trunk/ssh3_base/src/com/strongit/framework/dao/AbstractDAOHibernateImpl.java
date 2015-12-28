package com.strongit.framework.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.impl.CriteriaImpl;
import org.hibernate.transform.ResultTransformer;
import org.springframework.util.Assert;

import com.strongit.framework.exception.DAOException;
import com.strongit.framework.model.Model;
import com.strongit.framework.util.BeanUtils;
import com.strongit.framework.util.Page;
import com.strongit.framework.util.QueryParameter;

/**
 * 抽象DAO Hibernate实现<br>
 * 
 * 1、构造方法的参数必须传<br>
 * 2、两个抽象方法必须覆盖，注意他们两个的命名是有联系的<br>
 * public abstract String generateHQLWhere(QM uqm);<br>
 * public abstract void prepareQuery(Query query,QM uqm);<br>
 * 3、如果想要外键式的真实值/表现值的转换，需要覆盖4个方法(不是抽象的)<br>
 * protected String generateHQLSelect() {};<br>
 * protected String generateHQLFrom(){};<br>
 * protected String generateHQLJoinCondition() {};<br>
 * protected List<M> prepareResult(List<?> list){};<br>
 * 
 * @author lanjh
 * 
 * @param <M>
 * @param <QM>
 */
public abstract class AbstractDAOHibernateImpl<M extends Model, QM extends M>
		implements DAO<M, QM> {
	
	protected final Log logger = LogFactory.getLog(getClass());

	public SessionFactory sessionFactory = null;

	public Class<M> entityClass;
	public Class<QM> queryClass;
	private final String modelName;

	/**
	 * 通过子类的泛型定义取得对象类型Class. eg: public class UserDao extends SimpleHibernateDao<User,
	 * Long>
	 */
	@SuppressWarnings("unchecked")
	public AbstractDAOHibernateImpl(Class<M> entityClass, Class<QM> queryClass) {

		// 只能反射第一个类? 当需要反射2个类时就出现类型使用错误
		// this.entityClass =
		// ReflectionUtils.getSuperClassGenricType(getClass());
		// this.queryClass =
		// ReflectionUtils.getSuperClassGenricType(getClass());
		this.entityClass = entityClass;
		this.queryClass = queryClass;
		this.modelName = entityClass.getSimpleName();
	}

	public void setSessionFactory(final SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public final boolean create(M model) {

		try {
			getSession().save(model);
			getSession().flush();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} 
		return true;
	}

	public final boolean update(M model) {

		try {
			getSession().update(model);
			getSession().flush();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	public final boolean delete(int uuid, int version) {

		try {
			M model = (M) getSession().load(entityClass, uuid);
			if (model.getVersion() != version) {
				return false;
			}
			getSession().delete(model);
			getSession().flush();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} 
		return true;
	}
	
	public final boolean delete(M model) {
		
		getSession().delete(model);
		getSession().flush();
		return true;
	}

	@SuppressWarnings("unchecked")
	public final List<M> getAll(int firstRecord, int maxRecord) {

		try {

			final String hql = this.generateHQLSelect() + " From "
					+ this.modelName + " o " + this.generateHQLFrom()
					+ " where 1=1 " + this.generateHQLJoinCondition();
			Query query = getSession().createQuery(hql);
			query.setFirstResult(firstRecord);
			query.setMaxResults(maxRecord);
			List<M> list = query.list();
			return this.prepareResult(list);
		} catch (Exception e) {
			e.printStackTrace();
		}  
		return new ArrayList<M>();
	}

	@SuppressWarnings("unchecked")
	public final int getAllCount() {
		try {

			final String hql = "Select count(o) From " + this.modelName
					+ " o  ";
			Query query = getSession().createQuery(hql);
			List<Object> list = query.list();
			return ((Long) list.get(0)).intValue();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}  

	}

	/**
	 * 抽象方法让子类完成具体实现
	 * 
	 * @param uqm
	 * @return
	 */
	public abstract String generateHQLWhere(QM uqm);

	public abstract void prepareQuery(Query query, QM uqm);

	/**
	 * eg: Select o,s.sname From GradeModel o,StudentModel s Where 1=1 and
	 * o.snum = s.snum
	 * 
	 * @return
	 */
	protected String generateHQLSelect() {
		return "";
	}

	/**
	 * 注意，加逗号，不包括主表 eg: " StudentModel s "
	 * 
	 * @return
	 */
	protected String generateHQLFrom() {
		return "";
	}

	/**
	 * 注意，加and eg:" and o.snum = s.snum "
	 * 
	 * @return
	 */
	protected String generateHQLJoinCondition() {
		return "";
	}

	@SuppressWarnings("unchecked")
	protected List<M> prepareResult(List<?> list) {
		return (List<M>) list;
	}

	@SuppressWarnings("unchecked")
	public final List<M> getByCondition(QM uqm, int firstRecord, int maxRecord) {

		try {

			final String hql = this.generateHQLSelect() + "From "
					+ this.modelName + " o " + this.generateHQLFrom()
					+ " where 1=1 " + this.generateHQLJoinCondition()
					+ this.generateHQLWhere(uqm);
			Query query = getSession().createQuery(hql);
			this.prepareQuery(query, uqm);
			query.setFirstResult(firstRecord);
			query.setMaxResults(maxRecord);
			return this.prepareResult(query.list());
		} catch (Exception e) {
			e.printStackTrace();
		}  
		return new ArrayList<M>();
	}

	@SuppressWarnings("unchecked")
	public final int getByConditionCount(QM uqm) {
		try {

			final String hql = "select count(o) From " + this.modelName
					+ " o where 1=1 " + this.generateHQLWhere(uqm);
			Query query = getSession().createQuery(hql);
			this.prepareQuery(query, uqm);
			List<Object> list = query.list();
			return ((Long) list.get(0)).intValue();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}  
	}

	@SuppressWarnings("unchecked")
	public final M findUniqueByProperty(String propertyName, Object value) throws DAOException{

		Assert.hasText(propertyName);
		try {
			return (M) createCriteria(Restrictions.eq(propertyName, value))
					.uniqueResult();
		} catch (HibernateException e) {
			throw new DAOException(e);
		}
	}
	
	/**
	 * 返回一个查询对象
	 */
	public Query createQuery(final String queryString, Object... values)
			throws DAOException {
		Assert.hasText(queryString, "queryString不能为空");
		try {
			Query queryObject = getSession().createQuery(queryString);
			if (values != null) {
				for (int i = 0; i < values.length; i++) {
					queryObject.setParameter(i, values[i]); 
				}
			}
			return queryObject;
		} catch (HibernateException e) {
			throw new DAOException(e);
		}
	}

	public Page<M> find(final Page<M> page, String hql, Object... values)
			throws DAOException {
		Assert.notNull(page, "page不能为空");

		try {
			String countQueryString = " select count (*) "
					+ removeSelect(removeOrders(hql));

			if (page.isAutoCount()) {
				try {
					// if (logger.isWarnEnabled()) {
					// logger.warn("HQL查询暂不支持自动获取总结果数,hql为:" + hql);
					// }
					Query cq = createQuery(countQueryString, values);
					Long count = (Long) cq.uniqueResult();// 可以获取到
					page.setTotalCount(count.intValue());
				} catch (Exception e) {
					page.setTotalCount(0);
				}
			}
			if (page.getPageNo() > page.getTotalPages()) {
				page.setPageNo(1);
			}

			logger
					.info("******************************************************************");
			logger.info("PageNo=" + page.getPageNo() + ",TotalPages="
					+ page.getTotalPages());
			logger
					.info("******************************************************************");

			Query q = createQuery(hql, values);
			if (page.isFirstSetted()) {
				q.setFirstResult(page.getFirst());
			}
			if (page.isPageSizeSetted()) {
				q.setMaxResults(page.getPageSize());
			}
			List result = q.list();
			if (result != null && result.size() > 0
					&& !(result.get(0) instanceof Integer)) {
				page.setResult(result);
			}
			return page;
		} catch (HibernateException e) {
			throw new DAOException(e);
		}
	}
	
	/**
	 * 去除select 子句，未考虑union的情况
	 */
	private static String removeSelect(String hql) {
		Assert.hasText(hql);
		int beginPos = hql.toLowerCase().indexOf("from");
		Assert.isTrue(beginPos != -1, " hql : " + hql
				+ " must has a keyword 'from'");
		return hql.substring(beginPos);
	}

	/**
	 * 去除orderby 子句
	 */
	private static String removeOrders(String hql) {
		Assert.hasText(hql);
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 通过count查询获得本次查询所能获得的对象总数.
	 * 
	 * @return page对象中的totalCount属性将赋值.
	 */
	protected int countQueryResult(Page<M> page, Criteria c)
			throws DAOException {
		try {
			CriteriaImpl impl = (CriteriaImpl) c;

			// 先把Projection、ResultTransformer、OrderBy取出来,清空三者后再执行Count操作
			Projection projection = impl.getProjection();
			ResultTransformer transformer = impl.getResultTransformer();

			List<CriteriaImpl.OrderEntry> orderEntries = null;
			try {
				orderEntries = (List) BeanUtils.getFieldValue(impl,
						"orderEntries");
				BeanUtils.setFieldValue(impl, "orderEntries", new ArrayList());
			} catch (Exception e) {
				logger.error("不可能抛出的异常");
			}

			// 执行Count查询
			int totalCount = (Integer) c.setProjection(Projections.rowCount())
					.uniqueResult();
			if (totalCount < 1)
				totalCount = -1;

			// 将之前的Projection和OrderBy条件重新设回去
			c.setProjection(projection);

			if (projection == null) {
				c.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
			}
			if (transformer != null) {
				c.setResultTransformer(transformer);
			}

			try {
				BeanUtils.setFieldValue(impl, "orderEntries", orderEntries);
			} catch (Exception e) {
				logger.error("不可能抛出的异常");
			}

			return totalCount;
		} catch (HibernateException e) {
			throw new DAOException(e);
		}
	}
	
	public Page<M> findAll(Page<M> page) throws DAOException {
		return findByCriteria(page);
	}

	public Page<M> findByCriteria(Page<M> page, Criterion... criterion)
			throws DAOException {
		Assert.notNull(page);

		try {
			Criteria c = createCriteria(criterion);

			if (page.isAutoCount()) {
				try {
					page.setTotalCount(countQueryResult(page, c));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (page.isFirstSetted()) {
				c.setFirstResult(page.getFirst());
			}
			if (page.isPageSizeSetted()) {
				c.setMaxResults(page.getPageSize());
			}

			if (page.isOrderBySetted()) {
				if (page.getOrder().endsWith(QueryParameter.ASC)) {
					c.addOrder(Order.asc(page.getOrderBy()));
				} else {
					c.addOrder(Order.desc(page.getOrderBy()));
				}
			}

			List result = c.list();
			if (result != null && result.size() > 0
					&& !(result.get(0) instanceof Integer)) {
				page.setResult(result);
			}

			return page;
		} catch (HibernateException e) {
			throw new DAOException(e);
		}
	}
	
	/**
	 * 根据Criterion条件创建Criteria,后续可进行更多处理,辅助函数.
	 * 
	 * @see
	 * com.strongmvc.orm.hibernate.IGenericDAO#createCriteria(org.hibernate.
	 * criterion.Criterion)
	 */
	public  Criteria createCriteria(final Criterion... criterions)
			throws DAOException {
		Criteria criteria = getSession().createCriteria(entityClass);
		for (Criterion c : criterions) {
			criteria.add(c);
		}
		return criteria;
	}
	
	/**
	 * 
	 * @see com.strongmvc.orm.hibernate.IGenericDAO#getSession()
	 */
	public Session getSession() throws DAOException {
		try {
			return sessionFactory.getCurrentSession();
		} catch (HibernateException e) {
			throw new DAOException(e);
		}
	}

}
