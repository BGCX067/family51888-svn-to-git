<% @ Page Language="C#" Inherits="PageAdmin.sublanmu_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_fckeditor" src="/e/incs/fckeditor/fckeditor.ascx" %>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>子栏目设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv" style="display:<%=TheTable==""?"none":""%>">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">内容设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">页头设置</li>
<li id="tab" name="tab"  onclick="showtab(2)">相关参数</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
<tr>
  <td  colspan=2 height=25><b>当前子栏目</b>：<%=Sublanmu_Site%> &gt; <asp:Label id="Lb_Name" runat="server"/></td>
 </tr>
</table>

<asp:PlaceHolder id="Place_1" runat="server"  Visible="false">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td width=80px><b>内容编辑</b></td>
  <td>
      <asp:TextBox  id="Content"  TextMode="MultiLine"  runat="server" />
      <aspcn:uc_fckeditor Tb_Id="Content" Fck_Height="350" Fck_Style="Normal" runat="server"/>
  </td>
 </tr>
</table>
</div>
<div name="tabcontent" id="tabcontent" style="display:none"></div>
</asp:PlaceHolder>

<asp:PlaceHolder id="Place_2" runat="server" Visible="false">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td width=100px height=30>子栏目模型</td>
  <td><asp:DropDownList  id="D_Model"  DataTextField="name" DataValueField="id"  Runat="server"/>
     内容模型：<asp:DropDownList  id="D_Model_Detail"  DataTextField="name" DataValueField="id"  Runat="server"/>
  </td>
 </tr>

<tr>
  <td height=30>调用分类</td>
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
<br><asp:CheckBox id="Cb_SortSubLanmu" Runat="server" Checked/>是否作为调用分类的目标子栏目
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
<asp:DropDownList  id="D_SortStr"   Runat="server">
<asp:ListItem value="">默认排序</asp:ListItem>
</asp:DropDownList>
</td>
 </tr>

  <tr>
  <td height=30>目标窗口</td>
  <td><asp:DropDownList id="D_Target" Runat="server"><asp:ListItem value="_self">本窗口</asp:ListItem><asp:ListItem value="_blank">新窗口</asp:ListItem></asp:DropDownList></td>
 </tr>

  <tr>
  <td  height=30>每页显示数</td>
  <td><asp:TextBox id="Show_Num" runat="server" Text="20" Maxlength="5" size=5/> 条记录</td>
 </tr>

  <tr>
  <td  height=30>标题显示数</td>
  <td><asp:TextBox id="Title_Num" runat="server" Value="100" Maxlength="3" size=5/> 个字符</td>
 </tr>

  <tr>
  <td  height=30>标题图片</td>
  <td>宽：<asp:TextBox id="TitlePic_Width" runat="server"  Maxlength="5" size=5/>px 高：<asp:TextBox id="TitlePic_Height" runat="server" Maxlength="5" size=5/>px 注：其中一个设置0表示自动缩放</td>
 </tr>

</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
 <table border=0 cellpadding=0 cellspacing=2 width=98% align=center>
<tr>
  <td width=100px>页头编辑</td>
  <td><asp:TextBox  id="HeadContent"  TextMode="MultiLine"  runat="server" />
      <aspcn:uc_fckeditor  Tb_Id="HeadContent" Fck_Height="250" Fck_Style="Basic" runat="server"/>
  </td>
 </tr>
 </table>
</div>
</asp:PlaceHolder>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr style="display:<%=(Is_Static=="1")?"":"none"%>">
  <td align="left" width=120px>子栏目页生成设置</td>
  <td align="left">
<asp:RadioButton id="List_Html_1" GroupName="listhtml" runat="server"/>动态页面&nbsp;
<%if(TheTable!="zdy" && TheTable!=""){%><asp:RadioButton id="List_Html_2" GroupName="listhtml" runat="server"/>伪静态&nbsp;<%}%>
<asp:RadioButton id="List_Html_3" GroupName="listhtml" runat="server"/>静态 <%if(TheTable!="zdy" && TheTable!=""){%>(只生成前<asp:TextBox id="List_Html_Num" size="5" runat="server" maxlength="10" Text="5" />页)<%}%><%if(BSie<1500){%><input type="hidden" name="sort" id="sort" value="0"><%}%>
</td>
 </tr>

<tr style="display:<%=(Is_Static=="1" && TheTable!="zdy" && TheTable!="")?"":"none"%>">
  <td align="left">内容页生成设置</td>
 <td align="left">
<asp:RadioButton id="Detail_Html_1" GroupName="detailhtml" runat="server"/>动态页面&nbsp;
<asp:RadioButton id="Detail_Html_2" GroupName="detailhtml" runat="server"/>伪静态&nbsp;
<asp:RadioButton id="Detail_Html_3" GroupName="detailhtml" runat="server"/>静态页面&nbsp;&nbsp;
</td>
</tr>

<tr>
  <td align="left" width=120px>自定义Url</td>
  <td align="left"><asp:textBox TextMode="singleLine"  id="tb_zdyurl" runat="server" size=60 maxlength="150"  />
</td>
</tr>

<tr>
  <td align="left" width=120px>seo标题</td>
  <td align="left"><asp:textBox TextMode="singleLine"  id="tb_title" runat="server" size=60 maxlength="150"  />
</td>
</tr>

<tr>
  <td align="left">seo关键字</td>
 <td align="left" title="关键字之间用半角逗号分开"><asp:textBox TextMode="singleLine"  id="tb_keywords" runat="server" size=60 maxlength="150"  />
