<% @ Page Language="C#" Inherits="PageAdmin.table_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="zdytable_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>数据表管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="location.href='table_list.aspx'">数据表管理</li>
<li id="tab" name="tab" style="font-weight:bold"><asp:Label id="Lb1" runat="server" text="增加新表"/></li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td height=25><b>当前位置</b>：表增加/修改</td>
 </tr>
</table>
<table border=0 cellpadding=5 cellspacing=0 width=95% align=center>
<tr>
  <td style="width:130px">表名称</td>
  <td><asp:TextBox id="Add_Table" maxlength=20 size=20  runat="server" title="表中存在大量数据时建议不要随意修改表"/><asp:TextBox  id="Old_Table" maxlength=50 size=30  runat="server" Visible="false"/> <%if(Request.QueryString["act"]=="edit"){%> 更换数据表名时务必先备份数据库<%}else{%>*(如:article,只能由字母、数字组成，首字符必须是英文字母)<%}%></td>
</tr>
<tr>
  <td>表标识</td><td><asp:TextBox  id="Add_Name" maxlength=50 size=30  runat="server" /> *(如:文章)</td>
</tr>

<tr>
  <td>表用途</td><td>
<asp:DropDownList id="Add_Type" runat="server">
<asp:Listitem value="article">通用型</asp:Listitem>
<asp:Listitem value="product">产品型(支持订购功能)</asp:Listitem>
<asp:Listitem value="feedback">互动型(支持回复功能)</asp:Listitem>
</asp:DropDownList></td>
</tr>

<tr>
  <td>应用站点<br><a style="color:#666666" href="javascript:CheckBox_Inverse('SiteIds')">[反选]</a></td><td title="不选择则默认所有站点可使用">
        <asp:Repeater id="P_Site" runat="server">
         <ItemTemplate>
           <input type="checkbox" name="SiteIds" id="site_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" ><%#DataBinder.Eval(Container.DataItem,"sitename")%>&nbsp;
         </ItemTemplate>
        </asp:Repeater>
</td>
</tr>

<tr>
  <td>静态保存目录</td><td><asp:TextBox id="Add_Static_Dir" maxlength=50 size=30 runat="server" value="{table}/{yyyy}{mm}{dd}"/> 留空则默认：{table}/{yyyy}{mm}{dd}，分别表示：表/年月日</td>
</tr>

<tr>
  <td>数据默认排序</td><td><asp:TextBox id="Add_Default_Sort" maxlength=50 size=30 runat="server" value="actdate desc"/> 默认按时间降序</td>
</tr>

<tr>
  <td>后台管理</td><td><asp:DropDownList id="Add_DataManage" runat="server"><asp:Listitem value="1">开启</asp:Listitem><asp:Listitem value="0">关闭</asp:Listitem></asp:DropDownList></td>                              
</tr>

<tr>
  <td>栏目调用</td><td><asp:DropDownList id="Add_InLanmu" runat="server"><asp:Listitem value="1">开启</asp:Listitem><asp:Listitem value="0">关闭</asp:Listitem></asp:DropDownList> *(开启后可在栏目中调用)</td>
</tr>

<tr>
  <td>检查重复</td><td>
<asp:DropDownList id="Add_CheckRepeat" runat="server">
<asp:Listitem value="nocheck">不检查</asp:Listitem>
<asp:Listitem value="stop">禁止提交</asp:Listitem>
</asp:DropDownList> *(此功能只对前台会员中心有效)</td>
</tr>

<tr>
  <td>会员空间</td><td><asp:DropDownList id="Add_InSpace" runat="server"><asp:Listitem value="1">开启</asp:Listitem><asp:Listitem value="0">关闭</asp:Listitem></asp:DropDownList> </td>
</tr>

<tr>
  <td>投稿验证码</td><td><asp:DropDownList id="Add_TgYzm" runat="server"><asp:Listitem value="1">开启</asp:Listitem><asp:Listitem value="0">关闭</asp:Listitem></asp:DropDownList> </td>
</tr>

<tr>
  <td>删除会员同步删除信息</td><td><asp:DropDownList id="D_User_Delete_Same" runat="server"><asp:Listitem value="0">否</asp:Listitem><asp:Listitem value="1">是</asp:Listitem></asp:DropDownList></td>
</tr>

<tr>
  <td align="left">投稿总数上限<br><font color=#666666>0则不限制</font></td>
  <td align="left">
 <asp:Repeater id="M_3" Runat="server">
  <ItemTemplate>
<%#DataBinder.Eval(Container.DataItem,"m_type")%>：<input type="text" style="width:43px" value="<%#Get_TgSet(DataBinder.Eval(Container.DataItem,"id").ToString(),"maxnum")%>" maxlength="10" name="tg_maxnum" id="tg_maxnum" onkeyup="if(isNaN(value))execCommand('undo')">
  </ItemTemplate>
</asp:Repeater>
</td>
</tr>


<tr>
  <td align="left">每天投稿数上限<br><font color=#666666>0则不限制</font></td>
  <td align="left">
 <asp:Repeater id="M_2" Runat="server">
  <ItemTemplate>
