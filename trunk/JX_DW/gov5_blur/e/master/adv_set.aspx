<% @ Page Language="C#" Inherits="PageAdmin.adv_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"  Type="js_adv"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1 align="left"><b>广告设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
  <td height=10></td>
 </tr>
</table>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
 <tr>
  <td height=25px  align="left" width="100px">窗口名称</td>
  <td height=25px  align="left"><asp:TextBox id="Adv_name" maxlength="50" size="30" runat="server" /></td>
 </tr>

  <tr>
   <td height=25 align="left">广告类型</td>
    <td height=25px  align="left">
    <asp:DropDownlist id="Adv_Type" Runat="server">
     <asp:ListItem value="1">弹出窗口广告</asp:ListItem>
     <asp:ListItem value="2">漂浮广告</asp:ListItem>
     <asp:ListItem value="3">对联广告</asp:ListItem>
     <asp:ListItem value="4">自定义js</asp:ListItem>
    </asp:DropDownlist>
    </td>
  </tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left">应用范围</td>
  <td height=25px  align="left">
<asp:RadioButton id="Adv_Close" GroupName="range" runat="server" />关闭 <asp:RadioButton id="Adv_index"  GroupName="range" runat="server" />首页<asp:RadioButton id="Adv_all" GroupName="range" runat="server" />所有栏目
</td>
</tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left" width="100px">窗口标题</td>
  <td height=25px  align="left"><asp:TextBox id="Adv_title" maxlength="80" size="60" runat="server" /></td>
</tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left" width="100px">窗口参数</td>
  <td height=25px  align="left" ><asp:TextBox id="Adv_canshu" maxlength="80" size="60" runat="server" /></td>
</tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left" width="100px">广告内容<br><a href="javascript:Open_Editor('pa_adv','content','<%=FieldId%>','Adv_content','广告内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td height=25px  align="left" ><asp:TextBox id="Adv_content" TextMode="multiline" columns="90" rows="25" runat="server" /></td>
</tr>

<tr id="tr_item" name="tr_item">
 <td height=25px  align="left" width="100px">左侧内容<br><a href="javascript:Open_Editor('pa_adv','left_content','<%=FieldId%>','Left_content','广告内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td height=25px  align="left" ><asp:TextBox id="Left_content" TextMode="multiline" columns="80" rows="8" runat="server" /></td>
</tr>

<tr id="tr_item" name="tr_item">
  <td height=25px  align="left" width="100px">右侧内容<br><a href="javascript:Open_Editor('pa_adv','right_content','<%=FieldId%>','Right_content','广告内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td height=25px  align="left"><asp:TextBox id="Right_content" TextMode="multiline" columns="80" rows="8" runat="server" /></td>
</tr>

</table>

</td>
</tr>
</table>
<br>
<div align=center>
<span id="post_area">
<asp:Button Text=" 提交 " Cssclass="button" runat="server" OnClick="Data_Update" id="Bt_Submit" />
<input type="button" class="button" onclick="location.href='adv_list.aspx'" value="返回">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span> 
</div>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
 function change_type()
  {
   var thetype=document.getElementById("Adv_Type").value;
   var Obj=document.getElementsByName("tr_item");
   hideall(Obj);
   switch(thetype)
    {
      case "1":
       Obj[0].style.display="";
       Obj[1].style.display="";
       Obj[2].style.display="";
       Obj[3].style.display="";
      break;
      case "2":
       Obj[0].style.display="";
       Obj[4].style.display="";
      break;
      case "3":
       Obj[0].style.display="";
       Obj[4].style.display="";
       Obj[5].style.display="";
      break;
      case "4":
       Obj[3].style.display="";
      break;
    }
  }
change_type();
document.getElementById("Bt_Submit").onclick=startpost;
</script>
</body>
</html>  



