<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 int Model_id,Page;
 string TheTable,sql;
 protected void Page_Load(Object src,EventArgs e)
  {
    TheTable="";
    if(IsNum(Request.QueryString["modelid"]))
     {
       Model_id=int.Parse(Request.QueryString["modelid"]);
     }
    else
     {
      Model_id=0;
      Response.Write("alert('无效的ajax模型id')");
      Response.End();
     }
   Conn Myconn=new Conn();
   string constr=Myconn.Constr();//获取连接字符串
   OleDbConnection conn=new OleDbConnection(constr);
   conn.Open();
   sql="select thetable from pa_model where thetype='ajax' and hasfile=1 and id="+Model_id;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read()) 
    {
     TheTable=dr["thetable"].ToString();
    }
   dr.Close();
   conn.Close();
   if(TheTable=="")
   {
     Response.Write("alert('modelid无效或者模型文件不存在!')");
     Response.End();
   }
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
document.write('<div id="ajax_<%=Model_id%>" style="background-image:url(/e/images/public/loading.gif);background-repeat:no-repeat;background-position:center center"></div>');
var ajax_<%=Model_id%>=document.getElementById("ajax_<%=Model_id%>");
function rajax_<%=Model_id%>(Page) //读取ajax列表
 {
   ajax_<%=Model_id%>.style.backgroundImage="url('/e/images/public/loading.gif')";
   var x=new PAAjax();
   x.setarg("get",true);
   x.send("/e/zdymodel/<%=TheTable%>/ajax/<%=Model_id%>.aspx","modelid=<%=Model_id%>&table=<%=TheTable%>&page="+Page+"&"+ajaxparameter_<%=Model_id%>,function(v){wajax_<%=Model_id%>(v)});
 }
function wajax_<%=Model_id%>(V) //写入ajax内容
 {
   ajax_<%=Model_id%>.style.backgroundImage="none";
   ajax_<%=Model_id%>.innerHTML=V;
    if(typeof(ajax_<%=Model_id%>_fun)=="function")
    {
     ajax_<%=Model_id%>_fun(V);
    }
 }