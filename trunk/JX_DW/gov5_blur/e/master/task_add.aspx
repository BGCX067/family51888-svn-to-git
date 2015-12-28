<% @ Page Language="C#" Inherits="PageAdmin.task_add"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="basic_task"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b><%=Request.QueryString["id"]==null?"增加计划任务":"编辑计划任务"%></b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form  method="post" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
 </tr>
  <tr>
  <td height=22 width=100px>任务名称</td>
  <td><input name="name" id="name" type="text" maxlength="50" size="30" value="<%=Name%>"></td>
 </tr>

  <tr>
  <td height=25 width=100px>执行文件名</td>
  <td><input name="fileurl" id="fileurl" type="text" maxlength="50" size="30" value="<%=FileUrl%>"> <span style="color:#666666">文件请放在/e/task目录中,此处只需填写文件名如：task.aspx</a></td>
  </tr>

  <tr>
  <td height=25 width=100px>任务描述</td>
  <td><textarea name="description" id="description" cols="40" rows="3"><%=Description%></textarea></td>
  </tr>

  <tr>
  <td height=22 width=100px>任务启用</td>
  <td><input name="isopen" id="isopen" type="radio" value=1 checked>启用 &nbsp;<input name="isopen" id="isopen" type="radio" value=0 <%=IsOpen=="0"?"checked":""%>>关闭</td>
  </tr>

  <tr>
  <td height=22 width=100px>是否循环</td>
  <td><input name="isloop" id="isloop" type="radio" value=1 checked>循环执行 &nbsp;<input name="isloop" id="isloop"  type="radio" value=0 <%=IsLoop=="0"?"checked":""%>>仅执行一次<span style="color:#666666">(执行后自动关闭任务)</span></td>
  </tr>

  <tr>
  <td height=25 width=100px>执行周期</td>
  <td><input name="do_cycle" id="do_cycle" type="radio" value="month" checked>每月 &nbsp;<input name="do_cycle" id="do_cycle"  type="radio" value="week" <%=Do_Cycle=="week"?"checked":""%>>每周 &nbsp;<input name="do_cycle" id="do_cycle"  type="radio" value="day" <%=Do_Cycle=="day"?"checked":""%>>每天</td>
  </tr>

  <tr>
  <td height=25 width=100px>每月几号执行</td>
  <td><select name="do_day" id="do_day" style="width:100px;" size="10" multiple>
      <option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option>
      </select>
      <br><span style="color:#666666">执行周期为”每月“时有效，选择多个可以按住CTRL键选择，不选择则默认每月1号执行</span>
  </td><br>
  </tr>

  <tr>
  <td height=25 width=100px>每周星期几执行</td>
  <td>
      <select name="do_week" id="do_week" style="width:100px;" size="5" multiple>
          <option value="1">星期一</option>
          <option value="2">星期二</option>
          <option value="3">星期三</option>
          <option value="4">星期四</option>
          <option value="5">星期五</option>
          <option value="6">星期六</option>
          <option value="7">星期日</option>
       </select><br>
      <span style="color:#666666">执行周期为”每周“时有效，选择多个可以按住CTRL键选择，不选择则默认星期一执行</span>
   </td>
  </tr>

  <tr>
  <td height=25 width=100px>每天几点执行</td>
  <td>
      <select name="do_hour" id="do_hour" style="width:100px;" size="10" multiple>
       <option value='0'>0</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option></select>
     </select><br>
<span style="color:#666666">选择多个可以按住CTRL键选择，不选择则默认1点执行（耗时任务请选择访问人数比较少的时段运行）</span>
  </td>
  </tr>

  <tr>
  <td height=25 width=100px>任务截止日期</td>
  <td><input name="enddate" id="enddate" type="text" maxlength="10" value="<%=EndDate%>"><a href="javascript:open_calendar('enddate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a>  <span style="color:#666666">到期后自动关闭</a></td>
  </tr>

  <tr>
  <td height=25 width=100px>get参数</td>
  <td><textarea name="parameter" id="parameter" cols="60" rows="5"><%=Parameter%></textarea><br><span style="color:#666666">格式如：id=5 ，多个参数用"&"连接</span></td>
  </tr>

</table>
</td>
</tr>
</table>

<br>
<div align=center>
<input type="hidden" name="tijiao" value="yes">
<span id="post_area">
<input type="submit" class=button id="Bt_Submit" value="提交" onclick="return C_Form()">
<input type="button" class=button value="关闭"  onclick="closewin()">
</span>  
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>  
</div>
<br>
</form>
</td>
</tr>
</table>
</center>
</body>
<script type="text/javascript">
 var do_day="<%=Do_Day%>";
 var do_week="<%=Do_Week%>";
 var do_hour="<%=Do_Hour%>";
 var objday=document.getElementById("do_day");
 var objweek=document.getElementById("do_week");
 var objhour=document.getElementById("do_hour");
function Sleect_Check(obj,val)
 {
  if(val==""){val="1"}
  var Aval=val.split(",");
  if(obj.options.length==0)
   {
     obj1.value="";
     return;
   }
  for(i=0;i<obj.options.length;i++)
   {
     for(k=0;k<Aval.length;k++)
      {
       if(obj.options[i].value==Aval[k])
         {
           obj.options[i].selected=true;
         }
      }
   }
 }
Sleect_Check(objday,do_day);
Sleect_Check(objweek,do_week);
Sleect_Check(objhour,do_hour);

function C_Form()
  {
     var obj=document.getElementById("name");
     if(obj.value=="")
     {
       alert("请填写任务名称!");
       obj.focus();
       return false;
     }

     obj=document.getElementById("fileurl");
     if(obj.value=="")
     {
       alert("请填写要执行的文件名!");
       obj.focus();
       return false;
     }
   
  }
document.getElementById("Bt_Submit").onclick=startpost;

var closewinrefresh=0;
function task_postover(ptype)
 {
   if(ptype=="add")
    {
      alert("增加成功!");
      parent.location.reload();
    }
   else if(ptype=="edit")
    {
      alert("修改成功!");
      closewinrefresh=1;
    }
   document.getElementById("post_area").style.display="";
   document.getElementById("post_loading").style.display="none";
 }

function closewin()
 {
   if(closewinrefresh==1)
   {
    parent.location.reload();
    parent.CloseDialog();
   }
   else
   {
     parent.CloseDialog();
   }
 }
</script>
</html> 
