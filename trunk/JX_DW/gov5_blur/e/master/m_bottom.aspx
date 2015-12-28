<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>pageadmin网站管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Author"  content="PageAdmin CMS" />
<link rel="stylesheet" href="master.css" type="text/css">
<script language="javascript">
var hashide=false;
function showleftmenu()
{
var obj=window.parent.document.getElementById("leftmenu");
if(hashide)
{
 hashide=false;
 document.getElementById("signpic").src="images/arrow_left.gif";
 obj.cols="140,*"
 document.getElementById("sign_text").innerHTML="隐藏左菜单";
}
else
{
 hashide=true;
 document.getElementById("signpic").src="images/arrow_right.gif";
 obj.cols="1,*"
 document.getElementById("sign_text").innerHTML="显示左菜单";
}
}
</script>
</head>  
<body  topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0 class=bg2>
<table width=100% height=15px cellpadding=0 cellspacing=0 class=border1>
  <tbody>
  <tr>
  <td  valign=middle class=white ><a href="#" id="a_sign" onclick="showleftmenu()"><img id="signpic" src="images/arrow_left.gif" border=0 align="absmiddle" hspace=5 vspace=2><span id="sign_text">隐藏左菜单</span></a></td>
   </tr> 
   </tbody>
   </table>
</body>
</html>  
