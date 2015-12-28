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
<%}%><%conn.Open();%><div class="hh_article">
<ul>
<% 
string pic="",istop="0";
DataTable dt;
DataRow dr;
dt=Get_Data();
for(int i=0;i<dt.Rows.Count;i++)
 {
dr=dt.Rows[i];
pic=dr["titlepic"].ToString();
istop=dr["istop"].ToString();
%>
<%if(istop=="1" && i==0){%>
<li class="tw">
<%if(pic!=""){%><span class="pic"><a href="<%=Detail_Url(dr)%>" target="<%=Target%>"><img src="<%=pic%>" border="0" style="<%=TitlePic_Size%>"></a></span>
<%}%><span class="title"><a href="<%=Detail_Url(dr)%>" target="<%=Target%>" title="<%=Server.HtmlEncode(dr["title"].ToString())%>" style="<%=dr["pa_style"]%>"><%=SubStr(dr["title"].ToString(),Title_Num,true)%></a></span>
<p class="introduct"><%=SubStr(dr["pa_introduct"].ToString(),100,true)%></p>
</li>
<%}
else
{%>
<li class="normal"><span class="title">
<a href="<%=Detail_Url(dr)%>" target="<%=Target%>" title="<%=Server.HtmlEncode(dr["title"].ToString())%>" style="<%=dr["pa_style"]%>"><%=SubStr(dr["title"].ToString(),Title_Num,true)%></a></span>
<span class="date"><%=((DateTime)dr["thedate"]).ToString("MM-dd")%></span>
<span class="clear"></span>
</li>
<%
}
 }
%>
</ul></div><%conn.Close();%>
<%if(Zdy_Tag==0){%></div><div class="module_footer"><span class="l"></span><span class="r"></span></div>
</div>
</div><%=Module_EndHtml%><%}%>