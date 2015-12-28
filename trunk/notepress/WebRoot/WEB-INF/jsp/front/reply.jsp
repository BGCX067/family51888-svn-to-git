<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html lang="zh">

<head>
<title>会员中心-AJava.org</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="description" content="会员中心" />
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/icons/logo.ico" type="image/x-icon" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/screen.css" type="text/css" media="screen, projection" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/print.css" type="text/css" media="print" />
<!--[if IE]>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/ie.css" type="text/css" media="screen, projection" />
<![endif]-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/style.css" type="text/css" media="screen, projection" />
</head>

<body> 
  
<!-- 头部 -->
<div class="container">
		<div class="span-4"><a href="/${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/resources/images/logo.gif" class="logo"/></a></div>
		<div class="span-15"><a href="/file-000000002c45c61f012c4a08f3940007" target="_blank"><img src="${pageContext.request.contextPath}/resources/images/top.jpg"  class="logo"/></a></div>
		<div class="span-5 last">
			<div><c:if test="${!empty account.accountAlias}"><span class="border">欢迎你--${account.accountAlias}</span><span class="border"><a href="${pageContext.request.contextPath}/logout">退出</a></span></c:if></div>
			<div><a href="${pageContext.request.contextPath}/member.index">会员中心</a></div>
		</div>
</div> 
<!-- 头部 -->

<!-- 中部 -->
<div class="container">
	<!-- 左部 -->
	<div class="span-4 center">
		<h5 class="title-color round-box">会员中心</h5>
		<h5 class="menu-color round-box"><a href="${pageContext.request.contextPath}/member.reply.index">你的讨论</a></h5>
		<h5 class="menu-color round-box"><a href="${pageContext.request.contextPath}/file-000000002c45c61f012c542d1ea9004f">下载NotePress</a></h5>
	</div>
	<!-- 左部 -->
	
	<!-- 右部 -->
	<div class="span-19 last">
		<!-- 最新文件 -->
		<h5 class="content-color round-box">您参与的讨论话题</h5>
		<div class="round-box last" id="comment">
		<c:forEach items="${replyList}" var="reply" begin="0" step="1" varStatus="index">
			<span>${index.index+1}--<b>${reply.creater}</b><em>--${reply.createTime}</em></span>
			<h5 class='thin hr-border content'>${reply.content}</h5>
		</c:forEach>
		</div>
		<!-- 最新文件 -->
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