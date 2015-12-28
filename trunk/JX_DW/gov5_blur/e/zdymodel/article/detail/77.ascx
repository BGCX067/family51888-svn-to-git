<% @ Control language="c#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="current_location" id="current_location"><ul><li class="current_location_1"><%=Current_Location%></li><li class="current_location_2"><%=Current_Name%></li></ul></div>
<div class="sublanmu_box" id="sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><% 
DataTable dt=Get_Data(); 
DataRow dr=dt.Rows[0];
%>
<div class="article_pic_infor">
 <ul>
  <li class="left"><img vspace="5" src="<%=dr["titlepic"].ToString()==""?"/e/images/public/noimage.gif":dr["titlepic"].ToString()%>" border=0 width=120px><br><%=dr["title"]%>
  </li>
 <li class="right">
   <span class="title">个人简介</span>
   <span class="introduct"><%=dr["pa_introduct"]%></span>
</li>
 <li class="clear"></li>
 <li><span class="title">详细介绍</span></li>
 <li class="content"><%=dr["content"]%></li>
 </ul>
</div>



<%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>