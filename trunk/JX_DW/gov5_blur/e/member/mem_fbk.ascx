<% @  Control Language="c#" Inherits="PageAdmin.mem_fbk"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; 有问必答</li>
<li class="current_location_2">有问必答</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<div class="tabdiv"><ul>
 <li><a href='<%=Get_Url("mem_fbklst")%>'>我的留言</a></li>
 <li class="c"><a href='<%=Get_Url("mem_fbk")%>'>发布留言</a></li>
</ul></div>
<form method="post">
<table border=0 cellpadding="5px" cellspacing=0  align=center class="member_table">
 <tr>
      <td class="tdhead">类型<span style="color:#ff0000"> </span></td>
      <td><select name="fb_type" id="fb_type" >
	<option value="咨询">  咨询  </option>
	<option value="问题">  问题  </option>
	<option value="建议">  建议  </option>
	<option value="投诉">  投诉  </option>
	<option value="其他">  其他  </option></select>
     </td>
    </tr>

  <tr>
      <td class="tdhead">主题<span style="color:#ff0000">*</span></td>
      <td><input type="text" id="fb_title" name="fb_title" maxlength="50" size="40" class="tb"></td>
    </tr>
  </tr>

  <tr>
      <td class="tdhead">联系人<span style="color:#ff0000">*</span></td>
      <td><input type="text" id="fb_truename" name="fb_truename" value="<%=Name%>" maxlength="30" size="20" class="tb"></td>
    </tr>
  </tr>

   <tr>
      <td class="tdhead">电话<span style="color:#ff0000"> </span></td>
      <td><input type="text" id="fb_tel" name="fb_tel" maxlength="30" size="20" class="tb" ></td>
  </tr>

     <tr>
      <td class="tdhead">E-mail<span style="color:#ff0000">*</span></td>
      <td><input type="text" id="fb_email"  name="fb_email" value="<%=Email%>" maxlength="30" size="20" class="tb"></td>
    </tr>

   <tr>
      <td class="tdhead">反馈内容<span style="color:#ff0000">*</span></td>
      <td><textarea id="fb_content" name="fb_content" cols="10" rows="10" class="tb"></textarea> 
<script type="text/javascript" src="/e/incs/fckeditor/fckeditor.js"></script>
<script  type="text/javascript"> 
var FCKeditor = new FCKeditor("fb_content"); 
FCKeditor.BasePath = "/e/incs/fckeditor/"; 
FCKeditor.Height = 200; 
FCKeditor.Config['LinkBrowser'] = false;
FCKeditor.Config['ImageBrowser'] =false;
FCKeditor.Config['FlashBrowser'] = false;
FCKeditor.Config['LinkUpload'] =<%=Editor_AttachmentUpload%>;
FCKeditor.Config['ImageUpload'] =<%=Editor_ImageUpload%>;
FCKeditor.Config['FlashUpload'] =<%=Editor_ImageUpload%>;
FCKeditor.ToolbarSet ="Small"; 
FCKeditor.ReplaceTextarea(); 
</script>
    </td>
    </tr>
  </table>
<table border=0 cellpadding="5" cellspacing=0  align=center class="member_table_1">
   <tr>
       <td height=30px align=center>
      <input type="hidden" value="yes"  name="post">&nbsp;
      <input type="submit" value="提 交"  onclick="return Check_Feedback()" class="bt">&nbsp;
      <input type="button" value="返 回"   class="bt" onclick="location.href='<%=Get_Url("mem_fbklst")%>'">
     </td>
     </tr> 
 </table>
</form>
</div>
</div>