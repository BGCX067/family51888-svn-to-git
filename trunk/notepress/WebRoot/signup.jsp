<%@ page language="java" pageEncoding="utf-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html lang="zh">

<head>
<title>注册/登录账户-AJava.org</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="description" content="注册新账户" />
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
    <script>
    function getlengthB(str) {
    	return str.replace(/[^\x00-\xff]/g, "**").length;
    }

    $(document).ready(function() { 
        function validateAccountName() {
        	$.ajaxSetup({"async":false});
        	var flag = false;
        	var accountName = $("#accountName").val();

        	if (getlengthB(accountName) == 0) {
        		$('#accountNameSpan').text('请输入账户名称！').fadeIn();
        		flag = false;
        	} else if (getlengthB(accountName) > 60) {
        		$('#accountNameSpan').text('账户名称长度超过60！').fadeIn();
        		flag = false;
        	} else {
        			$.getJSON("${pageContext.request.contextPath}/duplicateAccount", {
        				accountName : accountName
        			}, function(json) {
        				if (json.duplicate) {
        					$('#accountNameSpan').text('账户名称已经存在！').fadeIn();
        					flag = false;
        				} else {
        					$('#accountNameSpan').fadeOut();
        					flag = true;
        				}
        			});
        	}
        	return flag;
        }
        $("#accountName").blur(validateAccountName);
        function validatePassword() {
            
        	var flag = false;
        	var password = $("#password").val();
        	if (getlengthB(password) == 0) {
        		$('#passwordSpan').text('请输入账户密码！').fadeIn();
        		flag = false;
        	} else if (getlengthB(password) > 60) {
        		$('#passwordSpan').text('账户密码长度超过60！').fadeIn();
        		flag = false;
        	} else {
        		$('#passwordSpan').fadeOut();
        		flag = true;
        	}

        	return flag;
        }
        $("#password").blur(validatePassword);
        function validatePassword2() {
        	var flag = false;
        	var password = $("#password").val();
        	var password2 = $("#password2").val();
        	if (password != password2) {
        		$('#password2Span').text('两次输入的密码不一致！').fadeIn();
        		flag = false;
        	} else {
        		$('#password2Span').fadeOut();
        		flag = true;
        	}
        	return flag;
        }
        $("#password2").blur(validatePassword2);
        function validateAccountAlias() {
        	var flag = false;
        	var accountAlias = $("#accountAlias").val();
        	if (getlengthB(accountAlias) == 0) {
        		$('#accountAliasSpan').text('请输入账户别名！').fadeIn();
        		flag = false;
        	} else if (getlengthB(accountAlias) > 60) {
        		$('#accountAliasSpan').text('账户别名长度超过60！').fadeIn();
        		flag = false;
        	} else {
        		$('#accountAliasSpan').fadeOut();
        		flag = true;
        	}

        	return flag;
        }
        $("#accountAlias").blur(validateAccountAlias);

        function validateEmail() {
        	$.ajaxSetup({"async":false});
        	var flag = false;
        	var email = $("#email").val();

        	if (getlengthB(email) == 0) {
        		$('#emailSpan').text('请输入邮件地址！').fadeIn();
        		flag = false;
        	} else if (getlengthB(email) > 60) {
        		$('#emailSpan').text('邮件地址长度超过60！').fadeIn();
        		flag = false;
        	} else {
        			$.getJSON("${pageContext.request.contextPath}/duplicateEmail", {
        				email : email
        			}, function(json) {
        				if (json.duplicate) {
        					$('#emailSpan').text('邮件地址已经存在！').fadeIn();
        					flag = false;
        				} else {
        					$('#emailSpan').fadeOut();
        					flag = true;
        				}
        			});
        	}
        	return flag;
        }
        $("#email").blur(validateEmail);
        function validateCreate() {
        	if (validateAccountName() && validateAccountAlias()&&  validatePassword() && validatePassword2()&& validateEmail()) {
        		return true;
        	} else {
        		return false;
        	}
        }
        function hanlderResponse(responseText){
            var o=$.parseJSON(responseText);
        	$('#createAccountSpan').text(o.msg).fadeIn();
        }

        $("#createAccountForm").ajaxForm({"beforeSubmit":validateCreate,"success":hanlderResponse});
        
    }); 
    </script> 
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
	<div class="span-14 border">
		<h5 class="title-color round-box">注册新账户</h5>
		<div class="round-box">
			<form id="createAccountForm" action="/createAccount.do" method="post"> 
			    <div><label>账户名称：</label><input type="text" id="accountName" name="accountName" maxlength="60" style="width:200px"/>最长60的任意字符<span id="accountNameSpan" class="menu-color round-box hide"></span></div>
			    <div><label>账户别名：</label><input type="text" id="accountAlias" name="accountAlias" maxlength="60" style="width:200px"/>最长60的任意字符<span id="accountAliasSpan" class="menu-color round-box hide"></span></div>
			   	<div><label>账户密码：</label><input type="password" id="password" name="password" maxlength="60" style="width:200px"/>最长60的任意字符<span id="passwordSpan" class="menu-color round-box hide"></span></div>
			    <div><label>确认密码：</label><input type="password" id="password2" name="password2" maxlength="60" style="width:200px"/><span id="password2Span" class="menu-color round-box hide"></span></div>
			    <div><label>邮件地址：</label><input type="text" id="email" name="email" maxlength="60" style="width:200px"/><span>用于找回密码</span><span id="emailSpan" class="menu-color round-box hide">邮件地址已经存在！</span></div>
			   <button class="button" type="submit"><img src="resources/images/icons/tick.png" alt=""/>创建账户</button><span id="createAccountSpan" class="menu-color round-box hide"></span>
			</form>
		</div>
	</div>
	<div class="span-8">
		<h5 class="title-color round-box">注册后可以干什么</h5>
		<ol><li><b>发表评论</b>。在AJava发表评论，需要注册账户并登陆，这样可以记录您的积分。</li><li><b>发布故事</b>。拥有账户后可以发布故事，可以获得丰厚的积分。</li><li><b>下载NotePress源码</b>。NotePress是采用SSH+Ext开发的开源网站系统，您可以从中学习到各种技术的使用方法。</li><li><b>获得物质奖励</b>。当您的积分达到一定规模时，将可获得U盘、鼠标、书籍等物质奖励。</li><li><b>认识朋友</b>。可以认识更多志同道合的朋友，大家一起学习、共同进步。</li></ol>
	</div>
</div>
<!-- 中部 -->

<!-- 底部 -->
<div class="container">
	<h5 class="center">Copyright © 2005-2010 www.ajava.org 版权所有 粤ICP备08114841号</h5>
</div>
<!-- 底部 -->

</body>
</html>