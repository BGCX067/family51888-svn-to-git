<% @ Control language="c#" Inherits="PageAdmin.spc_newlist" src="spc_newlist.ascx.cs"%>
<div class="spc_location">当前位置：<a href="/e/space/?uid=<%=UID%>"><%=UserName%>的空间</a> &gt; 首页</div>
<asp:Repeater Id="P1" Runat="server" OnItemDataBound="Data_Bound"><ItemTemplate>
<div class="module_box">
<div class="module_title"><span class="module_sign"><%#DataBinder.Eval(Container.DataItem,"table_name")%></span><span class="module_more"><a href="/e/space/?uid=<%=UID%>&tid=<%#DataBinder.Eval(Container.DataItem,"id").ToString()%>">more</a></span></div>
<div class="module_content"><ul class="list">
  <asp:Repeater Id="P2" Runat="server">
    <ItemTemplate>
    <li><span class="title"><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a href="<%#DetailUrl(DataBinder.Eval(Container.DataItem,"site_id").ToString(),DataBinder.Eval(Container.DataItem,"Static_dir").ToString(),DataBinder.Eval(Container.DataItem,"Static_file").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"sublanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"html").ToString())%>" target="myinfo"><%#SubStr(DataBinder.Eval(Container.DataItem,"title").ToString(),60,true)%></a><span class="clicks">(点击:<%#DataBinder.Eval(Container.DataItem,"clicks")%>)</span></span><span class="date"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></span></li>
  </ItemTemplate>
  </asp:Repeater></ul>
</div>
</div>
<asp:Label id="Lb_Table" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>' Visible="false"/>
</ItemTemplate>
</asp:Repeater>