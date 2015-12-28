package accp.util;

import org.hibernate.Transaction;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateTemplate;

import accp.bean.User;

public class InitSystem {
	public static void main(String[] args) {
		
		/**
		 * 在这里可以初始一些数据 ，插入到数据库中 做测试
		 * 这里省略.....
		 * 
		 * 
		 * user
		 * 
		 * role
		 * 
		 * resc
		 */
		
		
		//user add
		User user=new User();
		user.setUsername("admin");
		
		//role add
		
		//resc add
		
		//user_role add
		
		//role_resc add
		
		
		//save
		ApplicationContext ac= new  ClassPathXmlApplicationContext("applicationContext-dao.xml");
		HibernateTemplate hibernateTemplate=(HibernateTemplate) ac.getBean("hibernateTemplate");
		hibernateTemplate.save(user);
		
		Transaction tr=hibernateTemplate.getSessionFactory().openSession().beginTransaction();
		
		/*hibernateTemplate.save(role);
		  hibernateTemplate.save(resc);
		    省略
		  */
		
		tr.commit();
	}

}
