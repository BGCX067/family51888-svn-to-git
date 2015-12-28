<% @ Page Language="C#" Inherits="PageAdmin.member_fnc_rk"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>汇款入帐</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">

<form runat="server" onsubmit="return ck()">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="location.href='member_info.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">会员信息</li>
<li id="tab" name="tab"  style="font-weight:bold">入款/充积分</li>
<li id="tab" name="tab"  onclick="location.href='member_fnc_xf.aspx?username=<%=Server.UrlEncode(Request.QueryString["username"])%>'">扣款/扣积分</li>
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
        <td align="left" width="10%"><span id="rk_title">入账金额</span></td><td lign="left"><asp:TextBox Id="fnc_rk_amount" runat="server" size="15" Maxlength="15" /></td>
     </tr>
      <tr id="rk_way">
        <td align="left" width="10%">汇款方式</td>
        <td lign="left">
         <asp:DropDownList id="fnc_rk_way" runat="server">
               <asp:ListItem>建设银行</asp:ListItem> 
                <asp:ListItem>邮政汇款</asp:ListItem>
                <asp:ListItem>工商银行</asp:ListItem>
                <asp:ListItem>中国银行</asp:ListItem>
                <asp:ListItem>农业银行</asp:ListItem>
                <asp:ListItem>招商银行</asp:ListItem>  
                <asp:ListItem>交通银行</asp:ListItem>  
                <asp:ListItem>在线支付</asp:ListItem> 
                <asp:ListItem>公司帐号</asp:ListItem>
                <asp:ListItem>现金支付</asp:ListItem>
                <asp:ListItem>其它方式</asp:ListItem>
          </asp:DropDownList>
        </td>
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
<td height=25 align=center>
<asp:Button Cssclass=button  text="确定"  runat="server" onclick="Data_Add"/>
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
   var rk_way=document.getElementById("rk_way");
   if(type[0].checked)
    {
      rk_title.innerHTML="入账金额";
      rk_way.style.display="";
    }
   else
    {
      rk_title.innerHTML="入账点数";
      rk_way.style.display="none";
    }
 }

function ck()
 {
   var type=document.getElementsByName("fnc_type");
   var amount=document.getElementById("fnc_rk_amount").value;
   if(amount=="" || amount=="0")
    {
      alert("请输入有效数值!");
      return false;
    }
   if(isNaN(amount))
    {
      alert("请输入有效的数值!");
      return false;
    }
   if(type[0].checked)
    {
      if(confirm("此操作将入款"+amount+"元，是否确定?"))
       {
          return true;
       }
    }
   else 
    {
      if(confirm("此操作将充值"+amount+"积分，是否确定?"))
       {
          return true;
       }
    }
   return false;
 }
</script>
</body>
</html>  



