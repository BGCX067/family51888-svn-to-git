<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<tr><td align=right class='tdhead'>主题<span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>" style='width:300px'   maxlength='100' ></td></tr>
<tr><td align=right class='tdhead'>联系人</td><td><input type=text name='pa_truename' id='pa_truename' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_truename"));}%>" style='width:200px'   maxlength='100' ></td></tr>
<tr><td align=right class='tdhead'>联系电话</td><td><input type=text name='pa_tel' id='pa_tel' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_tel"));}%>" style='width:200px'   maxlength='100' ></td></tr>
<tr><td align=right class='tdhead'>邮箱<span style='color:#ff0000'>*</span></td><td><input type=text name='email' id='email' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("email"));}%>" onblur="if(!IsEmail(this.value)){alert('无效的邮件格式');document.letter.fbk_email.value=''}" maxlength='100' ></td></tr>
<tr><td align=right class='tdhead'>内容<span style='color:#ff0000'>*</span></td><td><textarea name='content' id='content'250  ><%if(post=="add"){Response.Write("");}else{Response.Write(r("content"));}%></textarea><script type='text/javascript' src='/e/incs/fckeditor/fckeditor.js'></script><script  type='text/javascript'>var FCKeditor = new FCKeditor('content');FCKeditor.BasePath = '/e/incs/fckeditor/';FCKeditor.Height = 250;FCKeditor.Config['LinkUpload'] = true;FCKeditor.Config['ImageUpload'] =true;FCKeditor.Config['FlashUpload'] =true;FCKeditor.Config['LinkBrowser'] = false;FCKeditor.Config['ImageBrowser'] =false;FCKeditor.Config['FlashBrowser'] =false;FCKeditor.ToolbarSet ='Small';FCKeditor.ReplaceTextarea();</script></td></tr>
<tr><td align=right class='tdhead'>发布日期<span style='color:#ff0000'>*</span></td><td><input type=text name='thedate' id='thedate' value="<%if(post=="add"){Response.Write(""==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"):"");}else{Response.Write(DateTime.Parse(r("thedate")).ToString("yyyy-MM-dd HH:mm:ss"));}%>"  maxlength='100' ><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 hspace=2 align=absbottom></a></td></tr>
<tr><td colspan=2 align=center><input type='hidden' name='mustname' value='主题,邮箱,内容,发布日期,'><input type='hidden' name='mustfield' value='title,email,content,thedate,'><input type='hidden' name='musttype' value='text,text,editor,text,'></td></tr>
<script  type='text/javascript'>
function feedback_zdycheck(){
return true;
}
</script>
<%End();%>






