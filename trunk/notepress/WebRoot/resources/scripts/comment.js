$(document).ready(function() {
	function validateComment() {
		var content = $("#content").val();
		if (content == '') {
			$('#tip').text("请输入评论内容");
			$('#tip').fadeIn();
			return false;
		} else {
			$('#tip').fadeOut();
			return true;
		}
	}
	function hanlderComment(responseText) {
		var o = $.parseJSON(responseText);
		$('#tip').text("您已成功发表评论。").fadeIn();
		var comment = "<div class='hide' id='newComment'><div><span class='user'>${account.accountName}--"
				+ o.ip
				+ "</span><span class='date'>"
				+ o.createTime
				+ "</span></div><div class='comment-content'>"
				+ o.content
				+ "</div><div class='comment-bottom'><span>引用</span><span>支持[0]</span><span>反对[0]</span></div></div>";
		$('#comment').prepend(comment);
		$("html,body").animate({
					scrollTop : $("#targetComment").offset().top
				}, 500);
		$('#newComment').fadeIn('slow');
	}

	$("#replyForm").ajaxForm({
				"beforeSubmit" : validateComment,
				"success" : hanlderComment
			});
});