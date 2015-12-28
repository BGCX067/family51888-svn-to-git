<% @ Page language="c#"  Inherits="PageAdmin.order" src="~/e/order/order.cs"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>购物车</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script src="/e/js/order.js" type="text/javascript"></script>
<script src="/e/js/function.js" type="text/javascript"></script>
<link href="order.css" type="text/css" rel="stylesheet" />
</head>
<body class="orderbody">
<center>
<form method="post" name="order">
<br>
  <table border=0 cellpadding=0 cellspacing=0 class="order">
      <tr class="header">
         <td width=40% align="center">产品</td>
         <td width=15% align="center">会员价</td>
         <td width=10% align="center">订购数量</td>
         <td width=10% align="center">赠送积分</td>
         <td width=15% align="center">总计</td>
         <td width=10% align="center">操作</td>
        </tr>
<asp:Repeater id="List" runat="server"> 
   <ItemTemplate>  
       <tr class="item">
         <td height=25 align=center>
         <img src="<%#Get_Field(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"titlepic",DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" border=0 class="pdpic">
         <%#DataBinder.Eval(Container.DataItem,"title")%>
         </td>
         <td>￥<%#DataBinder.Eval(Container.DataItem,"member_price")%></td>
         <td align="center"><input type="textbox" name="num" value="<%#DataBinder.Eval(Container.DataItem,"num")%>" size="4" maxlength="9" onkeyup="if(isNaN(value))execCommand('undo')"></td>
         <td align="center"><%#DataBinder.Eval(Container.DataItem,"count_sendpoint")%></td>
         <td align="center"><strong>￥<%#DataBinder.Eval(Container.DataItem,"tj")%></strong></td>
         <td align="center"><input type="hidden" name="id" value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><a href="javascript:del_order(<%#DataBinder.Eval(Container.DataItem,"id")%>)">删除</a></td>
       </tr>
   </ItemTemplate> 
</asp:Repeater>
     </table>
<br>
<div align="right">
赠送积分总计：<%=Tongji_Point%>&nbsp;&nbsp;&nbsp;&nbsp;订单总计：<strong style="color:#ff0000">￥<%=Tongji%></strong>&nbsp;&nbsp;&nbsp;&nbsp
<div style="padding:10px 5px 0 0">
<input type="button" value=" 关闭窗口 " class="o_bt" onclick="wclose()">
<%if(RecordCounts>0){%>
<input type="button" value=" 更新订购数量 " class="o_bt" onclick="edit_order()">&nbsp;
<input type="button" value=" 下一步 " class="o_bt" onclick="location.href='order1.aspx?s=<%=SiteId%>&table=<%=Table%>'">
<%}%>
</div>
</div>
<input type="hidden" name="delid" value="0">
<input type="hidden" name="post" value="">
</form>
</center>
<script type="text/javascript">
<%=ServerInfo%>
function wclose()
 {
   parent.CloseDialog();
 }
</script>
</body>
</html>