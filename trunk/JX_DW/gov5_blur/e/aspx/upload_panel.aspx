<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.Xml"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
   string Thumbnail_MinWidth,Thumbnail_MinHeight,IsMaster;
   protected void Page_Load(Object sender,EventArgs e)
   {
        if(!IsNum(Request.QueryString["sid"]) || Request.QueryString["sid"]=="0")
         {
           Response.Write("无效的sid");
           Response.End();
         }
        if(!IsStr(Request.QueryString["table"]))
         {
           Response.Write("无效的table");
           Response.End();
         }
        Read_Xml();
        if(Request.QueryString["from"]=="master")
         {
           Master_Valicate YZ=new Master_Valicate();
           YZ.Master_Check();
           IsMaster="1";
        }
      else
        {
           Member_Valicate Member=new Member_Valicate();
           Member.Member_Check();
           IsMaster="0";
        }
   }

private void Read_Xml()
 {
    string XmLFile="/e/incs/site_"+Request.QueryString["sid"]+".xml";
    Thumbnail_MinWidth="400";
    Thumbnail_MinHeight="400";
    if(File.Exists(Server.MapPath(XmLFile)))
     {
      XmlDocument   XMLFile=new XmlDocument(); 
      XMLFile.Load(Server.MapPath(XmLFile));
      XmlElement xe;
      XmlNodeList  xnlist;
      xnlist=XMLFile.SelectSingleNode("PageAdminConfig/Thumbnail").ChildNodes;
      foreach (XmlNode xn in xnlist) 
        { 
          xe=(XmlElement)(xn); 
          switch(xe.Name)
           {
              case "MinWidth":
                  Thumbnail_MinWidth=xe.InnerText;
              break;

             case "MinHeight":
                  Thumbnail_MinHeight=xe.InnerText;
              break;
           }
       } 
     }
 }

