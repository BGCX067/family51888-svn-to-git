<% @ Control language="c#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="current_location" id="current_location"><ul><li class="current_location_1"><%=Current_Location%></li><li class="current_location_2"><%=Current_Name%></li></ul></div>
<div class="sublanmu_box" id="sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><% 
string video,fj;
DataTable dt=Get_Data(); 
DataRow dr; 
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; 
  video=dr["pa_video"].ToString();
  fj=dr["pa_fj"].ToString();
%>
<div class="articleinfor">
<ul>
<li class="title"><h1><%=Server.HtmlEncode(dr["title"].ToString())%>
</h1></li>
<li class="info">
日期：<%=dr["thedate"].ToString()%>&nbsp;
<%=dr["pa_autor"].ToString()==""?"":"&nbsp;作者："+dr["pa_autor"].ToString()%>
<%=dr["pa_source"].ToString()==""?"":"&nbsp;来源："+dr["pa_source"].ToString()%>
<%=dr["pa_syh"].ToString()==""?"":"&nbsp;文号："+dr["pa_syh"].ToString()%>
&nbsp;【字体：<a href="javascript:FontZoom('16px','content')">大</a> <a href="javascript:FontZoom('14px','content')">中</a>  <a href="javascript:FontZoom('12px','content')">小</a>】
</li>
</ul>
<div class="content" id="Content">
<%if(video!=""){%>
<script src="/e/js/video.js" type="text/javascript"></script>
<div style="text-align:center;padding:10px 0 10px 0">
<script type="text/javascript">
player("<%=video%>",500,400);
</script></div>
<%}%>
<%=dr["content"].ToString()%>
<%if(fj!=""){
string[] Afj=fj.Split('/');
string fj_name=Afj[Afj.Length-1];
string fj_exe=(fj_name.Split('.'))[1];
string style="padding:5px 0 0 17px;background:url(/e/images/icon/"+fj_exe+".gif) no-repeat left center;";
%>
<div style="<%=style%>"><a href="<%=fj%>"><%=fj_name%></a></div>
<%}%>
</div>
</div>
<script src="/e/js/internal_page.js" type="text/javascript"></script>

<%}
Prev_and_Next();
%>

<ul class="sublanmu_pn">
<li><%=_Previous==""?"":"上一篇："+_Previous%></li>
<li><%=_Next==""?"":"下一篇："+_Next%></li>
</ul>
<%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>