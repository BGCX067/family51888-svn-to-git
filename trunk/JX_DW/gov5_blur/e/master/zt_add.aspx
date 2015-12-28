<% @ Page Language="C#" Inherits="PageAdmin.zt_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" type="zt_add"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>专题内容设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">内容设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">其他设置</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
  <table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
  <tr><td  height=25 ><b>当前操作</b>：<%=Request.QueryString["id"]==null?"增加专题":"专题修改"%></td></tr>
 </table>

<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<% if(Sort_List!=""){%>
<tr>
  <td height=30 width=100px>专题类别</td>
  <td><select name="sort" id="sort">
<option  value="">----请选择专题类别----</option>
 <%=Sort_List%>
</select>
  </td>
 </tr>
<%}%>
 <tr>
  <td height=25 width="100px">专题标题</td>
  <td><input name="zt_title" type="text" maxlength="50" id="zt_title" size="60" value="<%=TheTitle%>"></td>
 </tr>

  <tr>
  <td  height=25>专题关键字</td>
  <td><input name="zt_keywords" type="text" maxlength="50" id="zt_keywords" size="60"  value="<%=zt_keywords%>"></td>
 </tr>

  <tr>
  <td  height=25>专题描述</td>
  <td><textarea name="zt_description" id="zt_description" cols="60" rows="5"><%=zt_description%></textarea></td>
 </tr>

  <tr id="Tr_Dir">
  <td  height=25 width=100px>生成路径</td>
  <td>
  <table border=0 cellspacing=0>
  <tr><td align=center id="td_dir1">专题目录</td><td align=left id="td_dir2" style="padding-left:30px">生成文件名</td></tr>
  <tr>
  <td id="td_dir3" title="必填项，只能由字母、数字或下或中划线组成"><%=(Site_Dir==""?"/":("/"+Site_Dir+"/"))%><input name="zt_dir" type="text" maxlength="30" id="zt_dir" size="10" value="zt"></td>
  <td id="td_dir4">/<input name="zt_file" type="text" maxlength="40" id="zt_file" size="20" value="<%=Zt_File%>"></td></tr>
  </table>
</td>
  </tr>

 <tr>
  <td  height=25>专题内容<br><a href="javascript:Open_Editor('pa_zt','content','<%=Request.QueryString["id"]%>','zt_content','专题内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td>
【<a href="javascript:Open_TagWin()">点击这里获取标签</a>】<br>
<textarea name="zt_content" id="zt_content" cols="100" rows="30"><%=zt_Content%></textarea>
</td>
 </tr>


<tr><td align=left width='100px'>评论功能</td>
<td>
<input type="radio" name='comment_open' value="0" checked>关闭
<input type="radio" name='comment_open' id='comment_open_1' value="1">开启&nbsp;
<input type="checkbox" name='comment_check' id='comment_check' value="1" checked>评论需审核
<input type="checkbox" name='comment_anonymous' id='comment_anonymous' value="1" checked>允许匿名评论
</td>
</tr>

</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<tr>
<tr>
  <td width=100px><b>css样式</b></td>
  <td><asp:DropDownList id="D_csspath" runat="server"><asp:ListItem value="">默认风格</asp:ListItem></asp:DropDownList>
  </td>
 </tr>

<tr>
  <td><b>头信息自定义</b><br></td>
  <td><asp:TextBox  id="Headzdy" TextMode="MultiLine" runat="server" columns="75" rows="8" />
  </td>
</tr>

<tr>
 <td colspan=2 height="30">注:&lt;head&gt;&lt;/head&gt;之间的内容</td>
</tr>

<tr>
  <td><b>顶部信息自定义</b>
 <br><a href="javascript:Open_Editor('pa_zt','zdy_top','<%=Request.QueryString["id"]%>','Wztopzdy','顶部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td><asp:TextBox  id="Wztopzdy" TextMode="MultiLine"  runat="server" columns="75" rows="8" />
  </td>
 </tr>
<tr>
<tr>
 <td colspan=2 height="30">注:自动替换网站顶部信息，留空则显示默认。</td>
</tr>
<tr>
  <td><b>栏目菜单自定义</b>
 <br><a href="javascript:Open_Editor('pa_zt','zdy_lanmu','<%=Request.QueryString["id"]%>','Lanmuzdy','栏目菜单自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td><asp:TextBox  id="Lanmuzdy" TextMode="MultiLine"  runat="server" columns="75" rows="8"/>
  </td>
 </tr>
<tr>
 <td colspan=2 height="30">注:自动替换网站默认栏目条，留空则显示默认。</td>
</tr>


<tr>
  <td width=100px><b>横幅自定义</b>
 <br><a href="javascript:Open_Editor('pa_zt','zdy_banner','<%=Request.QueryString["id"]%>','Banner','横幅自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td><asp:TextBox  id="Banner" TextMode="MultiLine" runat="server" columns="75" rows="8" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="30">注:留空则默认通栏Banner，不显示默认banner可以输入&lt;p/&gt;等HTML空白标签</td>
</tr>

<tr>
  <td width=100px><b>底部信息自定义</b>
 <br><a href="javascript:Open_Editor('pa_zt','zdy_bottom','<%=Request.QueryString["id"]%>','Bottom','横幅自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td><asp:TextBox  id="Bottom" TextMode="MultiLine" runat="server" columns="75" rows="8" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="30">注:自动替换网站底部信息，留空则显示默认。</td>
</tr>
</table>
</div>

</td>
</tr>
</table>
<br>
<div align=center>
<asp:Label runat="server" id="Lb_sitedir" Visible="false"/>
<asp:Label runat="server" id="Lb_static" Visible="false"/>
<input type="hidden" name="tijiao"   value="yes">
<span id="post_area">
<input type="submit" class=button   value="提交" onclick="return C_Form()">
<input type="button" class=button  value="返回"  onclick="location.href='zt_list.aspx'">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>                 
</div>
</form>
</td>
</tr>
</table>
<br>
</center>
</body>
<script type="text/javascript">
function Open_TagWin()
 {
    Get_Tag("专题标签","module");
 }
if(document.getElementById("sort")!=null)
  {
   var Sort=document.getElementById("sort");
   Sort.value="<%=SortId%>";
   if(Sort.selectedIndex<0)
    {
      Sort.selectedIndex=0;
    }
  }

  if("<%=Comment_Open%>"=="1")
   {
     document.getElementById("comment_open_1").checked=true;
   }
  if("<%=Comment_Check%>"=="0")
   {
     document.getElementById("comment_check").checked=false;
   }
  if("<%=Comment_Anonymous%>"=="0")
   {
     document.getElementById("comment_anonymous").checked=false;
   }

 function C_Form()
  {
     var obj=document.getElementById("sort");
     if(obj!=null && obj.value=="")
     {
       alert("请选择专题分类!");
       showtab(0);
       obj.focus();
       return false;
     }
     obj=document.getElementById("zt_title");
     if(obj.value=="")
     {
       alert("请填写标题!");
       showtab(0);
       obj.focus();
       return false;
     }

    obj=document.getElementById("zt_dir")
    if(obj.value=="")
     {
       alert("专题目录必须填写!");
       showtab(0);
       obj.focus();
       return false;
     }

     obj=document.getElementById("zt_file")
     if(obj.value=="")
       {
        alert("专题文件名必须填写!");
        showtab(0);
        obj.focus();
        return false;
       }
    startpost();
  }
</script>
</html>  



