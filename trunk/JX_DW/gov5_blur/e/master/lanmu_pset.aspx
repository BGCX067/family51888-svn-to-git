<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<script language="c#" runat="server">
 OleDbConnection conn;
 string UserName,Is_Static;
 int SiteId;
 protected void Page_Load(Object src,EventArgs e)
    {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
     UserName=YZ._UserName;
     SiteId=int.Parse(Request.Cookies["SiteId"].Value);
     Conn theconn=new Conn();
     conn=new OleDbConnection(theconn.Constr());
     if(!Page.IsPostBack)
     {
       conn.Open();
       Get_Site(SiteId);
       Load_CssPath();
       conn.Close();
     }
   }
private void Load_CssPath()
 {
   string Template_Path=Server.MapPath("/e/templates/");
   DirectoryInfo di;
   string diname;
   DirectoryInfo dir=new DirectoryInfo(Template_Path);
   foreach(FileSystemInfo fsi in dir.GetFileSystemInfos())
    { 
      if(fsi is DirectoryInfo)
       {
         di=(DirectoryInfo)fsi;
         diname=di.Name;
         D_csspath.Items.Add(new ListItem(diname,"/e/templates/"+diname));
       }
    }
 }

protected void Data_Update(Object src,EventArgs e)
 {
    string sql_str="set xuhao=xuhao";
    if(Request.Form["ck_css"]=="1")
     {
      sql_str+=",zdy_csspath='"+Sql_Format(D_csspath.SelectedItem.Value)+"'";
     }
    if(Request.Form["ck_html"]=="1")
     {
      sql_str+=",html="+Sql_Format(D_Html.SelectedItem.Value);
     }
    if(Request.Form["ck_zdyurl"]=="1")
     {
      sql_str+=",zdy_url='"+Sql_Format(tb_url.Text)+"'";
     }
    if(Request.Form["ck_seotitle"]=="1")
     {
      sql_str+=",zdy_title='"+Sql_Format(tb_title.Text)+"'";
     }
    if(Request.Form["ck_seokeywords"]=="1")
     {
      sql_str+=",zdy_keywords='"+Sql_Format(tb_keywords.Text)+"'";
     }
     if(Request.Form["ck_seodescription"]=="1")
     {
       string Description=tb_description.Text;
       if(Description.Length>250)
        {
         Description=Description.Substring(0,250);
        }
       sql_str+=",zdy_description='"+Sql_Format(Description)+"'";
     }
    if(Request.Form["ck_zdyhead"]=="1")
     {
       sql_str+=",zdy_head='"+Sql_Format(Headzdy.Text)+"'";
     }
    if(Request.Form["ck_topzdy"]=="1")
     {
       sql_str+=",zdy_wztop='"+Sql_Format(Wztopzdy.Text)+"'";
     }
    if(Request.Form["ck_lanmuzdy"]=="1")
     {
       sql_str+=",zdy_lanmu='"+Sql_Format(Lanmuzdy.Text)+"'";
     }
    if(Request.Form["ck_dropmenuzdy"]=="1")
     {
       sql_str+=",zdy_dropmenu='"+Sql_Format(Dropmenuzdy.Text)+"'";
     }
    if(Request.Form["ck_banner"]=="1")
     {
       sql_str+=",zdy_banner='"+Sql_Format(Banner.Text)+"'";
     }
    if(Request.Form["ck_smallbanner"]=="1")
     {
       sql_str+=",zdy_smallbanner='"+Sql_Format(SmallBanner.Text)+"'";
     }
    if(Request.Form["ck_bottomzdy"]=="1")
     {
       sql_str+=",zdy_bottom='"+Sql_Format(Wzbottomzdy.Text)+"'";
     }
   string Ids=Request.Form["ids"];
   string[] AIds=Ids.Split(',');
   string sql;
   conn.Open();
   OleDbCommand comm;
   for(int i=0;i<AIds.Length;i++)
    {
     if(AIds[i]==""){continue;}
     sql="update pa_lanmu "+sql_str+" where id="+AIds[i];
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
    }
 
   conn.Close();
   PageAdmin.Log log=new PageAdmin.Log();
   log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"edit",1,UserName,"栏目批量属性设置");
   Response.Write("<"+"script type='text/javascript'>parent.restore(2)<"+"/script>");
   Response.End(); 
 }

