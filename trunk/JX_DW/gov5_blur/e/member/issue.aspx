<% @ Page language="c#" Inherits="PageAdmin.mem_issue"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>签发信息</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/ >
<style type=text/css>
body,div,ul,li,table,p,form,legend,fieldset,input button,select,textarea,button{margin:0px;padding:0px;font-family:inherit;font-size:inherit;}
ul,li{list-style:none;}
table{border-collapse:collapse;border-spacing:0;}
a{color:#333333;text-decoration:none;}
a:hover{color:#CC0000;text-decoration:none;}
body{word-wrap:break-word;text-align:center;font:12px/20px Verdana,Helvetica,Arial,sans-serif;color:#333333;padding-top:5px}
.page_style{width:96%;margin:0px auto 0px auto;text-align:center;background-color:#ffffff;overflow:hidden;}

#Ftable{border:1px solid #4388A9;text-align:center;}
#Ftable td{border:1px solid #4388A9;}
.tdhead{background-color:#4388A9;color:#ffffff;text-align:center;font-weight:bold;border-color:#ffffff;}
.bt{width:55px;font-size:9pt;height:19px;cursor:pointer;background-image:url(/e/images/public/button.gif);background-position: center center;border-top: 0px outset #eeeeee;border-right: 0px outset #888888;border-bottom: 0px outset #888888;border-left: 0px outset #eeeeee;padding-top: 2px;background-repeat: repeat-x;}
.current{background-color:#efefef}
</style>
<script src="/e/js/function.js" type="text/javascript"></script>
</head>
<body>
<div class="page_style">
<center>
<table border=0 cellpadding="2px" cellspacing="0" width=100% align=center>
   <tr>
      <td height=20 align="left"><span style="display:<%=current_workid=="0"?"none":""%>">当前步骤：<select id="work_node"><%=Node_List%></select>&nbsp;&nbsp;当前步骤指定操作人员：<%=current_username==null?"无":current_username%>&nbsp;&nbsp;</span>信息状态：<%=current_work_state%></td>
   </tr>
</table>
<iframe name="t_issue" id="t_issue" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<table border=0 cellpadding="5px" cellspacing="0" width=100% align=center style="table-layout:fixed;background-color:#D1EAFE;border:1px solid #333333;">
 <form method="post" name="issue" target="t_issue">
   <tr>
     <td width="80px">信息标题</td>
     <td align="left"><span id="sfont" onclick=showinput(1)><%=Server.HtmlEncode(DataTitle)%></span><span id="sinput" style="display:none"><input type="text" name="title" id="title" maxlength="150" size="60" value="<%=Server.HtmlEncode(DataTitle)%>"></span></td>
   </tr>

   <tr>
      <td height=20>操作选项</td>
      <td align="left"><input type="radio" value="pass" name="act" onclick="c_type()">通过&nbsp;<input type="radio" value="rework" name="act" onclick="c_type()">退回<%if(can_delete=="1"){%>&nbsp;<input type="radio" value="delete" name="act" onclick="c_type()">删除<%}%></td>
   </tr>

   <tr style="display:<%=author==""?"none":""%>">
     <td>通知作者</td>
     <td align="left"><input type="checkbox" value="1"  name="sendmsg" id="sendmsg"  onclick="c_sendway()">站内短信
      <input type="checkbox" value="1"  name="sendmail" id="sendmail" onclick="c_sendway()">发送邮件</td>
   </tr>

  <tr id="tr_fb_title" style="display:none">
      <td height=20>信件标题</td>
      <td align="left"><input type="text" id="fb_title"  name="fb_title"  maxlength="100" size="70" class="tb" ></td>
  </tr>

   <tr>
      <td height=20>点评/回复</td>
      <td align="left"><TextArea id="reply" name="reply"></textarea>
<script type="text/javascript" src="/e/incs/fckeditor/fckeditor.js"></script>
<script  type="text/javascript"> 
var FCKeditor = new FCKeditor("reply"); 
FCKeditor.BasePath = "/e/incs/fckeditor/"; 
FCKeditor.Height = 100; 
FCKeditor.Config['LinkBrowser'] = false  ;
FCKeditor.Config['ImageBrowser'] =false  ;
FCKeditor.Config['FlashBrowser'] =false ;
FCKeditor.Config['LinkUpload'] =  false ;
FCKeditor.Config['ImageUpload'] = false ;
FCKeditor.Config['FlashUpload'] = false ;
FCKeditor.ToolbarSet ="Small"; 
FCKeditor.ReplaceTextarea(); 
</script> 
</td>
   </tr>
   <tr>
      <td height=20px colspan="2" align="center">
<input type="hidden" name="is_static"  value="<%=Is_Static%>">
<input type="hidden" name="data_html"  value="<%=DataHtml%>">
<input type="hidden" name="author"  value="<%=author%>">
<input type="hidden" name="current_title"  value="<%=DataTitle%>">
<input type="hidden" name="current_username"  value="<%=current_username%>">
<input type="hidden" name="current_processname"  value="<%=current_process_name%>">
<input type="hidden" name="current_passname"  value="<%=current_pass_name%>">
<input type="hidden" name="current_reworkname"  value="<%=current_rework_name%>">
<input type="hidden" name="current_reworknode"  value="<%=current_rework_node%>">

<input type="hidden" name="current_node"  value="<%=currnt_node%>">
<input type="hidden" name="post"  value="update">
<input type="button" value="提交" class="bt" onclick="return ck()" <%=data_checked==1?"disabled":""%>>
</td>
   </tr>
 </form>
</table>

<br>

<table border=0 cellpadding="0" cellspacing="0" width=100% align=center>
   <tr>
      <td align="left"><b>操作记录</b></td>
   </tr>
</table>
 <table border=0 cellpadding=2 cellspacing=0 width=100% id="Ftable">
   <tr>
     <td align=center width=15% class=tdhead height=20px>步骤</td>
     <td align=center width=15% class=tdhead>操作</td>
     <td align=center width=15% class=tdhead>操作者</td>
     <td align=center width=25% class=tdhead>操作时间</td>
     <td align=center width=30% class=tdhead>点评/回复</td>
   </tr>
   <asp:Repeater id="plist" Runat="server">
    <ItemTemplate>
   <tr>
   <td align=center><%#GetNodeName(DataBinder.Eval(Container.DataItem,"work_node").ToString())%></td>
   <td align=center><%#DataBinder.Eval(Container.DataItem,"act").ToString()%></td>
   <td align=center><%#GetUser(DataBinder.Eval(Container.DataItem,"username").ToString())%></td>
   <td align=center><%#DataBinder.Eval(Container.DataItem,"thedate")%></td>
   <td align=left><%#DataBinder.Eval(Container.DataItem,"reply")%></td>
   </tr>
    </ItemTemplate>
  </asp:Repeater>
 </table>
<br>
<script type="text/javascript">
 var obj=document.forms["issue"].act;
 var fb_title=document.getElementById("fb_title");
 var oEditor,replycontent;
 var title="<%=Server.HtmlEncode(DataTitle)%>";
 var title_sl;
 var author="<%=author%>";
 if(title.length>25)
  {
    title_sl=title.substr(0,25)+"...";
  }
 else
  {
   title_sl=title;
  }
 fb_title.value="您发布的信息“"+title_sl+"”已通过审核！"
 function c_type()
  {
    if(author==""){return false;}
    oEditor = FCKeditorAPI.GetInstance("reply");
         if(obj[0].checked)
         {
           fb_title.value="您发布的信息“"+title_sl+"”已通过审核！"
           oEditor.SetHTML("",false);
         }
         if(obj[1].checked)
         {
           fb_title.value="您发布的信息“"+title_sl+"”被退回！"
           oEditor.SetHTML("退回原因：",false);
         }
         if(obj[2]!=null && obj[2].checked)
         {
           fb_title.value="您发布的信息“"+title_sl+"”被删除！"
           if(document.getElementById("sendmsg").checked || document.getElementById("sendmail").checked)
            {
             oEditor.SetHTML("删除原因：",false);
            }
           else
            {
             oEditor.SetHTML("",false);
            }
         }
  }

 function showinput(num)
  {
    var sfont=document.getElementById("sfont");
    var sinput=document.getElementById("sinput");
    if(num==0)
     {
       sfont.style.display="";
       sinput.style.display="none";
     }
    else
     {
       sfont.style.display="none";
       sinput.style.display="";
     }
  }

 function c_sendway()
  {
    if(document.getElementById("sendmsg").checked || document.getElementById("sendmail").checked)
     {
       document.getElementById("tr_fb_title").style.display="";
     }
   else
     {
       document.getElementById("tr_fb_title").style.display="none";
     }
  }

 function ck()
  {
    if(Trim(document.getElementById("title").value)=="")
     {
       alert("信息标题不能为空!");
       document.getElementById("title").focus();
       return false;
     }
    if(!IsChecked(obj))
     {
       alert("请选择一个操作选项!");
       return false;
     }
    if(author!="")
    {
      oEditor = FCKeditorAPI.GetInstance("reply");
      replycontent=oEditor.GetXHTML(false);
      if(replycontent=="<br />"){replycontent=""}
      if(obj[1].checked==true)
       {
        if(replycontent.length==0 || replycontent=="退回原因：")
         {
          alert("请输入退回原因!");
          return false;
         }
      }
     else if(obj[2]!=null && obj[2].checked==true)
      {
        if(document.getElementById("sendmsg").checked || document.getElementById("sendmail").checked)
           {
             if(replycontent.length==0 || replycontent=="删除原因：")
             {
              alert("请输入删除原因!");
              return false;
             }
           }
      }
    }

   if(obj[0].checked)
    {
      //if(!confirm("是否确定通过审核？"))
      //{
      //  return false;
      //}
    }
   if(obj[1].checked)
    {
      //if(!confirm("是否确定退回此信息？"))
      //{
      //  return false;
      //}
    }
   if(obj[2]!=null && obj[2].checked)
    {
      if(!confirm("是否确定删除此信息？"))
      {
        return false;
      }
    }

   document.forms["issue"].submit();
  }
 function postover(Act,Html_Success)
  {
    if(Act=="delete")
    {
     alert('删除成功!');
    }
    else
    {
     if(Html_Success==1)
      {
       alert('提交成功!');
      }
     else
      {
        alert('提交成功，但生成静态文件出错!');
      }
    }
    var issue_item=parent.document.getElementsByName("issue_item");
    if(issue_item==null || issue_item.length<1)
    {
      parent.location.href=parent.location.href;
      return;
    }
   var xuhao="<%=Request.QueryString["xuhao"]%>";
   if(xuhao==""){xuhao="0"}
   issue_item[parseInt(xuhao)].style.display="none";
   var showitems=0;
   for(i=0;i<issue_item.length;i++)
     {
       if(issue_item[i].style.display!="none")
       showitems++;
     }
   if(showitems<1)
    {
     parent.location.href=parent.location.href;
    }
   wclose();
  }
function wclose()
 {
   parent.CloseDialog();
 }
</script>
</center>
</body>
</html> 


