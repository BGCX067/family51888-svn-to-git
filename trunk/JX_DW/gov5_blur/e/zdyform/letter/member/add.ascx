<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<tr><td class='tdhead'>信件主题<span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>" style='width:300px'   maxlength='100' ></td></tr>
<tr><td class='tdhead'>姓名</td><td><input type=text name='pa_name' id='pa_name' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_name"));}%>"  maxlength='100' ></td></tr>
<tr><td class='tdhead'>性别<span style='color:#ff0000'>*</span></td><td> <input type=radio value='男'  name='pa_sex' id='pa_sex' <%if(post=="add"){Response.Write("男"=="男"?"checked":"");}else{Response.Write(r("pa_sex")=="男"?"checked":"");}%>>男 <input type=radio value='女'  name='pa_sex' id='pa_sex' <%if(post=="add"){Response.Write("男"=="女"?"checked":"");}else{Response.Write(r("pa_sex")=="女"?"checked":"");}%>>女</td></tr><tr><td class='tdhead'>电子邮箱<span style='color:#ff0000'>*</span></td><td><input type=text name='email' id='email' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("email"));}%>"  maxlength='100' ></td></tr>
<tr><td class='tdhead'>联系电话</td><td><input type=text name='pa_tel' id='pa_tel' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_tel"));}%>"  maxlength='100' ></td></tr>
<tr><td class='tdhead'>联系地址</td><td><input type=text name='pa_address' id='pa_address' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_address"));}%>" style='width:300px'   maxlength='100' ></td></tr>
<tr><td class='tdhead'>邮编</td><td><input type=text name='pa_postcode' id='pa_postcode' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_postcode"));}%>"  maxlength='100' ></td></tr>
<tr><td class='tdhead'>信件内容<span style='color:#ff0000'>*</span></td><td><textarea name='content' id='content'250  ><%if(post=="add"){Response.Write("");}else{Response.Write(r("content"));}%></textarea><script type='text/javascript' src='/e/incs/fckeditor/fckeditor.js'></script><script  type='text/javascript'>var FCKeditor = new FCKeditor('content');FCKeditor.BasePath = '/e/incs/fckeditor/';FCKeditor.Height = 250;FCKeditor.Config['LinkBrowser'] = false;FCKeditor.Config['ImageBrowser'] =false;FCKeditor.Config['FlashBrowser'] =false;FCKeditor.Config['LinkUpload'] =<%=Editor_AttachmentUpload%>;FCKeditor.Config['ImageUpload'] =<%=Editor_ImageUpload%>;FCKeditor.Config['FlashUpload'] =<%=Editor_FlashUpload%>;FCKeditor.ToolbarSet ='Small';FCKeditor.ReplaceTextarea();</script></td></tr>
<tr><td class='tdhead'>发布日期<span style='color:#ff0000'>*</span></td><td><input type=text name='thedate' id='thedate' value="<%if(post=="add"){Response.Write(""==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"):"");}else{Response.Write(DateTime.Parse(r("thedate")).ToString("yyyy-MM-dd HH:mm:ss"));}%>"  maxlength='100' ><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a></td></tr>

<input type='hidden' name='mustname' value='信件主题,性别,电子邮箱,信件内容,发布日期,'><input type='hidden' name='mustfield' value='title,pa_sex,email,content,thedate,'><input type='hidden' name='musttype' value='text,radio,text,editor,text,'>
<script  type='text/javascript'>
function letter_zdycheck(){
return true;
}
</script>
<%End();%>






