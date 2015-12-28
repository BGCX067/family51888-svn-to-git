<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page isELIgnored="false"%>
<html>
	<head>

		<title>列表页面</title>
		<%@ include file="/common/meta.jsp"%>
		<link href="css/yui.css" type="text/css" rel="stylesheet" />
		<link href="css/style.css" type="text/css" rel="stylesheet" />
	</head>

	<body>
		<div id="doc3">
			<%@ include file="/common/header.jsp"%>
			<div id="bd">
				<div id="yui-main">
					<div class="yui-b">
						<form action="${ctx}/userAction.do?method=listUser" method="post"><br>
							<div>
								你好,<security:authentication property="name" />
							</div>
							<div id="content">
								<table id="contentTable" width="80%">
									<tr>
										<td>
											用户名
										</td>
										<td>
											状态
										</td>
										<td>
											描述
										</td>
										<td>
											操作
										</td>


									</tr>
									<logic:notEmpty name="page">
										<c:forEach items="${page.result}" var="item"
											varStatus="statusItem">
											<tr>
												<td>
													${item.username }
												</td>
												<td>
													${item.status }
												</td>
												<td>
													${item.descn }
												</td>
												<td>
													<a
														href="userAction.do?method=beforeUpdateUser&id=${item.id }">
														修改 </a>
													<a
														href="userAction.do?method=deleteUser&id=${item.id }">
														删除 </a>
												</td>
											</tr>
										</c:forEach>
									</logic:notEmpty>
								</table>
							</div>
							<div>
								<a href="userAction.do?method=beforeaddUser">添加</a>
								<%@ include file="/common/split.jsp" %>
							</div>
			</form>
				</div>
				</div>
			</div>
			<%@ include file="/common/footer.jsp"%>
			</div>
	</body>
	<%
		if (request.getAttribute("message") != null
				&& !"null".equals(request.getAttribute("message"))
				&& !"".equals(request.getAttribute("message"))) {
			String message = (String) request.getAttribute("message");
	%>
	<script language="JavaScript" type="text/JavaScript">
	alert("<%=message%>");
	<%message = null;%>
	</script>
	<%
		}
	%>
</html>