<%#DataBinder.Eval(Container.DataItem,"m_type")%>：<input type="text" style="width:43px" value="<%#Get_TgSet(DataBinder.Eval(Container.DataItem,"id").ToString(),"num_day")%>" maxlength="8" name="tg_num_day" id="tg_num_day" onkeyup="if(isNaN(value))execCommand('undo')">
  </ItemTemplate>
</asp:Repeater>
</td>
</tr>

<tr>
  <td align="left">超过上限扣除积分点数<br><font color=#666666>0则不允许再发布</font></td>
  <td align="left">
 <asp:Repeater id="M_4" Runat="server">
  <ItemTemplate>
<%#DataBinder.Eval(Container.DataItem,"m_type")%>：<input type="text" style="width:43px" value="<%#Get_TgSet(DataBinder.Eval(Container.DataItem,"id").ToString(),"exceed_point")%>" maxlength="10" name="exceed_point" id="exceed_point" onkeyup="if(isNaN(value))execCommand('undo')">
  </ItemTemplate>
</asp:Repeater>
</td>
</tr>

<tr>
  <td align="left">两次投稿间隔秒数<br><font color=#666666>0则不限制</font></td>
  <td align="left">
 <asp:Repeater id="M_1" Runat="server">
  <ItemTemplate>
<%#DataBinder.Eval(Container.DataItem,"m_type")%>：<input type="text" style="width:43px" value="<%#Get_TgSet(DataBinder.Eval(Container.DataItem,"id").ToString(),"timelimit")%>" maxlength="10" name="tg_timelimit" id="tg_timelimit" onkeyup="if(isNaN(value))execCommand('undo')"> 
  </ItemTemplate>
</asp:Repeater>
</td>
</tr>

<tr>
  <td align="left">投稿是否审核<br><font color=#666666>此设置优先类别设置</font></td>
  <td align="left">
 <asp:Repeater id="M_5" Runat="server">
  <ItemTemplate>
<%#DataBinder.Eval(Container.DataItem,"m_type")%>：<select name="tg_check" id="tg_check" style="width:50px"><option value="">默认</option><option value="0" <%#Get_TgSet(DataBinder.Eval(Container.DataItem,"id").ToString(),"tg_check")=="0"?" selected":""%>>否</option><option value="1" <%#Get_TgSet(DataBinder.Eval(Container.DataItem,"id").ToString(),"tg_check")=="1"?" selected":""%>>是</option></select>
  </ItemTemplate>
</asp:Repeater>
</td>
</tr>

<tr>
  <td align="left">编辑是否重审<br><font color=#666666>此设置优先类别设置</font></td>
  <td align="left">
 <asp:Repeater id="M_6" Runat="server">
  <ItemTemplate>
<%#DataBinder.Eval(Container.DataItem,"m_type")%>：<select name="edit_check" id="edit_check" style="width:50px"><option value="">默认</option><option value="0" <%#Get_TgSet(DataBinder.Eval(Container.DataItem,"id").ToString(),"edit_check")=="0"?" selected":""%>>否</option><option value="1" <%#Get_TgSet(DataBinder.Eval(Container.DataItem,"id").ToString(),"edit_check")=="1"?" selected":""%>>是</option></select>
  </ItemTemplate>
</asp:Repeater>
</td>
</tr>

<tr>
  <td>序号</td><td><asp:TextBox id="Add_xuhao" maxlength="5" size="2" Text="1" runat="server"/></td>
</tr>

<tr>
  <td   colspan=2 height=45 align=center>
<input type="hidden" name="M_types" value="<%=M_types%>">
<asp:Label id="Lb_Copytable" text="" runat="server" Visible="false"/>
<asp:button  CssClass="button" id="BT1" Text="增加" runat="server" OnClick="Data_Add" />
<asp:button  CssClass="button" id="BT2" Text="修改" runat="server" OnClick="Data_Update"  Visible="false"/>
<asp:button  CssClass="button" id="BT3"  Text="确定" runat="server" OnClick="Data_Copy"  Visible="false"/>
<input type="button" class=button  value="返回"  onclick="location.href='table_list.aspx'">
</td>
 </tr>
</table>
</td>
</tr>
</table>
</form>
<br>
</td>
</tr>
</table>

</center>
<script type="text/javascript">
var SiteIds="<%=SiteIds%>";
var ASiteIds=SiteIds.split(',');
if(ASiteIds=="" || ASiteIds=="0")
 {
  for(i=0;i<document.forms[0].SiteIds.length;i++)
     {
      
      try{
           document.forms[0].SiteIds[i].checked=true;
         }
       catch(ex)
         {
         }
    }
 }
else
 {
   for(i=0;i<ASiteIds.length;i++)
    {
      try{
         document.getElementById("site_"+ASiteIds[i]).checked=true;
         }
       catch(ex)
         {
         }
    }
 }
var xuhao="<%=Request.QueryString["xuhao"]%>";
if(xuhao!="")
{
document.getElementById("Add_xuhao").value=xuhao;
}
var ErrInfo="<%=ErrInfo%>";
if(ErrInfo!="")
{
 alert(ErrInfo);
}
</script>
</body>
</html>  
