package org.notepress.core.model;

/**
 * LpCategory entity. @author MyEclipse Persistence Tools
 */

public class Category implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -3453795261370882535L;
	private String id;
	private String categoryParentId;
	private String categoryName;
	private Integer categoryType;
	private Integer categorySort;

	// Constructors

	/** default constructor */
	public Category() {
	}

	/** full constructor */
	public Category(String categoryParentId, String categoryName,
			Integer categoryType, Integer categorySort) {
		this.categoryParentId = categoryParentId;
		this.categoryName = categoryName;
		this.categoryType = categoryType;
		this.categorySort = categorySort;

	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCategoryParentId() {
		return this.categoryParentId;
	}

	public void setCategoryParentId(String categoryParentId) {
		this.categoryParentId = categoryParentId;
	}

	public String getCategoryName() {
		return this.categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public Integer getCategoryType() {
		return this.categoryType;
	}

	public void setCategoryType(Integer categoryType) {
		this.categoryType = categoryType;
	}

	public Integer getCategorySort() {
		return this.categorySort;
	}

	public void setCategorySort(Integer categorySort) {
		this.categorySort = categorySort;
	}
}