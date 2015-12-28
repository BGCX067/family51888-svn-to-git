<% @ Page language="c#" Inherits="PageAdmin.ajax_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%conn.Open();%><div class="article">
<ul>
<% 
DataTable dt;
DataRow dr;
dt=Get_Data();
for(int i=0;i<dt.Rows.Count;i++)
 {
dr=dt.Rows[i];
%>
<li><span class="title">
<a href="<%=Detail_Url(dr)%>" target="_blank" title="<%=Server.HtmlEncode(dr["title"].ToString())%>" style="<%=dr["pa_style"]%>"><%=SubStr(dr["title"].ToString(),100,true)%></a></span>
<span class="date"><%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%></span>
<span class="clear"></span>
</li>
<%
 }
%>
</ul></div>
<%conn.Close();%><asp:PlaceHolder id="PagePanel" runat="server">
<div class="sublanmu_page">
<%
string[] PageSign=HttpContext.GetGlobalResourceObject("pageadmin","sublanmu_page").ToString().Split(',');
if(CurrentPage>1){%>
<a href="javascript:rajax_<%=ModelId%>(1)"><%=PageSign[0]%></a><%
 }
 int p=10; //表示开始时显示的页码总数
 int M=5; //超过p页后左右两边显示页码数
 int LastPage=1;
 if(CurrentPage<p)
  {
    LastPage=p;
    if(LastPage>PageCount)
     {
       LastPage=PageCount;
     }
    for(int i=1;i<=LastPage;i++)
    {
     if(CurrentPage==i)
      {
        Response.Write(" <span class=\"c\">"+i.ToString()+"</span>");
      }
    else
      {
        Response.Write(" <a href=\"javascript:rajax_"+ModelId+"("+i+")\">"+i.ToString()+"</a>");
      }
    }
  }
 else
  {
    LastPage=CurrentPage+M;
    if(LastPage>PageCount)
     {
       LastPage=PageCount;
     }
    for(int i=(CurrentPage-M);i<=LastPage;i++)
    {
     if(CurrentPage==i)
      {
        Response.Write(" <span class=\"c\">"+i.ToString()+"</span>");
      }
    else
      {
        Response.Write(" <a href=\"javascript:rajax_"+ModelId+"("+i+")\">"+i.ToString()+"</a>");
      }
    }

  }

if(CurrentPage<PageCount)
{
if(LastPage<PageCount){Response.Write(" <a href=\"javascript:rajax_"+ModelId+"("+(LastPage+1)+")\">...</a>");}
%>
<a href="javascript:rajax_<%=ModelId%>(<%=PageCount%>)"><%=PageSign[3]%></a>
<%}%>
<span><%=String.Format(HttpContext.GetGlobalResourceObject("pageadmin","sublanmu_page_info").ToString(),CurrentPage,PageCount,RecordCount)%></span>
</div>
</asp:PlaceHolder>