private void Get_Site(int sid)
 {
   string sql="select html from pa_site where id="+sid;
   OleDbCommand  comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     Is_Static=dr["html"].ToString();
    }
   else
    {
     Is_Static="0";
     dr.Close();
     conn.Close();
     Response.Write("<"+"script>alert('无效站点id');history.back()<"+"/script>");
     Response.End();
    }
   dr.Close();
 }

private string Sql_Format(string str)
 {
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
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
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98%>
 <tr>
<td valign=top  align="left">
<iframe name="pframe" id="pframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="pframe">
<div id="div1">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">常用设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">其他设置</li>
</ul>
</div>
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<br>
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
 <tr>
  <td  height=30 width="100px"><input type="checkbox" name="ck_css" value="1">风格样式</td>
  <td><asp:DropDownList id="D_csspath" runat="server"><asp:ListItem value="">默认风格</asp:ListItem></asp:DropDownList></td>
 </tr>

<tr style="display:<%=Is_Static=="0"?"none":""%>">
  <td width=100px><input type="checkbox" name="ck_html" value="1">封面页静态<br></td>
  <td>
    <asp:DropDownList id="D_Html" runat="server">
    <asp:ListItem value="1">静态文件</asp:ListItem>
    <asp:ListItem value="0">动态文件</asp:ListItem>
    </asp:DropDownList>
  </td>
 </tr>
<tr>
  <td><input type="checkbox" name="ck_zdyurl" value="1">自定义链接</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="tb_url" runat="server" size=50 maxlength="150"  />
</td>
</tr>

<tr>
  <td><input type="checkbox" name="ck_seotitle" value="1">seo标题</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="tb_title" runat="server" size=50 maxlength="150"  />
</td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_seokeywords" value="1">seo关键字</td>
 <td align="left" title="关键字之间用半角逗号分开"><asp:textBox TextMode="singleLine" id="tb_keywords" runat="server" size=50 maxlength="150"  />
</td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_seodescription" value="1">seo描述</td>
 <td align="left" title="控制在250字以内"><asp:TextBox TextMode="multiLine" Columns="50" rows="4"  id="tb_description"  runat="server" onkeyup="if(this.value.length>250)this.value=this.value.substring(0,250)"/>
</td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_zdyhead" value="1">头信息自定义</td>
  <td><asp:TextBox  id="Headzdy" TextMode="MultiLine" runat="server" columns="50" rows="4" />
  </td>
</tr>
</table>
</div>
<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
<tr>
  <td width=120px><input type="checkbox" name="ck_topzdy" value="1">顶部信息自定义</td>
  <td><asp:TextBox  id="Wztopzdy"  TextMode="MultiLine"  runat="server" columns="50" rows="4" />
  </td>
 </tr>
<tr>

<tr>
  <td><input type="checkbox" name="ck_lanmuzdy" value="1">栏目自定义</td>
  <td><asp:TextBox id="Lanmuzdy" TextMode="MultiLine"  runat="server" columns="50" rows="4" />
  </td>
 </tr>


<tr>
  <td><input type="checkbox" name="ck_dropmenuzdy" value="1">下拉菜单自定义</td>
  <td><asp:TextBox  id="Dropmenuzdy" TextMode="MultiLine"  runat="server" columns="50" rows="4" />
  </td>
 </tr>


<tr>
  <td width=100px><input type="checkbox" name="ck_banner" value="1">横幅自定义</td>
  <td><asp:TextBox  id="Banner"  TextMode="MultiLine"  runat="server" columns="50" rows="4" />
  </td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_smallbanner" value="1">小幅banner自定义</td>
  <td><asp:TextBox  id="SmallBanner"  TextMode="MultiLine"  runat="server" columns="50" rows="4" />
  </td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_bottomzdy" value="1">底部信息自定义</td>
  <td><asp:TextBox  id="Wzbottomzdy"  TextMode="MultiLine"  runat="server" columns="50" rows="4" />
  </td>
 </tr>
<tr>
</table>
</div>
<br>
<div align=center>
<input type="hidden" value="" name="ids" id="ids">
<asp:Button Cssclass=button text="提交" id="Submit" runat="server" onclick="Data_Update" />
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog();">
</div>
<br>
</td>
</tr>
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
<br>
</center>
</body>
<script type="text/javascript">
document.getElementById("ids").value=parent.document.getElementById("ids").value;
if(GetCookie("tab")!="")
 {
  showtab(GetCookie("tab"));
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
</html>  



