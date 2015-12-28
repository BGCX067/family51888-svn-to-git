package org.notepress.util.init;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.notepress.core.config.FileExtraUtils;
import org.notepress.core.service.ICategoryService;
import org.notepress.util.cache.CacheUtils;
import org.notepress.util.error.ErrorUtils;
import org.notepress.util.print.Print;
import org.notepress.util.spring.SpringContextUtil;
import org.notepress.util.upload.UploadConfigUtils;

public class InitConfigListener implements ServletContextListener {
	public void contextInitialized(ServletContextEvent event) {
		long start = System.currentTimeMillis();
		Print.println("Initializing NotePress");
		String cacheConfigPath = event.getServletContext().getInitParameter(
				"cacheConfigPath");
		String uploadConfigPath = event.getServletContext().getInitParameter(
				"uploadConfigPath");
		String extraDataConfigPath = event.getServletContext()
				.getInitParameter("extraDataConfigPath");
		String errorConfigPath = event.getServletContext().getInitParameter(
				"errorConfigPath");
		String rootPath = System.getProperty("notepress.root");

		CacheUtils.setCacheConfigPath(rootPath + cacheConfigPath);
		CacheUtils.init();
		UploadConfigUtils.setUploadConfigPath(rootPath + uploadConfigPath);
		UploadConfigUtils.init();
		FileExtraUtils.setExtraDataConfigPath(rootPath + extraDataConfigPath);
		FileExtraUtils.init();
		ErrorUtils.setErrorConfigPath(rootPath + errorConfigPath);
		ErrorUtils.init();
		long end = System.currentTimeMillis();
		Print.println("Initialization processed in " + (end - start) + " ms");
		ServletContext application = event.getServletContext();
		ICategoryService categoryService = (ICategoryService) SpringContextUtil
				.getBean("categoryService");
		try {
			application
					.setAttribute("categoryList", categoryService.query("1"));
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		// TODO Auto-generated method stub
	}

}
