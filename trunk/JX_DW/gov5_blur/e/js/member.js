function no_vpermissions(type) //无访问权限提示
 {
  switch(type)
  {
   case 1:
     alert('对不起,您没有访问权限!');
     history.back();
   break;
 
   case 2:
    alert('对不起,您所属的会员类别没有访问权限!');
    history.back();
   break;
  }
 }

function no_permissions(backurl) //未登录提示
 {
   alert('对不起,请先登录!');
   location.href=backurl;
 }

function settop(thetable,detailid) //属性控制
 {
   IDialog('信息置顶',"/e/aspx/top_set.aspx?table="+thetable+"&id="+detailid,400,170);
   return false;
 }

function datadtl_back(backinfo,checked,url,cs) //提交信息返回
 {
  switch(backinfo)
  {
   case "success":
     if(cs=="add")
      {
       if(checked==1){alert("提交成功!");}
       else{alert("提交成功,请等待审核!");}
       top.location.href=url;
      }
     else
      {
        if(checked==1){alert("修改成功!");}
        else{alert("修改成功,请等待审核!");}
        top.location.href=top.location.href;
      }
   break;
 
   case "nopoint":
    sid=Request("s");
    if(confirm("对不起,此信息需要扣除"+cs+"点积分。\n\n您的帐户积分余额不足，是否需要购买积分?"))
      {
        top.location.href="/e/member/index.aspx?s="+sid+"&type=mem_point";
      }
    else
      {
        alert("感谢您的支持!");
      }
   break;

   case "repeat":
    alert("对不起,此信息标题重复，请更换标题!");
   break;

   case "forbid_keyword":
    alert("对不起,提交的内容包含被禁止的关键字："+cs);
   break;

   case "maxnum_limit":
    alert("对不起,您所在的会员组最多只能发布"+cs+"条信息!");
   break;

   case "daynum_limit":
    alert("对不起,您所在的会员组每天只能发布"+cs+"条信息!");
   break;

   case "time_limit":
    if(cs<60)
     {
      alert("对不起,连续两次投稿时间间隔不能少于"+cs+"秒，先稍后再发!");
     }
    else
     {
      cs=parseInt(cs/60);
      alert("对不起,连续两次投稿时间间隔不能少于"+cs+"分钟，先稍后再发!");
     }
   break;

   case "newuser_tg_timelimit":
    alert("对不起,新注册用户"+cs+"分钟内不可以发布信息!");
   break;

   default:
     alert(backinfo);
     top.location.href=top.location.href;
   break;
  }
 }

function delete_file(table,field,id) //删除附件
 {
   if(!confirm("是否确定删除?"))
    {
     return;
    }
   var obj=document.getElementById(field);
   var del_obj=document.getElementById("delete_"+field);
   var upload_obj=document.getElementById("upload_"+field);
   var date=new Date(); 
   var R=Math.random();
   var x=new PAAjax();
   x.setarg("post",false);
   x.send("/e/aspx/delete_file.aspx","table="+table+"&field="+field+"&id="+id+"&path="+obj.value+"&r="+R,function(v){});
   obj.value="";
   del_obj.style.display="none";
   upload_obj.style.display="";
 }

function open_upload(sid,path,type,table,field,Id) //上传界面
 {
  var Width=550;
  var Height=70;
  IDialog('文件上传',"/e/aspx/upload_panel.aspx?sid="+sid+"&filepath="+path+"&type="+type+"&table="+table+"&field="+field+"&objid="+Id+"&from=member",Width,Height);
 }

function open_files(sid,Id,table,field,FieldType,InforId)
 {
  var Width=580;
  var Height;
  var title;
  if(FieldType=="files")
   {
    Height=380;
    title="附件发布";
   }
  else
   {
    Height=280;
    title="图片发布";
   }
  IDialog(title,"/e/aspx/upload_files.aspx?sid="+sid+"&id="+Id+"&table="+table+"&field="+field+"&type="+FieldType+"&inforid="+InforId+"&from=member",Width,Height);
}

function Iframe_ReFresh(iframeid)
 {
   var obj=window.frames[iframeid];
   obj.location.href=obj.location.href;
 }

function Iframe_Submit(iframeid)
 {
   var obj=window.frames[iframeid].document.forms[0];
   obj.post.value="update";
   obj.submit();
 }

function foreColor(id,Addstr){
  if(!Error())	return;
  var arr = showModalDialog("/e/incs/color.html", "foreColor", "dialogWidth:18.5em; dialogHeight:17.5em;status:0;help:no;resizable:no;");
  if (arr != null) 
  document.getElementById(id).value=Addstr+arr;
}

