package org.notepress.util.struts;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.action.ExceptionHandler;
import org.apache.struts.config.ExceptionConfig;
import org.apache.struts.util.ModuleException;

/**
 * 1、扩展Struts异常处理器类。异常处理时不直接使用struts原有的便于以后扩展及调整，而不至于大量改动代码！<br/>
 * 2、此类在Struts配置文件中配置引用！<br/>
 * 3、此类用于捕获异常并抛出到统一的异常页面！<br/>
 * History: 胡浩修改于2010-01-10 00:15 增加了execute isXMLHttpRequest getStackTrace
 * getMessage方法。 </code>
 */
public class SimpleExceptionHandler extends ExceptionHandler {
	/**
	 * <p>
	 * Commons logging instance.
	 * </p>
	 */
	private static final Log LOG = LogFactory
			.getLog(SimpleExceptionHandler.class);

	/**
	 * 覆盖了ExceptionHandler的此方法，加入了如下处理：<br>
	 * 1、判断是否是XMLHttpRequest发送的请求，并将判断结果（一个boolean值）存储在request里，key为
	 * "isXMLHttpRequest"；<br>
	 * 2、将异常的message字符串存储在request里，key为"Message"；<br>
	 * 3、将异常的StackTrace字符串存储在request里，key为"StackTrace"；<br>
	 * StackTrace字符串一般有很多行，用"&ltbr/&gt"表示断行，用户应自行根据是否为XMLHttpRequest请求来处理
	 * "&ltbr/&gt"， 例如，根据需要转为"\r"。<br>
	 * 具体细节请查看{@link #isXMLHttpRequest} {@link #getStackTrace}
	 * {@link #isXMLHttpRequest}这三个方法。
	 */
	public ActionForward execute(Exception ex, ExceptionConfig ae,
			ActionMapping mapping, ActionForm formInstance,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException {

		ex.printStackTrace();
		ActionForward forward;
		ActionMessage error;
		String property;

		if (ae.getPath() != null) {
			forward = new ActionForward(ae.getPath());
		} else {
			forward = mapping.getInputForward();
		}

		if (ex instanceof ModuleException) {
			error = ((ModuleException) ex).getActionMessage();
			property = ((ModuleException) ex).getProperty();
		} else {
			error = new ActionMessage(ae.getKey(), ex.getMessage());
			property = error.getKey();
		}

		this.logException(ex);

		// 存储Exception对象到request中
		request.setAttribute(Globals.EXCEPTION_KEY, ex);
		request.setAttribute("isXMLHttpRequest", isXMLHttpRequest(request));
		request.setAttribute("Message", getMessage(ex));
		// request.setAttribute("StackTrace", getStackTrace(ex));
		this.storeException(request, property, error, forward, ae.getScope());

		if (!response.isCommitted()) {
			return forward;
		}

		if (!silent(ae)) {
			handleCommittedResponse(ex, ae, mapping, formInstance, request,
					response, forward);
		} else {
			LOG.warn("ExceptionHandler configured with " + SILENT_IF_COMMITTED
					+ " and response is committed.", ex);
		}

		return null;
	}

	/**
	 * 判断是否为XMLHttpRequest请求
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return 如果是XMLHttpRequest请求，返回true，否则返回false
	 */
	private boolean isXMLHttpRequest(HttpServletRequest request) {
		return request.getHeader("x-requested-with") != null;
	}

	/**
	 * 得到异常的堆栈信息
	 * 
	 * @param e
	 *            异常对象
	 * @return 堆栈信息
	 */
	private String getStackTrace(Exception e) {
		StackTraceElement[] causedTrace = e.getStackTrace();
		StringBuilder sb = new StringBuilder();
		int m = causedTrace.length - 1;
		for (int i = 0; i <= m; i++) {
			sb.append(causedTrace[i].toString() + "<br/>");
		}
		return sb.toString();
	}

	/**
	 * 得到异常的简洁信息
	 * 
	 * @param e
	 *            异常对象
	 * @return 异常的简洁信息
	 */
	private String getMessage(Exception e) {
		return e.getMessage();
	}

	protected void storeException(HttpServletRequest request, String property,
			ActionMessage error, ActionForward forward, String scope) {
		ActionMessages errors = new ActionMessages();

		errors.add(property, error);

		if ("request".equals(scope)) {
			request.setAttribute(Globals.ERROR_KEY, errors);
		} else {
			request.getSession().setAttribute(Globals.ERROR_KEY, errors);
		}
	}

	private boolean silent(ExceptionConfig config) {
		return "true".equals(config.getProperty(SILENT_IF_COMMITTED));
	}
}
