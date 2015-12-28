<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="System.Xml"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
   string Table,Field,FieldType,Post,TheTitle,Url,T_Url,FileSize,Content,Permissions,Point,Xuhao,IsMaster,Thumbnail_MinWidth,Thumbnail_MinHeight,MaxNum,Allow_Upload;
   string M_Type,sql;
   int SiteId,InforId;
   OleDbConnection  conn;
   protected void Page_Load(Object sender,EventArgs e)
    {
     if(Request.QueryString["from"]=="master")
      {
        Master_Valicate Master=new Master_Valicate();
        Master.Master_Check();
        IsMaster="1";
        M_Type="0";
      }
     else
      {
        Member_Valicate Member=new Member_Valicate();
        Member.Member_Check();
        M_Type=(Member._MemberTypeId).ToString();
        IsMaster="0";
      }
       FieldType=Request.QueryString["type"];
       Table=Request.QueryString["table"];
       Field=Request.QueryString["field"];
       if(!IsStr(Table) || !IsStr(Field) || !IsStr(FieldType) || !IsNum(Request.QueryString["inforid"]) || !IsNum(Request.QueryString["sid"]))
       {
         Response.Write("<"+"script type='text/javascript'>alert('invalid table or field or fieldtype or InforId or SiteId!')</"+"script>");
         Response.End();
       }
      SiteId=int.Parse(Request.QueryString["sid"]);
      InforId=int.Parse(Request.QueryString["inforid"]);
      Conn Myconn=new Conn();
      string constr=Myconn.Constr();
      conn=new OleDbConnection(constr);
      conn.Open();
        Read_Xml();
        Get_Member_Type(int.Parse(M_Type));
        Get_Field();
        if(IsNum(Request.QueryString["id"]) && Request.QueryString["id"]!="0")
        {
          Get_Data(int.Parse(Request.QueryString["id"]));
          Post="edit";
        }
       else
        {
          Post="add";
          Url="";
        }

    conn.Close();
    }


  private void Get_Data(int Id)
   {
     sql="select * from pa_file where thetable='"+Table+"' and [field]='"+Field+"' and id="+Id;
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     if(dr.Read())
      {
       TheTitle=HTMLEncode(dr["title"].ToString());
       Url=HTMLEncode(dr["url"].ToString());
       T_Url=HTMLEncode(dr["thumbnail"].ToString());
       FileSize=dr["filesize"].ToString();
       Permissions=dr["permissions"].ToString();
       Point=dr["point"].ToString();
       Content=HTMLEncode(dr["introduction"].ToString());
       Xuhao=dr["xuhao"].ToString();
      }
     else
      {
        Response.Write("文件不存在");
        Response.End();
      }
     dr.Close();
   }


 private void Get_Field()
   {
     sql="select max_num from pa_field where thetable='"+Table+"' and [field]='"+Field+"'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     if(dr.Read())
      {
        MaxNum=dr["max_num"].ToString();
      }
     else
      {
        MaxNum="1";
      }
     dr.Close();
   }

private void Get_Member_Type(int MtypeId)
 {
    Allow_Upload="0";
    string Mcenter_Permissions="";
    string sql="select m_set from pa_member_type where id="+MtypeId;
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr= comm.ExecuteReader();
    if(dr.Read())
      {
        Mcenter_Permissions=dr["m_set"].ToString();
      }  
    dr.Close();

    if(FieldType=="files")
     {
      if(Mcenter_Permissions.IndexOf("upload_field_attachments=1")>=0)
      {
       Allow_Upload="1";
      }
     }
    else if(FieldType=="images")
     {
      if(Mcenter_Permissions.IndexOf("upload_field_images=1")>=0)
      {
       Allow_Upload="1";
      }
     }
   sql="select * from pa_member_type order by xuhao";
   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(ds,"table1");
   P_permissions.DataSource= ds.Tables["table1"].DefaultView;
   P_permissions.DataBind(); 
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

private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
           Response.Write("<"+"script type='text/javascript'>alert('invalid submit!')</"+"script>");
           Response.End();
          }
      }
 }

private string HTMLEncode(string str)
 {
  if(string.IsNullOrEmpty(str)){return "";}
  str=str.Replace("&","&amp;");
  str=str.Replace("\"","&quot;");
  return str;
 }
