<% @ Page Language="C#" Inherits="PageAdmin.sort_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=5 cellspacing=0 width=98%>
 <tr>
<td valign=top align="left">
<iframe name="pframe" id="pframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<div id="div1">
<form method="post" action="sort_set.aspx?id=<%=Request.QueryString["id"]%>&name=<%=Server.UrlEncode(SortName)%>" target="pframe">
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
  <table border=0 cellpadding=5 cellspacing=0 width=98% align=center>
    <tr>
     <td  height=25px><b><%=SortName%></b></td>
   </tr>
   </table>

    <table border=0 cellpadding=5 cellspacing=0 width=98% align=center>
    <tr>
       <td height=20px  width="140px"><input type="checkbox" name="tg_open_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">允许投稿</td>
       <td>
        <input type="radio" name='tg_open' value="1" checked>开启
        <input type="radio" name='tg_open' value="0" <%=tg_open=="0"?"checked":""%>>关闭
      </td>
     </tr>

    <tr>
        <td height=20px><input type="checkbox" name="tg_permission_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">前台投稿权限</td>
       <td>
        <input type="checkbox" name="allow_all" id="allow_all" value="0"  onclick="select_all('tg')">允许非会员投稿<br>
        <asp:Repeater id="PBrower" runat="server">
         <ItemTemplate>
           <input type="checkbox" name="Allow_Type" id="Type_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#DataBinder.Eval(Container.DataItem,"m_type")%>&nbsp;
         </ItemTemplate>
        </asp:Repeater>
      </td>
     </tr>

    <tr>
       <td height=20px><input type="checkbox" name="tg_check_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">投稿审核</td>
       <td>
        <input type="radio" name='tg_check' value="0" checked>无需审核
        <input type="radio" name='tg_check' value="1" <%=tg_check=="1"?"checked":""%>>需要审核

        <input type="checkbox" name='edit_check' value="1" <%=edit_check=="1"?"checked":""%>>修改是否重新审核
      </td>
     </tr>

     <tr>
       <td height=20px><input type="checkbox" name="work_id_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">审核工作流</td>
       <td>
       <select id="work_id" name="work_id">
        <option value="0">不指定</option>
        <%=Works_Option%>
       </select>
      </td>
     </tr>

   <tr>
     <td align=left height=20px><input type="checkbox" name="tg_visiter_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">默认访问权限</td>
     <td>
      <input type="checkbox" name="Visiter_all" id="Visiter_all" value="0" onclick="select_all('brower')">所有人<br>
        <asp:Repeater id="P_permissions" runat="server">
         <ItemTemplate>
           <input type="checkbox" name="Visiter" id="Visiter_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" ><%#DataBinder.Eval(Container.DataItem,"m_type")%>&nbsp;
         </ItemTemplate>
        </asp:Repeater>
      </td>
    </tr>

    <tr>
       <td height=20px><input type="checkbox" name="comment_open_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">默认评论功能</td>
       <td><input type="radio" name='comment_open' value="1" checked>开启 <input type="radio" name='comment_open' value="0" <%=comment_open=="0"?"checked":""%>>关闭 &nbsp;评论审核：<input type="checkbox" name='comment_check' id='comment_check_1' value="1" <%=comment_check=="1"?"checked":""%>>需审核&nbsp;<input type="checkbox" name='comment_anonymous' id='comment_anonymous' value="1" <%=comment_anonymous=="1"?"checked":""%>>允许匿名评论
      </td>
     </tr>


    <tr>
       <td height=25px><input type="checkbox" name="tg_addpoint_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">会员投稿赠送积分</td>
       <td>
        <input type="textbox" name='tg_addpoint' value="<%=tg_point%>" size="5" Maxlength="15">点(为负数时则表示扣除积分)
      </td>
     </tr>

     <tr>
       <td height=20px><input type="checkbox" name="act_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">信息置顶设置</td>
       <td>
