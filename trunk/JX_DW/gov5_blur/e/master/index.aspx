<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>江西省电力公司办公室系统管理后台</title>
</head><%if(Request.Cookies["master"]!=null){%>
<frameset  cols="140,*" framespacing="0" border="0"  id="leftmenu" name="leftmenu" >
    <frame src="left.aspx" id="left" name="left" scrolling="auto" noresize frameborder=no marginwidth=0 marginheight=0>
    <frameset  rows="50,*,15" framespacing="0" border="0">
         <frame src="m_top.aspx"  id="m_head" name="m_head"   frameborder="no" scrolling="no" noresize marginwidth=0 marginheight=0 >
         <frame src="sysmain.aspx"   id="right" name="right"   frameborder="no" scrolling="auto" noresize marginwidth=0 marginheight=0 >
         <frame src="m_bottom.aspx"  frameborder="no" scrolling="no" noresize marginwidth=0 marginheight=0 >
   </frameset>
</frameset>
<noframes>
<body><br><br><div>对不起，您的浏览器不支持框架结构.</div></body>
</noframes><%}else{%>
<script type="text/javascript">
top.location.href="login.aspx";
</script><%}%>
</html>
