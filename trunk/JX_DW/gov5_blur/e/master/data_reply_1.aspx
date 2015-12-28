<% @ Page Language="C#" Inherits="PageAdmin.data_reply"%>
<% @ Register TagPrefix="aspcn" TagName="uc_fckeditor" src="/e/incs/fckeditor/fckeditor.ascx" %>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>信息回复</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
<form runat="server">
<td valign=top>
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
<tr>
  <td  colspan=2 height=25><b>当前位置：</b>信息回复</td>
 </tr>
</table>

<table border=0 cellpadding="0px" cellspacing="0" width=95% align=center class=tablestyle style="table-layout:fixed;">
      <tr>
         <td height=20 class=white colspan=2 class="tdstyle"><%=Fb_Sort%><%=Fb_Title%></td>
       </tr>
</table>
<table border=0 cellpadding="0px" cellspacing="0" width=95% align=center class=tablestyle style="table-layout:fixed;">
      <tr>
        <td  class="tdstyle" align=left width=100px>内容：</td>
        <td class="tdstyle" style="padding:5px 5px 5px 5px"><div style="overflow-x:auto;padding:5px 5px 5px 5px"><%=Fb_Content%><br></div>
          <div align=right>--- 发布时间：<%=Fb_Date%>&nbsp; <asp:Label id="Username" runat="server" /><asp:Label id="Lb_Email" runat="server" Visible="false"/>&nbsp; [<%=Fb_State%>]&nbsp;<asp:LinkButton runat="server" id="Lbt_Over" onCommand="Feedback_Over">[结贴]</asp:LinkButton>
     </div>
  </td>
      </tr>
</table>

<br>

<asp:Repeater id="P1" runat="server"  OnItemDataBound="P1_Bind">
     <ItemTemplate>
     <table border=0 cellpadding=0 cellspacing=0 width=95% align=center class="tablestyle" style="table-layout:fixed;">
      <tr>
        <td align=left width="100px" class="tdstyle"><a href="member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"username").ToString())%>"><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
        <td class="tdstyle">
           <div style="overflow-x:auto;padding:5px 5px 5px 5px"><%#DataBinder.Eval(Container.DataItem,"reply").ToString()%><br></div>
           <div align=right>---<%#DataBinder.Eval(Container.DataItem,"username")%>(姓名：<%#DataBinder.Eval(Container.DataItem,"truename")%> 部门：<%#DataBinder.Eval(Container.DataItem,"department")%>)回复于<%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%>&nbsp;
<asp:LinkButton runat="server"  CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' onCommand="Reply_Edit" visible='<%#Show_Edit(DataBinder.Eval(Container.DataItem,"username").ToString())%>'>[修改]</asp:LinkButton>
<asp:LinkButton runat="server"  CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' id="Delete" onCommand="Reply_Delete" visible='<%#Show_Edit(DataBinder.Eval(Container.DataItem,"username").ToString())%>'>[删除]</asp:LinkButton>
</div>
        </td>
      </tr>
     </table><br>
     </ItemTemplate>
</asp:Repeater>

<%if(Reply_State!="2"){%>
<table border=0 cellpadding=5px cellspacing=0 width=95% align=center class="tablestyle" style="table-layout:fixed;"  >
      <tr style="display:none">
        <td align=left width="100px" class="tdstyle">转办用户</td>
        <td align=left class="tdstyle" style="text-indent:0;padding:5px">
         <asp:DropDownList id="D_Department" Runat="server" DataTextField="department" DataValueField="id" AutoPostBack="True" onselectedindexchanged="Department_Change"/> &nbsp;<asp:DropDownList id="D_User" Runat="server" DataTextField="truename_username" DataValueField="username"/>
         <asp:CheckBox id="C_State" Text="是否继续处理" Runat="server"/> <asp:Button Text=" 转发 " Cssclass="button" Runat="server" onclick="Data_Tranform"/>
          <asp:Label id="Lb_err" Runat="server" ForeColor="#ff0000"/> <asp:Label id="Lb_zb" Runat="server"/>
       </td>
      </tr>
      <tr>
        <td  align=left class="tdstyle" width="100px">回复：</td>
        <td  align=left class="tdstyle" style="text-indent:0;padding:5px">
<asp:TextBox id="Reply" TextMode="MultiLine" runat="server" columns=80 rows=5/>
<aspcn:uc_fckeditor  Tb_Id="Reply" Fck_Height="200" Fck_Style="Simple" runat="server"/>
</td>
      </tr>
</table>

<table border=0 cellpadding=5 cellspacing=1 width=95% align=center>
      <tr>
        <td height=25  align=center>
           <input type="checkbox" value="1" name="sendmail" id="sendmail">同时邮件回复
           <asp:Label id="Lb_id" runat="server" Visible="false"/>
           <asp:Label id="Lb_siteid" runat="server" Visible="false"/>
          <asp:Button Text=" 修改 " Cssclass="button" Runat="server" id="Bt_Update" onclick="Data_Update" Visible="false" />
          <asp:Button Text=" 取消 " Cssclass="button" Runat="server" id="Bt_Cancel" onclick="Data_Cancel" Visible="false" />
          <asp:Button Text=" 提交 " Cssclass="button" Runat="server" id="Bt_Add"  onclick="Data_Add"    Visible="true"/>
          <input type="button"  value="返回"  class="button" onclick="location.href='letter_list.aspx'">
       </td>
     </tr>
</table>
<%}%>

</td>
</tr>
</form>
</table>
<br>
</center>
<script type="text/javascript">
SetCookie("tab","0");
</script>
</body>
</html> 