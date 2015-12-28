package org.notepress.core.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.notepress.core.model.Reply;
import org.notepress.core.model.ReplyMeta;
import org.notepress.core.service.IReplyService;
import org.notepress.core.vo.ReplyVo;
import org.notepress.util.hibernate.HibernateDaoSupport;

public class ReplyServiceImpl extends HibernateDaoSupport implements
		IReplyService {

	@Override
	public void create(Reply reply, ReplyMeta replyMeta) throws Exception {
		this.createEntity(reply);
		replyMeta.setReplyId(reply.getId());
		this.createEntity(replyMeta);
	}

	@Override
	public List<ReplyVo> queryByFileId(String fileId) throws Exception {
		// HQL参数Map
		Map<String, String> values = new HashMap<String, String>();
		values.put("fileId", fileId);// 机构ID集合

		// 查询文件所有评论
		String queryString = "select new org.notepress.core.vo.ReplyVo(a.id, a.fileId, a.content, a.createTime,a.updateTime,a.creater,b.id,b.agreeAmount,b.opposeAmount,b.replyStatus,b.hideVote,b.bestReply,b.replyIp) from Reply a,ReplyMeta b where a.fileId=:fileId and a.id=b.replyId order by a.createTime";
		return this.findEntity(queryString, values);
	}

	@Override
	public void vote(String voteType, Integer voteCount) throws Exception {
		// TODO Auto-generated method stub

	}
	@Override
	public List<ReplyVo> queryByCreater(String creater) throws Exception {
		// HQL参数Map
		Map<String, String> values = new HashMap<String, String>();
		values.put("creater", creater);// 机构ID集合

		// 查询文件所有评论
		String queryString = "select new org.notepress.core.vo.ReplyVo(a.id, a.fileId, a.content, a.createTime,a.updateTime,a.creater,b.id,b.agreeAmount,b.opposeAmount,b.replyStatus,b.hideVote,b.bestReply,b.replyIp) from Reply a,ReplyMeta b where a.creater=:creater and a.id=b.replyId order by a.createTime";
		return this.findEntity(queryString, values);
	}
}