function zdyform_checkbox(ckvalue,ckname) //自定表单多选框根据值选中checkbox
 {
  var objck=document.getElementsByName(ckname);
  var Ackvalue=ckvalue.split(',');
  for(i=0;i<Ackvalue.length;i++)
   {
     for(k=0;k<objck.length;k++)
      {
        if(objck[k].value==Ackvalue[i])
         {
          objck[k].checked=true;
         }
      }
   }
 }

//检测登录资料
function login_check()
 {
  var obj=document.pa_member.username;
  if(obj.value=="")
   {
     alert("请填写用户名!");
     obj.focus();
     return false;
   }
  else if(!IsUserName(obj.value))
   {
     alert("用户名只能由字母、数字、下划线和汉字组成!");
     obj.focus();
     return false;
   }
  else if(Length(obj.value)<4 || Length(obj.value)>16)
   {
     alert("用户名必须在4—16个字符之间!");
     obj.focus();
     return false;
   }

  obj=document.pa_member.password;
  if(obj.value=="")
   {
     alert("请填写密码!");
     obj.focus();
     return false;
   }
  else if(!IsStr(obj.value))
   {
     alert("密码只能由字母、数字、下划线组成!");
     obj.focus();
     return false;
   }
  else if(Length(obj.value)<4 || Length(obj.value)>16)
   {
     alert("密码必须在4—16个字符之间!");
     obj.focus();
     return false;
   }

  obj=document.pa_member.vcode;
  if(obj.value=="")
   {
     alert("请填写验证码!");
     obj.focus();
     return false;
   }
 }

//找回密码验证
function Find_Pass()
 {
  var obj=document.pa_member.username;
  if(obj.value=="")
   {
     alert("请填写用户名!");
     obj.focus();
     return false;
   }
  else if(!IsUserName(obj.value))
   {
     alert("用户名只能由字母、数字、下划线和汉字组成!");
     obj.focus();
     return false;
   }

  obj=document.pa_member.email;
  if(obj.value=="")
   {
     alert("请填写注册邮箱!");
     obj.focus();
     return false;
   }
  else if(!IsEmail(obj.value))
   {
     alert("注册邮箱格式错误!");
     obj.focus();
     return false;
   }
 }

//检测注册资料
function Check_Reg(security_code)
 {
  var obj=document.pa_member.username;
  if(obj.value=="")
   {
     alert("请填写用户名!");
     obj.focus();
     return false;
   }
  else if(!IsUserName(obj.value))
   {
     alert("用户名只能由字母、数字、下划线和汉字组成!");
     obj.focus();
     return false;
   }
  else if(Length(obj.value)<4 || Length(obj.value)>16)
   {
     alert("用户名必须在4—16个字符之间!");
     obj.focus();
     return false;
   }
  obj=document.pa_member.password;
  if(obj.value=="")
   {
     alert("请填写密码!");
     obj.focus();
     return false;
   }
  else if(!IsStr(obj.value))
   {
     alert("密码只能由字母、数字、下划线组成!");
     obj.focus();
     return false;
   }
  else if(Length(obj.value)<4 || Length(obj.value)>16)
   {
     alert("密码必须在4—16个字符之间!");
     obj.focus();
     return false;
   }
  if(document.pa_member.password1.value=="")
   {
     alert("请填写确认密码!");
     document.pa_member.password1.focus();
     return false;
   }
  else if(obj.value!=document.pa_member.password1.value)
   {
     alert("两次输入的密码不一致!");
     document.pa_member.password1.value="";
     return false;
   }
  document.getElementById("reservearea").innerHTML="<input type='hidden' name='security_code' value='"+security_code+"'>";
  var zdyform=Check_ZdyForm('pa_member');
  if(!zdyform)
   {
     return false;
   }
 }

//检测用户名重复
function check_repeat(val,field)
 {
  if(field=="email")
   {
     if(!IsEmail(val)){return;}
   }
  var sobj=document.getElementById("s_"+field);
  if(Trim(val)=="" || !IsStr(field))
   {
    return;
   }
  var IsRepeat="0";
  var R=Math.random();
  var x=new PAAjax();
  x.setarg("post",false);
  if(typeof(UserName)=="undefined")
   {
    x.send("/e/member/check_repeat.aspx","value="+val+"&field="+field+"&r="+R,function(v){IsRepeat=v});
   }
  else
   {
    x.send("/e/member/check_repeat.aspx","value="+val+"&field="+field+"&username="+UserName+"&r="+R,function(v){IsRepeat=v});
   }
  var bt_post=document.getElementById("bt_post");
  if(IsRepeat=="0")
  {
   bt_post.disabled=false;
   var allright="<img src='/e/images/public/right.gif' width=16px height=16px align=absmiddle>";
   sobj.innerHTML=allright;
   bt_post.value=" 同意会员注册协议，注册成为会员 ";
  }
 else
  {
    switch(field)
     {
      case "username":
       sobj.innerHTML="<font color=#ff0000>此用户已被注册，请重新选择用户名</font>"
       bt_post.disabled=true;
      break;

      case "email":
       sobj.innerHTML="<font color=#ff0000>此邮箱已被注册</font>"
       bt_post.disabled=true;
      break;
     }
  }
 }


