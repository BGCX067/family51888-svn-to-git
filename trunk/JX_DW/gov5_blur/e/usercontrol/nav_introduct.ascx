<% @ Control  language="c#" Inherits="PageAdmin.nav_introduct" %>
<div id="nav_<%=Nav_Id%>" <%=Nav_box_style%> class="nav_box nav_box_introduct">
<%if(Title_Show=="1"){%>
<div <%=Nav_titlebox_style%> class="nav_title"><span <%=Nav_title_style%> class="nav_sign"><%=Nav_title%></span><span <%=Nav_more_style%> class="nav_more"><%=More_Url%></span></div>
<%}if(Nav_Header!=""){Response.Write(Nav_Header);}%>
<div id="nav_conent_<%=Nav_Id%>" <%=Nav_content_style%> class="nav_content">
<%=Nav_Content%><asp:PlaceHolder id="P_Zdy" runat="server"/>
</div>
</div>