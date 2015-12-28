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
  dr=dt.Rows[i]; 
%>
<%=dr["content"].ToString()%>
<%}
Prev_and_Next();
%>
<ul class="sublanmu_pn">
<li><%=_Previous==""?"":"上一问卷："+_Previous%></li>
<li><%=_Next==""?"":"下一问卷："+_Next%></li>
</ul>
<%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>