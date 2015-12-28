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
<%}%><%conn.Open();%><table width="100%" border="0" cellpadding="0" cellspacing="0" class="letter_list">
 <tr class="head">
 <td width="70%">&nbsp;&nbsp;&nbsp;&nbsp;<b>主题</b></td>
 <td width="15%" align="center"><b>提交时间</b></td>
 <td width="15%" align="center"><b>回复状态</b></td>
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