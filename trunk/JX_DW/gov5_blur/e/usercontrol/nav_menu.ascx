<% @ Control  language="c#"  Inherits="PageAdmin.nav_menu" %>
<div id="nav_<%=Nav_Id%>" <%=Nav_box_style%> class="nav_box nav_box_sublanmu">
<%if(Title_Show=="1"){%>
<div <%=Nav_titlebox_style%> class="nav_title"><span <%=Nav_title_style%> class="nav_sign"><%=Nav_title%></span><span class="nav_more"></span></div>
<%}if(Nav_Header!=""){Response.Write(Nav_Header);}%>
<div id="nav_menu_<%=Nav_Id%>" <%=Nav_content_style%> class="nav_menu">
<ul id="rootul_<%=Nav_Id%>"><%=SubLanmu_List%></ul>
</div>
</div>
<script type="text/javascript">
shut_allsubnav("rootul_<%=Nav_Id%>");
expand_subnav("<%=Sublanmu_Id%>","<%=ParentSublanmu%>");
</script>