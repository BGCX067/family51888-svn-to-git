<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<tr><td class='tdhead'>标题<span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>" style='width:400px'   maxlength='100' ></td></tr>
<tr>
<td align="right">标题样式</td>
<td>
<input type="text" name="pa_style" id="pa_style" value=<%=r("pa_style")%>>
<a href="javascript:foreColor('pa_style','color:')"><img src=images/color.gif border=0 height=21 align=absbottom></a>
</td>
</tr>
<tr><td class='tdhead'>标题图片</td><td><input ondblclick="if(this.value!='')window.open(this.value)" type=text name='titlepic' id='titlepic'  value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("titlepic"));}%>"  ><%if(Field_ImageUpload=="true"){%><a href="javascript:delete_file('article','titlepic',<%=InforId%>)" id="delete_titlepic" style="padding-left:2px;display:<%=r("titlepic")==""?"none":""%>" title='删除图片'><img src=/e/images/public/del.gif border=0></a><a id='upload_titlepic' href="javascript:open_upload('<%=SiteId%>','','image','article','titlepic','titlepic')" style="display:<%=r("titlepic")==""?"":"none"%>"><img src='/e/images/public/attachimg.gif' border=0  hspace=2 alt='上传图片' align=absbottom></a><%}%></td></tr><tr>
<td align="right">作者</td>
<td>
<input type="text" name="pa_autor" id="pa_autor" value="<%=r("pa_autor")%>" maxlength=20>
<select onchange="if(this.options[this.selectedIndex].value!='')document.getElementById('pa_autor').value=this.options[this.selectedIndex].value">
<option value="">选择作者</option>
<option value="PageAdmin">PageAdmin</option>
<option value="佚名">佚名</option>
<option value="管理员">管理员</option>
<option value="不详">不详</option>
</select>
</td></tr>
<tr>
<td align="right">来源</td>
<td>
<input type="text" name="pa_source" id="pa_source" value="<%=r("pa_source")%>" maxlength=20>
<select onchange="if(this.options[this.selectedIndex].value!='')document.getElementById('pa_source').value=this.options[this.selectedIndex].value">
<option value="">选择来源</option>
<option value="本站原创">本站原创</option>
<option value="办公室">办公室</option>
<option value="公司">公司</option>
<option value="集团">集团</option>
</select>
</td></tr>
<tr><td class='tdhead'>文号</td><td><input type=text name='pa_syh' id='pa_syh' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_syh"));}%>" style='width:300px'   maxlength='100' ></td></tr>
<tr><td class='tdhead'>简介</td><td><textarea name='pa_introduct' id='pa_introduct' style='width:400px;height:100px'   ><%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_introduct"));}%></textarea></td></tr>
<tr><td class='tdhead'>视频</td><td><input ondblclick="if(this.value!='')window.open(this.value)" type=text name='pa_video' id='pa_video'  value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_video"));}%>" size="60" ><%if(Field_AttachmentUpload=="true"){%><a href="javascript:delete_file('article','pa_video',<%=InforId%>)" id="delete_pa_video" style="padding-left:2px;display:<%=r("pa_video")==""?"none":""%>" title='删除文件'><img src=/e/images/public/del.gif border=0></a><a id='upload_pa_video' href="javascript:open_upload('<%=SiteId%>','','file','article','pa_video','pa_video')" style="display:<%=r("pa_video")==""?"":"none"%>"><img src='/e/images/public/attachment.gif' border=0  hspace=2 alt='上传文件' align=absbottom></a><%}%></td></tr><tr><td class='tdhead'>附件</td><td><input ondblclick="if(this.value!='')window.open(this.value)" type=text name='pa_fj' id='pa_fj'  value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_fj"));}%>" size="60" ><%if(Field_AttachmentUpload=="true"){%><a href="javascript:delete_file('article','pa_fj',<%=InforId%>)" id="delete_pa_fj" style="padding-left:2px;display:<%=r("pa_fj")==""?"none":""%>" title='删除文件'><img src=/e/images/public/del.gif border=0></a><a id='upload_pa_fj' href="javascript:open_upload('<%=SiteId%>','','file','article','pa_fj','pa_fj')" style="display:<%=r("pa_fj")==""?"":"none"%>"><img src='/e/images/public/attachment.gif' border=0  hspace=2 alt='上传文件' align=absbottom></a><%}%></td></tr><tr><td class='tdhead'>内容<span style='color:#ff0000'>*</span></td><td><textarea name='content' id='content'  ><%if(post=="add"){Response.Write("");}else{Response.Write(r("content"));}%></textarea><script type='text/javascript' src='/e/incs/fckeditor/fckeditor.js'></script><script  type='text/javascript'>var FCKeditor = new FCKeditor('content');FCKeditor.BasePath = '/e/incs/fckeditor/';FCKeditor.Height = 350;FCKeditor.Config['LinkBrowser'] = false;FCKeditor.Config['ImageBrowser'] =false;FCKeditor.Config['FlashBrowser'] =false;FCKeditor.Config['LinkUpload'] =<%=Editor_AttachmentUpload%>;FCKeditor.Config['ImageUpload'] =<%=Editor_ImageUpload%>;FCKeditor.Config['FlashUpload'] =<%=Editor_FlashUpload%>;FCKeditor.ToolbarSet ='Basic';FCKeditor.ReplaceTextarea();</script></td></tr>
<tr><td class='tdhead'>发布日期<span style='color:#ff0000'>*</span></td><td><input type=text name='thedate' id='thedate' value="<%if(post=="add"){Response.Write(""==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"):"");}else{Response.Write(DateTime.Parse(r("thedate")).ToString("yyyy-MM-dd HH:mm:ss"));}%>"  maxlength='100' ><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 hspace=2 align=absbottom></a></td></tr>

<input type='hidden' name='mustname' value='标题,内容,发布日期,'><input type='hidden' name='mustfield' value='title,content,thedate,'><input type='hidden' name='musttype' value='text,editor,text,'>
<script  type='text/javascript'>
function article_zdycheck(){
return true;
}
</script>
<%End();%>






