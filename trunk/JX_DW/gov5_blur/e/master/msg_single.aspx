<% @ Page Language="C#" Inherits="PageAdmin.msgsend"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98% >
 <tr>
<td valign=top align="left">
<form method="post" name="msg">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding="2px" cellspacing=0  align=center width=99%>
  <tr>
      <td height=25 align=right width=80px>标题：</td>
      <td><input type="text"  id="fb_title" name="fb_title" maxlength="100" size="50" class="tb"> <span style="color:#ff0000">*</span>
   </td>
  </tr>

   <tr>
          <td align=right>内容：</td>
          <td>
            <textarea name="Content" id="Content"></textarea>
<script type="text/javascript" src="/e/incs/fckeditor/fckeditor.js"></script>
<script  type="text/javascript"> 
var FCKeditor = new FCKeditor("Content"); 
FCKeditor.BasePath = "/e/incs/fckeditor/"; 
FCKeditor.Height = 200; 
FCKeditor.Config['LinkBrowser'] = false ;
FCKeditor.Config['ImageBrowser'] =false ;
FCKeditor.Config['FlashBrowser'] = false ;
FCKeditor.Config['LinkUpload'] = true ;
FCKeditor.Config['ImageUpload'] = true ;
FCKeditor.Config['FlashUpload'] = true ;
FCKeditor.ToolbarSet ="Simple"; 
FCKeditor.ReplaceTextarea(); 
</script>
          </td>
      </tr> 

  <tr> 
      <td height=25 align=right>发件方式：</td>
      <td><input type="checkbox" value="1"  name="sendmsg" id="sendmsg" checked>站内短信
      <input type="checkbox" value="1"  name="sendmail" id="sendmail">发送邮件
   </td>
  </tr>

     <tr>
      <td height=20px align=center colspan=2>
      <input type="hidden" id="Receiver" name="Receiver" size="50" class="tb" value="<%=Receiver%>">
      <input type="hidden"  name="post" value="<%=SendType%>">
      <input type="button" value="发送"  class="button" onclick="Check_Message()">
     </td>
    </tr>
   </table>

  </td>
  <tr>
 </table>

</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
 <%if(Request.QueryString["send"]=="ok"){%>
   parent.ClosePop();
 <%}%>
 function Check_Message()
  { 
    var fb_value;
    fb_value=Trim(document.getElementById("Receiver").value);
    if(fb_value=="")
      {
       alert("收件人不能为空!");
       return false;
     }

   fb_value=Trim(document.getElementById("fb_title").value);
   if(fb_value=="")
    {
      alert("请输入信息标题!");
      document.getElementById("fb_title").focus();
      return false;
    }
   var Length=FckLength("Content");
   if(Length==0)
    {
      alert("请输入信息内容!");
      return false;
    }
   if(document.getElementById("sendmsg").checked==false && document.getElementById("sendmail").checked==false)
    {
      alert("请至少选择一种发件方式!");
      return false;
    }
   document.forms["msg"].submit();
  }
</script>
</body>
</html>  