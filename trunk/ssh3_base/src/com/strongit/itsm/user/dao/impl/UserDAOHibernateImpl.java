package com.strongit.itsm.user.dao.impl;


import org.hibernate.Query;

import com.strongit.framework.dao.AbstractDAOHibernateImpl;
import com.strongit.itsm.user.dao.UserDAO;
import com.strongit.itsm.user.model.UserModel;
import com.strongit.itsm.user.model.UserQueryModel;

/**
 * 
 * @author lanjh
 *
 */
public class UserDAOHibernateImpl extends AbstractDAOHibernateImpl<UserModel,UserQueryModel> implements UserDAO{
	
	public UserDAOHibernateImpl() {
		super(UserModel.class, UserQueryModel.class);
		// TODO Auto-generated constructor stub
	}

	@Override
	public String generateHQLWhere(UserQueryModel uqm) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void prepareQuery(Query query, UserQueryModel uqm) {
		// TODO Auto-generated method stub
		
	}


}
