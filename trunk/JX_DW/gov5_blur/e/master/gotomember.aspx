<% @ Page Language="C#" %>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string TheTable,TheField,TheId,objid;
 protected void Page_Load(Object src,EventArgs e)
  {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
     BuildMemberCookie();
  }

 protected void BuildMemberCookie()
  {
    string UID,Valicate,LoginDate;
    if(!IsUserName(Request.QueryString["username"]))
    {
      UID=Request.Cookies["Master"].Values["UID"];
      Valicate=Request.Cookies["Master"].Values["Valicate"];
    }
   else
   {
    LoginDate="";
    UID="";
    DateTime dt;
    Conn theconn=new Conn();
    OleDbConnection conn=new OleDbConnection(theconn.Constr());
    conn.Open();
    OleDbCommand comm;
    string sql="select id,lastdate from pa_member where username='"+Request.QueryString["username"]+"'";
    comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(dr.Read())
     {  
       UID=dr["id"].ToString();
       if(dr["lastdate"].ToString()=="")
        {
          dt=DateTime.Now;
          sql="update pa_member set lastdate='"+dt+"' where id="+UID;
          comm=new OleDbCommand(sql,conn);
          comm.ExecuteNonQuery();
        }
       else
        {
          dt=(DateTime)dr["lastdate"];
        }
      LoginDate=dt.ToString("yyyyMMddHHmmss"); 
     } 
    dr.Close();
    conn.Close();
    Md5 Jm=new Md5();
    Valicate=Jm.Get_Md5(LoginDate);
   }
   if(UID!="")
   {
   HttpCookie MCookie=new HttpCookie("Member");
   MCookie.Values.Add("UID",UID);
   MCookie.Values.Add("Valicate",Valicate);
   Response.AppendCookie(MCookie);
   Response.Redirect("/e/member/index.aspx?type=mem_idx&s="+Request.Cookies["SiteId"].Value);
   Response.End();
   }
  }

private bool IsUserName(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  Regex re = new Regex(@"[\u4e00-\u9fa5]+");
  str=re.Replace(str,"");
  if(str.Length==0){return true;}
  else{return IsStr(str);}
 }
private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  str=str.ToLower();
  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
 }
</script>