<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加页面</title>

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
<form action="" method="post">
		<table table width="100%" align="center" cellspacing="0" cellpadding="0"
				border="1" bordercolor="#adc9d7" bordercolordark="#FFFFFF">
			<tr>
			<td>UUID</td>
			<td>
			<input name="uuid" type="text" value="${model.uuid }" >
			</td>
			</tr>
			<tr>
			<td>学号</td>
			<td>
			<input name="snum" type="text" value="${model.snum }" ><font color="red">*</font>
			</td>
			</tr>
			<tr>
			<td>年级</td>
			<td>
			<input name="grade" type="text" value="${model.grade }" ><font color="red">*</font>
			</td>
			</tr>
			<tr>
			<td>班级号</td>
			<td>
			<input name="cnum" type="text" value="${model.cnum }" ><font color="red">*</font>
			</td>
			</tr>
			<tr>
			</tr>
				
		</table>
			<input type="button" value="保存" onclick="gotoSubmit()"><input type="button" value="返回" onclick="gotoCancel()">
		</form>
		</div>
				</div>
			</div>
			<%@ include file="/common/footer.jsp"%>
		</div>
	</body>
	<script type="text/javascript">
	
		function gotoCancel(){
			document.forms[0].action="gradeAction.do?method=listGrade";
	   		document.forms[0].submit();
	}
	
			function gotoSubmit(){
			
			document.forms[0].action="gradeAction.do?method=addGrade";
	   		document.forms[0].submit();
	}
	</script>
</html>
