<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html lang="zh">

<head>
<title>${param.tagName}相关资源-AJava.org</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="description" content="${param.tagName}" />
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
	<div class="span-19 prepend-0">
		
		<!-- 最新文件 -->
		<h5 class="content-color round-box">“${param.tagName}”相关资源</h5>
		<c:forEach items="${fileList}" var="file" begin="0" step="1"
			varStatus="index">
			<div class="content-color round-box">
					<h2><a href="${pageContext.request.contextPath}/file-${file.id}" target="_blank">${file.title}</a><span class="fancy">--${file.viceTitle}</span></h2>
					<p>${file.excerpt}<a href="${pageContext.request.contextPath}/file-${file.id}" target="_blank">查看详细内容</a></p>
					<h5 class="fancy">作者：${file.author}<c:if test="${!empty file.translator}"> - 译者：${file.translator}</c:if> - 来源：${file.source}<c:if test="${!empty file.sourceUrl}"><a href="${file.sourceUrl}" target="_blank">查看原文</a></c:if></h5>
			</div>
		</c:forEach>
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