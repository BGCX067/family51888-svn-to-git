package com.lanjh.report.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lanjh.report.ReportResult;

@Service("demo")
@Transactional(readOnly = true)
public class DemoServiceImpl implements IReportService {

	public ReportResult doService(String type,Map<String,Object> para, String format) {
		
		
		List<Map<String,Object>> lst = new ArrayList<Map<String, Object>>();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("ID", "001");
		map.put("NAME", "张三");
		map.put("ADDR", "中国南昌");
		lst.add(map);
		
		map = new HashMap<String,Object>();
		map.put("ID", "002");
		map.put("NAME", "李四");
		map.put("ADDR", "日本东京");
		lst.add(map);
		
		map = new HashMap<String,Object>();
		map.put("ID", "003");
		map.put("NAME", "王五");
		map.put("ADDR", "美国西雅图");
		lst.add(map);
		
		ReportResult reportResult = new ReportResult(lst);
		return reportResult;
	}

}
