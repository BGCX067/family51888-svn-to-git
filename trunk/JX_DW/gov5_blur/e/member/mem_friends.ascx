<% @  Control Language="c#" Inherits="PageAdmin.mem_friends"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="/member/index.aspx?language=<%=Request.QueryString["language"]%>">会员中心</a> &gt; 好友管理</li>
<li class="current_location_2">好友管理</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_msg")%>'>收件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgout")%>'>发件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgsend")%>'>发信息</a></li>
 <li class="c"><a href='<%=Get_Url("mem_friends")%>'>我的好友</a></li>
 <li><a href='<%=Get_Url("mem_friendssort")%>'>好友分类</a></li>
 <li><a href='<%=Get_Url("mem_blacklist")%>'>黑名单</a></li>
</ul></div>
<form runat="server">
<table border="0" cellspacing="0" cellpadding="0"  align="center" class="member_table_1"> 
    <tr>
      <td align=center  class="memlist_header_item" width="20%">用户名</td>
      <td align=center  class="memlist_header_item" width="20%"><asp:DropDownList id="Dl_Sort" runat="server" DataTextField="sort_name" DataValueField="id" AutoPostBack="true"  OnSelectedIndexChanged="PageAdmin_Sort_Change" /></td> 
      <td align=center  class="memlist_header_item" width="20%">备注</td> 
      <td align=center  class="memlist_header_item" width="20%">添加时间</td> 
      <td align=center  class="memlist_header_item_last" width="20%">操作</td> 
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">      
 <ItemTemplate>
      <tr>
       <td align=center  class="memlist_item"><a href='<%#Get_FriendUrl("mem_friendsdtl",DataBinder.Eval(Container.DataItem,"friend_username").ToString())%>'><%#DataBinder.Eval(Container.DataItem,"friend_username")%></a></td>
       <td align=center  class="memlist_item"><%#Get_FriendSort(DataBinder.Eval(Container.DataItem,"friend_sort").ToString())%></td>  
       <td align=center  class="memlist_item"><asp:TextBox id="tb_beizhu" Text='<%#DataBinder.Eval(Container.DataItem,"friend_beizhu")%>' Runat="server" CssClass="tb " size="16" maxlength="40"/></td> 
       <td align=center  class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td> 
       <td align=center  class="memlist_item_last">
       <asp:Label  id="lb_id" runat="server" Visible="false" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' />
       <asp:LinkButton Text="更新"   runat="server"   CommandName='<%#Items%>' OnCommand="Data_Update"/>
       <asp:LinkButton Text="删除" id="Delete" runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Delete" />

      </td>
    </tr>
 </ItemTemplate>
</asp:Repeater>
 </table> 

<div class="sublanmu_page" style="display:<%=Show_Page%>">
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
         <asp:LinkButton id="First" CssClass="link" CommandName="First"  OnCommand="Page_change"  runat="server" Text="首页"/>&nbsp;
         <asp:LinkButton id="Prev"  CssClass="link"  CommandName="Prev"  OnCommand="Page_change"  runat="server" Text="上一页"/>&nbsp;
         <asp:LinkButton id="Next"  CssClass="link"  CommandName="Next"  OnCommand="Page_change"  runat="server" Text="下一页"/>&nbsp;
         <asp:LinkButton id="Last"  CssClass="link"  CommandName="Last"  OnCommand="Page_change"  runat="server" Text="尾页"/>&nbsp;
       转到：<asp:DropDownList id="Dp_page" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_select">
          </asp:DropDownList>页
</div>
<br>
<table border=0 cellpadding=0 cellspacing=2 width=98% align=center>
<tr>
<td  height=25>添加好友：<asp:DropDownList id="Dl_AddType" runat="server" >
<asp:ListItem Value="username">根据用户名</asp:ListItem>
<asp:ListItem Value="truename">根据真实姓名</asp:ListItem>
</asp:DropDownList>：<asp:TextBox  Runat="server" Id="AddName"  size="10" CssClass="tb " />&nbsp;
添加到：<asp:DropDownList id="Dl_AddSort" runat="server" DataTextField="sort_name" DataValueField="id">
<asp:ListItem Value="0">无分类</asp:ListItem>
</asp:DropDownList>
<asp:Button  Text="确定" CssClass="bt" runat="server" onclick="Data_Add"/>
<br><asp:Label id="Lberror" Runat="server"  ForeColor="#ff0000"/>
</td>
</tr>
 </td>
 <tr>
</table>
</form>
</div>
</div>