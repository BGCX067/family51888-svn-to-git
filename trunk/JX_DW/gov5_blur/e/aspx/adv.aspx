<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
 string Id,Adv_Type,Adv_range,Adv_canshu,Adv_content,Left_content,Right_content;
 int Ad1,Ad2,Ad3,Ad4;
 OleDbConnection conn;
 protected void Page_Load(Object sender,EventArgs e)
   {
     Conn Myconn=new Conn();
     string constr=Myconn.Constr();//获取连接字符串
     conn=new OleDbConnection(constr);
     conn.Open();
      Get_Value();
     conn.Close();
   }
private void Get_Value()
 {
  if(!IsNum(Request.QueryString["id"]))
   {
     return;
   }
  Id=Request.QueryString["id"];
  string sql="select * from pa_adv where id="+Id;
  OleDbCommand Comm=new  OleDbCommand(sql,conn);
  OleDbDataReader dr=Comm.ExecuteReader();
  if(dr.Read())
   {
     Adv_Type=dr["adv_type"].ToString();
     Adv_range=dr["adv_range"].ToString();
     Adv_content=dr["content"].ToString().Replace("\"","\\\"").Replace("\r\n","<br>");
     switch(Adv_Type)
      {
        case "1":
         if(Adv_range!="0")
          {
           Ad1=1;
          }
        break;
        case "2":
         if(Adv_range!="0")
          {
           Ad2=1;
          }
        break;
        case "3":
         if(Adv_range!="0")
          {
           Ad3=1;
          }
        break;

        case "4":
         if(Adv_range!="0")
          {
           Ad4=1;
           Adv_content=dr["content"].ToString();
          }
        break;
      }
     Adv_canshu=dr["window_canshu"].ToString();
     Left_content=dr["left_content"].ToString().Replace("\"","\\\"").Replace("\r\n","<br>");
     Right_content=dr["right_content"].ToString().Replace("\"","\\\"").Replace("\r\n","<br>");
   }
  dr.Close();
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
var Url=location.href;<%if(Ad1==1){%>
var Adv_range="<%=Adv_range%>";
function newwindow_<%=Id%>()
 {
  window.open("/e/aspx/adv_new.aspx?id=<%=Id%>","newwindow<%=Id%>","<%=Adv_canshu%>");
 }
if(Url.indexOf("/e/")<0) 
  {
    if(Adv_range=="2"){newwindow_<%=Id%>();}
    else
     {
      if(IsPageHome=="1"){newwindow_<%=Id%>();}
     }
 }
<%}%>
<%if(Ad2==1){%>
document.write("<div id='floatadv_<%=Id%>' style='display:none;position:absolute;left:0px; top:0px;z-index:100'><%=Adv_content%></div>");
var Adv_Range="<%=Adv_range%>";
var floatadv_<%=Id%>=document.getElementById("floatadv_<%=Id%>");
var floatdelay =20; //控制每次执行间隔的时间，做越大移动得越慢；
var floatspeed =1; //控制每次执行移动的距离，值越大移动得越快；
var floatflagX =0;
var floatflagY =0;
function toPixel<%=Id%>(str1) 
{
 var oldLen = str1.length;
 var newLen = oldLen - 2;
 str2 = str1.slice(0, newLen);
 str3 = parseInt(str2);
 return str3;
}
function flowAdv<%=Id%>(){
var bWidth = document.body.clientWidth;
var bHeight = document.body.clientHeight;
var bLeft = document.body.scrollLeft;
var bTop = document.body.scrollTop;
var iWidth = floatadv_<%=Id%>.offsetWidth;
var iHeight = floatadv_<%=Id%>.offsetHeight;
var iLeft = toPixel<%=Id%>(floatadv_<%=Id%>.style.left);
var iTop = toPixel<%=Id%>(floatadv_<%=Id%>.style.top);
if(iLeft < (bWidth - iWidth) && floatflagX == 0) {
floatadv_<%=Id%>.style.left = (iLeft + floatspeed) + "px";
}
else if(iLeft >= (bWidth - iWidth) && floatflagX ==0) {
floatflagX = 1;
}
else if(iLeft > 0 && floatflagX == 1) {
floatadv_<%=Id%>.style.left = (iLeft - floatspeed) + "px";
}
else if(0 >= iLeft && floatflagX == 1) {
floatflagX = 0;
}
if(iTop < (bHeight - iHeight) && floatflagY == 0) {
floatadv_<%=Id%>.style.top = (iTop + floatspeed) + "px";
}
else if(iTop >= (bHeight - iHeight) && floatflagY ==0) {
floatflagY = 1;
}
else if(iTop > 0 && floatflagY == 1) {
floatadv_<%=Id%>.style.top = (iTop - floatspeed) + "px";
}
else if(0 >= iTop && floatflagY == 1) {
floatflagY = 0;
}
}
function startflowAdv<%=Id%>()
{
floatadv_<%=Id%>.style.display="block";
var floatinterval<%=Id%> = setInterval("flowAdv<%=Id%>()", floatdelay);
floatadv_<%=Id%>.onmouseover = function() {clearInterval(floatinterval<%=Id%>);}
floatadv_<%=Id%>.onmouseout = function() {floatinterval<%=Id%> = setInterval("flowAdv<%=Id%>()", floatdelay);}
}
if(Url.indexOf("/e/")<0)
{
 if(Adv_Range=="2"){startflowAdv<%=Id%>();}
else
 {
  if(IsPageHome=="1"){startflowAdv<%=Id%>();}
 }
}
<%}%>
<%if(Ad3==1){%>
var Adv_range="<%=Adv_range%>";
lastScrollY=0;
function DlAdv_<%=Id%>(){ 
var diffY;
if (document.documentElement && document.documentElement.scrollTop)
    diffY = document.documentElement.scrollTop;
else if (document.body)
    diffY = document.body.scrollTop
else
    {/*Netscape stuff*/}
percent=.1*(diffY-lastScrollY); 
if(percent>0)percent=Math.ceil(percent); 
else percent=Math.floor(percent); 
document.getElementById("LeftAdv_<%=Id%>").style.top=parseInt(document.getElementById("LeftAdv_<%=Id%>").style.top)+percent+"px";
document.getElementById("RightAdv_<%=Id%>").style.top=parseInt(document.getElementById("LeftAdv_<%=Id%>").style.top)+percent+"px";
lastScrollY=lastScrollY+percent; 
}
var LeftAdv="<div id=\"LeftAdv_<%=Id%>\" style='left:5px;position:absolute;TOP:120px;'><%=Left_content%></div>"
var RightAdv="<div id=\"RightAdv_<%=Id%>\" style='right:5px;position:absolute;TOP:120px;'><%=Right_content%></div>"
if(Url.indexOf("/e/")<0)
  {
    if(Adv_range=="2")
     {
       document.write(LeftAdv); 
       document.write(RightAdv); 
      window.setInterval("DlAdv_<%=Id%>()",10);
     }
    else
     {
       if(IsPageHome=="1")
        {
         document.write(LeftAdv); 
         document.write(RightAdv); 
         window.setInterval("DlAdv_<%=Id%>()",10);
        }
     }
 }
<%}%>
<%
if(Ad4==1)
{
 Response.Write(Adv_content);
}
%>