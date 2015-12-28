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
<%}%><%conn.Open();%><div id="m_<%=Module_Id%>" style="overflow:hidden;width:100%" class="article">
<table border=0 align=center cellpadding="0" cellspacing="0">
<tr>
<%
string pic="";
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
 dr=dt.Rows[i];
 pic=dr["titlepic"].ToString();
 if(pic==""){continue;}
%>
<td>
<a href="<%=Detail_Url(dr)%>" target="<%=Target%>"><img src="<%=pic%>" border="0" style="<%=TitlePic_Size%>"></a>
<br>
<a href="<%=Detail_Url(dr)%>" target="<%=Target%>" title="<%=Server.HtmlEncode(dr["title"].ToString())%>"><%=SubStr(dr["title"].ToString(),Title_Num,true)%></a></span>
</td>
<%
 }
%>
</tr>
</table>
</div>
<script type="text/javascript">
var m<%=Module_Id%>=new Marquee("m_<%=Module_Id%>","left",1,null,null,50,null,null,0);
</script>
<%conn.Close();%>
<%if(Zdy_Tag==0){%></div><div class="module_footer"><span class="l"></span><span class="r"></span></div>
</div>
</div><%=Module_EndHtml%><%}%>