private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  string str2=str.ToLower();;
  for(int i=0;i<str2.Length;i++)
   {
    if(str1.IndexOf(str2[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789";
  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
 }
</script><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>文件上传</title>
<style type="text/css">
body{word-wrap:break-word;font:12px/1.6em Tahoma,Helvetica,Arial,sans-serif;color:#333333;font-family:inherit;background-color:#ffffff}
form,ul,li{list-style-type:none;margin:0 0 0 0;padding:0 0 0 0;}
#list{border:0px solid menu;background-color:#cccccc}
#list td{background-color:menu;}
a:link{color:#333333;text-decoration:none}
a:visited{color:#333333;text-decoration:none}
a:hover{color:#333333;text-decoration:underline}
.main{border:1px solid #999999;text-align:cetner;width:520px;padding:2px 0 5px 0;background-color:#D1EAFE}
.main table td{padding:3px 3px 4px 3px;}
.button{
	width:55px;
	font-size:9pt;
	height:19px;
	cursor: hand;
	background-image: url(/e/images/public/button.gif);
	background-position: center center;
	border-top: 0px outset #eeeeee;
	border-right: 0px outset #888888;
	border-bottom: 0px outset #888888;
	border-left: 0px outset #eeeeee;
	padding-top: 2px;
	background-repeat: repeat-x;
	}
</style>
</head>
<body>
<center>
<iframe name="uframe" id="uframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<div class="main">
<table cellspacing="0" cellpadding="0" width="100%" border="0">
<form method="post" Enctype="multipart/form-data" name="f" target="uframe" action="upload.aspx" onsubmit="return UpLoad()">
<tr>
<td width="80px" align=right>本地上传</td>
<td align=left><input type="file" name="file" id="file" size="30" contentEditable="false"> &nbsp;<span id="postarea"><input type="submit" value="上传" style="height:22px" id="bt_upload"><span id="lb_rename" style="display:<%=IsMaster=="1"?"":"none"%>"><input type="checkbox" name="rename" value="1" checked>重命名</span></span><span id="UploadState" style="display:none"><img src="/e/images/public/uploading.gif" align="absmiddle">上传中...</span></td>
</tr>

<tr style="display:<%=IsMaster=="1"?"":"none"%>" id="images_set">
<td align=right>图片上传</td>
<td align=left><input type="checkbox" name="watermark" value="1" checked>增加水印 &nbsp;<input type="checkbox" name="thumbnail" value="1">生成缩略图 宽<input type="text" id="width" name="width" value="<%=Thumbnail_MinWidth%>" size="2" Maxlength="3" onkeyup="if(isNaN(value))execCommand('undo')" onblur="if(this.value=='')execCommand('undo')">px 高<input type="text" id="height" name="height" value="<%=Thumbnail_MinHeight%>" size="2" Maxlength="3" onkeyup="if(isNaN(value))execCommand('undo')" onblur="if(this.value=='')execCommand('undo')">px</td>
</tr>

<tr style="display:<%=IsMaster=="1"?"":"none"%>">
<td align=right>文件路径</td>
<td align=left><input type="textbox" id="url" name="url" size="30" ondblclick="ViewUrl()" title="双击查看">&nbsp;<input type="button" id="bt_url" value="服务器文件" onclick="open_upload('','<%=Request.QueryString["type"]%>','<%=Request.QueryString["table"]%>','<%=Request.QueryString["field"]%>','url')" style="height:22px;display:<%=IsMaster=="1"?"":"none"%>"></td>
</tr>

<tr style="display:<%=IsMaster=="1"?"":"none"%>">
<td align=right><input type="button" value=" 确定 "  onclick="GetUrl()" style="height:22px" ></td><td></td>
</tr>
<input type="hidden" name="filesize" id="filesize" value="0">
<input type="hidden" name="sid" value="<%=Request.QueryString["sid"]%>">
<input type="hidden" name="type" value="<%=Request.QueryString["type"]%>">
<input type="hidden" name="table" value="<%=Request.QueryString["table"]%>">
<input type="hidden" name="field" value="<%=Request.QueryString["field"]%>">
<input type="hidden" name="from" value="<%=Request.QueryString["from"]%>">
<input type="hidden" name="submit" value="1">
</form>
</table>
</div>
</center>
<script type="text/javascript">
 var parent_obj=parent.document.getElementById("<%=Request.QueryString["objid"]%>");
 var url_obj=document.getElementById("url");
 var objstate=document.getElementById("UploadState");
 var objpostarea=document.getElementById("postarea");
 var obj=document.getElementById("file");
 var Type=document.forms["f"].type.value;
 var Table=document.forms["f"].table.value;
 var Field=document.forms["f"].field.value;

 if(parent_obj.value!="" &&  parent_obj.value.indexOf(".")>0)
  {
   url_obj.value=parent_obj.value;
  }

 if(Type=="file")
  {
    document.getElementById("images_set").style.display="none";
  }

 if(Field=="titlepic")
  {
    document.forms["f"].thumbnail.checked=true;
  }
 function UpLoad()
  {
    if(Type=="" || Table=="" || Field=="" || "<%=Request.QueryString["objid"]%>"=="")
     {
      alert("参数错误!");
      return false;
     }

   if(obj.value=="")
   {
     alert("请选择要上传的文件!");
     return false;
   }
  else
   {
     objstate.style.display="";
     objpostarea.style.display="none";
     //document.forms["f"].submit();
     return true;
   }
  }

function ViewUrl()
 {
   var url=document.getElementById("url").value;
   if(url!="" && url.indexOf(".")>0)
    {
      window.open(url,"view");
    }
 }

function GetUrl()
 {
   var url=url_obj.value;
   if(url!="" && url.indexOf(".")>0)
    {
      var p_delete=parent.document.getElementById("delete_<%=Request.QueryString["objid"]%>");
      var p_upload=parent.document.getElementById("upload_<%=Request.QueryString["objid"]%>");
      parent_obj.value=url;
      p_delete.style.display="";
      p_upload.style.display="none";
    }
   else if(obj.value!="")
    {
      document.getElementById("bt_upload").click();
      return false;
    }
    parent.CloseDialog();
 }

function open_upload(path,type,table,field,id)
 {
  var Width=540;
  var Height=580;
  var Left=(window.screen.availWidth-10-Width)/2
  var Top=(window.screen.availHeight-30-Height)/2
  var Val=window.open("/e/aspx/file_select.aspx?sid=<%=Request.QueryString["sid"]%>&filepath="+path+"&type="+type+"&table="+table+"&field="+field+"&objid="+id+"&from=<%=Request.QueryString["from"]%>","select","width="+Width+",height="+Height+",top="+Top+",left="+Left+",toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=yes");
 }
</script>
</body>
</html>