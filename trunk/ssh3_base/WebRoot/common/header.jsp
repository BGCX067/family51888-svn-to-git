<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div id="hd">
	<div id="title">
		<h1>Web示例   --CRUD管理界面演示</h2>
	</div>
	<div id="menu">
		<ul>
			<li><a href="${ctx}/gradeAction.do?method=listGrade">班级列表</a></li>
			<li><a href="${ctx}/userAction.do?method=listUser">用户列表</a></li>
			<li><a href="${ctx}/account/role.action">角色列表</a></li>
			<li><a href="${ctx}/account/role.action">权限列表</a></li>
			<li><a href="${ctx}/j_spring_security_logout">退出登录</a></li>
		</ul>
	</div>
</div>