private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  string str2=str.ToLower();
  for(int i=0;i<str2.Length;i++)
   {
    if(str1.IndexOf(str2[i])==-1)
     {
       return false;
     }
   }
  return true;
 }
private bool IsFloat(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789.";
  if((str.Length-str.Replace(".",String.Empty).Length)>1)
    {
       return false;
    }
  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
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
<title>文件组发布界面</title>
<style type="text/css">
body{word-wrap:break-word;font:12px/1.6em Tahoma,Helvetica,Arial,sans-serif;color:#333333;font-family:inherit;background-color:#ffffff}
form,ul,li{list-style-type:none;margin:0 0 0 0;padding:0 0 0 0;}
#list{border:0px solid menu;background-color:#cccccc}
#list td{background-color:menu;}
.main{border:1px solid #999999;text-align:cetner;width:550px;padding:2px 0 5px 0;background-color:#D1EAFE}
.main table td{padding:3px 3px 4px 3px;}
a:link{color:#333333;text-decoration:none}
a:visited{color:#333333;text-decoration:none}
a:hover{color:#333333;text-decoration:underline}
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
<table cellspacing="0" cellpadding="0" width="100%" border="0" align="center">
<form method="post" name="f" target="uframe" action="upload_1.aspx" Enctype="multipart/form-data">
<tr>
<td align=right>文件来源</td>
<td align=left><span id="lb_source_1" style="display:none"><input type="radio" value="0" name="file_source" id="file_source_1" checked onclick="C_Srorce()">本地上传 &nbsp;</span><input type="radio" value="1" name="file_source" id="file_source_2" onclick="C_Srorce()">网络文件</td>
</tr>

<tr id="tr_upload" style="display:none">
<td align=right>文件上传</td>
<td align=left><input type="file" name="file" id="file" size="30" contentEditable="false"> &nbsp;<span id="postarea" style="display:<%=IsMaster=="1"?"":"none"%>"><input type="checkbox" name="rename" value="1" checked>重命名 &nbsp;<input type="checkbox" name="watermark" value="1" checked>加水印</span><span id="UploadState" style="display:none"><img src="/e/images/public/uploading.gif" align="absmiddle">上传中...</span></td>
</tr>

<tr id="tr_url" style="display:none">
<td align=right><%=FieldType=="images"?"图片":"文件"%>地址</td>
<td align=left><input type="textbox" id="url" name="url" size="50"  maxlength="200" ondblclick="ViewUrl(this.value)" value="<%=Url%>" <%=(Url.ToLower().IndexOf("http://")==0 || Url=="")?"":"readonly onkeydown=\"alert('禁止直接修改!');return false\""%> title="格式如：http://www.pageadmin.net/image.jpg"><%if(IsMaster=="1"){%>&nbsp;<input type="button" id="bt_url" value="浏览服务器" onclick="open_select('','<%=FieldType%>','<%=Request.QueryString["table"]%>','<%=Request.QueryString["field"]%>','url')" style="height:22px;"><%}%></td>
</tr>

<tr id="tr_size" style="display:none">
<td align=right>文件大小</td>
<td align=left><input type="textbox" name="filesize" id="filesize" value="<%=FileSize%>" onkeyup="if(isNaN(value))execCommand('undo')" size=10 maxlength="20">kb</td>
</tr>


<tr>
<td width="80px" align=right><%=FieldType=="images"?"图片":"文件"%>名称</td>
<td align=left><input type="textbox" name="title" id="title"  size="30" Maxlength="50" value="<%=TheTitle%>"></td>
</tr>

<tr>
<td align=right><%=FieldType=="images"?"图片":"文件"%>说明</td>
<td align=left><textarea  id="beizhu" name="beizhu" cols="50" rows="4"><%=Content%></textarea></td>
</tr>


<tr style="display:<%=FieldType=="files"?"":"none"%>">
<td  align=right>下载权限</td>
<td align=left>
  <input type="checkbox" name="Visiter_all" id="Visiter_0" value="0"  onclick="select_all()">无限制<br>
        <asp:Repeater id="P_permissions" runat="server">
         <ItemTemplate>
           <input type="checkbox" name="Visiter" id="Visiter_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" ><%#DataBinder.Eval(Container.DataItem,"m_type")%>&nbsp;
         </ItemTemplate>
        </asp:Repeater>
</td>
</tr>

<tr style="display:<%=FieldType=="files"?"":"none"%>">
<td align=right>下载积分</td>
<td align=left><input type="textbox" name="point" id="point"  size="10" Maxlength="10" value="<%=Point==null?"0":Point%>" onkeyup="if(isNaN(value))execCommand('undo')"></td>
</tr>



<tr>
<td align=right>排序</td>
<td align=left><input type="textbox" name="xuhao" id="xuhao" size="5" Maxlength="10" value="<%=Xuhao==null?"1":Xuhao%>" onkeyup="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align="center" colspan="2">
<input type="button" id="postbt" value=" <%=Post=="add"?"增加":"更新"%> "  onclick="return c_form()" style="height:22px">
<span id="showautotitlepic" style="display:none"><input name='autotitlepic' id='autotitlepic' type='checkbox' value='1'>同时存为标题图片</span>
</td>
</tr>
<input type="hidden" id="oldurl" name="oldurl" value="<%=Url%>">
<input type="hidden" id="thumbnail" name="thumbnail" value="<%=T_Url%>">
<input type="hidden" id="width" name="width" value="<%=Thumbnail_MinWidth%>">
<input type="hidden" id="height" name="height" value="<%=Thumbnail_MinHeight%>">
<input type="hidden" name="sid" value="<%=Request.QueryString["sid"]%>">
<input type="hidden" name="inforid" value="<%=Request.QueryString["inforid"]%>">
<input type="hidden" name="id" value="<%=Request.QueryString["id"]%>">
<input type="hidden" name="type" value="<%=FieldType%>">
<input type="hidden" name="table" value="<%=Table%>">
<input type="hidden" name="field" value="<%=Field%>">
<input type="hidden" name="post" value="<%=Post%>">
<input type="hidden" name="from" value="<%=Request.QueryString["from"]%>">

</form>
</table>
</div>
<script type="text/javascript">
var Visitor="<%=Permissions%>";
var AVisitor=Visitor.split(',');
if(Visitor=="" || Visitor=="0")
 {
   document.getElementById("Visiter_0").checked=true;
   lock_mem_check();
 }
else
 {
   for(i=0;i<AVisitor.length;i++)
    {
      try{
         document.getElementById("Visiter_"+AVisitor[i]).checked=true;
         }
       catch(ex)
         {
         }
    }
 }
function lock_mem_check()
 {
  for(i=0;i<document.forms[0].Visiter.length;i++)
     {
       document.forms[0].Visiter[i].checked=true;
       document.forms[0].Visiter[i].disabled=true;
    }
 }

function unlock_mem_check()
 {
  for(i=0;i<document.forms[0].Visiter.length;i++)
     {
       //document.forms[0].Visiter[i].checked=false;
       document.forms[0].Visiter[i].disabled=false;
    }
 }
function select_all()
 {
   var obj=document.getElementById("Visiter_0");
   if(obj.checked)
    {
      lock_mem_check();
    }
   else
    {
     unlock_mem_check()
    }
 }

//变更类型
var lb_source_1=document.getElementById("lb_source_1");
var radio_source_1=document.getElementById("file_source_1");
var radio_source_2=document.getElementById("file_source_2");
var tr_upload=document.getElementById("tr_upload");
var tr_url=document.getElementById("tr_url");
var tr_size=document.getElementById("tr_size");
var FieldType="<%=FieldType%>";
var Post="<%=Post%>";
var IsMaster=<%=IsMaster%>;
function C_Srorce()
 {
  if(radio_source_1.checked)
   {
    tr_upload.style.display="";
    tr_url.style.display="none";
    tr_size.style.display="none";
   }
  else
   {
    tr_upload.style.display="none";
    tr_url.style.display="";
    if(FieldType=="files")
     {
      tr_size.style.display="";
     }
   }
 }

var TitlePic=parent.document.getElementById("titlepic");
if(FieldType=="images")
 {
  var showautotitlepic=document.getElementById("showautotitlepic");
  if(TitlePic!=null)
   {
     if(TitlePic.value=="")
      {
       showautotitlepic.style.display="";
       document.getElementById("autotitlepic").checked=true;
      }
   }
 }

if(IsMaster==1)
 {
   lb_source_1.style.display="";
   tr_upload.style.display="";
 }
else
 {
   var Allow_Upload="<%=Allow_Upload%>" //是否允许上传
   if(Allow_Upload=="1")
    {
      lb_source_1.style.display="";
      tr_upload.style.display="";
    }
   else
    {
      radio_source_2.checked=true;
      tr_url.style.display="";
    }
 }

if(Post=="edit")
 {
  radio_source_2.checked=true;
  C_Srorce();
 }

var CurrentId="<%=Request.QueryString["id"]%>";
if(CurrentId=="0" || CurrentId=="")
{
var CurrentNum=parent.document.getElementById("<%=Field%>").value;
if(isNaN(CurrentNum)){CurrentNum="0";}
document.getElementById("xuhao").value=parseInt(CurrentNum)+1;
}
function c_form()
 {
   if("<%=Request.QueryString["table"]%>"=="" || "<%=Field%>"=="")
     {
      alert("参数错误!");
      return false;
     }
   var MaxNum=<%=MaxNum%>;
   if(document.forms["f"].post.value=="add" && !isNaN(CurrentNum) && MaxNum>0)
    {
      if(CurrentNum>=MaxNum)
      {
        if(FieldType=="images")
         {
          alert("对不起，只能发布"+MaxNum+"张图片!");
         }
        else
         {
          alert("对不起，只能发布"+MaxNum+"组文件!");
         }
        return false;
      }
    }

   var obj;
   if(radio_source_1.checked)
    {
     obj=document.forms["f"].file;
     if(obj.value=="")
     {
      alert("请选择上传文件!");
      obj.focus();
      return false;
     }
    }
   else
    {
     obj=document.forms["f"].url;
     if(obj.value=="" || obj.value.indexOf(".")<=0)
     {
      alert("请正确填写<%=FieldType=="images"?"图片":"文件"%>地址!");
      obj.focus();
      return false;
     }
     else if(obj.value.indexOf(":\\")>=0)
     {
      alert("您填写的地址可能是本地电脑的路径，请填写网络地址!");
      obj.focus();
      return false;
     }
   }

   obj=document.forms["f"].title;
   if(obj.value=="")
    {
      //alert("请填写<%=FieldType=="images"?"图片":"文件"%>名称!");
      //obj.focus();
      //return false;
    }

   var objstate=document.getElementById("UploadState");
   var objpostarea=document.getElementById("postarea");
   var postbt=document.getElementById("postbt");

   objstate.style.display="";
   objpostarea.style.display="none";
   postbt.disabled=true;
   document.forms["f"].submit();
   return true;
 }

function  ViewUrl(url)
 {
    if(url!="" && url.indexOf(".")>0)
    {
      window.open(url,"view");
    } 
 }


function ReFresh_Parent(Tpic)
 {
  if(Tpic!="" && TitlePic!=null)
   {
    TitlePic.value=Tpic;
    var p_delete=parent.document.getElementById("delete_titlepic");
    var p_upload=parent.document.getElementById("upload_titlepic");
    p_delete.style.display="";
    p_upload.style.display="none";
   }
   if(Post=="add")
   {
     parent.Iframe_ReFresh('iframe_<%=Field%>');
     parent.CloseDialog();
   }
  else
   {
     parent.Iframe_ReFresh('iframe_<%=Field%>');
     location.href=location.href;
   }
 }

function open_select(path,type,table,field,id)
 {
  var Width=540;
  var Height=580;
  var Left=(window.screen.availWidth-10-Width)/2
  var Top=(window.screen.availHeight-30-Height)/2
  var Val=window.open("/e/aspx/file_select.aspx?sid=<%=Request.QueryString["sid"]%>&filepath="+path+"&type="+type+"&table="+table+"&field="+field+"&objid="+id+"&from=<%=Request.QueryString["from"]%>","upload","width="+Width+",height="+Height+",top="+Top+",left="+Left+",toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=yes");
 }

</script>
</center>
</body>
</html>