</td>
 </tr>

<tr>
  <td align="left">seo描述</td>
 <td align="left" title="控制在250字以内"><asp:TextBox TextMode="multiLine" Columns="60" rows="4"  id="tb_description"    runat="server" onkeyup="if(this.value.length>250)this.value=this.value.substring(0,250)"/>
</td>
 </tr>

<tr>
<td align=left>浏览权限</td>
<td>
  <input type="checkbox" name="Visiter_all" id="Visiter_0" value="0"  onclick="select_all()">所有来访者<br>
        <asp:Repeater id="P_permissions" runat="server">
         <ItemTemplate>
           <input type="checkbox" name="Visiter" id="Visiter_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" ><%#DataBinder.Eval(Container.DataItem,"m_type")%>&nbsp;
         </ItemTemplate>
        </asp:Repeater>
      </td>
</tr>
</table>
</div>
<div align=center style="padding:5px">
<asp:Label  id="Lb_sitedir" runat="server" visible="false"/>
<asp:Label  id="Lb_lanmudir" runat="server" visible="false"/>
<asp:Label  id="Lb_parentids" runat="server" visible="false"/>
<asp:Label  id="Lb_parentdir" runat="server" visible="false"/>
<asp:Label  id="Lb_sublanmudir" runat="server" visible="false"/>
<asp:Label  id="Lb_sublanmufile" runat="server" visible="false"/>
<asp:Label  id="Lb_language" runat="server" visible="false"/>
<asp:Label  id="Lb_prefix" runat="server" visible="false"/>
<span id="post_area">
<asp:Button Cssclass=button text="提交" id="Bt_Submit" runat="server" onclick="Data_Update" />
<input type="button" class=button  value="关闭"  onclick="parent.CloseDialog();">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
<br>
</center>
</body>
<script type="text/javascript">

<% if(TheTable=="zdy"){%>
document.getElementsByName("tab")[1].style.display="none";
if(document.getElementsByName("tabcontent")[1].style.display=="")
 {
  showtab(0);
 }
<%}%>

<% if(TheTable==""){%>
document.getElementsByName("tab")[0].style.display="none";
document.getElementsByName("tab")[1].style.display="none";
showtab(2);
<%}%>

Load_Sort("<%=P_Sorts%>,<%=Sort_Id%>",'<%=TheTable%>');
var Visitor="<%=Permissions%>";
var AVisitor=Visitor.split(',');
if(Visitor=="" || Visitor=="0")
 {
   document.getElementById("Visiter_0").checked=true;
   lock_mem_check();
 }
else
 {
   for(i=0;i<AVisitor.length;i++)
    {
      try{
         document.getElementById("Visiter_"+AVisitor[i]).checked=true;
         }
       catch(ex)
         {
         }
    }
 }
function lock_mem_check()
 {
  for(i=0;i<document.forms[0].Visiter.length;i++)
     {
       document.forms[0].Visiter[i].checked=true;
       document.forms[0].Visiter[i].disabled=true;
    }
 }

function unlock_mem_check()
 {
  for(i=0;i<document.forms[0].Visiter.length;i++)
     {
       //document.forms[0].Visiter[i].checked=false;
       document.forms[0].Visiter[i].disabled=false;
    }
 }

function select_all()
 {
   var obj=document.getElementById("Visiter_0");
   if(obj.checked)
    {
      lock_mem_check();
    }
   else
    {
     unlock_mem_check()
    }
 }

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

var IsRepeat="";
function c_f()
  {
   <% if(TheTable!="zdy" && TheTable!="")
     {
   %>
    var obj=document.getElementById("D_Model")
    if(obj.selectedIndex==0)
     {
       showtab(0);
       alert("请选择子栏目模型!");
       obj.focus();
       return false;
     }

    obj=document.getElementById("D_Model_Detail")
    if(obj.selectedIndex==0)
     {
       showtab(0);
       alert("请选择内容页模型!");
       obj.focus();
       return false;
     }
    obj=document.getElementById("Show_Num")
    if(obj.value=="" || isNaN(obj.value))
     {
       showtab(0);
       alert("每页显示数填写错误!");
       obj.focus();
       return false;
     }
    var Cb_SortSubLanmu=document.getElementById("Cb_SortSubLanmu");
    if(Cb_SortSubLanmu.checked)
     {
        var s_objs=document.getElementsByName("s_sort");
        var s_objs_last=s_objs[0];
        for(i=0;i<s_objs.length;i++)
         {
           if(s_objs[i].style.display=="none")
            {
              s_objs_last=s_objs[i-1];
              break;
            }
         }
       var sort=s_objs_last.value;
       if(sort=="" || sort=="0")
       {
          sort=document.getElementById("sort").value;
          RepeatCheck(sort);
          if(IsRepeat!="")
           {
             alert("请取消”是否作为调用分类的目标子栏目”属性的选择!\n\n此调用分类的子分类已经被其他子栏目调用，并已作为目标子栏目存在。");
             return false;
           }
       }
     }
  <%}%>
  var Format_Fck=true;
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

function RepeatCheck(sortid) //检查子栏目是否调用重复。
 {
   if(sortid==""){return;}
   var R=Math.random();
   var x=new PAAjax();
   x.setarg("get",false);
   x.send("sublanmu_repeatcheck.aspx","siteid=<%=SiteId%>&table=<%=TheTable%>&sublanmuid=<%=Id%>&sortid="+sortid+"&r="+R,function(v){IsRepeat=v});
 }
</script>
</html>  