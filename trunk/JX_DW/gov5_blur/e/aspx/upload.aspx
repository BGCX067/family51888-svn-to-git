﻿<% @ Page language="c#" Inherits="PageAdmin.upload"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Upload</title>
</head>
<body bgcolor="menu">
<script type="text/javascript">
var Result="<%=Request.QueryString["result"]%>";
var CS="<%=Request.QueryString["cs"]%>";
var P_State=parent.document.getElementById("UploadState");
var P_Postarea=parent.document.getElementById("postarea");
var p_Ulr=parent.document.getElementById("url");
var p_Size=parent.document.getElementById("filesize");
var P_file=parent.document.getElementById("file");

<%if(Request.QueryString["result"]!=null)
 {
%>

switch(Result)
 {

  case "emptyfile":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("未选择上传文件!");
  break;

  case "invalid_submit":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("非法提交!");
  break;

  case "invalidimage":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("无效的图片文件!");
  break;

  case "toolarge":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("文件太大了,请控制在"+CS+"kb以内!");
  break;

  case "noext":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("禁止上传"+CS+"格式的文件!");
  break;

  case "dangerousext":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("警告：禁止上传"+CS+"这类不安全文件!");
  break;

  case "cs_error":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("参数错误!");
  break;

  case "nojilu":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("不存在上传点!");
  break;

  case "noset_ext":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("允许上传的扩展名未设置!");
  break;

  case "noset_maxlength":
   P_State.style.display="none";
   P_Postarea.style.display="";
   alert("未设置上传单个文件的最大限制!");
  break;

  case "success":
   P_State.style.display="none";
   P_Postarea.style.display="";
   p_Ulr.value=CS;
   p_Size.value="<%=Request.QueryString["filesize"]%>";
   P_file.value="";
   alert("上传成功!");
   parent.GetUrl();
  break;
 }
<%}%>

</script>
</body>
</html>