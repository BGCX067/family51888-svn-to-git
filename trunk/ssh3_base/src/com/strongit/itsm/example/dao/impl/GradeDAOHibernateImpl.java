package com.strongit.itsm.example.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;

import com.strongit.framework.dao.AbstractDAOHibernateImpl;
import com.strongit.itsm.example.dao.GradeDAO;
import com.strongit.itsm.example.model.GradeModel;
import com.strongit.itsm.example.model.GradeQueryModel;

/**
 * 1、业务实体DAO实现类需要继承抽象的DAO实现类
 * 2、需要注入sessionFactory
 * @author lanjh
 *
 */
public class GradeDAOHibernateImpl extends AbstractDAOHibernateImpl<GradeModel, GradeQueryModel> implements GradeDAO{


	public GradeDAOHibernateImpl() {
		super(GradeModel.class, GradeQueryModel.class);
		// TODO Auto-generated constructor stub
	}

	/**
	 * Select o,s.sname From GradeModel o,StudentModel s Where 1=1 and o.snum = s.snum 
	 */
	@Override
	protected String generateHQLFrom() {
		// TODO Auto-generated method stub
		return " ,StudentModel s ";
	}

	@Override
	protected String generateHQLJoinCondition() {
		// TODO Auto-generated method stub
		return " and o.snum = s.snum ";
	}

	@Override
	protected String generateHQLSelect() {
		// TODO Auto-generated method stub
		return "  Select o,s.sname  ";
	}

	@SuppressWarnings("unchecked")
	@Override
	protected List<GradeModel> prepareResult(List<?> queryResultList) {
		List<Object[]> list = (List<Object[]>) queryResultList;
		List<GradeModel> ret = new ArrayList<GradeModel>();
		for(Object[] objs : list){
			final GradeModel grade = (GradeModel) objs[0];
			final String name = (String) objs[1];
			grade.setSname(name);
			ret.add(grade);
		}
		return ret;
	}

	@Override
	public String generateHQLWhere(GradeQueryModel uqm) {
		// TODO Auto-generated method stub
		return "";
	}

	@Override
	public void prepareQuery(Query query, GradeQueryModel uqm) {
		// TODO Auto-generated method stub
		
	}
	
	public static void main(String[] args) {
		
		GradeDAO gradeDAO = new GradeDAOHibernateImpl();
		
		GradeModel grade = new GradeModel();
		
		grade.setUuid(1001);
		grade.setCnum("c1");
		grade.setGrade(1);
		grade.setSnum("s2");
		
		GradeQueryModel gqm = new GradeQueryModel();
		gqm.setUuid(1001);
		
//		System.out.println(gradeDAO.create(grade));
		
		System.out.println(gradeDAO.getByCondition(gqm,0,1));
		
		System.out.println("====================");
		
		System.out.println(gradeDAO.findUniqueByProperty("uuid", "1001"));
		
//		System.out.println(gradeDAO.findByCriteria(page, criterion));
		
	}

}
