package accp.util;

import org.hibernate.Transaction;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateTemplate;

import accp.bean.User;

public class InitSystem {
	public static void main(String[] args) {
		
		/**
		 * ��������Գ�ʼһЩ���� �����뵽���ݿ��� ������
		 * ����ʡ��.....
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
		    ʡ��
		  */
		
		tr.commit();
	}

}
