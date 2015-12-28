package com.oa.bean;

import java.io.Serializable;

public class Dictionary implements Serializable {
	
	private Long id;
	private String d_type;
	private String item;//
	private String d_value;
	
	
	public Dictionary(){}


	public Dictionary(String d_type, String item, String d_value) {
		this.d_type = d_type;
		this.item = item;
		this.d_value = d_value;
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getD_type() {
		return d_type;
	}


	public void setD_type(String d_type) {
		this.d_type = d_type;
	}


	public String getItem() {
		return item;
	}


	public void setItem(String item) {
		this.item = item;
	}


	public String getD_value() {
		return d_value;
	}


	public void setD_value(String d_value) {
		this.d_value = d_value;
	}
	
	
	
	

}
