<% @ Page Language="C#" Inherits="PageAdmin.slide_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="js_slide"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>幻灯片设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b>名称</b>：<%=Request.QueryString["name"]%></td>
 </tr>
</table>

<table border=0 cellpadding=3 cellspacing=0 width=95% align=center>
<tr>
  <td height=25 width=100>幻灯类型</td>
  <td> <asp:DropDownList id="Dl_Style" runat="server">
       <asp:ListItem Value="0">js幻灯</asp:ListItem>
       <asp:ListItem Value="1">js幻灯(带数字)</asp:ListItem>
       <asp:ListItem Value="2">Flash焦点幻灯</asp:ListItem>
       <asp:ListItem Value="3">bcastr幻灯</asp:ListItem>
       </asp:DropDownList>
 </tr>

<tr>
  <td height=25>图片来源数据表</td>
  <td><asp:DropDownList id="Dl_Table" runat="server" DataTextField="table_name" DataValueField="thetable" AutoPostBack="true" OnSelectedIndexChanged="Table_Change"></asp:DropDownList></td>
 </tr>
<asp:PlaceHolder id="p_1" runat="server">
<tr>
  <td  height=25>调用类别</td>
  <td>
<select name="s_sort" id="s_sort" onchange="c_sort(1,'<%=TheTable%>','admin')">
<option  value="0">---所有类别---</option>
<%=Sort_List%>
</select>
<input type="hidden" name="sort" id="sort" value="<%=Sort_Id%>">
<script type="text/javascript">
var Sort_Type="all";
Write_Select('<%=TheTable%>');
Load_Sort("<%=P_Sorts%>,<%=Sort_Id%>",'<%=TheTable%>');
</script>
</td>
 </tr>
<tr>
  <td  height=25>显示类型</td>
  <td><asp:DropDownList id="D_ShowType" runat="server">
       <asp:ListItem value="">选择类型</asp:ListItem>
       <asp:ListItem value="istop=1">设为"置顶"的信息</asp:ListItem>
       <asp:ListItem value="isgood=1">设为"推荐"的信息</asp:ListItem>
       <asp:ListItem value="isnew=1">设为"最新"的信息</asp:ListItem>
       <asp:ListItem value="ishot=1">设为"热门"的信息</asp:ListItem>
   </asp:DropDownList>

<asp:DropDownList  id="D_NotShowType"   Runat="server">
<asp:ListItem value="">选择排除类型</asp:ListItem>
<asp:ListItem value="istop=0">排除"置顶"的信息</asp:ListItem>
<asp:ListItem value="isgood=0">排除"推荐"的信息</asp:ListItem>
<asp:ListItem value="isnew=0">排除"最新"的信息</asp:ListItem>
<asp:ListItem value="ishot=0">排除"热门"的信息</asp:ListItem>
<asp:ListItem value="reply_state>=1">排除"未回复"的信息</asp:ListItem>
<asp:ListItem value="titlepic<>''">排除"标题图片"为空的信息</asp:ListItem>
</asp:DropDownList>
自定义条件：<asp:TextBox id="zdy_condition" Runat="server" size="30" Maxlength="50"/>

</td>
 </tr>

<tr>
  <td  height=25>排序方式</td>
  <td><asp:DropDownList id="Dl_list_order" runat="server">
	<asp:ListItem value="">默认排序</asp:ListItem>
	<asp:ListItem value="order by thedate desc">按发布时间↓</asp:ListItem>
	<asp:ListItem value="order by thedate">按发布时间↑</asp:ListItem>
	<asp:ListItem value="order by id desc">按ID↓</asp:ListItem>
	<asp:ListItem value="order by id">按ID↑</asp:ListItem>
	<asp:ListItem value="order by clicks desc">按点击量↓</asp:ListItem>
	<asp:ListItem value="order by downloads desc">按下载量↓</asp:ListItem>
	<asp:ListItem value="order by comments desc">按评论量↓</asp:ListItem>
   </asp:DropDownList></td>
 </tr>

<tr>
  <td  height=25>标题显示字数</td>
  <td><asp:TextBox id="Pic_title_num" runat="server"  Maxlength="3" size="5"/> 个字符 
 <asp:RequiredFieldValidator   ControlToValidate="Pic_title_num" display="Dynamic" type="integer"  runat="server">
显示字数不能为空</asp:RequiredFieldValidator>
<asp:RangeValidator   ControlToValidate="Pic_title_num" display="Dynamic" type="integer" MinimumValue="0" MaximumValue="100" runat="server">
请输入0—100之间的数字</asp:RangeValidator></td>
 </tr>

