<% @  Control Language="c#" Inherits="PageAdmin.order_lst"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; <a href="index.aspx?type=mem_odidx&s=<%=Request.QueryString["s"]%>">我的订单</a> &gt; 订单明细</li>
<li class="current_location_2">订单明细</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server">
 <table border="0" cellspacing="0" cellpadding="0" width="98%" align="center">
    <tr>
      <td height=25px style="font-weight:bold" > 订单号：<%=Request.QueryString["detailid"]%>[<a href='/e/order/orderview.aspx?orderid=<%=Request.QueryString["detailid"]%>' target='orderview'>查看</a>]</td> 
    </tr>
 </table>

 <table border="0" cellspacing="0"  align="center" class="member_table">
    <tr>
      <td align=center  class="memlist_header_item" width="5%">序号</td> 
      <td align=center  class="memlist_header_item" width="30%">名称</td> 
      <td align=center  class="memlist_header_item" width="10%">订购数量</td> 
      <td align=center  class="memlist_header_item" width="10%">赠送积分</td>
      <td align=center  class="memlist_header_item" width="10%">您的价格</td>
      <td align=center  class="memlist_header_item" width="10%">总计</td>
      <td align=center  class="memlist_header_item" width="10%">状态</td>
      <td align=center  class="memlist_header_item_last" width="15%">操作</td>
    </tr>
<asp:Repeater id="P1" runat="server" OnItemDataBound="P1_Bound">
 <ItemTemplate>
   <tr>
      <td align=center  class="memlist_item"><%#ItemIndex+1%></td> 
      <td align=center  class="memlist_item" align=center><a href="<%#Get_DetailUrl(DataBinder.Eval(Container.DataItem,"thetable").ToString(),DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" target="_blank"><img src="<%#Get_Field(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"titlepic",DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" border=0 class="order_pdimage"><%#DataBinder.Eval(Container.DataItem,"title")%></a></td>
      <td align=center  class="memlist_item"><asp:TextBox id="Tb_Num" Text='<%#DataBinder.Eval(Container.DataItem,"num")%>' runat="server" size="3" maxlength="10"/></td> 
      <td align=center  class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"count_sendpoint")%></td>
      <td align=center  class="memlist_item">￥<asp:Label id="Lb_MPrice" Text='<%#DataBinder.Eval(Container.DataItem,"member_price")%>' runat="server" /></td>
      <td align=center  class="memlist_item">￥<%#DataBinder.Eval(Container.DataItem,"tj")%></td>
      <td align=center  class="memlist_item"><%#Get_PdState(DataBinder.Eval(Container.DataItem,"state").ToString())%></td>
      <td align=center class="memlist_item_last">
     <asp:LinkButton Text="修改" id="Edit" runat="server" CommandName='<%#ItemIndex%>'  OnCommand="Data_Update" />
     <asp:LinkButton Text="删除" id="Delete" runat="server" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="Data_Delete" />
     <asp:Label Id="Lb_Paystate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"paystate")%>' Visible="false" />
     <asp:Label Id="Lb_Id" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Visible="false" />
    </td>
    </tr>
 </ItemTemplate>
</asp:Repeater>
 </table>

 <table border="0" cellspacing="0" cellpadding="0" width="98%" align="center">
   <tr>
      <td height=40px   align="left">
赠送积分总计：<asp:Label id="Lb_Point"  runat="server" style="Font-Size:15px;font-weight:bold"/>&nbsp;&nbsp;订单总计：￥<asp:Label id="Lb_Tj"  runat="server" style="color:#ff0000;Font-Size:15px;font-weight:bold"/>&nbsp;&nbsp;
配送费：￥<asp:Label id="Lb_send" runat="server" style="color:#ff0000;Font-Size:15px;font-weight:bold"/> (<asp:Label id="Lb_sendway" runat="server"/>)&nbsp;&nbsp;总费用：￥<asp:Label id="Lb_All"  runat="server"  style="color:#ff0000;Font-Size:15px;font-weight:bold"/>
      &nbsp;<asp:Button Text="付 款" id="PayOrder" onclick="Pay_Order"  runat="server" cssclass="bt" /> 
  </td> 
   </tr>
   <tr>
      <td align="center"><asp:label id="Lb_Empty" Text="此订单为空！" runat="server" visible="false" /></td> 
   </tr>
 </table>
</form>
</div>
</div>
<script type="text/javascript">
function payconfirm()
{
if(confirm("是否确定?确定后将从您的可用金额中扣除对应金额!"))
 {
  return true;
 }
else
 {
  return false;
 }
}
</script>