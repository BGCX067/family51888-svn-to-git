<% @ Page Language="C#" Inherits="PageAdmin.msgsend"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_msgsend"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>信息发送</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form method="post" name="msg">
<table border=0 cellpadding=5px cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 align=center width=98%>
  <tr> 
      <td height=25 align=right width=100px>发件方式：</td>
      <td><input type="radio" value="1"  name="sendmsg" id="sendmsg" checked onclick="change_type()">站内短信
      <input type="radio" value="2"  name="sendmsg" id="sendmsg" onclick="change_type()">发送邮件
   </td>
  </tr>
    <tr id="tr_fb_sendmails" style="display:none">
      <td height=25 align=right width=100px>发件箱<span id="lb_sendmails"></span>：</td>
      <td> 
         <textarea name="fb_sendmails" id="fb_sendmails" cols="80" rows="5" onfocus="Get_SendMailCount()"><%=em_host%>,<%=em_send%>,<%=em_pass%>,<%=em_name%></textarea>
          <br>每行一个发件箱,格式:邮箱服务器,邮箱,邮箱密码,邮箱名
      </td>
    </tr>

    <tr>
      <td height=25 align=right>收件组：</td>
      <td> 
        <asp:Repeater id="P1" runat="server">
         <ItemTemplate>
           <input type="checkbox" name="Receivers" id="Receivers" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" ><%#DataBinder.Eval(Container.DataItem,"m_type")%>
         </ItemTemplate>
        </asp:Repeater>
      <input type="button" id="bt_load" value="载入邮箱"  class="bt" onclick="return Add_Email()" style="display:none">
      </td>
    </tr>

     <tr id="tr_fb_mails" style="display:none">
      <td height=25 align=right width=100px>收件邮箱：</td>
      <td> 
         <textarea name="fb_mails" id="fb_mails" cols="80" rows="5" title="一行一个邮箱地址,或者邮箱之间用半角逗号隔开"></textarea>
      </td>
    </tr>

  <tr id="tr_fb_sleep" style="display:none">
      <td height=25 align=right>邮件发送频率：</td>
      <td><input type="text"  id="fb_sleep"  name="fb_sleep" maxlength="2" size="2" class="tb" value="2" onkeyup="if(isNaN(value) || Trim(this.value)=='' || this.value=='0')execCommand('undo')"> 秒(每发一封邮件的停顿时间,建议设置为1秒以上)
   </td>
  </tr>

  <tr>
      <td height=25 align=right>标题：</td>
      <td><input type="text"  id="fb_title"  name="fb_title"  maxlength="100" size="60" class="tb" > <span style="color:#ff0000">*</span>
   </td>
  </tr>

   <tr>
          <td align=right>内容：</td>
          <td>
            <textarea name="Content" id="Content"></textarea>
<script type="text/javascript" src="/e/incs/fckeditor/fckeditor.js"></script>
<script  type="text/javascript"> 
var FCKeditor = new FCKeditor("Content"); 
FCKeditor.BasePath = "/e/incs/fckeditor/"; 
FCKeditor.Height = 200; 
FCKeditor.Config['LinkBrowser'] = false ;
FCKeditor.Config['ImageBrowser'] =false ;
FCKeditor.Config['FlashBrowser'] = false ;
FCKeditor.Config['LinkUpload'] = true ;
FCKeditor.Config['ImageUpload'] = true ;
FCKeditor.Config['FlashUpload'] = true ;
FCKeditor.ToolbarSet ="Simple"; 
FCKeditor.ReplaceTextarea(); 
</script>
          </td>
      </tr> 

  </tr>

  <tr id="tr_sendmail_state"  style="display:none">
      <td height=25 align=right>邮件发送进度：</td>
      <td>
       总发件数：<span id="RecordsCount" style="">0</span>&nbsp;&nbsp;
       成功：<span id="Sended_Success" style="">0</span>&nbsp;&nbsp;
       失败：<span id="Sended_Failure" style="color:#ff0000">0</span> <a href="javascript:Show_Failure()">&gt;&gt;</a>
       <div style="padding:5px 0 0 0"; id="Sended_Time"></div>
     </td>
  </tr>

    <tr>
      <td height=30px align=center colspan=2>
      <input type="hidden"  value="<%=SendType%>"  name="post" id="Submit">&nbsp;
      <input type="button" id="bt_send" value="发 送"  class="button" onclick="return Check_Message()">
      <input type="button" id="bt_stop" value="暂停" class="button" onclick="stop_send()" style="display:none">
     </td>
    </tr>
   </table>

  </td>
  <tr>
 </table>
