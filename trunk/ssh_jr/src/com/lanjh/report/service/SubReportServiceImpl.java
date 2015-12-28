package com.lanjh.report.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.OrderedMap;
import org.apache.commons.collections.map.LinkedMap;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lanjh.report.ReportResult;

@Service("subReport")
@Transactional(readOnly = true)
public class SubReportServiceImpl implements IReportService {

	public ReportResult doService(String type, Map<String, Object> para,
			String format) {
		List<Map<String, Object>> lst = new ArrayList<Map<String, Object>>();

		List slist1 = new ArrayList();

		OrderedMap srow = new LinkedMap();
		srow.put("zip", "100000");
		srow.put("address", "北京市**********");
		srow.put("email", "emailname@mailserver.com");
		slist1.add(srow);

		List slist2 = new ArrayList();

		srow = new LinkedMap();
		srow.put("zip", "310012");
		srow.put("address", "杭州**********");
		srow.put("email", "emailname@mailserver.com");
		slist2.add(srow);

		OrderedMap row = new LinkedMap();
		row.put("name", "徐翔");
		row.put("post", "软件工程师");
		row.put("age", 33);
		row
				.put(
						"addressList",
						new net.sf.jasperreports.engine.data.JRBeanCollectionDataSource(
								slist1));
		lst.add(row);

		row = new LinkedMap();
		row.put("name", "陈文平");
		row.put("post", "软件工程师");
		row.put("age", 24);
		row
				.put(
						"addressList",
						new net.sf.jasperreports.engine.data.JRBeanCollectionDataSource(
								slist2));
		lst.add(row);
		HttpServletRequest request = ServletActionContext.getRequest();
		String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() ;
		para
				.put(
						"SUBREPORT_DIR",
						path+"/reportFiles/");
		para.put("TITLE", "子报表演示样例");

		ReportResult reportResult = new ReportResult(lst);
		return reportResult;
	}

}
