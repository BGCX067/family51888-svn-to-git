<% @ Control language="c#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="current_location" id="current_location"><ul><li class="current_location_1"><%=Current_Location%></li><li class="current_location_2"><%=Current_Name%></li></ul></div>
<div class="sublanmu_box" id="sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><% 
DataTable dt=Get_Data(); 
DataRow dr; 
if(dt.Rows.Count>0)
{
dr=dt.Rows[0]; //说明：给dr赋值
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="letterinfo">
    <tr class="head">
      <td colspan="2" align="center"><b>信件处理结果</b></td>
    </tr>
    <tr>
      <td align="right" width="100px">信件编号：</td>
      <td><%=dr["code"]%></td>
    </tr>
    <tr>
      <td align="right">信件类型：</td>
      <td><%=Sort_Name(int.Parse(dr["sort_id"].ToString()))%></td>
    </tr>
    <tr>
      <td align="right">来信时间：</td>
      <td><%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%></td>
    </tr>
    <tr>
      <td align="right">信件主题：</td>
      <td><%=Server.HtmlEncode(dr["title"].ToString())%></td>
    </tr>

    <tr>
      <td align="right">信件内容：</td>
      <td><%=dr["content"]%></td>
    </tr>

<%if(dr["reply_state"].ToString()=="0"){%>
    <tr>
      <td align="right">处理进度：</td>
      <td>待处理</td>
    </tr>
<%
}
else
{
dt=Get_Data("select * from pa_reply where thetable='letter' and detail_id="+dr["id"].ToString()+" order by thedate desc");  
for(int i=0;i<dt.Rows.Count;i++)
 {
   dr=dt.Rows[i]; //说明：给dr赋值
 
%>
    <tr>
      <td align="right">回复内容：</td>
      <td ><div><%=dr["reply"]%></div><div align="left" style="color:#666666">回复时间：<%=dr["thedate"]%> </div></td>
    </tr>

<%
}
}
%>
<tr>
<td colspan="2" align="center"><a href="javascript:history.back()">返回上一页</a></td>
</tr>

</table>
<%
 }
%><%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>