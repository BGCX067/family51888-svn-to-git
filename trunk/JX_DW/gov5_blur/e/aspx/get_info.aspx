<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string Table,Id;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    string rv="";
    Table=Request.QueryString["table"];
    Id=Request.QueryString["id"];
    if(IsStr(Table) && IsNum(Id))
     {
       Conn theconn=new Conn();
       conn=new OleDbConnection(theconn.Constr());
       conn.Open();
       string sql="select site_id,clicks,comments,downloads,reserves from "+Table+" where id="+int.Parse(Id);
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       if(dr.Read()) 
       {
         rv="clicks="+dr["clicks"].ToString()+"&comments="+dr["comments"].ToString()+"&downloads="+dr["downloads"].ToString()+"&reserves="+dr["reserves"].ToString();
       }
      dr.Close();
      sql="update "+Table+" set clicks=clicks+1 where id="+int.Parse(Id);
      comm=new OleDbCommand(sql,conn);
      comm.ExecuteNonQuery();
      conn.Close();
    }
   Response.Write(rv);
   Response.End();
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
</script>