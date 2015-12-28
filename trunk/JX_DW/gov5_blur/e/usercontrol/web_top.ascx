<% @ Control language="c#" Inherits="PageAdmin.web_top"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=PaTitle%><%=(!string.IsNullOrEmpty(PaTitle) && !string.IsNullOrEmpty(PaName))?"-":""%><%=PaName%><%=TC%></title><%=string.IsNullOrEmpty(PaKeyWords)?"":"\r\n<meta name=\"keywords\" content=\""+Server.HtmlEncode(PaKeyWords)+"\" />"%><%=string.IsNullOrEmpty(PaDescription)?"":"\r\n<meta name=\"description\" content=\""+Server.HtmlEncode(PaDescription)+"\" />"%>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link href="<%=CssPath%>/lanmu.css" type="text/css" rel="stylesheet" />
<script src="/e/js/comm.js" type="text/javascript"></script><%if(Is_Member==1){%><LINK href="/e/member/member.css" type="text/css" rel="stylesheet" /><script src="/e/js/member.js" type="text/javascript"></script><%}%>
<%=Zdy_Head%><link rel="shortcut icon" type="image/ico" href="/e/images/favicon.ico">
</head>
<body>
<div class="page_style" id="<%=LanmuType%>">
<div class="top_box"><%if(Wz_Logo!="" && Logo_Site=="0"){%><div class="logo"><a href="<%=Url_Prefix%>"><img src="<%=Wz_Logo%>" border=0></a></div><%}%>
<div class="topcontent"><%=Wz_Top%></div><%if(Wz_Logo!="" && Logo_Site=="0"){%><div class="clear"></div><%}%>
<%=Zdy_Lanmu%><asp:Repeater id="LanmuList" runat="server">
<HeaderTemplate><%if(Wz_Logo!="" && Logo_Site=="1"){%><div class="logo"><a href="<%=Url_Prefix%>"><img src="<%=Wz_Logo%>" border=0></a></div><%}%>
<div class="menu_box<%if(Wz_Logo!="" && Logo_Site=="1"){%> right<%}%>" id="Menu"><ul></HeaderTemplate>
 <ItemTemplate><li class="menu_style<%#DataBinder.Eval(Container.DataItem,"thetype").ToString()=="home"?"_homepage":""%><%#DataBinder.Eval(Container.DataItem,"id").ToString()==Lanmu_Id.ToString()?" menu_current":""%>" id="MenuItem<%#DataBinder.Eval(Container.DataItem,"id")%>" name="MenuItem"><a href="<%#Get_Url(DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"thetype").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_dir").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_file").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString())%>" class="menu"  target='<%#DataBinder.Eval(Container.DataItem,"target")%>'><%#DataBinder.Eval(Container.DataItem,"name")%></a><%#DataBinder.Eval(Container.DataItem,"zdy_dropmenu")%></li>
</ItemTemplate>
 <FooterTemplate></ul></div><%if(Wz_Logo!="" && Logo_Site=="0"){%><div class="clear"></div><%}%></FooterTemplate>
</asp:Repeater>
<script type="text/javascript">var IsPageHome="<%=PageHome%>";var Lanmu_Id="<%=Lanmu_Id%>";var Sublanmu_Id="<%=Sublanmu_Id%>";ShowSubMenu(Lanmu_Id);</script>
</div>
<script language="javascript">
var strValue = " "; 
var strTitle = document.title; 
document.title = strTitle.replace("-Powered by PageAdmin CMS",strValue);</script>