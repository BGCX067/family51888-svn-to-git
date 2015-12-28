<% @ Control language="c#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="current_location" id="current_location"><ul><li class="current_location_1"><%=Current_Location%></li><li class="current_location_2"><%=Current_Name%></li></ul></div>
<div class="sublanmu_box" id="sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><% 
int Id;
DataTable dt=Get_Data(); 
DataRow dr; 
if(dt.Rows.Count>0)
 {
  dr=dt.Rows[0]; //说明：给dr赋值
%>
<div class="bszninfo">
<span class="title"> <%=dr["title"]%></span>
<table border="0" cellpadding="0" cellspacing="0" width=100%>
<tr>
 <td width="120px">项目名称：</td><td><%=dr["title"]%></td>
</tr>
<tr>
 <td>事项依据：</td><td><%=dr["pa_bsyj"]%></td>
</tr>
<tr>
 <td>办理对象及范围：</td><td><%=dr["pa_dxfw"]%></td>
</tr>
<tr>
 <td>办理条件：</td><td><%=dr["pa_bltj"]%></td>
</tr>
<tr>
 <td>申办材料：</td><td><%=dr["pa_sbcl"]%></td>
</tr>

<tr>
 <td>办理流程：</td><td><%=dr["pa_bllc"]%></td>
</tr>

<tr>
 <td>办理时限：</td><td><%=dr["pa_blsx"]%></td>
</tr>

<tr>
 <td>费用情况：</td><td><%=dr["pa_fy"]%></td>
</tr>

<tr>
 <td>承办机构：</td><td><%=dr["pa_bljg"]%></td>
</tr>

<tr>
 <td>办理地点、邮编：</td><td><%=dr["pa_ddyb"]%></td>
</tr>

<tr>
 <td>办理时间：</td><td><%=dr["pa_blsj"]%></td>
</tr>

<tr>
 <td>联系方式：</td><td><%=dr["pa_lxfs"]%></td>
</tr>

<tr>
 <td>监督电话：</td><td><%=dr["pa_jddh"]%></td>
</tr>
<tr>
 <td>网上咨询：</td><td><%=dr["pa_wszx"]%></td>
</tr>
<tr>
 <td>网上办理</td><td><%=dr["pa_wsbl"]%></td>
</tr>

<tr>
 <td>状态查询：</td><td><%=dr["pa_ztcx"]%></td>
</tr>
<tr><td>表格下载：</td>
 <td><a name="bgxz"></a>
<%
Id=int.Parse(dr["id"].ToString());
dt=Get_File("bszn","pa_fj",Id);
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
%>
<p>
<%=i+1%>、<a  href="/e/aspx/attachment.aspx?id=<%=dr["id"]%>" target="_blank"><%=dr["title"]%></a></p>
<%
 }
%>
</td>
</tr>

</table>
</div>
<%
 }
%>
<%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>