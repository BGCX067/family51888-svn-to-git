<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="org.notepress.util.error.ErrorUtils" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<title>目录管理</title>
<link type="text/css" href="<%=path%>/resources/styles/ext-all.css"
	rel="stylesheet" />
<link type="text/css" href="<%=path%>/resources/styles/ext-extends.css"
	rel="stylesheet" />
<script type="text/javascript">
	var path='<%=path%>';
	<%=ErrorUtils.toJavaScript()%>
</script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/ext-base.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/ext-all.js"></script>
	<script type="text/javascript"
	src="<%=path%>/resources/scripts/ext-lang-zh_CN.js"></script>
		<script type="text/javascript"
	src="<%=path%>/resources/scripts/util.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/category.js"></script>

<base href="<%=basePath%>">
</head>
<body>
</body>
</html>