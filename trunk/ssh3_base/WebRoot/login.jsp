<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page isELIgnored="false"%>
<html>
	<head>

		<title>登录页面</title>

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
						<font color="red">
							${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message} </font>
						<form action="${pageContext.request.contextPath}/j_spring_security_check"
							method="POST">
							<div id="content">
								<table id="contentTable" >
								<tr>
									<td>
										用户名：
									</td>
									<td>
										<input name="j_username" type="text">
									</td>
								</tr>
								<tr>
									<td>
										密码：
									</td>
									<td>
										<input name="j_password" type="password">
									</td>
								</tr>
								<tr>
									<td></td>
								</tr>

							</table>
							</div>
							
							<div>
							<input type="submit" value="登录">
							</div>
						</form>
						
						<div>(管理员<b>admin/admin</b>, 普通用户<b>user/user</b>)</div>
					</div>
				</div>
			</div>
			<%@ include file="/common/footer.jsp"%>
		</div>
	</body>
</html>
