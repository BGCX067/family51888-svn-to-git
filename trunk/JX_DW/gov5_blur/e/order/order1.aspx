<% @ Page language="c#"  Inherits="PageAdmin.order1" src="~/e/order/order1.cs"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>购物车</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script src="/e/js/dialog.js" type="text/javascript"></script>
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
         <td width=20% align="center">会员价</td>
         <td width=10% align="center">订购数量</td>
         <td width=10% align="center">赠送积分</td>
         <td width=20% align="center">总计</td>
        </tr>
<asp:Repeater id="List" runat="server"> 
   <ItemTemplate>  
       <tr class="item">
         <td height=25 align=center>
         <img src="<%#Get_Field(DataBinder.Eval(Container.DataItem,"thetable").ToString(),"titlepic",DataBinder.Eval(Container.DataItem,"detail_id").ToString())%>" border=0 class="pdpic">
         <%#DataBinder.Eval(Container.DataItem,"title")%>
         </td>
         <td>￥<%#DataBinder.Eval(Container.DataItem,"member_price")%></td>
         <td align="center"><%#DataBinder.Eval(Container.DataItem,"num")%></td>
         <td align="center"><%#DataBinder.Eval(Container.DataItem,"count_sendpoint")%></td>
         <td align="center"><strong>￥<%#DataBinder.Eval(Container.DataItem,"tj")%></strong></td>
       </tr>
   </ItemTemplate> 
</asp:Repeater>
     </table>

<div align="right" style="padding:10px 5px 5px 0">
赠送积分总计：<%=Tongji_Point%>&nbsp;&nbsp;&nbsp;&nbsp;订单总计：<strong style="color:#ff0000">￥<%=Tongji%></strong>&nbsp;&nbsp;&nbsp;&nbsp
</div>
<table border=0 cellpadding=0 cellspacing="0" align="center" class="order">
 <tr class="send_header"><td align="left">&nbsp;&nbsp;<strong>配送方式：</strong></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing="1" align="center" class="order">
 <asp:Repeater id="S_List" Runat="server">
   <ItemTemplate>
   <tr>
    <td align="left"  width="20%"><input name="sendway" type="radio" value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#DataBinder.Eval(Container.DataItem,"sendway")%></td>
    <td align="left" width="20%">配送费用：<strong>￥<%#DataBinder.Eval(Container.DataItem,"spending")%></strong></td>
    <td align="left" style="padding:0 5px 0 5px" width="60%">说明：<%#ubb(DataBinder.Eval(Container.DataItem,"introduct").ToString())%></td>
   </tr>
   </ItemTemplate>
 </asp:Repeater>
</table>
<br>
<table border=0 cellpadding=0 cellspacing="0" align="center" class="order">
 <tr class="send_header"><td align="left">&nbsp;&nbsp;<strong>收货人信息：</strong></td></tr>
</table>
<table border=0 cellpadding=3 cellspacing="0" align="center" class="order" width=100%>
        <tr>
         <td align="right" width=100px>联系人姓名：</td>
         <td align="left"><input name="Name" id="Name" type="text" Maxlength="25" class="si" value=""></td>
        </tr>
        <tr>
         <td align="right">联系电话：</td>
         <td align="left"><input id="Tel" name="Tel" type="text" Maxlength="30" class="si"  value=""></td>
        </tr>
        <tr>
         <td align="right">省  份：</td>
         <td align="left">
