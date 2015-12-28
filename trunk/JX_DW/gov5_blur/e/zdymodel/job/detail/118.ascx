<% @ Control language="c#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="current_location" id="current_location"><ul><li class="current_location_1"><%=Current_Location%></li><li class="current_location_2"><%=Current_Name%></li></ul></div>
<div class="sublanmu_box" id="sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><% 
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
%>
<div class="jobinfo">
<div class="item">
职位名称：<%=dr["title"]%><br>
薪资待遇：<%=dr["pa_xz"]%><br>
工作经验：<%=dr["pa_nianxian"]%><br>
学历要求：<%=dr["pa_xueli"]%><br>
招聘人数：<%=dr["pa_num"]%>名<br>
发布时间：<%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%>
</div>
  
<div class="description">
<span class="title"> 职位描述<img src="/e/css/images/job_icon.gif" border="0" hspace="5"></span>
<%=Ubb(dr["content"].ToString())%> 
</div>
  
</div>

<%
 }
%><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>