package org.notepress.score.model;

/**
 * LpScore entity. @author MyEclipse Persistence Tools
 */

public class Score implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -6742668486109031092L;
	private String id;
	private String accountId;
	private Integer scoreIncome;
	private Integer scorePunish;
	private Integer scoreCost;

	// Constructors

	/** default constructor */
	public Score() {
	}

	/** full constructor */
	public Score(String accountId, Integer scoreIncome, Integer scorePunish,
			Integer scoreCost) {
		this.accountId = accountId;
		this.scoreIncome = scoreIncome;
		this.scorePunish = scorePunish;
		this.scoreCost = scoreCost;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAccountId() {
		return this.accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public Integer getScoreIncome() {
		return this.scoreIncome;
	}

	public void setScoreIncome(Integer scoreIncome) {
		this.scoreIncome = scoreIncome;
	}

	public Integer getScorePunish() {
		return this.scorePunish;
	}

	public void setScorePunish(Integer scorePunish) {
		this.scorePunish = scorePunish;
	}

	public Integer getScoreCost() {
		return this.scoreCost;
	}

	public void setScoreCost(Integer scoreCost) {
		this.scoreCost = scoreCost;
	}

}