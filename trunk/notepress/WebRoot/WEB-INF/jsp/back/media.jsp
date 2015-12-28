<%@ page language="java" pageEncoding="utf-8"%>
<%@ page
	import="org.notepress.util.error.ErrorUtils,org.notepress.core.config.FileExtraUtils,org.notepress.util.upload.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			// 得到关于文件上传的相关参数
			UploadConfig uploadConfig = UploadConfigUtils.getUploadConfig();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<title>媒体管理</title>
<link type="text/css" href="<%=path%>/resources/styles/ext-all.css"
	rel="stylesheet" />
<link type="text/css" href="<%=path%>/resources/styles/ext-extends.css"
	rel="stylesheet" />
	<link type="text/css" href="<%=path%>/resources/styles/data-view.css"
	rel="stylesheet" />
<script type="text/javascript">
	var path="<%=path%>";
	var sessionId="<%=session.getId()%>";
	var fileTypes="<%=uploadConfig.getFileType()%>";
	var fileSizeLimit="<%=uploadConfig.getFileSize()%>";
    <%=ErrorUtils.toJavaScript()%>
</script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/ext-base.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/ext-all.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path%>/resources/scripts/util.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/media.js"></script>
	<script type="text/javascript"
	src="<%=path%>/resources/scripts/media.handler.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/swfupload.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/swfupload.queue.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/scripts/swfupload.speed.js"></script>
<base href="<%=basePath%>">
</head>
<body>

</body>
</html>