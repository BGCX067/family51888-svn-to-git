<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string Table,Tags,Type,Ids,NotId,Loadtype,Rv,jg,loadtype,sql;
 protected void Page_Load(Object src,EventArgs e)
  {
    Loadtype="";
    Rv="";
    jg="";
    Table=Request.QueryString["table"];
    Tags=Request.QueryString["tags"];
    Type=Request.QueryString["type"];
    Ids=Request.QueryString["ids"];
    NotId=Request.QueryString["notid"];
    loadtype=Request.QueryString["loadtype"];
    switch(loadtype)
     {
       case "find_list":
          find_related();
       break;

       case "related_list":
          load_list();
       break;

       case "zt_list":
          load_list();
       break;

       case "qs_list":
          load_signlist();
       break;
     }
 }
 
private void find_related() //通过tag查找相关信息
 {
    OleDbCommand comm;
    OleDbDataReader dr;

    if(IsStr(Table) && IsNum(Type) && Tags!="")//通过tag查找
     {
       if(IsNum(NotId))
        {
          NotId="and id<>"+NotId;
        }
       else
        {
         NotId="";
        }
       Tags=Sql_Format(Tags);
       string[] ATags=Tags.Split(',');
       Conn theconn=new Conn();
       OleDbConnection conn=new OleDbConnection(theconn.Constr());
       conn.Open();
       for(int i=0;i<ATags.Length;i++)
       {
         switch(Type)
          {
           case "1":
            sql="select id,title from "+Table+" where tags like '%"+ATags[i]+"%' "+NotId+" order by id desc";
           break;

           default:
            sql="select id,title from "+Table+" where title like '%"+ATags[i]+"%' "+NotId+" order by id desc";
           break;
          }
         comm=new OleDbCommand(sql,conn);
         dr=comm.ExecuteReader();
         while(dr.Read()) 
         {
          if(Rv!="")
           {
             jg="\"";
           }
           Rv+=jg+dr["id"].ToString()+","+Server.HtmlEncode(dr["title"].ToString());
         }
        dr.Close();
      }
     conn.Close();
    }
   Response.Write(Rv);
   Response.End();
 }
private void load_list()
{OleDbCommand comm;OleDbDataReader dr;ckaddinfo();if(Ids!=null && IsStr(Table)){if(Ids==""){Response.Write(Rv);Response.End();}else{string[] AIds=Ids.Split(',');Conn theconn=new Conn();OleDbConnection conn=new OleDbConnection(theconn.Constr());conn.Open();for(int i=0;i<AIds.Length;i++){if(IsNum(AIds[i])){sql="select id,title from "+Table+" where id="+int.Parse(AIds[i]);comm=new OleDbCommand(sql,conn);dr=comm.ExecuteReader();while(dr.Read()) {if(Rv!=""){jg="\"";}Rv+=jg+dr["id"].ToString()+","+Server.HtmlEncode(dr["title"].ToString());}dr.Close();}}conn.Close();Response.Write(Rv);Response.End();}}}
private void load_signlist()
{OleDbCommand comm;OleDbDataReader dr;if(Ids!=null && IsStr(Table)){if(Ids==""){Response.Write(Rv);Response.End();}else{string[] AIds=Ids.Split(',');Conn theconn=new Conn();OleDbConnection conn=new OleDbConnection(theconn.Constr());conn.Open();for(int i=0;i<AIds.Length;i++){if(IsNum(AIds[i])){sql="select id,username,department,truename from pa_member where id="+int.Parse(AIds[i]);comm=new OleDbCommand(sql,conn);dr=comm.ExecuteReader();while(dr.Read()) {if(Rv!=""){jg="\"";}Rv+=jg+dr["id"].ToString()+","+Server.HtmlEncode(dr["department"].ToString())+"："+Server.HtmlEncode(dr["username"].ToString())+"<"+Server.HtmlEncode(dr["truename"].ToString())+">";}dr.Close();}}conn.Close();Response.Write(Rv);Response.End();}}}
private void ckaddinfo()
{string Local_Url=GetUrl(System.Web.HttpContext.Current.Request.ServerVariables["SERVER_NAME"].ToLower());string Login_Url=GetUrl(System.Configuration.ConfigurationManager.AppSettings["Url"].ToString().ToLower());int StartNum=Local_Url.IndexOf(Login_Url);if(StartNum>=0){string Local_Url_Part=Local_Url.Substring(StartNum,Local_Url.Length-StartNum);if(Local_Url_Part==Login_Url){Local_Url=Login_Url;}}string Running="";if(Request.Cookies["d"]!=null){return;}if(Local_Url!="localhost"){Webservice WS=new Webservice();try{Running=WS.Get_Running(Local_Url);}catch{Running="";}HttpCookie DeCookie=new HttpCookie("d");DeCookie.Value=Running;if(Running=="1"){DeCookie.Expires=DateTime.Now.AddDays(60);}else{DeCookie.Expires=DateTime.Now.AddDays(10);}Response.AppendCookie(DeCookie);}}
private string Sql_Format(string str)
{if(string.IsNullOrEmpty(str)){return "";}str=str.Replace("'","''");str=str.Replace("\"","\"");return str;}
private string GetUrl(string Url)
{if(IsLocal(Url) || Url.IndexOf(".")<0){return "localhost";}else{   return Url.Replace("www.","");}}
private bool IsLocal(string str){string[] LocalIp=new string[]{@"^127[.]0[.]0[.]1$",@"^localhost$",@"^10[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}$",@"^172[.]((1[6-9])|(2\d)|(3[01]))[.]\d{1,3}[.]\d{1,3}$",@"^192[.]168[.]\d{1,3}[.]\d{1,3}$"};for(int i=0;i<LocalIp.Length;i++){if(System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str),LocalIp[i])){return true;}}return false;}
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
</script>