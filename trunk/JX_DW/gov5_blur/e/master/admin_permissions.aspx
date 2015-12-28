<% @ Page Language="C#" Inherits="PageAdmin.admin_permissions"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="admin_permissions"/>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td align="left" height=10></td></tr>
 <tr><td align="left" class=table_style1><b>管理权限设置</b></td></tr>
 <tr><td align="left" height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td align="left" valign=top>
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form method="post" Runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=5 width=100% align=center  class=table_style2>
<tr>
  <td align="left" valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
 <tr><td height="30px"><b>用户：<%=Request.QueryString["username"]%></b></td></tr>
</table>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
 <tr>
  <td align="left" height=25><b>可管理站点</b></td>
  <td align="left" height=25><asp:ListBox id="SiteList" Runat="server" DataTextField="sitename" DataValueField="id" SelectionMode="Multiple" Rows="10" style="width:180px"/></td>
 <tr>
 <tr>
  <td align="left" height=25><b>管理权限设置</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="basic_webset" name="basic" value="basic_webset">网站参数设置&nbsp;
   <input type="checkbox" id="basic_task" name="basic" value="basic_task">计划任务管理
   <input type="checkbox" id="basic_worklist" name="basic" value="basic_worklist">工作流管理
   <input type="checkbox" id="basic_onlinepay" name="basic" value="basic_onlinepay">在线支付接口&nbsp;
   <input type="checkbox" id="basic_pointcard" name="basic" value="basic_pointcard">积分充值管理&nbsp;
   <input type="checkbox" id="basic_sendwaylist" name="basic" value="basic_sendwaylist">配送方式管理&nbsp;
   <input type="checkbox" id="basic_datamanage" name="basic" value="basic_datamanage">数据库操作
   <input type="checkbox" id="basic_log" name="basic" value="basic_log">日志管理
   <input type="checkbox" id="basic_tongji" name="basic" value="basic_tongji">流量统计
 </td>
 </tr>

<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>会员中心</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="member_set" name="member" value="member_set">会员系统设置&nbsp;
   <input type="checkbox" id="member_type" name="member" value="member_type">会员类别设置&nbsp;
   <input type="checkbox" id="member_field" name="member" value="member_field">会员字段管理&nbsp;
   <input type="checkbox" id="member_department" name="member" value="member_department">部门设置&nbsp;
   <input type="checkbox" id="member_list" name="member" value="member_list">会员查看&nbsp;
 </td>
 </tr>

<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>事务管理</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="bs_issue" name="business" value="bs_issue">签发信息&nbsp;
   <input type="checkbox" id="bs_sign" name="business" value="bs_sign">信息签收&nbsp;
   <input type="checkbox" id="bs_letter" name="business" value="bs_letter">信息回复&nbsp;
   <input type="checkbox" id="bs_feedback" name="business" value="bs_feedback">会员留言&nbsp;
   <input type="checkbox" id="bs_order" name="business" value="bs_order">订单管理&nbsp;
   <input type="checkbox" id="bs_exchange" name="business" value="bs_exchange">兑换管理&nbsp;
   <input type="checkbox" id="bs_finance" name="business" value="bs_finance">财务记录查看&nbsp;
   <input type="checkbox" id="bs_point" name="business" value="bs_point">积分记录查看&nbsp;
   <input type="checkbox" id="bs_msgsend"  name="business" value="bs_msgsend">信息群发&nbsp;
 </td>
 </tr>


<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>栏目布局配置</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="lanmu_list" name="lanmu" value="lanmu_list">栏目管理&nbsp;
   <input type="checkbox" id="module_list" name="lanmu" value="module_list">栏目 &gt; 模块管理&nbsp;
   <input type="checkbox" id="nav_list" name="lanmu" value="nav_list">栏目 &gt; 导航管理&nbsp;
   <input type="checkbox" id="sublanmu_list" name="lanmu" value="sublanmu_list">栏目 &gt; 导航 &gt; 子栏目管理&nbsp;
   <br>
   <input type="checkbox" id="lanmu_style" name="lanmu" value="lanmu_style">局部样式设置&nbsp;
   <input type="checkbox" id="lanmu_spc" name="lanmu" value="lanmu_spc">局部内容设置&nbsp;
 </td>
 </tr>

<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>专题管理</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="pa_zt_sort" name="zt" value="pa_zt_sort">专题分类&nbsp;
   <input type="checkbox" id="zt_list" name="zt" value="zt_list">专题管理&nbsp;
   <input type="checkbox" id="zt_add" name="zt" value="zt_add">增加专题&nbsp;
   <input type="checkbox" id="zt_comment" name="zt" value="zt_comment">评论管理&nbsp;
 </td>
 </tr>


<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>表单模型管理</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="zdytable_list" name="zdytable" value="zdytable_list">自定义表单&nbsp;
 </td>
 </tr>

<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>数据管理</b></td>
  <td align="left" height=25>
    <asp:Repeater id="P_zdyform" runat="server">
    <ItemTemplate>
        <div align="left" style="padding:10px 0 0 0"><input type="checkbox" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>" name="datas" value='zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>'><b><%#DataBinder.Eval(Container.DataItem,"table_name")%></b></div>
        <input type="checkbox" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_sort" name="datas" value='zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_sort'>分类管理&nbsp;
        <input type="checkbox" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_list" name="datas" value='zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_list'>信息管理&nbsp;
        <input type="checkbox" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_add" name="datas" value='zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_add'>发布&nbsp;
        <input type="checkbox" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_edit" name="datas" value='zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_edit'>修改&nbsp;
        <input type="checkbox" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_del" name="datas" value='zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_del'>删除&nbsp;
        <input type="checkbox" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_comment" name="datas" value='zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_comment'>评论管理&nbsp;
       <br>
     </ItemTemplate>
    </asp:Repeater>
 </td>
 </tr>


<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>采集管理</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="collection_1" name="collection" value="collection_1">采集节点管理&nbsp;
 </td>
 </tr>

<tr><td colspan="2" height="10px"></td></tr>
<tr>
  <td align="left" height=25><b>插件调用区</b></td>
  <td align="left" height=25>
   <input type="checkbox" id="js_loginbox" name="js" value="js_loginbox">会员登陆&nbsp;
   <input type="checkbox" id="js_slide" name="js" value="js_slide">幻灯片 &nbsp;
   <input type="checkbox" id="js_vote" name="js" value="js_vote">问卷调查 &nbsp;
   <input type="checkbox" id="js_adv"  name="js" value="js_adv">问卷调查 &nbsp;
   <input type="checkbox" id="js_link" name="js" value="js_link">友情链街 &nbsp;
 </td>
 </tr>
<tr>
 <td colspan="2" align="center" style="padding:20px 0 0 0">
<input type="hidden" name="tijiao" value="yes" >
<span id="post_area">
<input type="submit" value="提 交" id="Bt_Submit" class="button" />
<input type="button" value="返 回"  class="button" onclick="location.href='member_list.aspx?tid=<%=Request.QueryString["m_type"]%>&group=admin'" />
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</td>
</tr>
</table>
</td>
</tr>
</td>
</tr>
</table>
<br>
注：以上权限设置只对非admin管理员有效
</form>
<script language="javascript">
 var Obj;
 var Permissions="<%=Permissions%>";
 var APermissions=Permissions.split(',');
 for(i=0;i<APermissions.length;i++)
  {
    if(APermissions[i]!="")
     {
        Obj=document.getElementById(APermissions[i]);
        if(Obj!=null)
         {
          Obj.checked=true;
         }
     }
  }
document.getElementById("Bt_Submit").onclick=startpost;
</script>
</center>
</body>
</html>  
