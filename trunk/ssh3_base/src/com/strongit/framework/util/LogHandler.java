package com.strongit.framework.util;

import java.sql.SQLException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.strongit.framework.model.StrongLogInfo;
/**
 * 日志记录类
 * 
 * 通过HibernateCallback，完全可以使用hibernate灵活的方式来访问数据库，解决
 * spring封装hibernate后灵活性不足的缺陷。注意：方法doInHibernate方法内可以
 * 访问Session，该Session对象是绑定到该线程的Session实例。该方法内的持久层操
 * 作，与不使用Spring时的持久层操作完全相同。这保证对于复杂的持久层访问，依然可以
 * 使用Hibernate的访问方式。 
 * 
 * @author lanjh
 *
 */
public class LogHandler extends HibernateDaoSupport {

	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * <aop:config>
		<aop:aspect ref="log">
			<aop:pointcut id="AllCreateMethods" expression="execution(* com.strongit..service.*.create*(..))"/>
			<aop:after-returning method="recordLog"  pointcut-ref="AllCreateMethods" returning="logInfo"/>
		</aop:aspect>
	</aop:config>
	 * @param logInfo
	 */
	public void recordLog(final StrongLogInfo logInfo) {
		try {
			this.getHibernateTemplate().execute(new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException, SQLException {
					session.save(logInfo);
					session.flush();
					return null;
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//	/**
//	 * <aop:config>
//		<aop:aspect ref="log">
//			<aop:pointcut id="AllCreateMethods" expression="execution(* com.strongit..service.*.create*(..))"/>
//			<aop:around method="recordLog1"  pointcut-ref="AllCreateMethods"/>
//		</aop:aspect>
//	</aop:config>
//	 * @param logInfo
//	 */
//	public void recordLog1(final ProceedingJoinPoint joinpoint) {
//
//		try {
//		this.getHibernateTemplate().execute(new HibernateCallback() {
//			public Object doInHibernate(Session session)
//					throws HibernateException, SQLException {
//				try {
//					session.save((StrongLogInfo) joinpoint.proceed());
//				} catch (Throwable e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//				session.flush();
//				return null;
//			}
//		});
//	} catch (Exception e) {
//		e.printStackTrace();
//	}
//
//	}

}