<tr>
  <td  height=25>图片总显示数</td>
  <td><asp:TextBox id="Show_num" runat="server"  Maxlength=3 size=5/> 张图片
 <asp:RequiredFieldValidator   ControlToValidate="Show_num" display="Dynamic" type="integer"  runat="server">
不能为空</asp:RequiredFieldValidator>
<asp:RangeValidator   ControlToValidate="Show_num" display="Static" type="integer" MinimumValue="1" MaximumValue="100" runat="server">
请输入1—100之间的数字</asp:RangeValidator></td>
 </tr>
</asp:PlaceHolder>

<asp:PlaceHolder id="p_2" runat="server" Visible="false">
<tr>
  <td  height=25>图片地址</td>
  <td><asp:TextBox id="Zdy_image" runat="server"  TextMode="multiLine"  Columns="70" Rows="5" /> 多个图片请用"|"分开,
 <asp:RequiredFieldValidator   ControlToValidate="zdy_image" display="Dynamic" type="integer"  runat="server">
不能为空</asp:RequiredFieldValidator>
 </tr>
<tr>
  <td  height=25>图片链接</td>
  <td><asp:TextBox id="Zdy_link" runat="server"  TextMode="multiLine"  Columns="70" Rows="5"/> 多个链接请用"|"分开,
 </tr>
<tr>
  <td  height=25>图片标题</td>
  <td><asp:TextBox id="Zdy_title" runat="server"  TextMode="multiLine"  Columns="70" Rows="5"/> 多个链接请用"|"分开,

 </tr>
</asp:PlaceHolder>

<tr>
  <td  height=25>图片边框</td>
  <td><asp:DropDownList id="Dl_border_width" runat="server" >
     <asp:ListItem value="0">无边框</asp:ListItem>
     <asp:ListItem value="1">带边框</asp:ListItem>
     </asp:DropDownList>
边框颜色：<asp:TextBox id="Tb_border_color"  runat="server" size="5" maxlength="8"/><a href="javascript:foreColor('Tb_border_color','')"><img src=images/color.gif border=0 height=21 align=absbottom></a>
  </td>
 </tr>

<tr>
  <td  height=25>图片尺寸</td>
  <td>宽：<asp:TextBox id="Tb_width"  runat="server" size="4" maxlength="4"/>px
高：<asp:TextBox id="Tb_height" runat="server" size="4" maxlength="4" />px
<asp:RequiredFieldValidator  ControlToValidate="Tb_width" display="Dynamic" type="integer"  runat="server">
宽度不能为空</asp:RequiredFieldValidator>
<asp:RequiredFieldValidator ControlToValidate="Tb_height" display="Dynamic" type="integer"  runat="server">
高度不能为空</asp:RequiredFieldValidator>

<asp:RangeValidator ControlToValidate="Tb_width" display="Dynamic" type="integer" MinimumValue="0" MaximumValue="10000" runat="server">
请输入正确的宽度</asp:RangeValidator>
<asp:RangeValidator ControlToValidate="Tb_height" display="Dynamic" type="integer" MinimumValue="0" MaximumValue="10000" runat="server">
请输入正确的高度</asp:RangeValidator>
</td>
 </tr>

<tr>
  <td  height=25 width=100>链接窗口</td>
  <td><asp:RadioButton id="RB_target_1" GroupName="Target" runat="server" />原窗口&nbsp;&nbsp;<asp:RadioButton id="RB_target_2" GroupName="Target" runat="server" />新窗口</td>
</tr>
</table>
<br>
<div align=center>
<asp:Button Text="提交" CssClass="button" Runat="server" OnClick="Data_Update" id="Bt_Submit"/>
<input type="button" class=button  value="返回"  onclick="location.href='slide_list.aspx'">
</div>
</td>
</tr>
</table>
<br>
注意："链接窗口"仅对JS幻灯片有效,flash焦点幻灯只能为jpg格式。

<asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">

var obj1=document.getElementById("D_ShowType");
var obj2=document.getElementById("D_NotShowType");
var obj3=document.getElementById("zdy_condition");
obj1.onchange=change_showtype;
obj2.onchange=change_showtype;
function change_showtype()
 {
   var v1=obj1.value;
   var v2=obj2.value;
   if(v2!="")
    {
      if(v1=="")
       {
        obj3.value="and "+v2;
       }
      else
       {
        obj3.value="and "+v1+" and "+v2;
       }
    }
  else
    {
      obj3.value="and "+v1;
    }
  if(v2=="" && v1=="")
   {
    obj3.value="";
   }
 }

function change_notshowtype()
 {
  change_showtype();
 }
</script>
</body>
</html>