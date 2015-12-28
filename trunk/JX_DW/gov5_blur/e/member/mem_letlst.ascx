<% @  Control Language="c#" Inherits="PageAdmin.mem_letlst"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 信息回复</li>
<li class="current_location_2">信息回复</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server">
 <table border="0" cellspacing="0" cellpadding="0"  align="center" width=100%  class="member_table"> 
    <tr>
      <td align=center  class="memlist_header_item" width="45%">标题</td> 
      <td align=center  class="memlist_header_item" width="10%">分类</td> 
      <td align=center  class="memlist_header_item" width="10%">发布人</td> 
      <td align=center  class="memlist_header_item" width="15%">发布时间</td> 
      <td align=center  class="memlist_header_item" width="10%"><select id="s_type" onchange="Go()">
<option value="">状态</option>
<option value="1">已回复</option>
<option value="0">未回复</option>
</select></td> 
      <td align=center  class="memlist_header_item_last" width="10%">操作</td> 
    </tr>
<asp:Repeater id="P_Data" runat="server" OnItemDataBound="P1_Bound">      
 <ItemTemplate>
      <tr>
       <td align=left class="memlist_item"><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a href='<%#DetailUrl(DataBinder.Eval(Container.DataItem,"site_id").ToString(),DataBinder.Eval(Container.DataItem,"static_dir").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"subLanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"checked").ToString())%>' target="dataview" title="<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%>"><%#SubStr(DataBinder.Eval(Container.DataItem,"title").ToString(),60,true)%></a></td> 
       <td align=center class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"table_name").ToString()%></td>
       <td align=center class="memlist_item"><%#GetUserName(DataBinder.Eval(Container.DataItem,"username").ToString())%></td>
       <td align=center class="memlist_item" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td> 
       <td align=center class="memlist_item"><%#GetReplayState(DataBinder.Eval(Container.DataItem,"reply_state").ToString())%></td> 
       <td align=center class="memlist_item_last"><a href="<%#Get_Url("mem_letdtl",DataBinder.Eval(Container.DataItem,"thetable").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString())%>">回复</a></td>
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
   </asp:DropDownList>页
</div>

<br>
</form>
</div>
</div>
<script type="text/javascript">

var obj_type=document.getElementById("s_type");
var Sid="<%=Request.QueryString["s"]%>";
var SType="<%=Request.QueryString["stype"]%>";
if(obj_type!=null){obj_type.value=SType;}

function Go()
  { 
   location.href="?s="+Sid+"&type=mem_letlst&stype="+obj_type.value;
  }
</script>
