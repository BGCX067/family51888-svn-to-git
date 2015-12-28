<% @ Page Language="C#" Inherits="PageAdmin.module_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_fckeditor" src="/e/incs/fckeditor/fckeditor.ascx" %>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" />  
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>模块设置</b></td></tr>
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
<li id="tab" name="tab"  onclick="showtab(1)">相关参数</li>
<li id="tab" name="tab"  onclick="showtab(2)">html布局辅助</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  height=25><b>当前模块</b>：<%=ModuleName%></td>
 </tr>
</table>

<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<asp:PlaceHolder id="P1" runat="server" Visible="false">
<tr>
  <td width=100px>启用标签模式</td>
  <td>
   <input name="ZdyTag_Open" id="ZdyTag_Open"  type="checkbox" value="1" onclick="C_Mode()" <%=Zdy_Tag_Open=="1"?"checked":""%>>
   <a href="javascript:Open_TagWin()">&gt;&gt;点击生成标签</a>
  <td>
 </tr>

<tr>
  <td width=100px>
内容编辑
<br><a href="javascript:Open_Editor('pa_module','zdy_tag','<%=Request.QueryString["id"]%>','Zdy_Tag','模块内容编辑')"  id="open_editor" style="display:none"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td>
     <div id="dcontent" name="dcontent">
      <asp:TextBox  id="Content"  TextMode="MultiLine"  runat="server" />
      <aspcn:uc_fckeditor Tb_Id="Content" Fck_Height="350" Fck_Style="Normal" runat="server"/>
     </div>
     <div id="dcontent" name="dcontent"  style="display:none">
     <asp:TextBox  id="Zdy_Tag" TextMode="MultiLine" runat="server" style="width:100%;height:300px"/>
   </div>
  </td>
 </tr>

 </tr>
</asp:PlaceHolder>

<asp:PlaceHolder id="P2" runat="server" Visible="false">
<tr>
  <td width=100px height=30>模块模型</td>
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
  <td  height=30>信息排序</td>
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
  <td  height=30>显示信息数</td>
  <td><asp:TextBox id="Show_Num" runat="server" Value="5" Maxlength="3" size=5/> 条记录</td>
 </tr>

  <tr>
  <td  height=30>标题显示数</td>
  <td><asp:TextBox id="Title_Num" runat="server" Value="50" Maxlength="3" size=5/> 个字符</td>
 </tr>

  <tr>
  <td  height=30>标题图片</td>
  <td>宽：<asp:TextBox id="TitlePic_Width" runat="server"  Maxlength="5" size=5/>px 高：<asp:TextBox id="TitlePic_Height" runat="server" Maxlength="5" size=5/>px 注：其中一个设置0表示自动缩放</td>
 </tr>

</asp:PlaceHolder>
<tr>
  <td colspan=2 height=5></td><td>
 </tr>

<tr>
  <td height=30>模块布局</td>
  <td>
<asp:RadioButton id="Layout_1" GroupName="site" runat="server" Title="一个模块一行" />整行
<asp:RadioButton id="Layout_2" GroupName="site" runat="server" Title="float:left：多个模块同行显示时，可以选择靠左" />靠左
<asp:RadioButton id="Layout_3" GroupName="site" runat="server" Title="float:right：如果是同行中最右边的模块，务必选择靠右，以保证各种浏览器正常显示"/>靠右</td>
 </tr>

<tr>
  <td height=30>模块宽度</td>
  <td><asp:TextBox id="Module_Width" runat="server"  size="7" maxlength="12" value="100%" Title="模块布局为整行时此宽度设置无效" />(如：500，默认单位为px，也可定义百分比，如：100%)</td>
</tr>

<tr>
  <td height=30>内容区高度</td>
  <td><asp:TextBox id="Module_Height" runat="server"  size="7" maxlength="12" value="auto"/>(如：200，默认单位为px，留空或设为auto则自动适应内容高度)</td>
</tr>

<tr title="相对上一个模块的位置，选择'是'则从新的一行开始显示">
  <td height=30>换行显示</td>
  <td><asp:RadioButton id="Wrap_1" GroupName="wrap" runat="server"  />否<asp:RadioButton id="Wrap_2" GroupName="wrap" runat="server" />是</td>
 </tr>
</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td width=100px>模块标题</td>
  <td><asp:RadioButton id="RB_Show" GroupName="Hide" runat="server" />显示&nbsp;&nbsp;<asp:RadioButton id="RB_Hide" GroupName="Hide" runat="server" />隐藏</td>
 </tr>
<tr>
  <td>目标地址</td>
  <td><asp:TextBox id="Url" runat="server" size="70" maxlength="250"/></td>
 </tr>
<tr>
  <td>模块风格</td>
  <td><asp:DropDownList id="D_Style" DataTextField="name" DataValueField="id" Runat="server" /></td>
</tr>
<tr>
  <td>自定义头信息</td>
  <td align="left"><asp:TextBox  id="HeadContent" TextMode="MultiLine" runat="server" />
      <aspcn:uc_fckeditor Tb_Id="HeadContent" Fck_Height="150" Fck_Style="Basic"  runat="server" />
</td>
 </tr>
</table>

</div>

<div name="tabcontent" id="tabcontent" style="display:none">

<table border=0 cellpadding=2 cellspacing=0 width=92% align=center>
<tr>
  <td width=100px>模块开始处</td>
  <td align="left"><asp:TextBox id="StartHtml" TextMode="MultiLine" runat="server" Columns="60" rows="5"/>
</td>
 </tr>

<tr>
  <td>模块结束处</td>
  <td align="left"><asp:TextBox id="EndHtml" TextMode="MultiLine" runat="server" Columns="60" rows="5"/>
</td>
 </tr>
</table>
</div>
<div align=center style="padding:5px">
<span id="post_area">
<input type="hidden" name="ModuleName" value="<%=ModuleName%>">
<asp:Button Cssclass=button id="Bt_Submit" text="提交" runat="server" onclick="Data_Update" />
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
var Sort_Id="<%=Sort_Id%>";
Load_Sort("<%=P_Sorts%>,<%=Sort_Id%>",'<%=TheTable%>');

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

function c_f()
  {
   <% if(TheTable!="zdy")
     {
   %>
    var obj=document.getElementById("D_Model")
    if(obj.selectedIndex==0)
     {
       showtab(0);
       alert("请选择模块模型!");
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
    Get_Tag("模块标签生成界面","module");
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