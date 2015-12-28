<% @ Page Language="C#" Inherits="PageAdmin.left"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>pageadmin网站管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Author"  content="www.pageadmin.net" />
<link rel="stylesheet" href="master.css" type="text/css">
<script src="master.js" type="text/javascript"></script>
<script language=javascript>
 <!--
  var Objs=document.getElementsByName("left");
  var zdyformItems=document.getElementsByName("tableitem");
  var zdyObj=document.getElementsByName("table");
  function hideall()
   {
    for(i=0;i<Objs.length;i++)
     {
      Objs[i].style.display="none";
     }
    if(zdyformItems.length>0)
     {
    for(i=0;i<zdyformItems.length;i++)
     {
      zdyformItems[i].style.display="none";
     }
    }
  }

   function show_menu(num)
     {
      var style1=Objs[num].style.display;
      if(style1=="none")
      {
      hideall();
      Hide_AllZdyData();
      Objs[num].style.display="";
      }
     else
      {
      Objs[num].style.display="none";
      }
     }

  function Show(Id)
    {
     var Obj=document.getElementById(Id);
     if(Obj!=null)
     {
      Obj.style.display="";
     }
    }

  function Load_Menu()
   {
     var Permissions="<%=Permissions%>";
     var LoginName="<%=UserName%>";
     if(Permissions.indexOf("basic_")>=0 || LoginName=="admin")
      {
        Show("basic");
      }
     if(Permissions.indexOf("member_")>=0  || LoginName=="admin")
      {
        Show("member");
      }
     if(Permissions.indexOf("bs_")>=0  || LoginName=="admin")
      {
        Show("business");
      }
     if(Permissions.indexOf("lanmu")>=0  || LoginName=="admin")
      {
        Show("lanmu");
      }

     if(Permissions.indexOf("zt_")>=0  || LoginName=="admin")
      {
        Show("zt");
      }

     if(Permissions.indexOf("collection_")>=0  || LoginName=="admin")
      {
        Show("collection");
      }

     if(Permissions.indexOf("zdytable_")>=0  || LoginName=="admin")
      {
        Show("zdytable");
      }

     if(Permissions.indexOf("js_")>=0  || LoginName=="admin")
      {
        Show("js");
      }

     if(LoginName=="admin")
      {
       var TagSpan=document.getElementsByTagName("span");
       for(i=0;i<TagSpan.length;i++)
        {
          TagSpan[i].id = "Span"+i;
          document.getElementById("Span"+i).style.display="";
        }
       for(i=0;i<zdyObj.length;i++)
       {
        zdyObj[i].getElementsByTagName("td")[0].style.display="";
       }
      }
      else
      {
       var APermissions=Permissions.split(',');
       for(i=0;i<APermissions.length;i++)
        {
         if(APermissions[i]!="" || LoginName=="admin")
          {
            Show(APermissions[i]);
          }
        }
      }

    }

  function Hide_AllZdyData()
    {
      for(i=0;i<zdyformItems.length;i++)
       {
          zdyformItems[i].style.display="none";
       }
    }

   function showitem(num,show)
    {
     var zdyformItem=zdyformItems[num];
     if(zdyformItem.style.display=="")
      {
        show="none";
      }
     else
      {
        show="";
      }
     hideall();
     var zdyformItem=zdyformItems[num];
     zdyformItem.style.display=show;
    }
-->
</script>
<style>
html,body{margin:0px;height:100%;}
</style>
</head>  
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0 bgcolor=#D1EAFE onload="Load_Menu()">
<table width=140px cellpadding=0 cellspacing=0 border=0 style="height:100%;overflow:hidden;background:url(images/left_bg.gif) repeat top;">
 <tr>
  <td align=center valign=top>
  <div style="width=140px;background:url(images/left_top.gif) no-repeat;padding:30px 0 35px 0;">
   <a href="sysmain.aspx" class=left target="right"><span style='color:#ffffff;font-size:12px;font-weight:bold;'>后台管理首页</span></a>
  </div>
