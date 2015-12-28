<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
  OleDbConnection conn;
  int SiteId,PageSize,List_Level;
  string SiteDir,Is_Static,TheTable,List_Space,sql_str,order_str,Url_Prefix,TheMaster,Site_List,Sort_List;
  protected void Page_Load(Object src,EventArgs e)
   {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    TheMaster=YZ._UserName;
    SiteId=int.Parse(Request.Cookies["SiteId"].Value);
    TheTable="pa_zt";
    if(IsNum(Tb_pagesize.Text.Trim()))
     {
      PageSize=int.Parse(Tb_pagesize.Text.Trim());
     }
    else
     {
      PageSize=20;
     }
   if(!Page.IsPostBack)
    {
      Conn theconn=new Conn();
      ViewState["constr"]=theconn.Constr();//获取连接字符串
      ViewState["CurrentPage"]=0;
      if(IsNum(Request.QueryString["pagesize"]))
       {
         PageSize=int.Parse(Request.QueryString["pagesize"]);
         Tb_pagesize.Text=PageSize.ToString();
       }
      sql_str="";
      if(IsNum(Request.QueryString["siteid"]) && Request.QueryString["siteid"]!="0")
       {
         sql_str+=" and site_id="+int.Parse(Request.QueryString["siteid"]);
         SiteId=int.Parse(Request.QueryString["siteid"]);
       }
      else
       {
         sql_str+=" and site_id="+SiteId;
       }

      if(IsNum(Request.QueryString["sortid"]))
       {
         sql_str+=" and sort_id="+int.Parse(Request.QueryString["sortid"]);
       }
      if(IsStr(Request.QueryString["type"]))
       {
          switch(Request.QueryString["type"])
           {
             case "isgood":
                sql_str+=" and isgood=1";
             break;
           }
       }

        if(Request.QueryString["keyword"]!=null && Request.QueryString["keyword"]!="")
          {
            sql_str+=" and title like '%"+Sql_Format(Request.QueryString["keyword"])+"%'";
          }
       order_str="id desc"; 
       if(Request.QueryString["order"]!=null && Request.QueryString["order"]!="")
          {
            order_str=Sql_Format(Request.QueryString["order"]);
          }
      ViewState["order_str"]=order_str;
      ViewState["Calculatesql"]="select count(id) as co from "+TheTable+" where id>0"+sql_str;
      ViewState["sql"]="select id from "+TheTable+" where id>0"+sql_str+"  order by "+order_str;
      conn=new OleDbConnection((string)ViewState["constr"]);
      conn.Open();
        //Get_Site(SiteId);
        Tongji();
        Data_Bind();
        Get_Site();
        Get_Sort(0);
     conn.Close();
     Tb_pagesize.Text=PageSize.ToString();
    }
   else
    {
      conn=new OleDbConnection((string)ViewState["constr"]);
      conn.Open();
       Get_Site();
       Get_Sort(0);
      conn.Close();
    }
  }


private void Data_Bind()
 {
  string sql=(string)ViewState["sql"];
  int CurrentPage=(int)ViewState["CurrentPage"];
  int PageCount=(int)ViewState["PageCount"];
  LblPrev.Enabled=true;
  LblNext.Enabled=true;

  if(CurrentPage<=0)   //控制转页按纽
   {
   LblPrev.Enabled=false;
   }
   if(CurrentPage>=(PageCount-1))
   {
   LblNext.Enabled=false;
   }
  Lblcurrentpage.Text=(CurrentPage+1).ToString();

//填充下拉单
  DLpage.Items.Clear();
  int StartPage,EndPage;
  int JS=200,MB=100;
  if(CurrentPage<JS)
   {
     StartPage=0;
     EndPage=JS;
   }
  else
   {
     StartPage=CurrentPage-MB;
     EndPage=CurrentPage+MB;
     DLpage.Items.Add(new ListItem("1","0"));
     DLpage.Items.Add(new ListItem("...",(StartPage-1).ToString()));
   }
  if(EndPage>=PageCount)
   {
     EndPage=PageCount;
   }

  for(int i=StartPage;i<EndPage;i++)
    {
     DLpage.Items.Add(new ListItem((i+1).ToString(),i.ToString()));
    }

  if(PageCount>JS && EndPage<PageCount-1)
   {
     DLpage.Items.Add(new ListItem("...",EndPage.ToString()));
   }
  if(EndPage<PageCount)
   {
     DLpage.Items.Add(new ListItem(PageCount.ToString(),(PageCount-1).ToString()));
   }
   
  DLpage.SelectedIndex=DLpage.Items.IndexOf(DLpage.Items.FindByValue(CurrentPage.ToString()));
 //填充下拉单
  
  int StartIndex=CurrentPage*PageSize;
  DataSet ds=new DataSet();
  OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);//在数据库和DataSet之间建立桥接。
  myAdapter.Fill(ds,StartIndex,PageSize,"default");
  ds=Optimize_DataSet(ds,"pa_zt",(string)ViewState["order_str"]);
  P1.DataSource=ds.Tables["default"].DefaultView;
  P1.DataBind();

 }


