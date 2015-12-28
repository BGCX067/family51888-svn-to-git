<% @ Page Language="C#" Inherits="PageAdmin.member_fnc_xf"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>消费扣款</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" onsubmit="return ck()">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="location.href='member_info.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">会员信息</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_rk.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">入款/充积分</li>
<li id="tab" name="tab"  style="font-weight:bold">扣款/扣积分</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_fk.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">返款/返积分</li>
</ul>
</div>

<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
 <table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
      <tr>
        <td align="left" width="10%">操作类型</td><td lign="left"><input type="radio" name="fnc_type" id="fnc_type" value=1 checked onclick="c_type()">财务操作 <input type="radio" name="fnc_type" id="fnc_type" value=2 onclick="c_type()">积分操作</td>
     </tr>
      <tr>
        <td align="left" width="10%">用户名</td><td lign="left"><asp:TextBox Id="Username" runat="server" size="15" Maxlength="16" Enabled="false" /></td>
     </tr>
      <tr>
        <td align="left" width="10%"><span id="rk_title">扣款金额</span></td><td lign="left"><asp:TextBox Id="fnc_xf_amount" runat="server" size="15" Maxlength="10" /></td>
     </tr>
      <tr>
        <td align="left" width="10%">扣除事由</td>
        <td lign="left"><asp:TextBox Id="fnc_xf_product" runat="server" size="40" Maxlength="50" /></td>
     </tr>
      <tr>
        <td align="left" width="10%">备注</td><td lign="left"><asp:TextBox Id="beizhu" runat="server" TextMode="multiline" Columns="50" rows="5" /></td>
     </tr>
   </table>

  </td>
  <tr>
 </table>
<br>
<asp:Label id="Lbl_Info" runat="server" Lbl_Error/><br>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
<td height=25 align=center >
<asp:Button  Cssclass=button text="确定" runat="server"  onclick="Data_Add"/>
<input type="button" class=button  value="返回"  onclick="history.back()">
</td>
 </tr>
</table>
</form>
</td>
</tr>
</table>
</center>
<script type='text/javascript'>
function c_type()
 {
   var type=document.getElementsByName("fnc_type");
   var rk_title=document.getElementById("rk_title");
   if(type[0].checked)
    {
      rk_title.innerHTML="扣款金额";
    }
   else
    {
      rk_title.innerHTML="扣除点数";
    }
 }

function ck()
 {
   var type=document.getElementsByName("fnc_type");
   var amount=document.getElementById("fnc_xf_amount").value;
   if(amount=="" || amount=="0")
    {
      alert("请输入有效数值!");
      document.getElementById("fnc_xf_amount").focus();
      return false;
    }
   if(isNaN(amount))
    {
      alert("请输入有效的数值!");
      return false;
    }
   var fnc_xf_product=document.getElementById("fnc_xf_product");
   if(fnc_xf_product.value=="")
    {
      alert("请输入扣除事由!");
      fnc_xf_product.focus();
      return false;
    }
   if(type[0].checked)
    {
      if(confirm("此操作将扣款"+amount+"元，是否确定?"))
       {
          return true;
       }
    }
   else 
    {
      if(confirm("此操作将扣除"+amount+"积分，是否确定?"))
       {
          return true;
       }
    }
   return false;
 }
</script>
</body>
</html>  
