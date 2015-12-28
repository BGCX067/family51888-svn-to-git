<% @ Page Language="C#" %>
<% @ Register TagPrefix="aspcn" TagName="uc_fckeditor" src="/e/incs/fckeditor/fckeditor.ascx"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string TheTable,TheField,TheId,objid;
 protected void Page_Load(Object src,EventArgs e)
  {
    ///公共区域==========================================================
       Master_Valicate YZ=new Master_Valicate();
       YZ.Master_Check();       //PageAdmin网站管理系统管理权限验证
       Conn conn=new Conn();
       ViewState["constr"]=conn.Constr();//获取连接字符串
     ///公共区域==========================================================
    TheTable=Request.QueryString["table"];
    TheField=Request.QueryString["field"];
    TheId=Request.QueryString["id"];
    objid=Request.QueryString["objid"];
  }

protected void Content_Update(Object src,EventArgs e)
 {
   int Id;
   if(IsNum(TheId))
    {
     Id=int.Parse(TheId);
    }
   else
    {
      Id=0;
      Response.Write("<script type='text/javascript'>alert('提交成功!');parent.cwin()</"+"script>");
      return;
    }
   string TheContent=Content.Text;
   string sql="select * from  "+TheTable+" where id="+Id;
   OleDbConnection conn=new OleDbConnection((string)ViewState["constr"]);
   conn.Open();
   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   OleDbCommandBuilder mycb=new  OleDbCommandBuilder(myAdapter);
   myAdapter.Fill(ds,"table1");
   DataRow dr;
     dr=ds.Tables["table1"].Rows[0];
     dr[TheField]=TheContent;
   myAdapter.Update(ds,"table1");
   conn.Close();
   Response.Write("<script type='text/javascript'>alert('提交成功!');</"+"script>");
   Response.End();
 }


private bool IsNum(string str)
 {
  if(str=="" || str==null)
   {
    return false;
   }
  string str1="0123456789";
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

</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>在线编辑器-PageAdmin网站管理系统</title>
<link rel="stylesheet" href="master.css" type="text/css">
<script src="master.js" type="text/javascript"></script>
</head>  
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98%>
 <tr>
<td valign=top>
<iframe name="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
  <td><asp:TextBox  id="Content"  TextMode="MultiLine"  runat="server" columns="80" rows="20" />
   <aspcn:uc_fckeditor id="uc_fck" Tb_Id="Content" Fck_Height="360" Fck_Style="Basic" runat="server"/>
  </td>
 </tr>
</table>
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
<td height=20 align=center>
<asp:Button Cssclass=button text="提交" runat="server" onclick="Content_Update" Id="Bt_Submit"/>
<input type="button" class=button  value="关闭"  onclick="cwin()">
</td>
 </tr>
</table>
<asp:Label id="Lb_Id" runat="server" visible="false"/>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
function cwin()
 { 
  parent.CloseDialog();
 }
var p_obj=parent.document.getElementById("<%=objid%>");
function FCKeditor_OnComplete()
{
 var oEditor=FCKeditorAPI.GetInstance("Content");
 oEditor.SetHTML(p_obj.value,false);
}

function Write_Pcontent()
 {
  var oEditor=FCKeditorAPI.GetInstance("Content");
  p_obj.value=oEditor.GetXHTML(true); 
 }
document.getElementById("Bt_Submit").onclick=Write_Pcontent;
</script>
</body>
</html>