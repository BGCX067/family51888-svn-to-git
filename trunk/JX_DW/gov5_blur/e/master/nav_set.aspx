<% @ Page Language="C#" Inherits="PageAdmin.nav_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_fckeditor" src="/e/incs/fckeditor/fckeditor.ascx" %>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>导航设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">内容设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">相关参数</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td height=25><b>当前导航</b>：<%=NavName%></td>
 </tr>
</table>
<div name="tabcontent" id="tabcontent">
<asp:PlaceHolder id="P1" runat="server" Visible="false">
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td style="width:100px">标签模式</td>
  <td>
   <input name="ZdyTag_Open" id="ZdyTag_Open"  type="checkbox" value="1" onclick="C_Mode()" <%=Zdy_Tag_Open=="1"?"checked":""%>>
   <a href="javascript:Open_TagWin()">&gt;&gt;点击生成标签</a>
  <td>
 </tr>
<tr>
  <td style="width:100px">
内容编辑
<br><a href="javascript:Open_Editor('pa_nav','zdy_tag','<%=Request.QueryString["navid"]%>','Zdy_Tag','导航内容编辑')"  id="open_editor" style="display:none"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td>
     <div id="dcontent" name="dcontent">
      <asp:TextBox  id="Content" TextMode="MultiLine"  runat="server" />
      <aspcn:uc_fckeditor Tb_Id="Content" Fck_Height="350" Fck_Style="Normal" runat="server"/>
     </div>
     <div id="dcontent" name="dcontent"  style="display:none">
     <asp:TextBox  id="Zdy_Tag" TextMode="MultiLine" runat="server" style="width:100%;height:300px"/>
     </div>
     
  </td>
 </tr>
</table>
</asp:PlaceHolder>
<asp:PlaceHolder id="P2" runat="server" Visible="false">
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td width=100px height=30>导航模型</td>
  <td>
     <asp:DropDownList  id="D_Model"  DataTextField="name" DataValueField="id"  Runat="server"/>
  </td>
 </tr>

<tr>
  <td height=30>调用类别</td>
  <td>
<select name="s_sort" id="s_sort" onchange="c_sort(1,'<%=TheTable%>','admin')">
<option  value="0">---所有类别---</option>
<%=Sort_List%>
</select>
<script type="text/javascript">
var Sort_Type="all";
Write_Select('<%=TheTable%>')
</script>
<input type="hidden" name="sort" id="sort" value="<%=Sort_Id%>">
  </td>
 </tr>

 <tr>
  <td  height=30>信息筛选</td>
  <td><asp:DropDownList  id="D_ShowType"   Runat="server">
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
  <td height=30>信息排序</td>
  <td>
<asp:DropDownList id="D_SortStr" Runat="server">
<asp:ListItem value="">默认排序</asp:ListItem>
</asp:DropDownList>
</td>
 </tr>

  <tr>
  <td height=30>目标窗口</td>
  <td><asp:DropDownList id="D_Target" Runat="server"><asp:ListItem value="_self">本窗口</asp:ListItem><asp:ListItem value="_blank">新窗口</asp:ListItem></asp:DropDownList></td>
 </tr>

  <tr>
  <td height=30>显示信息数</td>
  <td><asp:TextBox id="Show_Num" runat="server" Value="5" Maxlength="3" size=5/> 条记录
</td>
 </tr>

  <tr>
  <td  height=30>标题显示数</td>
  <td><asp:TextBox id="Title_Num" runat="server" Value="50" Maxlength="3" size=5/> 个字符</td>
 </tr>

  <tr>
  <td  height=30>标题图片</td>
  <td>宽：<asp:TextBox id="TitlePic_Width" runat="server"  Maxlength="5" size=5/>px 高：<asp:TextBox id="TitlePic_Height" runat="server" Maxlength="5" size=5/>px 注：其中一个设置0表示自动缩放</td>
 </tr>

</table>
</asp:PlaceHolder>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding="2" cellspacing="0" width="95%" align=center>
<tr>
  <td  height=25 width="100px">默认导航标志</td>
  <td align="left"><asp:RadioButton id="RB_Show" GroupName="Hide" runat="server" />显示&nbsp;&nbsp;<asp:RadioButton id="RB_Hide" GroupName="Hide" runat="server" />隐藏</td>
 </tr>
 <tr>
  <td  height=25>目标地址</td>
  <td align="left"><asp:TextBox id="Url" runat="server"  size="70" maxlength="250"/></td>
 </tr>
<tr>
  <td  height=25>导航风格</td>
  <td align="left"><asp:DropDownList  id="D_Style"  DataTextField="name" DataValueField="id" Runat="server" /></td>
