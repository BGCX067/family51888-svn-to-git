package com.strongit.framework.util;

import org.hibernate.cfg.Configuration;
import org.hibernate.tool.hbm2ddl.SchemaExport;

/**
 * 将hbm生成ddl
 * @author lanjh
 *
 */
public class ExportDB {

	public static void main(String[] args) {
		
		//默认读取hibernate.cfg.xml文件
		Configuration cfg = new Configuration().configure();
		
		SchemaExport export = new SchemaExport(cfg);
		export.create(true, true);
	}
}
