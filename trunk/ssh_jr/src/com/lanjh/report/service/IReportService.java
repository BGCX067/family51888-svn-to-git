package com.lanjh.report.service;

import java.util.Map;

import com.lanjh.report.ReportResult;

public interface IReportService {

	
	public ReportResult doService(String type,Map<String,Object> para,String format);
}