<select name="Province" id="Province">
<option value="北京">北京</option>
<option value="重庆">重庆</option>
<option value="福建">福建</option>
<option value="甘肃">甘肃</option>
<option value="广东" selected>广东</option>
<option value="广西">广西</option>
<option value="贵州">贵州</option>
<option value="海南">海南</option>
<option value="河北">河北</option>
<option value="黑龙江">黑龙江</option>
<option value="河南">河南</option>
<option value="湖北">湖北</option>
<option value="湖南">湖南</option>
<option value="内蒙古">内蒙古</option>
<option value="安徽">安徽</option>
<option value="江苏">江苏</option>
<option value="江西">江西</option>
<option value="吉林">吉林</option>
<option value="辽宁">辽宁</option>
<option value="宁夏">宁夏</option>
<option value="青海">青海</option>
<option value="山西">山西</option>
<option value="陕西">陕西</option>
<option value="山东">山东</option>
<option value="上海">上海</option>
<option value="四川">四川</option>
<option value="天津">天津</option>
<option value="西藏">西藏</option>
<option value="新疆">新疆</option>
<option value="云南">云南</option>
<option value="浙江">浙江</option>
<option value="香港">香港</option>
<option value="澳门">澳门</option>
<option value="台湾">台湾</option>
<option value="其他">其他</option>
</select>
</td>
        </tr>

    <tr>
         <td align="right">所在城市：</td>
         <td align="left"><input id="City" name="City" type="text" Maxlength="15" class="si"  value=""></td>
     </tr>
    <tr>
         <td align="right">电子邮件：</td>
         <td align="left"><input id="Email" name="Email" type="text" Maxlength="30" class="si" value=""></td>
       </tr>
    <tr>
         <td align="right">邮编：</td>
         <td align="left"><input name="PostCode" id="PostCode" type="text" Maxlength="6" style="width:100px" class="si" value=""></td>
       </tr>
    <tr>
         <td align="right">详细地址：</td>
         <td align="left"><input name="Address" id="Address" type="text" Maxlength="50" class="si" style="width:300px" value=""></td>
       </tr>
    <tr>
         <td align="right">其他说明：</td>
         <td align="left"><textarea id="Beizhu" name="Beizhu" style="width:300px;height:50px;"></textarea></td>
       </tr>
   </table>
<div align=left style="width:98%">提示：请详细填写以上姓名、收货地址、电话、邮政编码等资料，不然可能导致送货失败。</div>
<div align="left" style="width:98%">
<input type="button" value=" 上一步 " class="o_bt" onclick="location.href='order.aspx?s=<%=SiteId%>&table=<%=Table%>'">&nbsp;&nbsp;<input type="button" value=" 提交订单 " class="o_bt"  onclick="checkall()">
</div>
<input type="hidden" name="post" value="add">
</form>
<br>
<br>
</center>
<script type="text/javascript">
function checkname()
 {
 var value=document.getElementById("Name").value;
  if(value.length<2)
  {
   alert("请正确填写联系人姓名！");
   document.getElementById("Name").focus();
   return false;
  }
  return true;
 }

function checktel()
 {
  var value=document.getElementById("Tel").value;
  if(value.length<8)
   {
    alert("请正确填写联系电话！");
    document.getElementById("Tel").focus();
    return false;
   }

  return true;
 }

function checkcity()
 {
  var value=document.getElementById("City").value;
  if(value.length<2)
  {
   alert("请填写您所在的城市！");
   document.getElementById("City").focus();
   return false;
  }

  return true;

 }

function checkemail()
 {
   var u_nme=document.getElementById("Email").value;
   if(u_nme.length==0)
     {
       alert("请填写电子邮件地址。");
      document.getElementById("Email").focus();
       return false;
     } 
   else
    {
      if (u_nme.charAt(0)=="." || u_nme.charAt(0)=="@" || u_nme.indexOf('@', 0) == -1 || u_nme.indexOf('.', 0) == -1 || u_nme.lastIndexOf("@")==u_nme.length-1 || u_nme.lastIndexOf(".")==u_nme.length-1)
        {
          alert("电子邮件格式错误。");
          document.getElementById("Email").focus();
          return false;
        }
      else
       {
          return true;
       }
   }

 }

function checkpostcode()
 {
  var value=document.getElementById("PostCode").value;
  if(!IsNum(value))
   {
    alert("邮编号码填写错误。");
    document.getElementById("PostCode").focus();
    return false;
   }

  if(value.length!=6)
  {
   alert("邮编只能由6位数字组成!");
   document.getElementById("PostCode").focus();
   return false;
  }

  return true;

 }

function checkaddress()
 {
  var value=document.getElementById("Address").value;
  if(value.length<4)
  {
    alert("请填写详细联系地址!");
    document.getElementById("Address").focus();
    return false;
  }
  return true;
 }

function checkall()
 {
  var sendway=Get_CheckBox("sendway");
  if(sendway=="0")
   {
    alert("请选择配送方式!");
    return false;
   }
  var Message=checkname() && checktel() && checkcity() && checkemail() && checkpostcode() && checkaddress();
  if(Message)
  {
    document.order.submit();
  }
  else
  {
   return false;
  }
 }
</script>
</body>
</html>

