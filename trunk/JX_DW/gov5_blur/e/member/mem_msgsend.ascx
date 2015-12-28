<% @  Control Language="c#" Inherits="PageAdmin.mem_msgsend"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="/e/member/index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 发送信息</li>
<li class="current_location_2">发送信息</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_msg")%>'>收件箱</a></li>
 <li><a href='<%=Get_Url("mem_msgout")%>'>发件箱</a></li>
 <li class="c"><a href='<%=Get_Url("mem_msgsend")%>'>发信息</a></li>
 <li><a href='<%=Get_Url("mem_friends")%>'>我的好友</a></li>
 <li><a href='<%=Get_Url("mem_friendssort")%>'>好友分类</a></li>
 <li><a href='<%=Get_Url("mem_blacklist")%>'>黑名单</a></li>
</ul></div>
<form method="post">
<table border=0 cellpadding="5px" cellspacing=0  align=center class="member_table">
     <tr>
      <td height=25 align=right width=100px>收件人：</td>
      <td><input type="text"  id="fb_receiver"  name="fb_receiver"  size="60" class="tb"  value="<%=The_Sender%>"> [<a href="javascript:Friends_window()">选择好友</a>]<span style="color:#ff0000"> *</span></td>
    </tr>

  <tr>
      <td height=25 align=right>短信标题：</td>
      <td><input type="text"  id="fb_title"  name="fb_title"  maxlength="100" size="60" class="tb"  value="<%=The_Title%>"><span style="color:#ff0000">*</span>
   </td>
  </tr>

   <tr>
          <td align=right>短信内容：</td>
          <td><textarea name="Content" id="Content"><%=The_Content%></textarea>
<script type="text/javascript" src="/e/incs/fckeditor/fckeditor.js"></script>
<script  type="text/javascript"> 
var FCKeditor = new FCKeditor("Content"); 
FCKeditor.BasePath = "/e/incs/fckeditor/"; 
FCKeditor.Height = 200; 
FCKeditor.Config['LinkBrowser'] = false ;
FCKeditor.Config['ImageBrowser'] =false ;
FCKeditor.Config['FlashBrowser'] = false ;
FCKeditor.Config['LinkUpload'] =<%=Editor_AttachmentUpload%>;
FCKeditor.Config['ImageUpload'] =<%=Editor_ImageUpload%>;
FCKeditor.Config['FlashUpload'] =<%=Editor_ImageUpload%>;
FCKeditor.ToolbarSet ="Small"; 
FCKeditor.ReplaceTextarea(); 
</script></td>
      </tr> 
   </table>
<table border=0 cellpadding="5" cellspacing=0  align=center class="member_table_1">
   <tr>
       <td height=30px align=center>
      <input type="hidden" value="<%=SendMail%>"  name="sendmail">&nbsp;
      <input type="hidden" value="send"  name="post" id="post">&nbsp;
      <input type="submit" value="发 送"  onclick="return Check_Message('send')" class="bt">&nbsp;
      <input type="submit" value="保 存"  onclick="return Check_Message('save')" class="bt">&nbsp;
      <input type="button" value="返 回"   class="bt"  onclick="location.href='<%=Get_BackUrl()%>'">
     </td>
     </tr> 
 </table>
</form>
</div>
</div>
<script type='text/javascript'>
function Friends_window()
 {
   IDialog("好友列表","mem_friendslist.aspx",240,340);
 }
</script>
