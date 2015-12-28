<% @ Control language="c#" Inherits="PageAdmin.module_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%if(Zdy_Tag==0){%><%=Module_StartHtml%>
<div id="module_<%=Module_Id%>" <%=Module_box_style%> class="module_box<%=Layout%> module_box_<%=Query_Table%>">
<div <%=Module_box_1_style%> class="module_box_1<%=Layout%>">
<%if(Title_Show=="1"){%>
<div <%=Module_titlebox_style%> class="module_title"><span <%=Module_title_style%> class="module_sign"><%=Module_Title%></span><span <%=Module_more_style%> class="module_more"><%=More_Url%></span></div>
<%}if(Module_Header!=""){%><%=Module_Header%><%}%>
<div id="module_content_<%=Module_Id%>" <%=Module_content_style%> class="module_content">
<%}%><%conn.Open();%><ul class="bszn">
<% 
DataTable dt=Get_Data(); 
DataRow dr; 
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
%>
<li>
<span class="title"><%=dr["title"].ToString()%></span>
<a href="<%=Detail_Url(dr)%>" target="bszn">办事指南</a> → <a href="<%=Detail_Url(dr)%>#bgxz" target="bszn">表格下载</a><%=dr["pa_wszx"].ToString()==""?"":" → <a href='"+dr["pa_wszx"].ToString()+"' target='wszx'>在线咨询</a>"%> → 受理机构：<%=dr["pa_bljg"]%>
</li> 
<%
 }
%>
</ul><%conn.Close();%>
<%if(Zdy_Tag==0){%></div><div class="module_footer"><span class="l"></span><span class="r"></span></div>
</div>
</div><%=Module_EndHtml%><%}%>