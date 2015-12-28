package com.strongit.framework.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.config.ModuleConfig;

import com.strongit.framework.exception.SystemException;
import com.strongit.framework.util.ResourceUtils;


/**
 * 重写了<p>org.apache.struts.action.ActionServlet<p>的initModuleConfig方法，
 * 使其支持通配符的配置方式。
 * @author lanjh
 *
 */
public class ActionServlet extends org.apache.struts.action.ActionServlet {

	/**
	 * <p>
	 * Initialize the module configuration information for the specified module.
	 * </p>
	 * 
	 * @param prefix
	 *            Module prefix for this module
	 * @param paths
	 *            Comma-separated list of context-relative resource path(s) for
	 *            this modules's configuration resource(s)
	 * @return The new module configuration instance.
	 * @throws ServletException
	 *             if initialization cannot be performed
	 * @since Struts 1.1
	 */
	protected ModuleConfig initModuleConfig(String prefix, String paths)
			throws ServletException {

		// 加入web.xml中对struts初始化参数conf值采用通配符的支持
		try {
			paths = ResourceUtils.getResourcesAsString(
					this.getServletContext(), paths);
		} catch (SystemException ex) {
			throw new ServletException(ex);
		}

		return super.initModuleConfig(prefix, paths);
	}
	
	@Override
	protected void process(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		super.process(request, response);
	}

}