<br>
注：群发邮件可能导致您的邮箱被服务商关闭</font>
</form>
</td>
</tr>
</table>
</center>
<script>
 var thetype=document.forms["msg"].sendmsg;
 var MGroup=document.getElementsByName("Receivers");
 var SendMails=document.getElementById("fb_sendmails");
 var ToMails=document.getElementById("fb_mails");
 var fb_title=document.getElementById("fb_title");
 function change_type()
  {
    if(thetype[0].checked)
     {
       document.getElementById("tr_fb_sleep").style.display="none";
       document.getElementById("tr_fb_sendmails").style.display="none";
       document.getElementById("tr_fb_mails").style.display="none";
       document.getElementById("tr_sendmail_state").style.display="none";
       document.getElementById("bt_load").style.display="none";
     }
    else
     {
       document.getElementById("tr_fb_sleep").style.display="";
       document.getElementById("tr_fb_sendmails").style.display="";
       document.getElementById("tr_fb_mails").style.display="";
       document.getElementById("tr_sendmail_state").style.display="";
       document.getElementById("bt_load").style.display="";
     }
  }


 function Check_Message()
  { 
    var fb_value;
    if(thetype[0].checked=="1")
     {
      if(!IsChecked(MGroup))
       {
        alert("请至少选择一个收件组!");
        return false;
       }
     }
    else
     {

      if(SendMails.value=="")
       {
        alert("请填写好发件箱资料!");
        SendMails.focus();
        return false;
       }

      if(ToMails.value=="")
       {
        alert("请填写要发送的邮箱!");
        ToMails.focus();
        return false;
       }
     }

   fb_value=Trim(fb_title.value);
   if(fb_value=="")
    {
      alert("请输入信息标题!");
      fb_title.focus();
      return false;
    }
   var Length=FckLength("Content");
   if(Length==0)
    {
      alert("请输入信息内容!");
      return false;
    }
   if(thetype[0].checked=="1")
    {
      document.forms["msg"].submit();
    }
   else
    {
      Start_SendMail();
    }
  }

//载入邮箱
var x=new PAAjax();

function Add_Email()
 {
   if(!IsChecked(MGroup))
     {
      alert("请选择要载入的收件组!");
      return false;
     }
   ToMails.value="载入中...";
   R=Math.random();
   x.setarg("post",false);
   x.send("msgsend.aspx","post=loademail&Receivers="+Get_CheckBox("Receivers")+"&s"+R,function(v){ToMails.value=v;alert('载入完毕！');});
 }

//发邮件部分
var RecordsCount=document.getElementById("RecordsCount");
var Sended_Success=document.getElementById("Sended_Success");
var Sended_Failure=document.getElementById("Sended_Failure");

var Sended_Time=document.getElementById("Sended_Time");
var bt_stop=document.getElementById("bt_stop");
var bt_send=document.getElementById("bt_send");
var fb_sleep,SendMailCount,MailsNum,Current_SendMail,SendCount,SendedNum,Send_Ok,Send_No,stop,em_subject,em_body;
var A_SendMails,A_SendMail,A_ToMail;
var date;
var st,StartTime,Editor;
var str_failure_mails="",str_failure_sendmails="";

