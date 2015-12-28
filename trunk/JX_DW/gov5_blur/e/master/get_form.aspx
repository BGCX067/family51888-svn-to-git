<% @ Page Language="C#" Inherits="PageAdmin.get_form"%>
<% @ Register TagPrefix="aspcn" TagName="uc_fckeditor" src="/e/incs/fckeditor/fckeditor.ascx" %>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="zdytable_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>获取表单(<%=Request.QueryString["tablename"]%>)</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="showtab(0)" style="font-weight:bold">发布表单</li>
<li id="tab" name="tab" onclick="showtab(1)">搜索表单</li>
</ul>
</div>
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=10 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td><asp:TextBox id="Content" TextMode="MultiLine"  runat="server" />
      <aspcn:uc_fckeditor  Tb_Id="Content" Fck_Height="400" Fck_Style="Default" runat="server"/>
  </td>
 </tr>
 <tr><td>注：编辑器却换到源代码模式可获取表单代码，在不修改表单项目基础上可自行美化。</td></tr>
</table>
</div>
<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=10 cellspacing=0 width=100% align=center class=table_style2>
 <tr>
  <td ><asp:TextBox id="Search" TextMode="MultiLine"  runat="server" />
      <aspcn:uc_fckeditor  Tb_Id="Search" Fck_Height="300" Fck_Style="Default" runat="server"/>
  </td>
   </tr>
 <tr><td>搜索HTML代码用法：却换到源代码模式，找到name=modelid的value，改为对应的搜索模型ID。</td></tr>
</table>
</div>
<div align=center style="padding:10px"><input type="button" class=button value="关闭"  onclick="parent.CloseDialog()"></div>
</td>
</tr>
</table>
<br>
</td>
</tr>
</table>
</form>
</center>
</body>
</html>