<select id="act" name="act"><option value="">不开启</option><option value="top">置顶</option></select>  
对应操作扣除<input type="textbox" name='act_point' id='act_point' value="<%=act_point%>" size="5" Maxlength="10" onkeyup="if(isNaN(value))execCommand('undo')">积分/天
</td>
     </tr>

     <tr style="display:<%=TableType=="feedback"?"":"none"%>">
       <td height=20px><input type="checkbox" name="reply_username_set" value="1" style="display:<%=posttype=="p_update"?"":"none"%>">指定回复用户</td>
       <td><input name="reply_username" id="reply_username" type="text" maxlength="50" size="12" value="<%=Reply_UserName%>">[<a href="#" onclick="open_departmentuser('text','reply_username','','选择信息回复用户')">选择用户</a>] &nbsp;留言信息预设的回复用户</td>
     </tr>

    <tr style="display:<%=IsFinalSort=="1"?"none":""%>">
       <td height=20px>覆盖子类设置</td>
       <td title="选择后将复制当前设置到对应子类中">
        <input type="checkbox" name='copy_set' id='copy_set' value="1">
      </td>
     </tr>

   <tr>
    <td colspan="2" align="center" height="30px">
<input type="hidden" value="<%=Request.QueryString["id"]%>" name="id">
<input type="hidden" value="<%=IsFinalSort%>" name="FinalSort">
<input type="hidden" value="" name="ids" id="ids">
<input type="hidden" value="<%=posttype%>" name="post">
<input type="hidden" value="<%=TableName%>" name="tablename">
<input type="submit" class=button value="提交" >
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog()">
</td>
  </tr>
  </table>
  </td>
  <tr>
 </table>
</form>
</div>

<div id="div2" align="center" style="display:none">
<br><br><br><br><img src="images/suc.png" vspace="5"><br><br>
<a href="#" onclick="restore(1);return false;">点击这里返回提交页面</a></div>
</div>

</td>
</tr>
</table>
</center>
<script Language="javascript">
document.getElementById("ids").value=parent.document.getElementById("ids").value;
var M_Type="<%=allow_memtype%>";
var AType=M_Type.split(',');
if(M_Type=="" || M_Type=="0")
 {
  document.getElementById("allow_all").checked=true;
   lock_mem_check('tg');
 }
else
 {
   for(i=0;i<AType.length;i++)
    {
      if(document.getElementById("Type_"+AType[i])!=null)
         {
          document.getElementById("Type_"+AType[i]).checked=true;
         }
    }
 }

var act="<%=act%>";
document.getElementById("act").value=act;

//浏览权限
var Visitor="<%=permissions%>";
var AVisitor=Visitor.split(',');
if(Visitor=="" || Visitor=="0")
 {
   document.getElementById("Visiter_all").checked=true;
   lock_mem_check('brower');
 }
else
 {
   for(i=0;i<AVisitor.length;i++)
    {
      if(document.getElementById("Visiter_"+AVisitor[i])!=null)
        {
         document.getElementById("Visiter_"+AVisitor[i]).checked=true;
        }
    }
 }




//其他函数
function lock_mem_check(type)
 {
  if(type=="tg")
   {

    for(i=0;i<document.forms[0].Allow_Type.length;i++)
      {
       document.forms[0].Allow_Type[i].checked=true;
       document.forms[0].Allow_Type[i].disabled=true;
      }
   }
  else
   {
    for(i=0;i<document.forms[0].Visiter.length;i++)
      {
        document.forms[0].Visiter[i].checked=true;
        document.forms[0].Visiter[i].disabled=true;
      }
   }
 }

function unlock_mem_check(type)
 {
  if(type=="tg")
   {
    for(i=0;i<document.forms[0].Allow_Type.length;i++)
     {
       //document.forms[0].Allow_Type[i].checked=false;
       document.forms[0].Allow_Type[i].disabled=false;
     }
   }
  else
   {
    for(i=0;i<document.forms[0].Visiter.length;i++)
     {
       //document.forms[0].Visiter[i].checked=false;
       document.forms[0].Visiter[i].disabled=false;
     }
   }
 }

function select_all(type)
 {
   var obj;
   if(type=="tg")
    {
      obj=document.getElementById("allow_all");
    }
  else
    {
      obj=document.getElementById("Visiter_all");
    }

     if(obj.checked)
     {
      lock_mem_check(type);
     }
    else
     {
     unlock_mem_check(type)
     }
 }

function restore(backtype)
 {
   var d1=document.getElementById("div1");
   var d2=document.getElementById("div2");
   if(backtype==1)
    {
      d1.style.display="block";
      d2.style.display="none";
    }
   else
    {
      d2.style.display="block";
      d1.style.display="none";
    }
 }
</script>
</body>
</html>  
