<%@ page language="java" pageEncoding="utf-8"%>
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
<title>NotePress网站管理系统</title>
<link type="text/css" href="<%=path%>/resources/styles/ext-all.css"
	rel="stylesheet" />
<link type="text/css" href="<%=path%>/resources/styles/ext-extends.css"
	rel="stylesheet" />
	<script type="text/javascript">
	var path="<%=path%>";
</script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/ext-base.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/ext-all.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/ux/TabCloseMenu.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/console.js"></script>

<script type="text/javascript">
	var memberMenuArray = [ [ '文章', '/story.do' ],
	                        [ '栏目', '/category.do' ],[ '媒体', '/media.do' ]];
</script>
<base href="<%=basePath%>">
</head>
<body>
<div id="west" class="x-hide-display"></div>
<div id="welcomeTabPanel" class="x-hide-display">
<p>欢迎使用NotePress！</p>
</div>

<div id="south" class="x-hide-display">
<p>NosdfsadfsadtePress网站管理系统，是一款采用Java+MySql开发，基于ExtJs 3.X UI的免费产品。</p>
</div>

</body>
</html>