</tr>
<tr>
  <td height=30>内容区高度</td>
  <td><asp:TextBox id="Nav_Height" runat="server"  size="7" maxlength="12" value="auto"/>(如：200，默认单位为px，留空或设为auto则自动适应内容高度)</td>
</tr>
<tr>
  <td  height=25>自定义头信息</td>
  <td align="left"><asp:TextBox  id="HeadContent"  TextMode="MultiLine"  runat="server" />
      <aspcn:uc_fckeditor Tb_Id="HeadContent" Fck_Height="150" Fck_Style="Basic" runat="server" /></td>
 </tr>
<tr>
  <td  height=25>导航应用</td>
  <td align="left">
   <select name="NavRange" id="NavRange">
    <option value="0">所有子栏目导航</option><%=Sublanmu_Options%>
   </select> 注：设置导航是否在对应子栏目中显示
</td>
 </tr>
<tr>
  <td height=40>页面显示设置</td>
  <td align="left">
封面页：<asp:DropDownList  id="D_Nav_used_module"  Runat="server">
<asp:ListItem value="1">显示</asp:ListItem>
<asp:ListItem value="0" style="color:#ff0000">关闭</asp:ListItem>
</asp:DropDownList>&nbsp;
子栏目页：<asp:DropDownList  id="D_Nav_used_sublanmu"  Runat="server">
<asp:ListItem value="1">显示</asp:ListItem>
<asp:ListItem value="0" style="color:#ff0000">关闭</asp:ListItem>
</asp:DropDownList>&nbsp;
内容页：<asp:DropDownList  id="D_Nav_used_detail"  Runat="server">
<asp:ListItem value="1">显示</asp:ListItem>
<asp:ListItem value="0" style="color:#ff0000">关闭</asp:ListItem>
</asp:DropDownList>
</td>
</tr>
</table>
</div>
<div align=center style="padding:5px">
<span id="post_area">
<input type="hidden" name="NavName" value="<%=NavName%>">
<asp:Button Cssclass=button  text="提交" runat="server" onclick="Data_Update" id="Bt_Submit" />
<input type="button" class=button  value="关闭"  onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</td>
</tr>
</table>
<asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
<br>
</center>
</body>
<script language="javascript">
<%if(Request.QueryString["table"]=="sublanmu")
{%>
  document.getElementsByName("tabcontent")[1].style.display="";
  document.getElementById("tabdiv").style.display="none";
<%}%> 
Load_Sort("<%=P_Sorts%>,<%=Sort_Id%>",'<%=TheTable%>');
document.getElementById("NavRange").value="<%=NavRange==""?"0":NavRange%>";
var obj1=document.getElementById("D_ShowType");
var obj2=document.getElementById("D_NotShowType");
var obj3=document.getElementById("zdy_condition");

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

function C_Mode()
 {
   var Obj=document.getElementById("ZdyTag_Open");
   if(Obj.checked)
    {
      document.getElementsByName("dcontent")[0].style.display="none";
      document.getElementsByName("dcontent")[1].style.display="";
      document.getElementById("open_editor").style.display="";
    } 
  else
    {
      document.getElementsByName("dcontent")[0].style.display="";
      document.getElementsByName("dcontent")[1].style.display="none";
      document.getElementById("open_editor").style.display="none";
    }
 }

function Open_TagWin()
 {
  if(document.getElementById("ZdyTag_Open").checked)
   {
    Get_Tag("导航标签生成界面","nav");
   }
  else
   {
     alert("只有标签模式下才可以调用标签,可点击左侧的单选框开启。")
   }
 }
   <% if(TheTable=="zdy" && Zdy_Tag_Open=="1")
     {
   %>
     C_Mode();
   <%}%>

function c_f()
  {
   <% if(TheTable!="zdy" && TheTable!="sublanmu")
     {
   %>
    var obj=document.getElementById("D_Model")
    if(obj.selectedIndex==0)
     {
       showtab(0);
       alert("请选择导航模型!");
       obj.focus();
       return false;
     }

    obj=document.getElementById("Show_Num")
    if(obj.value=="" || isNaN(obj.value))
     {
       showtab(0);
       alert("显示信息数填写错误!");
       obj.focus();
       return false;
     }
  <%}%>
  startpost();
 }
document.getElementById("Bt_Submit").onclick=c_f;
function Format_Fck()
 {
   var oEditor,fckhtml;
   oEditor=FCKeditorAPI.GetInstance("HeadContent");
   if(oEditor!=null)
   {
    fckhtml=oEditor.GetXHTML(false);
    if(fckhtml=="<br />")
     {
       oEditor.SetHTML("",false);
     }
   }
 }
</script>
</html>