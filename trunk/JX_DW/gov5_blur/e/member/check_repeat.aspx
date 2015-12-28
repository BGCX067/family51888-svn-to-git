<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
protected void Page_Load(Object src,EventArgs e)
{
  Check_Post();
  string Field=Request.Form["field"];
  string Field_Value=Request.Form["value"];
  string UserName=Request.Form["username"];
  if(!IsStr(Field))
  {
    return;
  }
  string Repeat="0";
  int counts=0;
  if(IsStr(Field))
    {
     Conn theconn=new Conn();
     OleDbConnection conn=new OleDbConnection(theconn.Constr());
     conn.Open();
     string sql;
     sql="select count(id) as co from pa_member where "+Field+"='"+Sql_Format(Field_Value)+"'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     if(dr.Read())
      {
        counts=int.Parse(dr["co"].ToString());
      }
     dr.Close();
     conn.Close();
     if(counts>0){Repeat="1";}
    }
  Response.Write(Repeat);
}

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
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


private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
           Response.Write("invalid submit");
           Response.End();
          }
      }
 }
</script>