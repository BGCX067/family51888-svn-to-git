<% @ Control language="c#" Inherits="PageAdmin.module_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%if(Zdy_Tag==0){%><%=Module_StartHtml%>
<div id="module_<%=Module_Id%>" class="module_box<%=Layout%>" style="width:<%=Module_Width%>;<%=Module_box_style%>">
<div class="module_box_1<%=Layout%>" style="<%=Module_box_1_style%>">
<%if(Title_Show=="1"){%>
<div class="module_title" style="<%=Module_titlebox_style%>"><span class="module_sign" style="<%=Module_title_style%>"><%=Module_Title%></span><span class="module_more" style="<%=Module_more_style%>"><%=More_Url%></span></div>
<%}if(Module_Header!=""){%><%=Module_Header%><%}%>
<div id="module_content_<%=Module_Id%>" class="module_content" style="<%=Module_content_style%>">
<%}%><%conn.Open();%><div id="m_<%=Module_Id%>" style="overflow:hidden;width:100%" class="article">
<table border=0 align=center cellpadding="0" cellspacing="0">
<tr>
<% 
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
dr=dt.Rows[i];
%>
<td>
<a href="<%=Detail_Url(dr)%>" target="<%=Target%>"><img src="<%=dr["titlepic"]%>" border="0" style="<%=TitlePic_Size%>"></a>
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
new Marquee("m_<%=Module_Id%>","left",1,null,null,50,0,null,null);
</script>
<%conn.Close();%>
<%if(Zdy_Tag==0){%></div><div class="module_footer"><span class="l"></span><span class="r"></span></div>
</div>
</div><%=Module_EndHtml%><%}%>