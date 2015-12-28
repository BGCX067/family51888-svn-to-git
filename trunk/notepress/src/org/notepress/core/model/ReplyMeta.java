package org.notepress.core.model;

/**
 * LpReplyMeta entity. @author MyEclipse Persistence Tools
 */

public class ReplyMeta implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 873709564661962529L;
	private String id;
	private String replyId;
	private Integer agreeAmount;
	private Integer opposeAmount;
	private Integer replyStatus;
	private Integer hideVote;
	private Integer bestReply;
	private String replyIp;

	// Constructors

	/** default constructor */
	public ReplyMeta() {
	}

	/** full constructor */
	public ReplyMeta(String replyId, Integer agreeAmount, Integer opposeAmount,
			Integer replyStatus, Integer hideVote, Integer bestReply,
			String replyIp) {
		this.replyId = replyId;
		this.agreeAmount = agreeAmount;
		this.opposeAmount = opposeAmount;
		this.replyStatus = replyStatus;
		this.hideVote = hideVote;
		this.bestReply = bestReply;
		this.replyIp = replyIp;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getReplyId() {
		return this.replyId;
	}

	public void setReplyId(String replyId) {
		this.replyId = replyId;
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

	public Integer getReplyStatus() {
		return this.replyStatus;
	}

	public void setReplyStatus(Integer replyStatus) {
		this.replyStatus = replyStatus;
	}

	public Integer getHideVote() {
		return this.hideVote;
	}

	public void setHideVote(Integer hideVote) {
		this.hideVote = hideVote;
	}

	public Integer getBestReply() {
		return this.bestReply;
	}

	public void setBestReply(Integer bestReply) {
		this.bestReply = bestReply;
	}

	public String getReplyIp() {
		return this.replyIp;
	}

	public void setReplyIp(String replyIp) {
		this.replyIp = replyIp;
	}

}