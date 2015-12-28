<% @ Page Language="C#"   Inherits="PageAdmin.lanmu_spc"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_spc"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>局部内容设置</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top>
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">自定义栏目</li>
<li id="tab" name="tab"  onclick="showtab(1)">会员中心</li>
<li id="tab" name="tab"  onclick="showtab(2)">搜索页面</li>
</ul>
</div>

<table border=0 cellpadding=5 cellspacing=0  width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
     <tr>
          <td height=40 width="100px">是否开启</td>
          <td><asp:CheckBox id="Spe_lanmu_open"  Runat="server" />开启自定义栏目(通过此功能，用户可制作个性化的栏目菜单)</td>
      </tr> 
      <tr>
          <td>
         栏目内容
         <br><a href="javascript:Open_Editor('pa_webset','zdy_lanmu','<%=FieldId%>','Content','栏目内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
        </td>
          <td>
             <asp:TextBox id="Content" TextMode="MultiLine"  runat="server" columns="80" rows="15"/>
          </td>
      </tr> 
      
    </table>
<br>
<div align="left">说明：开启自定义栏目后，系统默认栏目将不显示，所以自定义栏目中的链接务必和默认栏目链接保持一致。</div>

</div>

<div name="tabcontent" id="tabcontent" style="display:none">

<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
  <td width=120px height=40 >会员中心风格</td>
  <td><asp:DropDownList id="csspath_member" runat="server"><asp:ListItem value="">默认风格</asp:ListItem></asp:DropDownList>
  </td>
 </tr>

<tr>
  <td>Head区自定义</td>
  <td><asp:TextBox  id="zdy_head_member" TextMode="MultiLine" runat="server" columns="75" rows="8" />
  </td>
</tr>

<tr>
  <td>顶部信息自定义
 <br><a href="javascript:Open_Editor('pa_webset','zdy_wztop_member','<%=FieldId%>','zdy_wztop_member','顶部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td><asp:TextBox  id="zdy_wztop_member"  TextMode="MultiLine"  runat="server" columns="75" rows="8" />
  </td>
 </tr>


<tr>
  <td>栏目自定义
 <br><a href="javascript:Open_Editor('pa_webset','zdy_lanmu_member','<%=FieldId%>','zdy_lanmu_member','栏目自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td>
<asp:TextBox id="zdy_lanmu_member" TextMode="MultiLine"  runat="server" columns="75" rows="8" />
  </td>
 </tr>


<tr>
  <td width=100px>横幅自定义
 <br><a href="javascript:Open_Editor('pa_webset','zdy_banner_member','<%=FieldId%>','zdy_banner_member','横幅自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td>
<asp:TextBox  id="zdy_banner_member"  TextMode="MultiLine"  runat="server" columns="75" rows="8" />
  </td>
 </tr>

<tr>
  <td>底部信息自定义
 <br><a href="javascript:Open_Editor('pa_webset','zdy_bottom_member','<%=FieldId%>','zdy_bottom_member','底部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td>
  <asp:TextBox  id="zdy_bottom_member" TextMode="MultiLine"  runat="server" columns="75" rows="8" />
  </td>
 </tr>
</table>

<br>
<div align="left">说明：以上项目留空则显示默认内容</div>
</div>


<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
  <td width=120px height=40 >搜索页风格<br></td>
  <td><asp:DropDownList id="csspath_search" runat="server"><asp:ListItem value="">默认风格</asp:ListItem></asp:DropDownList>
  </td>
 </tr>

<tr>
  <td>Head区自定义</td>
  <td><asp:TextBox  id="zdy_head_search" TextMode="MultiLine" runat="server" columns="75" rows="8" />
  </td>
</tr>

<tr>
  <td>顶部信息自定义
 <br><a href="javascript:Open_Editor('pa_webset','zdy_wztop_search','<%=FieldId%>','zdy_wztop_search','顶部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td><asp:TextBox id="zdy_wztop_search"  TextMode="MultiLine" runat="server" columns="75" rows="8" />
  </td>
 </tr>


<tr>
  <td>栏目自定义
 <br><a href="javascript:Open_Editor('pa_webset','zdy_lanmu_search','<%=FieldId%>','zdy_lanmu_search','栏目自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td>
<asp:TextBox  id="zdy_lanmu_search"  TextMode="MultiLine"  runat="server" columns="75" rows="8" />
  </td>
 </tr>


<tr>
  <td width=100px>横幅自定义
 <br><a href="javascript:Open_Editor('pa_webset','zdy_banner_search','<%=FieldId%>','zdy_banner_search','横幅自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td>
<asp:TextBox  id="zdy_banner_search"  TextMode="MultiLine"  runat="server" columns="75" rows="8" />
  </td>
 </tr>

<tr>
  <td>底部信息自定义
 <br><a href="javascript:Open_Editor('pa_webset','zdy_bottom_search','<%=FieldId%>','zdy_bottom_search','底部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td>
  <asp:TextBox  id="zdy_bottom_search"  TextMode="MultiLine"  runat="server" columns="75" rows="8" />
  </td>
 </tr>
</table>
<br>
<div align="left">说明：以上项目留空则显示默认内容</div>
</div>
<br>
<div align="center">
<span id="post_area"><asp:Button Text=" 提 交 " runat="server" cssclass="button"  onclick="Data_Update" Id="Bt_Submit"/></span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span> 
</div>
 </td>
 <tr>
</table>
</form>
</td>
</tr>
</table>
<br>
</center>
</body>
<script language="javascript">
if(GetCookie("tab")!="")
 {
  showtab(GetCookie("tab"));
 }   
document.getElementById("Bt_Submit").onclick=startpost;
</script>
</html>