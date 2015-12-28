<% @ Control language="c#" Inherits="PageAdmin.sublanmu_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="sublanmu_box" id="sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_site" id="sublanmu_site"><ul><li class="sublanmu_site_1"><%=Sublanmu_Site%></li><li class="sublanmu_site_2"><%=Sublanmu_Name%></li></ul></div>
<div class="sublanmu_content"><%=Introduct%><asp:PlaceHolder id="P_Search" Runat="server"/>
<%conn.Open();if(IsSearch==0){%><table width="100%" border="0" cellpadding="0" cellspacing="0" class="letter_list">
 <tr class="head">
 <td width="60%" align="center"><b>主题</b></td>
 <td width="10%" align="center"><b>类型</b></td>
 <td width="20%" align="center"><b>来信时间</b></td>
 <td width="10%" align="center"><b>回复状况</b></td>
</tr>  
<% 
string style;
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
dr=dt.Rows[i];
if(((i+1)%2)==0)
 {
  style="style='background-color:#eeeeee'";
 }
else
 {
  style="";
 }

%>
<tr class="item" <%=style%>>
    <td height="15px"><a href="<%=Detail_Url(dr)%>" target="<%=Target%>" title="<%=Server.HtmlEncode(dr["title"].ToString())%>" class="title"><%=SubStr(dr["title"].ToString(),Title_Num,true)%></a></td>
    <td align="center"><%=Get_SortName("letter",int.Parse(dr["sort_id"].ToString()),"_blank")%></td>
    <td align="center"><%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%></td>
    <td align="center"><%=dr["reply_state"].ToString()=="1"?"已回复":"待处理"%></td>
  </tr>
<%
 }
%>
</table>
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
