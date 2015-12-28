package org.notepress.security.model;

/**
 * LpFunction entity. @author MyEclipse Persistence Tools
 */

public class Function implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 3970033936512677808L;
	private String id;
	private String functionName;
	private String functionUrl;
	private String functionAnturl;
	private Integer functionSort;

	// Constructors

	/** default constructor */
	public Function() {
	}

	/** full constructor */
	public Function(String functionName, String functionUrl,
			String functionAnturl, Integer functionSort) {
		this.functionName = functionName;
		this.functionUrl = functionUrl;
		this.functionAnturl = functionAnturl;
		this.functionSort = functionSort;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFunctionName() {
		return this.functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	public String getFunctionUrl() {
		return this.functionUrl;
	}

	public void setFunctionUrl(String functionUrl) {
		this.functionUrl = functionUrl;
	}

	public Integer getFunctionSort() {
		return this.functionSort;
	}

	public void setFunctionSort(Integer functionSort) {
		this.functionSort = functionSort;
	}

	public String getFunctionAnturl() {
		return functionAnturl;
	}

	public void setFunctionAnturl(String functionAnturl) {
		this.functionAnturl = functionAnturl;
	}
}