<table width=120px cellpadding=0 cellspacing=0 border=0>
   <tbody>
     <tr>
     <td id="basic" align="left" height=25px  onclick="show_menu(0)" style="display:none;cursor:pointer">&nbsp;<img src="images/left_1.gif" width=16 height=16 hspace=3 align=absmiddle>网站基础管理</td>
    </tr> 
   <tr id="left" name="left" style="display:in-line" >
     <td align="left" class=left_padd>
      <span style="display:none;" id="basic_webset">·<a href="set_1.aspx" class=left target="right">网站参数设置</a><br></span>
      <span style="display:none;" id="basic_task">·<a href="task_list.aspx" class=left target="right">计划任务管理</a><br></span>
      <span style="display:none;" id="basic_worklist">·<a href="work_list.aspx" class=left target="right">工作流管理</a><br></span>
      
      <span style="display:none;" id="basic_datamanage">·<a href="data_manage.aspx" class=left target="right">数据库操作</a><br></span>
      <span style="display:none;" id="basic_log">·<a href="log_list.aspx" class=left target="right">管理日志</a><br></span>
      <span style="display:none;" id="basic_tongji">·<a href="tongji.aspx" class=left target="right">流量统计</a><br></span>
    </td>
    </tr> 

 <tr>
     <td id="member" align="left" height=25px  onclick="show_menu(1)" style="display:none;cursor:pointer">&nbsp;<img src="images/member.gif" width=20 height=20 hspace=3 align=absmiddle>会员中心</td>
    </tr> 
   <tr id="left" name="left"  style="display:none" >
     <td  align="left" class=left_padd>
      <span style="display:none;" id="member_set">·<a href="member_set.aspx" class=left target="right">会员系统设置</a><br></span>
      <span style="display:none;" id="member_type">·<a href="member_type.aspx" class=left target="right">会员类别设置</a><br></span>
      <span style="display:none;" id="member_field">·<a href="field_list.aspx?table=pa_member&tablename=<%=Server.UrlEncode("会员")%>" class=left target="right">会员字段管理</a><br></span>
      <span style="display:none;" id="member_department">·<a href="department_list.aspx" class=left target="right">部门设置</a><br></span>
      <span style="display:none;" id="member_list">
        <asp:Repeater id="P1" runat="server">
         <ItemTemplate>
        ·<a href="member_list.aspx?tid=<%#DataBinder.Eval(Container.DataItem,"id")%>&group=<%#DataBinder.Eval(Container.DataItem,"m_group")%>" class=left target="right"><%#DataBinder.Eval(Container.DataItem,"m_type")%></a><br>
         </ItemTemplate>
       </asp:Repeater>
     </span>
    </td>
  </tr> 

   <tr>
     <td  id="business" align="left" height=25px onclick="show_menu(2)" style="display:none;cursor:pointer">&nbsp;<img src="images/yw.gif" width=16 height=16 hspace=3 align=absmiddle>事务管理</td>
    </tr> 
   <tr id="left" name="left" style="display:none">
     <td  align="left" class=left_padd>
      <span style="display:none;" id="bs_issue">·<a href="issue_list.aspx" class=left target="right">签发信息</a><br></span>
      <span style="display:none;" id="bs_sign">·<a href="sign_list.aspx" class=left target="right">信息签收</a><br></span>
      <span style="display:none;" id="bs_letter">·<a href="letter_list.aspx" class=left target="right">信息回复</a><br></span>
      <span style="display:none;" id="bs_feedback">·<a href="feedback_list.aspx" class=left target="right">会员留言</a><br></span>
      <span style="display:none;" id="bs_order">·<a href="order_list.aspx" class=left target="right">订单管理</a><br></span>
      <span style="display:none;" id="bs_exchange">·<a href="exchange_list.aspx" class=left target="right">兑换记录</a><br></span>
      <span style="display:none;" id="bs_finance">·<a href="finance_list.aspx" class=left target="right">财务记录</a><br></span>
      <span style="display:none;" id="bs_point">·<a href="point_list.aspx" class=left target="right">积分记录</a><br></span>
      <span style="display:none;" id="bs_msgsend">·<a href="msgsend.aspx" class=left target="right">信息群发</a><br></span>
    </td>
    </tr>
 <tr>
     <td  id="lanmu" align="left" height=25px  onclick="show_menu(3)" style="display:none;cursor:pointer">&nbsp;<img src="images/left_2.gif" width=18 height=18 hspace=3 align=absmiddle>栏目布局配置</td>
    </tr> 
   <tr id="left" name="left"  style="display:none" >
     <td  align="left" class=left_padd>
      <span style="display:none;" id="lanmu_list">·<a href="lanmu_list.aspx" class=left target="right">网站栏目管理</a><br></span>
      <span style="display:none;" id="lanmu_style">·<a href="lanmu_style_list.aspx" class=left target="right">局部样式设置</a><br></span>
      <span style="display:none;" id="lanmu_spc">·<a href="lanmu_spc.aspx" class=left target="right">局部内容设置</a></span>
    </td>
  </tr> 

 <tr>
     <td id="zt" align="left" height=25px onclick="show_menu(4)" style="display:none;cursor:pointer">&nbsp;<img src="images/zt.gif" width=16 height=16 hspace=3 align=absmiddle>专题管理</td>
    </tr> 
   <tr id="left" name="left"  style="display:none" >
     <td  align="left" class=left_padd>
      <span style="display:none;" id="pa_zt_sort">·<a href="sort_list.aspx?table=pa_zt&name=<%=Server.UrlEncode("专题")%>" class=left target="right">专题分类</a><br></span>
      <span style="display:none;" id="zt_list">·<a href="zt_list.aspx" class=left target="right">专题管理</a><br></span>
      <span style="display:none;" id="zt_add">·<a href="zt_add.aspx" class=left target="right">增加专题</a><br></span>
      <span style="display:none;" id="zt_comment">·<a href="comments_list.aspx?table=pa_zt&name=<%#Server.UrlEncode("专题")%>" class=left target="right">评论管理</a></span>
    </td>
  </tr>
   <tr>
     <td id="zdytable" align="left" height=25px onclick="show_menu(5)" style="display:none;cursor:pointer">&nbsp;<img src="images/zdyform.gif"  width=16 height=16 hspace=3 align=absmiddle>表单模型管理</td>
    </tr> 
   <tr id="left" name="left"   style="display:none">
     <td  align="left" class=left_padd>
      <span style="display:none;" id="zdytable_list">·<a href="table_list.aspx" class=left target="right">自定义表单</a><br></span>
     </td>
   </tr>
        <asp:Repeater id="P_zdyform" runat="server">
         <ItemTemplate>
          <tr id="table" name="table"><td id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>" align="left" height=25px onclick="return showitem(<%=ZdyformItems++%>)"  style="cursor:pointer;display:none;">
            &nbsp;<img src="images/zdy.gif" width=16 height=16 hspace=3 align=absmiddle><%#DataBinder.Eval(Container.DataItem,"table_name")%>
          </td>
         </tr>
           <tr id="tableitem" name="tableitem" style="display:none">
            <td align="left" class=left_padd>
             <span style="display:none;" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_sort">·<a href="sort_list.aspx?table=<%#DataBinder.Eval(Container.DataItem,"thetable")%>&name=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"table_name").ToString())%>" class=left target="right">分类管理</a><br></span>
             <span style="display:none;" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_list">·<a href="data_<%#DataBinder.Eval(Container.DataItem,"thetype").ToString()=="feedback"?"fbk":""%>list.aspx?table=<%#DataBinder.Eval(Container.DataItem,"thetable")%>&name=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"table_name").ToString())%>" class=left target="right">信息管理</a><br></span>
             <span style="display:none;" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_add">·<a href="data_add.aspx?table=<%#DataBinder.Eval(Container.DataItem,"thetable")%>&name=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"table_name").ToString())%>" class=left target="right">发布信息</a><br></span>
             <span style="display:none;" id="zdy_<%#DataBinder.Eval(Container.DataItem,"thetable")%>_comment">·<a href="comments_list.aspx?table=<%#DataBinder.Eval(Container.DataItem,"thetable")%>&name=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"table_name").ToString())%>" class=left target="right">评论管理</a><br></span>
          </td>
         </tr>
         </ItemTemplate>
       </asp:Repeater>
  <tr>
     <td id="collection" align="left" height=25px  onclick="show_menu(6)" style="display:none;cursor:pointer">&nbsp;<img src="images/collection.gif" width=16 height=16 hspace=3 align=absmiddle>采集管理</td>
    </tr> 
   <tr id="left" name="left" style="display:none" >
     <td  align="left" class=left_padd>
      <span style="display:none;" id="collection_1">·<a href="collection_1.aspx" class=left target="right">采集管理</a></span>
    </td>
    </tr>

  <tr>
     <td id="js" align="left" height=25px onclick="show_menu(7)" style="display:none;cursor:pointer">&nbsp;<img src="images/left_8.gif"  width=16 height=16 hspace=3 align=absmiddle>插件调用</td>
    </tr> 
   <tr id="left" name="left" style="display:none">
     <td  align="left" class=left_padd>
      <span style="display:none;" id="js_loginbox">·<a href="loginbox_list.aspx" class=left target="right">会员登陆</a><br></span>
      <span style="display:none;" id="js_slide">·<a href="slide_list.aspx" class=left target="right">幻灯片</a><br></span>
      <span style="display:none;" id="js_vote">·<a href="vote_list.aspx" class=left target="right">问卷调查</a><br></span>
      <span style="display:none;" id="js_adv">·<a href="adv_list.aspx" class=left target="right">站内广告</a><br></span>
      <span style="display:none;" id="js_link">·<a href="link_list.aspx" class=left target="right">友情链接</a><br></span>
    </td>
    </tr>
     </tbody>
   </table>
 </td>
 </tr>
</table>
</body>
</html>