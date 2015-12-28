<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Alipay_Return.aspx.cs" Inherits="Alipay_Return" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>支付结果</title>
<style type="text/css">
html,body{height:100%}
body,div,ul,li,table,p,h1,form,legend,fieldset,input button,select,textarea,button{margin:0px;padding:0px;font-family:inherit;font-size:inherit;}
body{word-wrap:break-word;text-align:center;font:12px/1.6em Verdana,Helvetica,Arial,sans-serif;color:#333333;}
table{border-collapse:collapse;border-spacing:0;}
a{color:#333333;text-decoration:underline;}
a:hover{text-decoration:none;}
.resultbox{line-height:24px;padding:100px 0 0 150px;}
</style>
</head>
<body>
    <form id="form1" runat="server">
     <div class="resultbox">
    <TABLE width=500 border=0 align="center" cellPadding=2 cellSpacing=0>
                        <tr>
                          <td align="left"><img src="../payimage/suc.png" border=0"></td>
                       </tr>
			<TR> 
			  <TD vAlign=top align="left">支付结果：<%=Pay_Result%></TD>
			</TR>
			<TR> 
			  <TD vAlign=top align="left">订单号：<%=Request.QueryString["trade_no"]%></TD>
			</TR>
			<TR> 
			  <TD vAlign=top align="left">充值金额：<%=Request.QueryString["total_fee"]%></TD>
			</TR>
			<TR> 
			  <TD vAlign=top align="left">支付类型：<%=Request.QueryString["subject"]%></TD>
			</TR>	
                        <tr>
                          <td align="left">返回 <a href="/e/member/index.aspx?s=<%=SiteId%>"><B>会员中心</B></a></td>
			</tr>			
		</TABLE>
    </div>
    </form>
</body>
</html>
