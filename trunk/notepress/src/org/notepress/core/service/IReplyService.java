package org.notepress.core.service;

import java.util.List;

import org.notepress.core.model.Reply;
import org.notepress.core.model.ReplyMeta;
import org.notepress.core.vo.ReplyVo;

public interface IReplyService {
	public void create(Reply reply, ReplyMeta replyMeta) throws Exception;

	public void vote(String voteType, Integer voteCount) throws Exception;

	public List<ReplyVo> queryByFileId(String fileId) throws Exception;

	public List<ReplyVo> queryByCreater(String creater)
			throws Exception;
}
