<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html lang="zh">

<head>
<title>${file.title}-AJava.org</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="description" content="${file.excerpt}" />
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/icons/logo.ico" type="image/x-icon" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/screen.css" type="text/css" media="screen, projection" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/print.css" type="text/css" media="print" />
<!--[if IE]>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/ie.css" type="text/css" media="screen, projection" />
<![endif]-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/style.css" type="text/css" media="screen, projection" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery.floatbox.1.0.8.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/signup.js"></script>
</head>

<body> 
  
<!-- 头部 -->
<div class="container">
		<div class="span-4"><a href="/${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/resources/images/logo.gif" class="logo"/></a></div>
		<div class="span-15"><a href="/file-000000002c45c61f012c4a08f3940007" target="_blank"><img src="${pageContext.request.contextPath}/resources/images/top.jpg"  class="logo"/></a></div>
		<div class="span-5 last">
			<div><c:if test="${!empty account.accountAlias}"><span class="border">欢迎你--${account.accountAlias}</span><span class="border"><a href="${pageContext.request.contextPath}/logout">退出</a></span></c:if></div>
			<div><c:if test="${empty account.accountAlias}"><span class="border"><a href="${pageContext.request.contextPath}/signup">注册</a></span><span class="border"><a href="##" id="login">登录</a></span></c:if></div>
			<div><a href="${pageContext.request.contextPath}/member.index">会员中心</a></div>
		</div>
</div> 
<!-- 头部 -->

<!-- 中部 -->
<div class="container">
	<!-- 左部 -->
	<div class="span-4 center">
		<h5 class="title-color round-box">故事分类</h5>
		<c:forEach items="${categoryList}" var="category" begin="0" step="1">
			<h5 class="menu-color round-box"><a href="${pageContext.request.contextPath}/c-${category.id}">${category.categoryName}</a></h5>
		</c:forEach>
	</div>
	<!-- 左部 -->
	
	<!-- 右部 -->
	<div class="span-19 last">
		
		<!-- 故事内容 -->
	<div class="title-color round-box">
		<h2 class="center">${file.title}<span class="fancy">--${file.viceTitle}</span></h2>
		<h4 class="center">主题：<c:forEach items="${tagList}" var="tag" begin="0" step="1"><span><a href="${pageContext.request.contextPath}/t-${tag.tagName}" class="border">${tag.tagName}</a></span></c:forEach></h4>
		</div>
		<div class="content-color round-box">
				<p>${file.content}</p>
				<p><em>(完)作者：${file.author}<c:if test="${!empty file.translator}"> 译者：${file.translator}</c:if> 来源：${file.source} <c:if test="${!empty file.sourceUrl}"><a href="${file.sourceUrl}" target="_blank">查看原文</a></c:if></em></p>
		</div>
		<c:if test="${!empty urlList}">
			<h5 class="title-color round-box">${file.title}</h5>
			<div class="clearfix">
				<div class="span-8">
				<ul>
					<li>文件版本：${file.version}</li>
					<li>文件大小：${file.size}</li>
					<li>操作系统：${file.os}</li>
					<li>许可协议：${file.license}</li>
					<li>文件语言：${file.language}</li></ul>
				</div>
				<div class="span-10">
					<c:forEach items="${urlList}" var="fileDownloadUrl" begin="0" step="1">						
							<h5><a href="${fileDownloadUrl.url}" class="span-3 selected-border clearfix center">${fileDownloadUrl.name}</a></h5>
					</c:forEach>
				</div>
				</div>
				<h5 class="fancy">下载前请确认本文件是否为您所需要的，以免浪费您的时间。</h5>
		</c:if>
		<!-- 故事内容 -->
		<h5 id="targetComment" class="title-color round-box">网友评论--如果此文对您有帮助，请注册用户发表评论，您的评论是对AJava的最大支持。</h5>
		<div class="round-box last" id="comment">
		<c:forEach items="${replyList}" var="reply" begin="0" step="1" varStatus="index">
			<span>第${index.index+1}楼--<b>${reply.creater}</b><em>--${reply.createTime}</em></span>
			<h5 class='thin hr-border content'>${reply.content}</h5>
		</c:forEach>
		</div>
		<c:if test="${!empty account.accountAlias}">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/jquery.jump.js"></script>
		<script>
		$(document).ready(function() {
	function validateComment() {
		var content = $("#content").val();
		if (content == '') {
			$('#tip').text("请输入评论内容！");
			$('#tip').fadeIn();
			return false;
		} else if(getlengthB(content)>1000){
			$('#tip').text("评论内容超过1000个字符了！");
			$('#tip').fadeIn();
			return false;
		}else{
			$('#tip').fadeOut();
			return true;
		}
	}
	function hanlderComment(responseText) {
		var o = $.parseJSON(responseText);
		$('#tip').text("您已成功发表评论。").fadeIn();
		var comment = "<span><b>${account.accountName}</b><em>--"+o.createTime+ "</em></span><h5 class='thin hr-border'><code>"
				+ o.content
				+ "</code></h5>";
		$('#comment').append(comment);
	}

	$("#replyForm").ajaxForm({
				"beforeSubmit" : validateComment,
				"success" : hanlderComment
			});
});</script>
		<form id="replyForm" action="/member.reply" method="post">
		<input type="hidden" name="fileId" value="${file.id}">
		<textarea cols="60" id="content" name="content" rows="5" ></textarea><br/>				               
        <button type="submit" >发表评论</button><span>请爱护AJava，文明发言。</span><span id="tip" class="error-color round-box hide"></span> 
        </form>
        </c:if>
        <c:if test="${empty account.accountAlias}"><h5 class="round-box">如果您有话说，请先登录AJava。<a href="/signup" target="_blank">点击这里注册</a></h5></c:if>  
	</div>
	<!-- 右部 -->
</div>
<!-- 中部 -->

<!-- 底部 -->
<div class="container">
	<h5 class="center">Copyright © 2005-2010 www.ajava.org 版权所有 粤ICP备08114841号</h5>
</div>
<div class="hide">
	<script language="JavaScript" src="http://s68.cnzz.com/stat.php?id=1212066&web_id=1212066"></script>
</div>
<!-- 底部 -->

</body>
</html>