private DataSet Optimize_DataSet(DataSet SourceDs,string Table,string Order)
 {
   int RCount=SourceDs.Tables["default"].Rows.Count;
   string Ids="0";
   if(RCount>0)
    {
      DataRow dr;
      for(int i=0;i<RCount;i++)
       {
         dr=SourceDs.Tables["default"].Rows[i];
         Ids+=","+dr["id"].ToString();
       }
    }
   SourceDs.Clear();
   string sql="select * from "+Table+" where id in("+Ids+") order by "+Order;
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(SourceDs,"default");
   return SourceDs;
 }

private void Tongji()
{
//计算总记录
 string sql=(string)ViewState["Calculatesql"];
 OleDbCommand myComm=new OleDbCommand(sql,conn);
 OleDbDataReader dr=myComm.ExecuteReader();
 int Rcount;
  if(dr.Read())
   {
    Rcount=(int)dr["co"];
   }
  else
   {
   Rcount=0;
   }
 Lblrecordcount.Text=Rcount.ToString();

//计算总页数
 int PageCount;
 if(Rcount%PageSize==0)
  {
   PageCount=Rcount/PageSize;
  }
 else
 {
  PageCount=Rcount/PageSize+1;
 }

 ViewState["PageCount"]=PageCount;
 LblpageCount.Text=PageCount.ToString();
}


private void Get_Site()
 {
   string sql="select id,sitename from pa_site order by xuhao,id";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
     Site_List+="<option value='"+dr["id"].ToString()+"'>"+dr["sitename"].ToString()+"</option>\r\n";
    }
   dr.Close();
 }

private void Get_Sort(int Parentid)
 {
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and site_id="+SiteId+" and thetable='"+TheTable+"' order by xuhao,id";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      List_Space="";
      List_Level=int.Parse(dr["sort_level"].ToString());
      for(int i=0;i<List_Level-1;i++)
       {
        List_Space+="&nbsp;&nbsp;&nbsp;";
       }
      if(dr["final_sort"].ToString()=="1") 
       {
         Sort_List+="<option value='"+dr["id"].ToString()+"'>"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
       }
      else
       {
        Sort_List+="<optgroup Label='"+List_Space+dr["sort_name"].ToString()+"'></optgroup>\r\n";
       }
      Get_Sort(int.Parse(dr["id"].ToString()));
    }
   dr.Close();
 }

protected string GetSortName(string sortid)
 {
   string Rv="";
   string sql="select sort_name from pa_sort where id="+int.Parse(sortid);
   OleDbCommand  myComm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=myComm.ExecuteReader();
   if(dr.Read())
    {
      Rv="["+dr["sort_name"].ToString()+"]";
    }
   dr.Close();
   return Rv;
 }

protected void Bt_Click(Object sender,CommandEventArgs e)
 {
   string CName=e.CommandName;
   switch(CName)
    {
      case "Prev":
       if((int)ViewState["CurrentPage"]>0)
        {
          ViewState["CurrentPage"]=(int)ViewState["CurrentPage"]-1;
        }
      break;

     case "Next":
       if((int)ViewState["CurrentPage"]<(int)ViewState["PageCount"]-1)
        {
          ViewState["CurrentPage"]=(int)ViewState["CurrentPage"]+1;
        }
     break;
    }

  conn.Open();
   Data_Bind();
  conn.Close();

 }


protected void Page_Changed(Object sender,EventArgs e)
 {
  int CurrentPage=int.Parse(DLpage.SelectedItem.Value);
  ViewState["CurrentPage"]=CurrentPage;
  conn.Open();
   Data_Bind();
  conn.Close();
 }

protected string ZtUrl(string SiteId,string Zt_Dir,string Zt_File,string Id)
 {
  string Rv;
  if(Is_Static=="1")
     {
       Rv="/e/zt/"+Zt_Dir+"/"+Zt_File;
     }
    else
     {
       Rv="/e/zt/index.aspx?id="+Id;
     }
  return Rv;
 }


private void Get_Site(int sid)
 {
   string sql="select [directory],[domain],[html] from pa_site where id="+sid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
     Is_Static=dr["html"].ToString();
     if(TheDomain!="")
      {
        Url_Prefix=TheDomain+"/";
      }
     else
      {
       if(SiteDir=="")
        {
         Url_Prefix="/";
        }
       else
        {
         Url_Prefix="/"+SiteDir+"/";
        }
      }

    }
   else
    {
     Is_Static="0";
     Url_Prefix="/";
     dr.Close();
     conn.Close();
     Response.Write("<"+"script language=javascript>alert('无效的siteid!');location.href=location.href</"+"script>");
     Response.End();
    }
   dr.Close();
 }

