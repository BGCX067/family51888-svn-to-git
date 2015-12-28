package com.oa.util;

import java.util.List;

public class PageBean<T> {
	private int totalCount;//�ܼ�¼��
	private int currentPage;//��ǰҳ
	private int pageSize; //ÿҳ��ʾ������
	private int totalPage;//��ҳ��
	//private String orader; //����
	private int startIndex; //��ʾ��ҳ��  
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
		//�����ǰҳ������ҳ��
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
	
	//�õ���ҳ�� ����������
	public int getTotalPage() {
	//��ҳ��
	int temp;
	totalPage=(temp=(totalCount%pageSize))==0
			?totalCount/pageSize
		    :totalCount/pageSize+1;
	
    return totalPage;
	}
	
	/** 
     * ��ʼ��ʾҳ�� 
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
