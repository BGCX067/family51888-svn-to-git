<% @  Control Language="c#" Inherits="PageAdmin.mem_signlst"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 信息签收</li>
<li class="current_location_2">信息签收</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server" name="datalist">

<table border=0 cellpadding=0 cellspacing=0 width=100% class="member_table">
         <tr>
           <td width=45% align=center class="memlist_header_item">标题</td>
           <td width=10% align=center class="memlist_header_item">分类</td>
           <td width=15% align=center class="memlist_header_item">发布时间</td>
           <td width=10% align=center class="memlist_header_item">签收状态</td>
           <td width=10% align=center class="memlist_header_item">是否签收</td>
           <td width=10% align=center class="memlist_header_item_last">签收</td>
         </tr>
      <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr>
                  <td align=left class="memlist_item"><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a href='<%#DetailUrl(DataBinder.Eval(Container.DataItem,"site_id").ToString(),DataBinder.Eval(Container.DataItem,"static_dir").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"subLanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"checked").ToString())%>' target="dataview" title="<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%>"><%#SubStr(DataBinder.Eval(Container.DataItem,"title").ToString(),50,true)%></a></td>
                  <td align=center  class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"table_name")%></td>
                  <td align=center class="memlist_item" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center  class="memlist_item_last"><%#GetState((DateTime)DataBinder.Eval(Container.DataItem,"sign_enddate"))%></td>
                  <td align=center  class="memlist_item_last"><img src="/e/images/public/<%#GetSignState(DataBinder.Eval(Container.DataItem,"thetable").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString())%>.gif"></td>
                  <td align=center  class="memlist_item_last"><a href=# onclick="Sign('<%#DataBinder.Eval(Container.DataItem,"thetable")%>','<%#DataBinder.Eval(Container.DataItem,"id")%>')">签收</a></td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
 </table>
<div class="sublanmu_page">
<span>共<asp:Literal id="Lblrecordcount"  Text=0 runat="server" />条记录</span>
<span>页次：<asp:Literal id="Lblcurrentpage"  runat="server" />/<asp:Literal id="LblpageCount"  runat="server" /></span>
<asp:LinkButton id="First" CssClass="link" CommandName="First"  OnCommand="Page_change"  runat="server" Text="首页"/>
<asp:LinkButton id="Prev"  CssClass="link"  CommandName="Prev"  OnCommand="Page_change"  runat="server" Text="上一页"/>
<asp:LinkButton id="Next"  CssClass="link"  CommandName="Next"  OnCommand="Page_change"  runat="server" Text="下一页"/>
<asp:LinkButton id="Last"  CssClass="link"  CommandName="Last"  OnCommand="Page_change"  runat="server" Text="尾页"/>
转到：<asp:DropDownList id="Dp_page" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_select">
</asp:DropDownList>页 <input text="text" id="s_keyword" size="10" class="tb"> <input type="button" value="搜索" class="button" onclick="Go()">
</div>
</form>
<script type="text/javascript">

 var obj_sort=document.getElementById("sortid");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");

 var Sid="<%=Request.QueryString["s"]%>";

 var Sortid="<%=Request.QueryString["sortid"]%>";

 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_sort!=null && Sortid!="0"){obj_sort.value=Sortid;}

 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

 function Go()
  { 
   location.href="?type=mem_signlst&s="+Sid+"&keyword="+escape(obj_keyword.value);
  }

 function Sign(Table,Id)
  {
   IDialog("信息签收","/e/member/sign.aspx?table="+Table+"&id="+Id,800,"90%");
  } 

</script>
</div>
</div>
