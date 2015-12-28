package com.strongit.framework.service;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.criterion.Criterion;

import com.strongit.framework.exception.DAOException;
import com.strongit.framework.model.Model;
import com.strongit.framework.model.StrongLogInfo;
import com.strongit.framework.util.Page;
/**
 * 抽象的业务接口
 * @author lanjh
 *
 * @param <M>
 * @param <QM>
 */
public interface Ebi<M extends Model, QM extends M> {
	
	public StrongLogInfo create(M model) throws DAOException;

	public StrongLogInfo update(M model) throws DAOException;

	public boolean delete(int uuid, int version) throws DAOException;
	
	public StrongLogInfo delete(M model) throws DAOException;

	public M findUniqueByProperty(String propertyName, Object value)
			throws DAOException;

	/**
	 * 返回所有的数量 注意，返回-1代表出错
	 * 
	 * @return
	 */
	public int getAllCount() throws DAOException;

	public List<M> getAll(int firstRecord, int maxRecord) throws DAOException;

	public int getByConditionCount(QM uqm) throws DAOException;

	public List<M> getByCondition(QM uqm, int firstRecord, int maxRecord)
			throws DAOException;

	public Page<M> find(final Page<M> page, String hql, Object... values)
			throws DAOException;

	public Page<M> findByCriteria(Page<M> page, Criterion... criterion)
			throws DAOException;
	
	public Page<M> findAll(Page<M> page) throws DAOException;
	
	public Session getSession() throws DAOException;

}
