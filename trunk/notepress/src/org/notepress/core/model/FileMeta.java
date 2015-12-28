package org.notepress.core.model;

/**
 * LpStoryMeta entity. @author MyEclipse Persistence Tools
 */

public class FileMeta implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -2248757157507285407L;
	private String id;
	private String fileId;
	private Integer clickAmount;
	private Integer agreeAmount;
	private Integer opposeAmount;
	private Integer fileStatus;
	private Integer fileScore;
	private Integer hideVote;
	private Integer htmlStatus;
	private Integer accessScore;
	private Integer accessCost;
	private Integer downloadCost;
	private Integer downloadAmount;
	private Integer rewardCost;
	private Integer replyAmount;
	private Integer replyStatus;
	private String fileIp;
	private Integer fileAttr;
	private Integer recommend;
	private Long topTime;

	// Constructors

	/** default constructor */
	public FileMeta() {
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFileId() {
		return this.fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public Integer getClickAmount() {
		return this.clickAmount;
	}

	public void setClickAmount(Integer clickAmount) {
		this.clickAmount = clickAmount;
	}

	public Integer getAgreeAmount() {
		return this.agreeAmount;
	}

	public void setAgreeAmount(Integer agreeAmount) {
		this.agreeAmount = agreeAmount;
	}

	public Integer getOpposeAmount() {
		return this.opposeAmount;
	}

	public void setOpposeAmount(Integer opposeAmount) {
		this.opposeAmount = opposeAmount;
	}

	public Integer getFileStatus() {
		return this.fileStatus;
	}

	public void setFileStatus(Integer fileStatus) {
		this.fileStatus = fileStatus;
	}

	public Integer getHideVote() {
		return this.hideVote;
	}

	public void setHideVote(Integer hideVote) {
		this.hideVote = hideVote;
	}

	public Integer getHtmlStatus() {
		return this.htmlStatus;
	}

	public void setHtmlStatus(Integer htmlStatus) {
		this.htmlStatus = htmlStatus;
	}

	public Integer getAccessScore() {
		return this.accessScore;
	}

	public void setAccessScore(Integer accessScore) {
		this.accessScore = accessScore;
	}

	public Integer getAccessCost() {
		return this.accessCost;
	}

	public void setAccessCost(Integer accessCost) {
		this.accessCost = accessCost;
	}

	public Integer getRewardCost() {
		return this.rewardCost;
	}

	public void setRewardCost(Integer rewardCost) {
		this.rewardCost = rewardCost;
	}

	public Integer getReplyAmount() {
		return this.replyAmount;
	}

	public void setReplyAmount(Integer replyAmount) {
		this.replyAmount = replyAmount;
	}

	public Integer getReplyStatus() {
		return this.replyStatus;
	}

	public void setReplyStatus(Integer replyStatus) {
		this.replyStatus = replyStatus;
	}

	public String getFileIp() {
		return fileIp;
	}

	public void setFileIp(String fileIp) {
		this.fileIp = fileIp;
	}

	public Integer getFileScore() {
		return fileScore;
	}

	public void setFileScore(Integer fileScore) {
		this.fileScore = fileScore;
	}

	public Integer getFileAttr() {
		return fileAttr;
	}

	public void setFileAttr(Integer fileAttr) {
		this.fileAttr = fileAttr;
	}

	public Integer getRecommend() {
		return recommend;
	}

	public void setRecommend(Integer recommend) {
		this.recommend = recommend;
	}

	public Long getTopTime() {
		return topTime;
	}

	public void setTopTime(Long topTime) {
		this.topTime = topTime;
	}

	public Integer getDownloadCost() {
		return downloadCost;
	}

	public void setDownloadCost(Integer downloadCost) {
		this.downloadCost = downloadCost;
	}

	public Integer getDownloadAmount() {
		return downloadAmount;
	}

	public void setDownloadAmount(Integer downloadAmount) {
		this.downloadAmount = downloadAmount;
	}
}