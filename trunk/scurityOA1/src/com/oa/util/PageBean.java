package com.oa.util;

import java.util.List;

public class PageBean<T> {
	private int totalCount;//总记录数
	private int currentPage;//当前页
	private int pageSize; //每页显示的条数
	private int totalPage;//总页数
	//private String orader; //排序
	private int startIndex; //显示的页码  
	private List<T> beanList;
	
	
	
	public List<T> getBeanList() {
		return beanList;
	}


	public void setBeanList(List<T> beanList) {
		this.beanList = beanList;
	}


	
    
	
public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}


	/*	public String getOrader() {
		return orader;
	}
	public void setOrader(String orader) {
		this.orader = orader;
	}*/
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	
	
	public void setCurrentPage(int currentPage) {
		//如果当前页大于总页数
		if(this.getTotalPage()<currentPage){
			currentPage = this.totalPage;
		}
		if(0>=currentPage){
			currentPage=1;
		}
		
		this.currentPage = currentPage;
	}
	
	
	public int getPageSize() {
		if(pageSize<=0){
			pageSize=5;
		}
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	//得到总页数 根据总行数
	public int getTotalPage() {
	//总页数
	int temp;
	totalPage=(temp=(totalCount%pageSize))==0
			?totalCount/pageSize
		    :totalCount/pageSize+1;
	
    return totalPage;
	}
	
	/** 
     * 起始显示页数 
     * @return 
     */  
    public int getStartIndex() { 
    	System.out.println("this.getTotalPage()  "+this.getTotalPage());
        for(int i=1;i<=this.getTotalPage();i+=3){  
            if(this.getCurrentPage()>=i&&this.getCurrentPage()<i+4){  
                startIndex=i;  
                break;  
        }  
        }  
        System.out.println("getStartIndex "+startIndex);
        //if(startIndex<=0){startIndex=1;}
        return startIndex;  
    }  
	
	
	
}
