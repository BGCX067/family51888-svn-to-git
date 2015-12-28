package com.lanjh.report;

import java.util.List;

public class ReportResult {
	
	public ReportResult(List<?> lst){
		this.list = lst;
	}
	
	private List<?> list = null;

	public List<?> getList() {
		return list;
	}

	public void setList(List<?> list) {
		this.list = list;
	}
	
	

}
