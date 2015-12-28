<% @ Control language="c#" Inherits="PageAdmin.module" %>
<%if(Current_Name!=null){%><div class="current_location" id="current_location"><ul><li class="current_location_1"><%=Current_Location%></li><li class="current_location_2"><%=Current_Name%></li></ul></div><%}%>
<asp:Repeater id="List"  runat="server"  OnItemDataBound="Data_Bound">
<ItemTemplate><asp:PlaceHolder id="Holder" runat="server"/><asp:Label id="Lb_type" Text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>' runat="server" Visible="false"/><asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" Visible="false"/><asp:Label id="Lb_ModelId" Text='<%#DataBinder.Eval(Container.DataItem,"model_id")%>' runat="server" Visible="false"/>
</ItemTemplate>
</asp:Repeater>