<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><decorator:title default="欢迎使用用户管理系统"/></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css"/>
<decorator:head/>
</head>
<body>
<h1><decorator:title/></h1>
<c:if test="${not empty loginUser}">
<a href="<%=request.getContextPath() %>/user/add">用户添加</a>
<a href="<%=request.getContextPath() %>/user/users">用户列表</a>
<a href="<%=request.getContextPath() %>/logout">退出系统</a>
当前用户:${loginUser.nickname }
</c:if>
<hr/>
<decorator:body/>
<div align="center" style="width:100%;border-top:1px solid; float:left;margin-top:10px;">
	CopyRight@2012-2015<br/>
	开发培训教学项目
</div>
</body>
</html>