<% @ Page Language="c#" Inherits="PageAdmin.master_login"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>江西省电力公司办公室系统管理登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Author"  content="PageAdmin CMS V3.0" />
<link rel="stylesheet" href="master.css" type="text/css">
<script src="master.js" type="text/javascript"></script>

<style type="text/css">
.master_tb{width:120px;height:18px;border:1px solid #cccccc;background:url(images/login_tb_bg.jpg) repeat-x 0 0;}
.master_yzm{width:60px;height:18px;border:1px solid #cccccc;background:url(images/login_tb_bg.jpg) repeat-x 0 0;}
.masterlogin{background:url(images/master_login.jpg) no-repeat 0 0;width:62px;height:20px;border-width:0px;margin:2px 5px 0 0;font-size:12px;cursor:pointer}
</style>
</head>
<body>
<table border=0 cellpadding=0 cellspacing=0 width=100% style="margin:150px 0 0 0;">
 <tr>
  <td valign=center height=100% align=center style="padding:20px 0 0 0">
<table border="0" cellpadding="0" cellspacing="0" width="506" align=center>
  <tr>
   <td colspan="2"><img  src="images/login_r1_c1.jpg" width="506" height="135" border="0" title="pageadmin网站管理系统"></td>
   <td><img src="images/spacer.gif" width="1" height="135" border="0" alt=""></td>
  </tr>
  <tr>
   <td><img  src="images/login_r2_c1.jpg" width="294" height="136" border="0" alt=""></td>
   <td background="images/login_r2_c2.jpg" style="width:212px;height:136px;overflow:hidden;" valign="middle">
<table border=0 cellpadding=0 cellspacing=0 width="100%" align=centert>
<form method="post" onsubmit="return check_login()">
<tr><td height=10px></td><tr>
<tr>
<td height=27px align="left">管理员：<input type="textbox" class="master_tb" id="username" name="username"  maxlength="25" size="15" /></td>
<tr>
<td height=27px align="left">密&nbsp;&nbsp;码：<input type="password" class="master_tb" id="password"  name="password" maxlength="25" size="15" /></td>
</tr>
<tr>
<td height=27px align="left">验证码：<input type="textbox" class="master_yzm" id="validatecode" name="validatecode" maxlength="25" size="15" />
<img src="../aspx/yzm.aspx" align=absmiddle border=0 Onclick="Code_Change()" id="validatecodeimg"  alt="点击更换" style='cursor:pointer;height:20px'>
</td>
</tr>
<tr>
<td height=27px align=center >
    <input type="submit" value="登 陆" class="masterlogin">&nbsp;&nbsp;
    <input type="button" value="返 回" class="masterlogin"  onclick="location.href='/'">
</td>
</tr>
</form>
</table>

   </td>
   <td><img src="images/spacer.gif" width="1" height="136" border="0" alt=""></td>
  </tr>
  <tr>
   <td colspan="2"><img  src="images/login_r3_c1.jpg" width="506" height="25" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="25" border="0" alt=""></td>
  </tr>
</table>
 </td>
 </tr>
</table>
<script  language="javascript" type="text/javascript">
function check_login()
 {

  Obj=document.getElementById("username");
  if(Obj.value=="")
   {
     alert("请输入管理员!");
     Obj.focus();
     return false;
   }


  Obj=document.getElementById("password");
  if(Obj.value=="")
   {
     alert("请输入密码!");
     Obj.focus();
     return false;
   }

  Obj=document.getElementById("validatecode");
  if(Obj.value=="")
   {
     alert("请输入验证码!");
     Obj.focus();
     return false;
   }

 }

function Code_Change()
 {
  var R=Math.floor(Math.random()*10+1);
  Obj=document.getElementById("validatecodeimg");
  Obj.src="../aspx/yzm.aspx?r="+R;
 }
</script>
</body>
</html>
