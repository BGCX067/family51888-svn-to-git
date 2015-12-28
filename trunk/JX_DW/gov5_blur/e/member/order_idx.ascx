<% @  Control Language="c#" Inherits="PageAdmin.order_idx"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 我的订单</li>
<li class="current_location_2">我的订单</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server">
 <table border="0" cellspacing="0" cellpadding="0" align="center" class="member_table">
    <tr>
      <td align=center  class="memlist_header_item" width="5%">序号</td> 
      <td align=center  class="memlist_header_item" width="35%">订单号</td> 
      <td align=center  class="memlist_header_item" width="10%">付款状态</td> 
      <td align=center  class="memlist_header_item" width="10%">发货状态</td> 
      <td align=center  class="memlist_header_item" width="20%">订购日期</td>
      <td align=center  class="memlist_header_item_last" width="20%">操作</td>
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">
 <ItemTemplate>
   <tr>
      <td align=center height="25px" class="memlist_item"><%=i++%></td> 
      <td align=center class="memlist_item"><a href='/e/order/orderview.aspx?orderid=<%#DataBinder.Eval(Container.DataItem,"order_id")%>' target='orderview'><%#DataBinder.Eval(Container.DataItem,"order_id")%></a></td> 
      <td align=center class="memlist_item"><asp:Image src="/e/images/public/state_1.gif" title="付款状态:已付款" runat="server" CssClass="order_state_image" visible='<%#Get_State(DataBinder.Eval(Container.DataItem,"paystate").ToString())%>'/>  <asp:Image  title="付款状态:未付款"  src="/e/images/public/state_0.gif" runat="server" CssClass="order_state_image"   visible='<%#!Get_State(DataBinder.Eval(Container.DataItem,"paystate").ToString())%>'/></td> 
      <td align=center class="memlist_item"><asp:Image src="/e/images/public/state_1.gif" title="发货状态:已发货" runat="server" CssClass="order_state_image"  visible='<%#Get_State(DataBinder.Eval(Container.DataItem,"sendstate").ToString())%>'/> <asp:Image title="发货状态:未发货" src="/e/images/public/state_0.gif" runat="server" CssClass="order_state_image"  visible='<%#!Get_State(DataBinder.Eval(Container.DataItem,"sendstate").ToString())%>'/></td> 
      <td align=center class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
      <td align=center class="memlist_item_last">
     <asp:HyperLink Text="详细" id="Hy_List" runat="server" NavigateUrl='<%#Get_Url("mem_odlst",DataBinder.Eval(Container.DataItem,"order_id").ToString())%>' />&nbsp;
     <asp:LinkButton Text="删除" id="Delete" runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"order_id")%>' OnCommand="Data_Delete" />
     <asp:Label Id="Lb_Paystate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"paystate")%>' Visible="false" />
    </td>
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

</form>
</div>
</div>
