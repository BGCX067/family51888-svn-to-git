package com.strongit.framework.service;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.criterion.Criterion;

import com.strongit.framework.dao.DAO;
import com.strongit.framework.exception.DAOException;
import com.strongit.framework.model.Model;
import com.strongit.framework.model.StrongLogInfo;
import com.strongit.framework.util.Page;
/**
 * 抽象业务实现，继承了抽象业务接口
 * @author lanjh
 *
 * @param <M>
 * @param <QM>
 */
public abstract class AbstractEbo<M extends Model,QM extends M> implements Ebi<M,QM>{

	public Page<M> findAll(Page<M> page) throws DAOException {
		return dao.findAll(page);
	}

	public Page<M> find(Page<M> page, String hql, Object... values)
			throws DAOException {
		return dao.find(page, hql, values);
	}

	public Page<M> findByCriteria(Page<M> page, Criterion... criterion)
			throws DAOException {
		return dao.findByCriteria(page, criterion);
	}

	private DAO<M,QM> dao;
	
	public abstract StrongLogInfo getCreateLogInfo(M model);
	public abstract StrongLogInfo getUpdateLogInfo(M model);
	public abstract StrongLogInfo getDeleteLogInfo(M model);
	
	
	public StrongLogInfo create(M model) {
		StrongLogInfo logInfo  = null;
		if(dao.create(model)){
			logInfo = getCreateLogInfo(model);
		}
		return logInfo;
	}

	public StrongLogInfo delete(M model) {
		StrongLogInfo logInfo  = null;
		if(dao.delete(model)){
			logInfo = getDeleteLogInfo(model);
		}
		return logInfo;
		
	}
	
	public boolean delete(int uuid, int version){
		return dao.delete(uuid, version);
	}

	public List<M> getAll(int firstRecord, int maxRecord) {
		return dao.getAll(firstRecord, maxRecord);
	}

	public int getAllCount() {
		return dao.getAllCount();
	}

	public List<M> getByCondition(QM uqm, int firstRecord, int maxRecord) {
		return dao.getByCondition(uqm, firstRecord, maxRecord);
	}

	public int getByConditionCount(QM uqm) {
		return dao.getByConditionCount(uqm);
	}

	public M findUniqueByProperty(String propertyName, Object value) {
		return dao.findUniqueByProperty(propertyName,value);
	}

	public StrongLogInfo update(M model) {
		StrongLogInfo logInfo  = null;
		if(dao.update(model)){
			logInfo = getUpdateLogInfo(model);
		}
		return logInfo;
	}

	public Session getSession() throws DAOException {
		return dao.getSession();
	}

	public void setDao(DAO<M, QM> dao) {
		this.dao = dao;
	}

}
