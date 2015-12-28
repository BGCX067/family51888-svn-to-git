package org.notepress.config.model;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

/**
 * LpOptions entity. @author MyEclipse Persistence Tools
 */

public class Options implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 2220390309087160177L;
	private String id;
	private String optionName;
	private String optionAlias;
	private String optionValue;
	private Integer optionType;

	// Constructors

	/** default constructor */
	public Options() {
	}

	/** full constructor */
	public Options(String optionName, String optionAlias, String optionValue,
			Integer optionType) {
		this.optionName = optionName;
		this.optionAlias = optionAlias;
		this.optionValue = optionValue;
		this.optionType = optionType;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOptionName() {
		return this.optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

	public String getOptionAlias() {
		return this.optionAlias;
	}

	public void setOptionAlias(String optionAlias) {
		this.optionAlias = optionAlias;
	}

	public String getOptionValue() {
		return this.optionValue;
	}

	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}

	public Integer getOptionType() {
		return optionType;
	}

	public void setOptionType(Integer optionType) {
		this.optionType = optionType;
	}

	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}

}