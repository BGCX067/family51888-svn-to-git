package com.strongit.framework.exception;

import java.sql.SQLException;

/**
 * 系统异常
 * @author lanjh
 *
 */
public class SystemException extends BaseException {

    public SystemException(Throwable t) {
        super(getAllMessage(t), t);
    }

    public SystemException(String message) {
        super(message);
    }

    static private String getAllMessage(Throwable t) {
        String message = null;
        if (t != null) {
            message = t.getMessage();
            if (t instanceof SQLException) {
                SQLException ex = (SQLException) t;
                String nextMessage = getAllMessage(ex.getNextException());
                if (nextMessage != null) {
                    message += "\r\n" + nextMessage;
                }
            }
        }
        return message;
    }
}
