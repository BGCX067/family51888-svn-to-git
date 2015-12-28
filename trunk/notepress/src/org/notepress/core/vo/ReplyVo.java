package org.notepress.core.vo;

import org.notepress.util.DateUtils;

public class ReplyVo {
	private String id;
	private String fileId;
	private String content;
	private Long createTime;
	private Long updateTime;
	private String creater;
	private String replyMetaId;
	private Integer agreeAmount;
	private Integer opposeAmount;
	private Integer replyStatus;
	private Integer hideVote;
	private Integer bestReply;
	private String replyIp;

	public ReplyVo(String id, String fileId, String content, Long createTime,
			Long updateTime, String creater, String replyMetaId,
			Integer agreeAmount, Integer opposeAmount, Integer replyStatus,
			Integer hideVote, Integer bestReply, String replyIp) {
		this.id = id;
		this.fileId = fileId;
		this.content = content;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.creater = creater;
		this.replyMetaId = replyMetaId;
		this.agreeAmount = agreeAmount;
		this.opposeAmount = opposeAmount;
		this.replyStatus = replyStatus;
		this.hideVote = hideVote;
		this.bestReply = bestReply;
		this.replyIp = replyIp;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreateTime() {
		return DateUtils.formatDate(createTime);
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return DateUtils.formatDate(updateTime);
	}

	public void setUpdateTime(Long updateTime) {
		this.updateTime = updateTime;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getReplyMetaId() {
		return replyMetaId;
	}

	public void setReplyMetaId(String replyMetaId) {
		this.replyMetaId = replyMetaId;
	}

	public Integer getAgreeAmount() {
		return agreeAmount;
	}

	public void setAgreeAmount(Integer agreeAmount) {
		this.agreeAmount = agreeAmount;
	}

	public Integer getOpposeAmount() {
		return opposeAmount;
	}

	public void setOpposeAmount(Integer opposeAmount) {
		this.opposeAmount = opposeAmount;
	}

	public Integer getReplyStatus() {
		return replyStatus;
	}

	public void setReplyStatus(Integer replyStatus) {
		this.replyStatus = replyStatus;
	}

	public Integer getHideVote() {
		return hideVote;
	}

	public void setHideVote(Integer hideVote) {
		this.hideVote = hideVote;
	}

	public Integer getBestReply() {
		return bestReply;
	}

	public void setBestReply(Integer bestReply) {
		this.bestReply = bestReply;
	}

	public String getReplyIp() {
		return replyIp;
	}

	public void setReplyIp(String replyIp) {
		this.replyIp = replyIp;
	}

}
