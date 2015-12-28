<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<c:set var="now" value="<%=System.currentTimeMillis()/86400000%>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html lang="zh">

<head>
<title>出错啦-AJava.org</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
		<div class="span-15"><img src="${pageContext.request.contextPath}/resources/images/top.gif"  class="logo"/></div>
		<div class="span-5 last">
			<div><c:if test="${!empty account.accountAlias}"><span class="border">欢迎你--${account.accountAlias}</span><span class="border"><a href="${pageContext.request.contextPath}/logout">退出</a></span></c:if></div>
			<div><c:if test="${empty account.accountAlias}"><span class="border"><a href="${pageContext.request.contextPath}/signup">注册</a></span><span class="border"><a href="##" id="login">登录</a></span></c:if></div>
			<div>更多功能正在开发中</div>
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
		
		<!-- 信息 -->
		<h5 class="content-color round-box">访问错误</h5>
		<p><b>没有找到您访问的页面，或者您访问的页面发生了意外错误。</b></p>
		<p>您可以尝试以下操作：</p>
		<ol>
		<li>检查您输入的网址是否正确</li>
		<li>检查您输入的网址参数是否正确</li>
		<li>重新刷新一下网页</li>
		<li>过一段时间再尝试</li>
		<li>如果还是有问题，请给daozhanga@gmail.com发送邮件，道长A将感激不尽！</li>
		</ol>
		<!-- 信息 -->
		
	</div>
	<!-- 右部 -->
</div>
<!-- 中部 -->

<!-- 底部 -->
<div class="container">
	<h5 class="center">Copyright © 2005-2010 www.ajava.org 版权所有 粤ICP备08114841号</h5>
</div>
<!-- 底部 -->

</body>
</html>