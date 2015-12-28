package org.notepress.core.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.MappingDispatchAction;
import org.notepress.core.model.Reply;
import org.notepress.core.model.ReplyMeta;
import org.notepress.core.service.IReplyService;
import org.notepress.util.DateUtils;
import org.notepress.util.HtmlUtils;
import org.notepress.util.security.UserUtil;
import org.notepress.util.spring.SpringContextUtil;

public class MemberAction extends MappingDispatchAction {
	// 发表评论
	public ActionForward index(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("target");
	}
	// 发表评论
	public ActionForward reply(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 检查必要的参数
		String json = "{\"success\":false}";
		String fileId = (String) request.getParameter("fileId");
		String content = (String) request.getParameter("content");
		if (StringUtils.isBlank(fileId) || StringUtils.isBlank(content)) {
			return mapping.findForward("error");
		}

		try {
			// 得到service
			IReplyService replyService = (IReplyService) SpringContextUtil
					.getBean("replyService");

			Reply reply = new Reply();

			content = HtmlUtils.filterHtml(content);
			reply.setContent(content);
			reply.setFileId(fileId);

			ReplyMeta replyMeta = new ReplyMeta();
			replyMeta.setAgreeAmount(0);
			replyMeta.setOpposeAmount(0);
			replyMeta.setReplyStatus(1);
			replyMeta.setHideVote(0);
			replyMeta.setBestReply(0);
			replyMeta.setReplyIp(request.getRemoteAddr());

			replyService.create(reply, replyMeta);

			json = "{\"success\":true,\"content\":\"" + content
					+ "\",\"createTime\":\""
					+ DateUtils.formatDate(reply.getCreateTime())
					+ "\",\"ip\":\"" + request.getRemoteAddr() + "\"}";
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("error");
		}
		response.getWriter().println(json);
		return null;
	}

	public ActionForward replyIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String creater = UserUtil.getUserName();

		try {
			// 得到service
			IReplyService replyService = (IReplyService) SpringContextUtil
					.getBean("replyService");
			List replyList = replyService.queryByCreater(creater);
			request.setAttribute("replyList", replyList);
			return mapping.findForward("target");
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("error");
		}

	}
}
