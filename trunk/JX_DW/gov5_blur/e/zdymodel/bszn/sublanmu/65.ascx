﻿<% @ Control language="c#" Inherits="PageAdmin.sublanmu_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="current_location" id="current_location"><ul><li class="current_location_1"><%=Current_Location%></li><li class="current_location_2"><%=Current_Name%></li></ul></div>
<div class="sublanmu_box" id="sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content"><%=Introduct%><asp:PlaceHolder id="P_Search" Runat="server"/>
<%if(IsSearch==0){conn.Open();%><ul class="bszn">
<% 
DataTable dt=Get_Data(); 
DataRow dr; 
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
%>
<li>
<span class="title"><a href="<%=Detail_Url(dr)%>" target="<%=Target%>"><%=dr["title"].ToString()%></a></span>
<a href="<%=Detail_Url(dr)%>" target="<%=Target%>">办事指南</a><%if(dr["pa_fj"].ToString()!="0"){%> → <a href="<%=Detail_Url(dr)%>#bgxz" target="<%=Target%>">表格下载</a><%}%><%=dr["pa_wszx"].ToString()==""?"":" → <a href='"+dr["pa_wszx"].ToString()+"' target='wszx'>在线咨询</a>"%> → 受理机构：<%=dr["pa_bljg"]%>
</li> 
<%
 }
%>
</ul><%conn.Close();}
if(PageCount>1)
{
string PageHtml="<div id=\"sublanmu_page\" class=\"sublanmu_page\">";
if(CurrentPage>1)
{
 if(APage_LinkText[0]!=""){PageHtml+="<a href=\""+GoPage(1)+"\">"+APage_LinkText[0]+"</a>";} //首页
 if(APage_LinkText[1]!=""){PageHtml+=" <a href=\""+GoPage(CurrentPage-1)+"\">"+APage_LinkText[1]+"</a>";} //上一页
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
  if(APage_LinkText[2]!=""){PageHtml+=" <a href=\""+GoPage(CurrentPage+1)+"\">"+APage_LinkText[2]+"</a>";}  //下一页
  if(APage_LinkText[3]!=""){PageHtml+=" <a href=\""+GoPage(PageCount)+"\">"+APage_LinkText[3]+"</a>";}     //尾页
}
if(Page_LinkInfo!=""){PageHtml+=" <span>"+String.Format(Page_LinkInfo,CurrentPage,PageCount,RecordCount)+"</span>";} //记录页次
PageHtml+="</div>";
Response.Write(PageHtml);
}%>
</div>
</div>