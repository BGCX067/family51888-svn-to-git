<% @ Control language="c#" Inherits="PageAdmin.sublanmu_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="sublanmu_box" id="sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_site" id="sublanmu_site"><ul><li class="sublanmu_site_1"><%=Sublanmu_Site%></li><li class="sublanmu_site_2"><%=Sublanmu_Name%></li></ul></div>
<div class="sublanmu_content"><%=Introduct%><asp:PlaceHolder id="P_Search" Runat="server"/>
<%conn.Open();if(IsSearch==0){%><ul class="tw_article">
<% 
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
dr=dt.Rows[i];
%>
<li>
<span class="pic"><a href="<%=Detail_Url(dr)%>" target="<%=Target%>"><img src="<%=dr["titlepic"]%>" border="0" style="<%=TitlePic_Size%>"></a></span>
<span class="title"><a href="<%=Detail_Url(dr)%>" target="<%=Target%>" title="<%=Server.HtmlEncode(dr["title"].ToString())%>" style="<%=dr["pa_style"]%>"><%=SubStr(dr["title"].ToString(),Title_Num,true)%></a></span>
<p class="introduct"><%=dr["pa_introduct"]%></p>
</li>
<%
 }
%>
</ul>
<%}conn.Close();%>
<%if(PageCount>1)
{
string PageHtml="<div id=\"sublanmu_page\" class=\"sublanmu_page\">";
string[] PageSign=HttpContext.GetGlobalResourceObject("pageadmin","sublanmu_page").ToString().Split(',');
if(CurrentPage>1)
{
 PageHtml+="<a href=\""+GoPage(1)+"\">"+PageSign[0]+"</a>"; //首页
 PageHtml+=" <a href=\""+GoPage(CurrentPage-1)+"\">"+PageSign[1]+"</a>"; //上一页
}

 int p=8; //表示开始时显示的页码总数
 int M=4; //超过p页后左右两边显示页码数
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
        PageHtml+=" <span class=\"c\">"+i.ToString()+"</span>";
      }
    else
      {
       PageHtml+=" <a href=\""+GoPage(i)+"\">"+i.ToString()+"</a>";
      }
    }
  }
 else
  {
    //PageHtml+=" <a href=\""+GoPage(CurrentPage-1)+"\">1...</a>";
    LastPage=CurrentPage+M;
    if(LastPage>PageCount)
     {
       LastPage=PageCount;
     }
    for(int i=(CurrentPage-M);i<=LastPage;i++)
    {
     if(CurrentPage==i)
      {
        PageHtml+=" <span class=\"c\">"+i.ToString()+"</span>";
      }
    else
      {
       PageHtml+=" <a href=\""+GoPage(i)+"\">"+i.ToString()+"</a>";
      }
    }

  }

if(CurrentPage<PageCount)
{
  if(LastPage<PageCount)
   {
     PageHtml+=" <a href=\""+GoPage(LastPage+1)+"\">...</a>";
   }
  PageHtml+=" <a href=\""+GoPage(CurrentPage+1)+"\">"+PageSign[2]+"</a>";  //下一页
  PageHtml+=" <a href=\""+GoPage(PageCount)+"\">"+PageSign[3]+"</a>";     //尾页
}
PageHtml+=" <span>"+String.Format(HttpContext.GetGlobalResourceObject("pageadmin","sublanmu_page_info").ToString(),CurrentPage,PageCount,RecordCount)+"</span>"; //记录页次
PageHtml+="</div>";
Response.Write(PageHtml);
}%>
</div>
</div>
