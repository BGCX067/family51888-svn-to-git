package org.notepress.util.json;

/**
 * 行处理器接口，由用户在需要处理json的地方自己实现，
 * 
 * @author daozhanga
 * 
 */
public interface RowHanlder {
	public abstract AsyncTreeModel execute(Object object);
}
