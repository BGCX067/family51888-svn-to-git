<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.notepress.util.error.ErrorUtils"%>
<%
	String message = (String) request.getAttribute("Message");
	if (message == null) {
		out.print("{\"success\":true,\"result\":true,\"msg\":\"" + ErrorUtils.getError().getNpc003() + "\",\"data\":"
				+ request.getAttribute("data") + "}");
	} else {
		out.print("{\"success\":true,\"result\":false,\"msg\":\"" + message + "\"}");
	}
%>
