package com.strongit.framework.exception;

import java.sql.SQLException;

/**
 * DAO异常抛出
 * @author lanjh
 *
 */
public class DAOException extends BaseException {

	private static final long serialVersionUID = 1L;

	public DAOException(Throwable t) {
		super(getAllMessage(t), t);
	}

	public DAOException(String message) {
		super(message);
	}

	static private SQLException getInheritSQLException(Throwable t) {
		SQLException ex = null;
		while (t != null) {
			if (t instanceof SQLException) {
				ex = (SQLException) t;
				break;
			} else {
				t = t.getCause();
			}
		}
		return ex;
	}

	static private String getAllMessage(Throwable t) {
		String message = null;

		if (t != null) {
			if (!(t instanceof SQLException)) {
				message = t.getMessage();
			}
			SQLException ex = getInheritSQLException(t);
			if (ex != null) {
				if (message != null) {
					message += "\r\n" + ex.getMessage();
				} else {
					message = ex.getMessage();
				}
				String nextMessage = getAllMessage(ex.getNextException());
				if (nextMessage != null) {
					message += "\r\n" + nextMessage;
				}
			}
		}

		return message;
	}
}
