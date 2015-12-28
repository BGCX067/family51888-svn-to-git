<% @ Page Language="C#" Inherits="PageAdmin.zt_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="zt_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>专题管理</b></a></td></tr>
 <tr><td height=10 ></td></tr>
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
  <td height=25><b>当前表</b>:<%=Request.QueryString["name"]%></td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="150px">
每页<asp:TextBox id="Tb_pagesize" size="3" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select  name="sortid" id="sortid" onchange="Go()"><option  value="">所有类别</option><%=Sort_List%><option value="0" style="color:#ff0000">未分类专题</option></select>
<select id="s_order" onchange="Go()">
<option value="id desc">按ID↓</option>
<option value="id">按ID↑</option>
<option value="thedate">按发布时间↑</option>
<option value="thedate desc">按发布时间↓</option>
</select>
关键字<input text="text" id="s_keyword" size="15">
<select id="s_field">
<option value="title">标题</option>
<option value="zdy_keywords">关键字</option>
<option value="username">用户名</option>
</select>
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td  align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;" id="tb_list">
                <tr>
                  <td align=center width=47% class=white>专题标题</td>
                  <td align=center width=8% class=white>专题ID</td>
                  <td align=center width=15% class=white height=20>提交时间</td>
                  <td align=center width=5% class=white height=20>评论</td>
                  <td align=center width=10% class=white height=20>发布人</td>
                  <td align=center width=15% class=white>管理</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=left class="tdstyle"><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a href='<%#ZtUrl(DataBinder.Eval(Container.DataItem,"zt_dir").ToString(),DataBinder.Eval(Container.DataItem,"zt_file").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString())%>' target="_blank"><%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%></a><asp:Label ForeColor="#ff0000" text="[荐]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"isgood").ToString())%>' runat="server"/></td>
                  <td align=center class="tdstyle"><input type="textbox" size="4" value='<%#DataBinder.Eval(Container.DataItem,"id")%>' readonly></td>
                  <td align=center class="tdstyle" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate")%></td>
                  <td align=center class="tdstyle"><a href='comments_list.aspx?detailid=<%#DataBinder.Eval(Container.DataItem,"id")%>&table=pa_zt&name=<%#Server.UrlEncode("专题")%>'><%#DataBinder.Eval(Container.DataItem,"comments")%></a></td>
                  <td align=center class=tdstyle><a href='member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"username").ToString())%>'><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
                  <td align=center class="tdstyle">
                   <a href='zt_add.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>'>编辑</a>
                    <asp:LinkButton Id="Delete" runat="server" Text="删除" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="BT_Delete" />
                  </td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
<tr>
<td colspan="6" class=tdstyle>

<table border=0 width=100%>
 <tr><td>
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
[<a href="javascript:set('isgood')">推荐</a>/<a href="javascript:set('notgood')">取消</a>]
<a href="javascript:set('delete')">[删除]</a>

</td>
<td align=right>
<input type="hidden" name="act" id="act" value="">
<input type="hidden" name="ids" id="ids" value="">
<select  name="tosortid" id="tosortid"><option  value="0">目标类别</option><%=Sort_List%></select>
<input type="button" class="button" value="转移" onclick="set('transfer')"/>
<input type="button" class="button" value="复制" onclick="set('copy')"/>
</td></tr></table>
</td></tr></table> 

<br>
<%if(Is_Static=="1")
 {
%>
<select  name="htmltype" id="htmltype"><option  value="0">仅选中专题生成静态</option><option  value="1">所有专题生成静态</option></select>
<input type="button" class="button" value="确定" onclick="html()"/>
<%}%>
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  class=button runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  class=button runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;

       </td>
    </tr>
   </table>
  </td>
  <tr>
 </table>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
 MouseoverColor("tb_list");
 var obj_sort=document.getElementById("sortid");
 var obj_field=document.getElementById("s_field");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var Table="pa_zt";
 var name="专题列表";

 var Sortid="<%=Request.QueryString["sortid"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_sort!=null && Sortid!="0"){obj_sort.value=Sortid;}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

 function Go()
  { 
   location.href="?table="+Table+"&name="+escape(name)+"&sortid="+obj_sort.value+"&field="+obj_field.value+"&order="+obj_order.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function Get_CheckBox(Name)
 {
   var Obj=document.getElementsByName(Name);
   var ID="0";
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].checked)
       {
         ID+=","+Obj[i].value;
       }
     }
   return ID.replace("0,","");
 }

function set(act)
 {
   var Ids=Get_CheckBox("CK");
   if(Ids=="0")
    {
      alert("请选择要操作的信息!");
      return;
    }

   if(act=="delete")
    {
      if(!confirm("确定删除吗?"))
       {
         return;
       }
    }

   if(act=="copy" || act=="transfer")
    {
      if(!confirm("是否确定?"))
       {
         return;
       }
      if(document.getElementById("tosortid").value=="0")
      {
        alert("请选择要操作的目标类别!");
        document.getElementById("tosortid").focus();
        return ;
      }
    }

  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }

function html()
 {
  var obj=document.getElementById("htmltype")
  if(obj.value=="0")
   {
     var Ids=Get_CheckBox("CK");
     if(Ids=="0")
     {
      alert("请选择要生成的记录!");
      return;
     }
     htm_panel(Table,name,Ids);
   }
  else
   {
     htm_panel(Table,name,"");
   }
 }

function htm_panel(Table,Name,Ids)
 {
  var PageSize=5;
  var Width=400;
  var Height=180;
  IDialog("专题页静态生成","static_panel.aspx?table="+Table+"&ids="+Ids+"&sortid=<%=Request.QueryString["sortid"]%>&pagesize="+PageSize,Width,Height);
 }

SetCookie("tab","0");
</script>
</body>
</html>  