function Check_Feedback() //用户反馈
  {  

   var fb_value=Trim(document.getElementById("fb_title").value);
   if(fb_value=="")
    {
      alert("请输入留言主题!");
      document.getElementById("fb_title").focus();
      return false;
    }

   fb_value=Trim(document.getElementById("fb_truename").value);
   if(fb_value.length<2)
    {
      alert("请输入联系人姓名!");
      document.getElementById("fb_truename").focus();
      return false;
    }

  fb_value=Trim(document.getElementById("fb_email").value);
   if(fb_value=="")
    {
     alert("请输入您的邮箱!");
     document.getElementById("fb_email").focus();
     return false;
    }
   else if (fb_value.charAt(0)=="." || fb_value.charAt(0)=="@" || fb_value.indexOf('@', 0) == -1 || fb_value.indexOf('.', 0) == -1 || fb_value.lastIndexOf("@")==fb_value.length-1 || fb_value.lastIndexOf(".")==fb_value.length-1)
     {
        alert("邮箱格式错误，请重新输入!");
        document.getElementById("fb_email").focus();
        return false;
     }

   if(FckLength("fb_content")==0)
    {
      alert("请输入内容!");
      return false;
    }

  }

function Check_Reply() //用户反馈回复
  { 
   if(FckLength("fb_content")==0)
    {
      alert("请输入内容!");
      return false;
    }
  }

//发短信
 function Check_Message(thetype)
  {  

   var fb_value=Trim(document.getElementById("fb_receiver").value);
   document.getElementById('post').value=thetype;
   if(fb_value=="")
    {
      alert("收件人不能为空!");
      document.getElementById("fb_receiver").focus();
      return false;
    }

   fb_value=Trim(document.getElementById("fb_title").value);
   if(fb_value=="")
    {
      alert("请输入短信标题!");
      document.getElementById("fb_title").focus();
      return false;
    }

   if(FckLength("Content")==0)
    {
      alert("请输入短信内容!");
      return false;
    }

  }

function memnav_current()
 {
   var tid,url=location.href;
  try
   {
   if(url.indexOf("type=reg")>0){document.getElementById("nav_reg").className="current";}
   else if(url.indexOf("type=login")>0){document.getElementById("nav_login").className="current";}
   else if(url.indexOf("type=find_pass")>0){document.getElementById("nav_fps").className="current";}
   else if(url.indexOf("type=mem_msg")>0 || url.indexOf("type=mem_friends")>0 || url.indexOf("type=mem_black")>0){document.getElementById("nav_msg").className="current";}
   else if(url.indexOf("type=mem_issuelst")>0){document.getElementById("nav_issue").className="current";}
   else if(url.indexOf("type=mem_signlst")>0){document.getElementById("nav_sign").className="current";}
   else if(url.indexOf("type=mem_let")>0){document.getElementById("nav_let").className="current";}
   else if(url.indexOf("&tid=")>0)
    {
     tid=request("tid",url);
     document.getElementById("nav_"+tid).className="current";
    }
   else if(url.indexOf("mem_odidx")>0 || url.indexOf("mem_odlst")>0){document.getElementById("nav_od").className="current";}
   else if(url.indexOf("mem_exlst")>0 || url.indexOf("mem_exdtl")>0){document.getElementById("nav_ex").className="current";}
   else if(url.indexOf("mem_fnclst")>0 || url.indexOf("type=mem_pay")>0){document.getElementById("nav_fnc").className="current";}
   else if(url.indexOf("mem_ptlst")>0 || url.indexOf("type=mem_point")>0){document.getElementById("nav_pt").className="current";}
   else if(url.indexOf("mem_fbk")>0){document.getElementById("nav_fbk").className="current";}
   else if(url.indexOf("type=mem_favolst")>0){document.getElementById("nav_favolst").className="current";}
   else if(url.indexOf("type=mem_mdy")>0 || url.indexOf("type=mem_spcset")>0){document.getElementById("nav_mdy").className="current";}
  }
 catch (e)
  {
  }
 }
document.write("<script src=\"/e/js/dialog.js\" type=\"text/javascript\"></script>");