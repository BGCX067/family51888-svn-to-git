<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string UID;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    Check_Post();
    UID=Request.Form["uid"];
    if(IsNum(UID))
     {
       Conn theconn=new Conn();
       conn=new OleDbConnection(theconn.Constr());
       conn.Open();
         string sql="update pa_member set space_clicks=space_clicks+1 where id="+UID;
         OleDbCommand comm=new OleDbCommand(sql,conn);
         comm.ExecuteNonQuery();
       conn.Close();
    }
   Response.End();
  }

private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
            Response.Write("invalid_submit");
            Response.End();
          }
      }
 }

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="1234567890";
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