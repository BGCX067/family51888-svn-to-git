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
<%}%><%conn.Open();%><table width="100%" border="0" cellpadding="0" cellspacing="0" class="letter">
 <tr class="head">
 <td width="70%" align="center">主题</td>
 <td width="15%" align="center">提交时间</td>
 <td width="15%" align="center">回复状态</td>
</tr>  
<% 
string style;
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
dr=dt.Rows[i];
%>
<tr class="item">
    <td height="15px"><a href="<%=Detail_Url(dr)%>" target="<%=Target%>" title="<%=Server.HtmlEncode(dr["title"].ToString())%>" class="title"><%=SubStr(dr["title"].ToString(),Title_Num,true)%></a></td>
    <td align="center"> <%=((DateTime)dr["thedate"]).ToString("MM-dd")%></td>
    <td align="center"><%=dr["reply_state"].ToString()=="1"?"已回复":"待处理"%></td>
  </tr>
<%
 }
%>
</table>
<%conn.Close();%>
<%if(Zdy_Tag==0){%></div><div class="module_footer"><span class="l"></span><span class="r"></span></div>
</div>
</div><%=Module_EndHtml%><%}%>