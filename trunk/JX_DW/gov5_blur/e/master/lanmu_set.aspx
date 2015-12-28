<% @ Page Language="C#" Inherits="PageAdmin.lanmu_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_list"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>栏目参数设置</td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25 align="left">当前栏目：<%=Request.QueryString["lanmu"]%></td>
 </tr>
</table>
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<tr>
  <td style="width:100px">风格样式<br></td>
  <td><asp:DropDownList id="D_csspath" runat="server"><asp:ListItem value="">默认风格</asp:ListItem></asp:DropDownList>
  </td>
 </tr>

<tr style="display:<%=Is_Static=="0"?"none":""%>">
  <td width=100px>封面页静态<br></td>
  <td>
    <asp:DropDownList id="D_Html" runat="server">
    <asp:ListItem value="1">静态文件</asp:ListItem>
    <asp:ListItem value="0">动态文件</asp:ListItem>
    </asp:DropDownList>
  </td>
 </tr>

<tr>
  <td>自定义链接</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="tb_url" runat="server" size=80 maxlength="150"  />
</td>
</tr>

<tr>
  <td>Seo标题</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="tb_title" runat="server" size=80 maxlength="150"  />
</td>
 </tr>

<tr>
  <td>Seo关键字</td>
 <td align="left" title="关键字之间用半角逗号分开"><asp:textBox TextMode="singleLine" id="tb_keywords" runat="server" size=80 maxlength="150"  />
</td>
 </tr>

<tr>
  <td>Seo描述</td>
 <td align="left" title="控制在250字以内"><asp:TextBox TextMode="multiLine" Columns="70" rows="5"  id="tb_description"  runat="server" onkeyup="if(this.value.length>250)this.value=this.value.substring(0,250)"/>
</td>
 </tr>

<tr>
  <td>头信息自定义<br></td>
  <td><asp:TextBox  id="Headzdy" TextMode="MultiLine" runat="server" columns="70" rows="6" />
  </td>
</tr>

<tr>
 <td colspan=2 height="30">注:&lt;head&gt;&lt;/head&gt;之间的内容</td>
</tr>


<tr>
  <td>顶部信息自定义<br><a href="javascript:Open_Editor('pa_lanmu','zdy_wztop','<%=FieldId%>','Wztopzdy','顶部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Wztopzdy"  TextMode="MultiLine"  runat="server" columns="70" rows="6" />
  </td>
 </tr>
<tr>
<tr>
 <td colspan=2 height="30">注:自动替换网站顶部信息，留空则显示默认。</td>
</tr>

<tr>
  <td>栏目自定义<br><a href="javascript:Open_Editor('pa_lanmu','zdy_lanmu','<%=FieldId%>','Lanmuzdy','栏目自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox id="Lanmuzdy" TextMode="MultiLine"  runat="server" columns="70" rows="6" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="30">注:自动替换网站默认栏目条，留空则显示默认。</td>
</tr>

<tr>
  <td>下拉菜单自定义<br><a href="javascript:Open_Editor('pa_lanmu','zdy_dropmenu','<%=FieldId%>','Dropmenuzdy','下拉菜单自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Dropmenuzdy"  TextMode="MultiLine"  runat="server" columns="70" rows="6" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="30">注:支持三级下拉，格式为：&lt;ul&gt;&lt;li&gt;&lt;a href="链接"&gt;链接内容&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;,多条下拉可相应增加&lt;li&gt;&lt;/li&gt;记录</td>
</tr>

<tr>
  <td width=100px>横幅自定义<br><a href="javascript:Open_Editor('pa_lanmu','zdy_banner','<%=FieldId%>','Banner','banner横幅自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Banner"  TextMode="MultiLine"  runat="server" columns="70" rows="6" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="30">注:留空则默认通栏Banner，不显示默认banner可以输入&lt;p/&gt;等HTML空白标签</td>
</tr>
<tr>
  <td>小幅banner自定义<br><a href="javascript:Open_Editor('pa_lanmu','zdy_smallbanner','<%=FieldId%>','SmallBanner','小幅banner自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="SmallBanner"  TextMode="MultiLine"  runat="server" columns="70" rows="6" />
  </td>
 </tr>

<tr>
  <td>底部信息自定义<br><a href="javascript:Open_Editor('pa_lanmu','zdy_bottom','<%=FieldId%>','Wzbottomzdy','底部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Wzbottomzdy"  TextMode="MultiLine"  runat="server" columns="70" rows="6" />
  </td>
 </tr>
<tr>
<tr>
 <td colspan=2 height="30">注:自动替换网站底部信息，留空则显示默认。</td>
</tr>
</table>

</td>
</tr>
</table>
<br>
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
<td height=25 align=center >
<asp:Label    id="Lb_SiteDir"   runat="server" Visible="false" />
<asp:Label    id="Lb_OldFile"   runat="server" Visible="false" />
<span id="post_area">
<asp:Button Cssclass=button  text="提交" id="Bt_Submit" runat="server" onclick="Data_Update" />
<input type="button" class=button  value="返回"  onclick="location.href='lanmu_list.aspx'">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</td>
 </tr>
</table>
<asp:Label id="LblErr" runat="server" />

</form>

</td>
</tr>
</table>

</center>
</body>
<script language="javascript">  
document.getElementById("Bt_Submit").onclick=startpost;
</script>
</html>  