function Get_SendMailCount() //或者邮箱服务器组数
 {
   var SendMail=Trim(SendMails.value).replace(/\r\n/ig,"{|}").replace(/\n/ig,"{|}");
   A_SendMails=SendMail.split("{|}");
   SendMailCount=A_SendMails.length;
   lb_sendmails.innerHTML="(共"+SendMailCount+"组)";

 }

function Start_SendMail()
 {
    MailsNum=0;
    SendCount=0;
    SendedNum=0;Send_Ok=0;
    Send_No=0;
    stop=0
    document.getElementById("tr_sendmail_state").style.display="";
    bt_send.style.display="none";
    bt_stop.style.display="";
    var ToMail=ToMails.value.replace(/\r\n/ig,",");
    ToMail=ToMail.replace(/\n/ig,",");
    A_ToMail=ToMail.split(',');//获取收件邮件数组
    SendCount=A_ToMail.length; //计算总发件数
    RecordsCount.innerHTML=SendCount;
    fb_sleep=document.getElementById("fb_sleep").value;
    Editor=FCKeditorAPI.GetInstance("Content"); 
    em_subject=fb_title.value;
    em_body=Editor.GetXHTML(true);
    Get_SendMailCount();
    date=new Date();
    StartTime=date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
    sendmail();
 }

function sendmail()
 {
   if(MailsNum>=SendMailCount){MailsNum=0;}
   A_SendMail=A_SendMails[MailsNum].split(",");
   MailsNum++;
   if(A_SendMail.length!=4)
    {
      sendmail();
      return;
    }
   Current_SendMail=A_SendMail[1];
   R=Math.random();
   x.setarg("post",false);
   x.send("sendmail.aspx","em_to="+A_ToMail[SendedNum]+"&em_subject="+encodeURI(em_subject)+"&em_body="+encodeURI(em_body)+"&emailserver="+encodeURI(A_SendMail[0])+"&fajianemail="+encodeURI(A_SendMail[1])+"&emailpassword="+encodeURI(A_SendMail[2])+"&fajianname="+encodeURI(A_SendMail[3])+"&em_sign=<%=em_sign%>&sendway=<%=em_sendway%>&r="+R,function(v){send_state(v)});
  }

function send_state(v)
 {
   date=new Date();
   if(SendedNum>=SendCount)
    {
      EndTime=date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
      Sended_Time.innerHTML="发送完毕!&nbsp;&nbsp;总耗时为："+TimeDiff(StartTime,EndTime);
      bt_stop.style.display="none";
      bt_send.style.display="";
    }
  else
   {
    if(v=="1")
     {
      Send_Ok++;
      Sended_Success.innerHTML=Send_Ok;
     }
    else
     {
      Send_No++;
      Sended_Failure.innerHTML=Send_No;
      str_failure_mails+="\r\n"+A_ToMail[SendedNum];
      str_failure_sendmails+="\r\n"+Current_SendMail;
     }
    SendedNum++;
    EndTime=date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
    Sended_Time.innerHTML="已耗时："+TimeDiff(StartTime,EndTime);
    if(stop==0)
      {
        st=setTimeout("sendmail()",parseInt(fb_sleep)*1000);
      }
  }
 }

function stop_send()
 {
  if(stop==0)
   {
    document.getElementById("bt_stop").value="继续";
    stop=1;
    clearTimeout(st);
   }
  else
   {
    document.getElementById("bt_stop").value="暂停";
    stop=0;
    fb_sleep=document.getElementById("fb_sleep").value;
    em_subject=fb_title.value;
    em_body=Editor.GetXHTML(true);
    Get_SendMailCount();
    st=setTimeout("sendmail()",500);
   }
 }

function Show_Failure()
 {
   var w=window.open("","w");
   w.document.write("发送失败邮箱："+str_failure_mails+"<br><br>对应的发件箱："+str_failure_sendmails);
 }

</script>
</body>
</html>  