protected void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
 if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 
   }
 }

protected bool Get_Bool(string str)
 {
   if(str=="1") 
    { 
      return true;
    }
   else
    {
      return false;
    }
 }

private string Sql_Format(string str)
 {
  if(str=="" || str==null)
   {
    return "";
   }
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   str=str.Replace("_","[_]");
   str=str.Replace("%","[%]");
   return str;
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

private bool IsStr(string str)
 { 
   if(str==null || str=="")
    {
     return false;
    }
  string str1="0123456789abcdefghijklmnopqrstuvwxyz_";
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
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=98% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>专题列表</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=98% >
 <tr>
<td valign=top align="left">

<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
<tr>
  <td height=25><b>当前表</b>:专题列表</td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=98%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="130px">
每页<asp:TextBox id="Tb_pagesize" size="3" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select name="siteid" id="siteid" style="display:<%=TheMaster=="admin"?"":"none"%>"  onchange="Go()"><%=Site_List%></select>
<select  name="sortid" id="sortid" onchange="Go()"><option value="">所有类别</option><%=Sort_List%><option value="0" style="color:#ff0000">未分类专题</option></select>
标题搜索：<input text="text" id="s_keyword" size="10">
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
      <tr>
        <td  align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;">
                <tr>
                  <td align=center width=75% class=white>专题</td>
                  <td align=center width=15% class=white height=20>提交时间</td>
                  <td align=center width=10% class=white height=20>发布人</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr>
                  <td align=left class="tdstyle"><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><input type="hidden" id="Title_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%>"><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a href='<%#ZtUrl(DataBinder.Eval(Container.DataItem,"site_id").ToString(),DataBinder.Eval(Container.DataItem,"zt_dir").ToString(),DataBinder.Eval(Container.DataItem,"zt_file").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString())%>' target="_blank"><%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%></a></td>
                  <td align=center class="tdstyle" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center class=tdstyle><a href='member_info.aspx?username=<%#DataBinder.Eval(Container.DataItem,"username")%>'><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
<tr>
<td colspan="3" class=tdstyle>
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  class=button runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  class=button runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed" /> 页&nbsp;

       </td>
    </tr>
   </table>

  </td>
  <tr>
 </table>
  </td>
  <tr>
 </table>
</form>
     </td>
    </tr>
 </table>
<div align="center" style="padding:10px">
<input type="button" class="button" value="确定" onclick="GetCheckItem()">&nbsp;&nbsp;
<input type="button" class="button" value="关闭" onclick="closewin()">
</div>
</center>
<script type="text/javascript">

 var obj_site=document.getElementById("siteid");
 var obj_sort=document.getElementById("sortid");
 var obj_type=document.getElementById("s_type");
 var obj_field=document.getElementById("s_field");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var Table="pa_zt";
 var name="专题列表";

 var Sitetid="<%=SiteId%>";
 var Sortid="<%=Request.QueryString["sortid"]%>";
 var Type="<%=Request.QueryString["type"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_site!=null && Sitetid!=""){obj_site.value=Sitetid;}
 if(obj_sort!=null && Sortid!=""){obj_sort.value=Sortid;}
 if(obj_type!=null){obj_type.value=Type;}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

 function T1()
  { 
   location.href="?siteid="+obj_site.value+"&pagesize="+obj_pagesize.value;
  }
 function T2()
  { 
   location.href="?siteid="+obj_site.value+"&sortid="+obj_sort.value+"&pagesize="+obj_pagesize.value;
  }

 function Go()
  { 
   location.href="?siteid="+obj_site.value+"&sortid="+obj_sort.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function Get_CheckBox(Name)
 {
   var Obj=document.getElementsByName(Name);
   var ID="0";
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].checked)
       {
         ID+=","+Obj[i].value;
       }
     }
   return ID.replace("0,","");
 }

var op_obj=parent.document.getElementById("zt_list");

function GetCheckItem()
 {
   var Ids=Get_CheckBox("CK");
   var Title;
   if(Ids!="0")
    {
      var AIds=Ids.split(',');
      for(var i=0;i<AIds.length;i++)
       {
         if(!CheckRepeat(AIds[i]))
          {
           Title=document.getElementById("Title_"+AIds[i]).value;
           parent.AddSelect(Title,AIds[i],"zt_list");
         }
       }
   }
   closewin();
 }

function CheckRepeat(id)
 {
   for(i=0;i<op_obj.length;i++)
     {
       if(op_obj[i].value==id)
        {
          return true;
        }
     }
  return false;
 }
function closewin()
 {
  parent.CloseDialog();
 }
</script>
</body>
</html>  



