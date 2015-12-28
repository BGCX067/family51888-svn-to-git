<% @ Control  language="c#" Inherits="PageAdmin.nav_zdymodel" %>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%if(Zdy_Tag==0){%><div id="nav_<%=Nav_Id%>" <%=Nav_box_style%> class="nav_box nav_box_<%=Query_Table%>">
<%if(Nav_Header=="" && Title_Show=="1"){%>
<div <%=Nav_titlebox_style%> class="nav_title"><span <%=Nav_title_style%> class="nav_sign"><%=Nav_title%></span><span <%=Nav_more_style%> class="nav_more"><%=More_Url%></span></div>
<%}else{Response.Write(Nav_Header);}%>
<div id="nav_content_<%=Nav_Id%>" <%=Nav_content_style%> class="nav_content">
<%}%><%conn.Open();%>{pa:Model_Content}<%conn.Close();%>
<%if(Zdy_Tag==0){%></div>
</div><%}%>