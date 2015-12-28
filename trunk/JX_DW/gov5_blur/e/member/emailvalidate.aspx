<% @ Page language="c#" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.Text.RegularExpressions"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
     string Sid=Request.QueryString["s"];
     string UserName=Request.QueryString["UserName"];
     string ValicateCode=Request.QueryString["code"];
     if(IsNum(Sid) && IsUserName(UserName) && IsStr(ValicateCode))
      {
        Conn Myconn=new Conn();
        string constr=Myconn.Constr();
        conn=new OleDbConnection(constr);
        conn.Open();
        string sql="select id,m_type from pa_member where username='"+Sql_Format(UserName)+"' and valicatecode='"+ValicateCode+"'";
        OleDbCommand comm=new OleDbCommand(sql,conn);
        OleDbDataReader dr= comm.ExecuteReader();
        if(dr.Read())
        {
          Update_Data(UserName,dr["m_type"].ToString());
          dr.Close();
          conn.Close();
          Response.Write("<"+"script type='text/javascript'>alert('验证成功!');location.href='"+Get_Url("mem_login",Sid)+"'<"+"/script>");
          Response.End();
        }
       else
        {
         Response.Write("对不起，此用户可能因为超过激活期限已经被删除。");
        }
       dr.Close();
       conn.Close();
      }
    else
     {
       Response.Write("对不起，此url地址无效。");
       Response.End();
     }
  }

private void Update_Data(string UserName,string M_type)
 {
   DateTime LoginDate=DateTime.Now;
   string LastDate=LoginDate.ToString("yyyy-MM-dd HH:mm:ss");
   string Lst_Ip=Request.ServerVariables["REMOTE_ADDR"];
   string sql="update pa_member set checked=1,lastdate='"+LastDate+"',lst_ip='"+Lst_Ip+"',logins=logins+1 where username='"+UserName+"'";
   OleDbCommand Comm=new  OleDbCommand(sql,conn);
   Comm.ExecuteNonQuery();
   Md5 Jm=new Md5();
   HttpCookie MCookie=new HttpCookie("Member");
   MCookie.Values.Add("UserName",UserName);
   MCookie.Values.Add("Valicate",Jm.Get_Md5(LoginDate.ToString("yyyyMMddHHmmss")));
   MCookie.Values.Add("Type_Id",M_type);
   Response.AppendCookie(MCookie); 
 }

private string Get_Url(string Type,string Sid)
  {
    return "index.aspx?type="+Type+"&s="+Sid;
  }

private string Sql_Format(string str)
 {
    if(string.IsNullOrEmpty(str)){return "";}
    str=Server.UrlDecode(Server.UrlEncode(str).Replace("%00",""));
    str=str.Replace("'","''");
    str=str.Replace("\"","\"");
    return str;
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

