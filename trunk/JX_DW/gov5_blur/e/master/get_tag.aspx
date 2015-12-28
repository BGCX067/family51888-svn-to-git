<% @ Page Language="C#" Inherits="PageAdmin.get_tag"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" />  
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98% >
 <tr>
<td valign=top  align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
  <td width=100px height=30>数据站点</td>
  <td>
     <asp:DropDownList id="D_Site" DataTextField="sitename" DataValueField="id"  Runat="server" AutoPostBack="True"/> <span style="color:#999999">当前站点ID值：<%=SiteId%></span>
  </td>
 </tr>

<tr>
  <td width=100px height=30>选择模型</td>
  <td>
     <asp:DropDownList id="D_Table" DataTextField="table_name" DataValueField="thetable"  Runat="server" AutoPostBack="True"/>
     <asp:DropDownList id="D_Model" DataTextField="name" DataValueField="id"  Runat="server" onchange="show_modelid(this.value)"/> <span style="color:#999999" id="s_modelid">当前模型ID值：0</span>
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
<span style="color:#999999">当前分类ID值：<input type="text" name="sort" id="sort" value="0" size="10" style="background-color:#D1EAFE;border-width:0px;color:#999999"></span>
  </td>
 </tr>

 <tr>
  <td  height=30>信息筛选</td>
  <td><select name="D_ShowType" id="D_ShowType" onchange="change_showtype()">
	<option selected="selected" value="">选择类型</option>
	<option value="istop=1">&quot;置顶&quot;的信息</option>
	<option value="isgood=1">&quot;推荐&quot;的信息</option>
	<option value="isnew=1">&quot;最新&quot;的信息</option>
	<option value="ishot=1">&quot;热门&quot;的信息</option>

</select><select name="D_NotShowType" id="D_NotShowType" onchange="change_notshowtype()">
	<option selected="selected" value="">选择排除类型</option>
	<option value="istop=0">排除&quot;置顶&quot;信息</option>
	<option value="isgood=0">排除&quot;推荐&quot;信息</option>
	<option value="isnew=0">排除&quot;最新&quot;信息</option>
	<option value="ishot=0">排除&quot;热门&quot;信息</option>
	<option value="reply_state>=1">排除&quot;未回复&quot;信息</option>
	<option value="titlepic&lt;>''">排除无&quot;标题图片&quot;信息</option>

</select>条件：<input name="zdy_condition" type="text" maxlength="50" id="zdy_condition" size="30" />

</td>
 </tr>

  <tr>
  <td  height=30>信息排序</td>
  <td>
<asp:DropDownList id="D_SortStr" Runat="server">
</asp:DropDownList>
</td>
 </tr>

  <tr>
  <td height=30>目标窗口</td>
  <td><asp:DropDownList id="D_Target" Runat="server"><asp:ListItem value="_self">本窗口</asp:ListItem><asp:ListItem value="_blank">新窗口</asp:ListItem></asp:DropDownList></td>
 </tr>

  <tr>
  <td height=30>显示信息数</td>
  <td><asp:TextBox id="Show_Num" runat="server" Value="5" Maxlength="3" size=5/> 条记录</td>
 </tr>

  <tr>
  <td  height=30>标题显示数</td>
  <td><asp:TextBox id="Title_Num" runat="server" Value="50" Maxlength="3" size=5/> 个字符</td>
 </tr>

  <tr>
  <td  height=30>标题图片</td>
  <td>宽：<asp:TextBox id="TitlePic_Width" runat="server"  Maxlength="5" Text="150" size=5/>px 高：<asp:TextBox id="TitlePic_Height" runat="server" Text="150" Maxlength="5" size=5/>px 注：其中一个设置0表示自动缩放</td>
 </tr>



  <tr>
  <td height=30><input type="button" class=bt  value="获取标签"  onclick="get_tag()"></td>
  <td><input type="textbox" id="tag" size="85" Maxlength="100"></td>
 </tr>
</table>

</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</center>
<script language="javascript">

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

function show_modelid(Id)
 {
  document.getElementById("s_modelid").innerHTML="当前模型ID值："+Id;
 }

function change_notshowtype()
 {
  change_showtype();
 }

function get_tag()
 {
   var Table=document.getElementById("D_Table");
   if(Table.value=="0")
    {
      alert("请选择模型对应的数据表!");
      Table.focus();
      return;
    }
   var Model=document.getElementById("D_Model");
   if(Model.value=="0")
    {
      alert("请选择模型!");
      Model.focus();
      return;
    }
   var Tag=document.getElementById("tag");
   var Sql_Lj="";
   var TagStr=document.getElementById("D_Site").value+","+Model.value+","+document.getElementById("sort").value;
   TagStr+=","+obj3.value;
   TagStr+=","+document.getElementById("D_SortStr").value+","+document.getElementById("D_Target").value+","+document.getElementById("Show_Num").value+","+document.getElementById("Title_Num").value;
   TagStr+=","+document.getElementById("TitlePic_Width").value+","+document.getElementById("TitlePic_Height").value;
   Tag.value="{pa:model}"+ubb(TagStr)+"{/pa:model}";
 }
function ubb(content)
 {
   content=ReplaceAll(content,"\\","/fxg/");
   content=ReplaceAll(content,"*","/xh/");
   content=ReplaceAll(content,"+","/jh/");
   content=ReplaceAll(content,"?","/wh/");
   content=ReplaceAll(content,"$","/my/");
   content=ReplaceAll(content,"(","/lykh/");
   content=ReplaceAll(content,")","/rykh/");
   content=ReplaceAll(content,"[","/lfkh/");
   content=ReplaceAll(content,"]","/rfkh/");
   content=ReplaceAll(content,"{","/ldkh/");
   content=ReplaceAll(content,"}","/rdkh/");
   return content;
 }
</script>
</body>
</html>  