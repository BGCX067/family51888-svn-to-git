<% @ Page Language="C#" Inherits="PageAdmin.department_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_department" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>部门管理</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server">

<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
     <table border=0 cellpadding=0 cellspacing=0 width=95%  class=tablestyle align=center id="tb_list">
       <tr>
          <td height=25 align=center width=10%  class=white>ID</td>
           <td height=25 align=center width=30%  class=white>部门名称</td>
           <td height=25 align=center width=30%  class=white>备注</td>
           <td height=25 align=center width=10%  class=white>序号</td>
           <td height=25 align=center width=20%  class=white>操作</td>
        </tr>
       <asp:Repeater id="List1" runat="server" OnItemDataBound="Data_Bound">  
            <ItemTemplate>
                <tr class="listitem">
                  <td height=25 align=center class="tdstyle"><input type="text" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" size="4"/></td>
                  <td height=25 align=center class="tdstyle"><asp:TextBox id="Tb_department" Text='<%#DataBinder.Eval(Container.DataItem,"department")%>' Runat="server" size="20" maxlength="50" /></td>
                  <td height=25 align=center class="tdstyle"><asp:TextBox id="Tb_beizhu" Text='<%#DataBinder.Eval(Container.DataItem,"beizhu")%>' Runat="server" size="25" maxlength="100" /></td>
                  <td height=25 align=center class="tdstyle"><asp:TextBox id="Tb_xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' Runat="server" size="3" maxlength="5"/></td>
                  <td height=25 align=center class="tdstyle">
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Runat="server" Visible="false" />
                   <asp:Label id="Lb_siteid" Text='<%#DataBinder.Eval(Container.DataItem,"site_id")%>' Runat="server" Visible="false" />
                   <asp:LinkButton id="Delete" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' CommandArgument='<%#DataBinder.Eval(Container.DataItem,"department")%>' OnCommand="Data_Delete" runat="server" Text="删除"  />
                  </td>
                </tr>
            </ItemTemplate>
       </asp:Repeater>
    </table>
<br>
<div align=center><asp:Button  runat="server" Text="修改"  CssClass="button" OnClick="Data_Update" />
  </td>
  <tr>
 </table>

<br>

<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr>
    <td height=25><b>增加部门</b></td>
   </tr>
    </table>
    <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
    <tr>
    <td height=25>
   名称：<asp:TextBox  id="Add_Name" maxlength="50" size="20"  runat="server" />
   备注：<asp:TextBox  id="Add_Beizhu"  maxlength="50" size="20" runat="server" />
   序号：<asp:TextBox  id="Add_Xuhao" Text="1"  maxlength="5" size="3"  runat="server" />
   <asp:button  CssClass="button" Text="增加"  runat="server" OnClick="Data_Add" />
    </td>
   </tr>
    </table>
  </td>
  <tr>
 </table>

<br>
<asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
MouseoverColor("tb_list");
</script>
</body>
</html>