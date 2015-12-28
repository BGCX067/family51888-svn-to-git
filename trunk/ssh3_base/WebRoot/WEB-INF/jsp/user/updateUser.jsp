<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>修改页面</title>

		<%@ include file="/common/meta.jsp"%>
		<link href="css/yui.css" type="text/css" rel="stylesheet" />
		<link href="css/style.css" type="text/css" rel="stylesheet" />
		<link href="js/validate/jquery.validate.css" type="text/css"
			rel="stylesheet" />
		<script src="js/jquery.js" type="text/javascript"></script>
		<script src="js/validate/jquery.validate.js"
			type="text/javascript"></script>
		<script src="js/validate/messages_cn.js" type="text/javascript"></script>
		<script>
		$(document).ready(function() {
			//聚焦第一个输入框
			$("#id").focus();
			//为inputForm注册validate函数
			$("#inputForm").validate({
				rules: {
					username: {
						required: true,
						remote: "userAction.do?method=checkUserName&oldUserName=" + encodeURIComponent('${model.username}')
					},
					password: {
						required: true,
						minlength:3
					},
					passwordConfirm: {
						equalTo:"#password"
					}
				},
				messages: {
					username: {
						remote: "用户登录名已存在"
					},
					passwordConfirm: {
						equalTo: "输入与上面相同的密码"
					}
				}
			});
		});
	</script>
	</head>

	<body>
		<div id="doc3">
			<%@ include file="/common/header.jsp"%>
			<div id="bd">
				<div id="yui-main">
					<div class="yui-b">
		<form id="inputForm" action="${ctx}/userAction.do?method=updateUser" method="post">
		<table class="noborder">
			<input name="id" type="hidden" value="${model.id }" >	
			<tr>
			<td>用户ID</td>
			<td>
			<input name="id" type="text" value="${model.id }" readonly>
			</td>
			</tr>
			<tr>
									<td>
										用户名：
									</td>
									<td>
										<input id="username" name="username" type="text" value="${model.username }">
										<font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td>
										密码：
									</td>
									<td>
										<input id="password" name="password" type="password" value="${model.password }">
										<font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td>
										确认密码：
									</td>
									<td>
										<input id="passwordConfirm" name="passwordConfirm" type="password" value="${model.password }">
										<font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td>
										状态:
									</td>
									<td>
										<select id="status" name="status">
											<option value="1">启用</option>
											<option value="0">不启用</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										描述:
									</td>
									<td>
										<input id="descn" name="descn" type="text" value="${model.descn }">
									</td>
								</tr>
			<tr>
			</tr>
				
		</table>
			<input type="submit" value="修改" ><input type="button" value="返回" onclick="gotoCancel()">
		</form>
		</div>
				</div>
			</div>
			<%@ include file="/common/footer.jsp"%>
		</div>
	</body>
	<script type="text/javascript">
	
	function gotoCancel(){
			document.forms[0].action="userAction.do?method=listUser";
	   		document.forms[0].submit();
	}
	
	</script>
</html>
