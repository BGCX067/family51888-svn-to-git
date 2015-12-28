package com.strongit.framework.util;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.web.context.support.ServletContextResourceLoader;
import org.springframework.web.context.support.ServletContextResourcePatternResolver;

import com.strongit.framework.exception.SystemException;


/**
 * 资源的获取，支持了通配符的配置方式
 * @author lanjh
 *
 */
public class ResourceUtils {
	private static Log log = LogFactory.getLog(ResourceUtils.class);

	/**
	 * 
	 * @param context
	 *            ServletContext
	 * @param paths
	 *            String
	 * @return Resource[]
	 * @throws SystemException
	 */
	private static Resource[] getSimpleResources(ServletContext context,
			String paths) throws SystemException {
		try {
			ServletContextResourcePatternResolver resolver = new ServletContextResourcePatternResolver(
					new ServletContextResourceLoader(context));
			return resolver.getResources(paths);
		} catch (Exception ex) {
			throw new SystemException(ex);
		}
	}

	/**
	 * 
	 * @param context
	 *            ServletContext
	 * @param paths
	 *            String
	 * @return Resource[]
	 * @throws SystemException
	 */
	private static Resource[] getMulitResources(ServletContext context,
			String paths) throws SystemException {
		StringTokenizer st = new StringTokenizer(paths, ",");
		List list = new ArrayList();
		while (st.hasMoreTokens()) {
			Resource[] rs = getSimpleResources(context, st.nextToken());
			for (int i = 0; i < rs.length; i++) {
				list.add(rs[i]);
			}
		}
		return (Resource[]) list.toArray(new Resource[list.size()]);
	}

	/**
	 * 
	 * @param context
	 *            ServletContext
	 * @param paths
	 *            String
	 * @return Resource[]
	 * @throws SystemException
	 */
	public static Resource[] getResources(ServletContext context, String paths)
			throws SystemException {
		if (paths.indexOf(',') != -1) {
			return getMulitResources(context, paths);
		} else {
			return getSimpleResources(context, paths);
		}
	}

	/**
	 * 解析带通配符path成paths，以逗号为分割符。
	 * 
	 * @param context
	 * @param paths
	 * @return String
	 */
	public static String getResourcesAsString(ServletContext context,
			String paths) throws SystemException {
		StringBuffer buffer = new StringBuffer(1024);

		try {
			Resource[] resources = getResources(context, paths);

			for (int i = 0; i < resources.length; i++) {
				String path = null;
				if (buffer.length() > 0) {
					buffer.append(",");
				}
				if (resources[i] instanceof ClassPathResource) {
					ClassPathResource cpr = (ClassPathResource) resources[i];
					path = cpr.getPath();
				} else {
//					URI uri = resources[i].getURI();
					URL uri = resources[i].getURL();
					// path = (String) uri.getPath();//JDK1.4不支持
					path = (String) uri.getPath() ;
//					path = (String) uri.getSchemeSpecificPart();
					int offset = path.indexOf("/WEB-INF/");
					if (offset > 0) {
						path = path.substring(offset);
					}
				}
				buffer.append(path);
			}
		} catch (SystemException ex) {
			throw ex;
		} catch (Exception ex) {
			throw new SystemException(ex);
		}

		return buffer.toString();
	}
}
