<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
 string LinkHtml,Id,sql,Name,Target;
 OleDbConnection conn;
 protected void Page_Load(Object sender,EventArgs e)
   {
     Conn Myconn=new Conn();
     string constr=Myconn.Constr();//获取连接字符串
     conn=new OleDbConnection(constr);
     conn.Open();
       Link_Bind();
     conn.Close();
   }

private void Link_Bind()
   {
    if(IsNum(Request.QueryString["id"]))
     {
      Id=Request.QueryString["id"];
      Target=Request.QueryString["target"];
      Name=Request.QueryString["name"];
      sql="select * from pa_link_item where link_id="+int.Parse(Id)+" order by xuhao";
      switch(Request.QueryString["thetype"])
        { 
         case "image":
          Show_Style3(sql);
         break;

         case "text":
          Show_Style2(sql);
         break;

         default:
          Show_Style1(sql);
         break;
        }
    }
   }

private void Show_Style1(string sql)
  {
     LinkHtml="<select onChange=Link_Open(this.options[this.selectedIndex].value,'"+Target+"')>";
     LinkHtml+="<option value=''>"+Name+"</option>";
     OleDbCommand Comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=Comm.ExecuteReader();
     while(dr.Read())
      {
        LinkHtml+="<option value='"+dr["url"].ToString()+"'>"+ubb(dr["title"].ToString())+"</option>";
      }
     dr.Close();
     LinkHtml+="</select>";
 }

private void Show_Style2(string sql)
  {
     LinkHtml="<ul>";
     OleDbCommand Comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=Comm.ExecuteReader();
     while(dr.Read())
      {
        LinkHtml+="<li><a href=javascript:Link_Open('"+dr["url"].ToString()+"','"+Target+"')>"+dr["title"].ToString()+"</a></li>";
      }
     dr.Close();
     LinkHtml+="</ul>";
  }

private void Show_Style3(string sql)
  {
    LinkHtml="<ul>";
     OleDbCommand Comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=Comm.ExecuteReader();
     while(dr.Read())
      {
        LinkHtml+="<li><a href=javascript:Link_Open('"+dr["url"].ToString()+"','"+Target+"')><img src='"+dr["image"].ToString()+"' border='0'/></a></li>";
      }
     dr.Close();
     LinkHtml+="</ul>";
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
private string ubb(string str)
   {
   if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("\"","\'");
   return str;
   }
</script>
document.write("<%=LinkHtml%>");