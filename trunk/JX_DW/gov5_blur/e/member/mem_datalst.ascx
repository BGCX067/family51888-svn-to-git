<% @ Control Language="c#" Inherits="PageAdmin.mem_datalst"%>
<div class="current_location">
<ul><li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; <%=TableName%><%=IsMultiSite=="0"?"":"("+SiteName+")"%></li>
<li class="current_location_2"><%=TableName%></li></ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<form runat="server">
<table border=0 cellpadding=0 cellspacing=0 width=100%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="85%">
<select  name="sortid" id="sortid" onchange="Go()"><option value="">所有类别</option><%=Sort_List%></select>
&nbsp;<select id="s_type" onchange="Go()">
<option value="">任何属性</option>
<option value="unchecked">未审核</option>
<option value="cg">草稿</option>
</select>
<select id="s_order" onchange="Go()">
<option value="">默认排序</option>
<option value="thedate desc">按发布时间↓</option>
<option value="thedate asc">按发布时间↑</option>
<option value="clicks desc">按点击次数↓</option>
<!--<option value="comments desc">按评论次数↓</option>
<option value="downloads desc">按下载次数↓</option>-->
</select> <input text="text" id="s_keyword" size="10"> <input type="button" value="搜索" class="button" onclick="Go()">
</td>
<asp:PlaceHolder id="P_Add" runat="server" Visible="false">
<td align="right"><input type="button" class='m_bt' value=" 我要发布 " onclick="location.href='<%=Get_Url("mem_datadtl",Request.QueryString["tid"])%>'"></td>
</asp:PlaceHolder>
 </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=100% class="class="member_table">
         <tr>
           <td width=55% align=center class="memlist_header_item"><%=TitleName%></td>
           <td width=15% align=center class="memlist_header_item">提交时间</td>
           <td width=5% align=center class="memlist_header_item">点击</td>
           <td width=10% align=center class="memlist_header_item">状态</td>
           <td width=15% align=center class="memlist_header_item_last">管理</td>
         </tr>
      <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr>
                  <td align=left class="memlist_item"><asp:Literal id="L_sortname" runat="server"/><a href='<%#DetailUrl(DataBinder.Eval(Container.DataItem,"static_dir").ToString(),DataBinder.Eval(Container.DataItem,"static_file").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"subLanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"checked").ToString(),DataBinder.Eval(Container.DataItem,"html").ToString())%>' target="dataview" title="<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%>"><%#SubStr(DataBinder.Eval(Container.DataItem,"title").ToString(),50,true)%></a><img src=images/image.gif height=20px align=absmiddle title="带标题图片" style="display:<%#(DataBinder.Eval(Container.DataItem,"titlepic").ToString())==""?"none":""%>"><asp:Label ForeColor="#ff0000" text="[顶]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"istop").ToString())%>' runat="server" Title='<%#"置顶结束日期："+(DataBinder.Eval(Container.DataItem,"actdate")).ToString()%>'/><asp:Label ForeColor="#ff0000" text="[荐]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"isgood").ToString())%>' runat="server"/><asp:Label ForeColor="#ff0000" text="[新]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"isnew").ToString())%>' runat="server"/><asp:Label ForeColor="#ff0000" text="[热]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"ishot").ToString())%>' runat="server"/></td>
                  <td align=center  class="memlist_item" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center  class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"clicks")%></td>
                  <td align=center  class="memlist_item"><a href=# onclick="return state('<%=TheTable%>','<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"work_id")%>')"><%#GetState(DataBinder.Eval(Container.DataItem,"iscg").ToString(),DataBinder.Eval(Container.DataItem,"checked").ToString(),DataBinder.Eval(Container.DataItem,"work_id").ToString(),DataBinder.Eval(Container.DataItem,"work_state").ToString())%></a></td>
                  <td align=left  class="memlist_item_last">&nbsp;
                    <asp:Label id="Lb_id" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Visible="false"/><asp:Label id="Lb_checked" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"checked")%>' Visible="false"/><asp:Label id="Lb_sortid" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"sort_id")%>' Visible="false"/>
                    <asp:HyperLink Id="TopAct" runat="server" Text="置顶"  cscclass="actlbt" NavigateUrl="#"/><asp:Label id="Lb_istop" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"istop")%>' Visible="false"/>
                    <asp:HyperLink Text="编辑" id="Edit" runat="server" NavigateUrl='<%#Get_Url("mem_datadtl",Request.QueryString["tid"],DataBinder.Eval(Container.DataItem,"id").ToString())%>' />
                    <asp:LinkButton Id="Delete" runat="server" Text="删除" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="BT_Delete" />
                  </td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
 </table>
<div class="sublanmu_page">
<span>共<asp:Literal id="Lblrecordcount"  Text=0 runat="server" />条记录</span>
<span>页次：<asp:Literal id="Lblcurrentpage"  runat="server" />/<asp:Literal id="LblpageCount"  runat="server" /></span>
         <asp:LinkButton id="First" CssClass="link" CommandName="First"  OnCommand="Page_change"  runat="server" Text="首页"/>
         <asp:LinkButton id="Prev"  CssClass="link"  CommandName="Prev"  OnCommand="Page_change"  runat="server" Text="上一页"/>
         <asp:LinkButton id="Next"  CssClass="link"  CommandName="Next"  OnCommand="Page_change"  runat="server" Text="下一页"/>
         <asp:LinkButton id="Last"  CssClass="link"  CommandName="Last"  OnCommand="Page_change"  runat="server" Text="尾页"/>
转到：<asp:DropDownList id="Dp_page" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_select">
          </asp:DropDownList>页
</div>

</form>
<script type="text/javascript">
 var obj_sort=document.getElementById("sortid");
 var obj_type=document.getElementById("s_type");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");

 var Sid="<%=Request.QueryString["s"]%>";
 var Tid="<%=Request.QueryString["tid"]%>";

 var Sortid="<%=Request.QueryString["sortid"]%>";
 var SType="<%=Request.QueryString["stype"]%>";

 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_sort!=null && Sortid!="0"){obj_sort.value=Sortid;}
 if(obj_type!=null){obj_type.value=SType;}

 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

 function Go()
  { 
   location.href="?s="+Sid+"&type=mem_datalst&tid="+Tid+"<%=Request.QueryString["siteid"]!=null?"&siteid="+Request.QueryString["siteid"]:""%>&sortid="+obj_sort.value+"&stype="+obj_type.value+"&order="+obj_order.value+"&keyword="+escape(obj_keyword.value);
  }

 function state(Table,Id,Wid)
  {
   if(Wid=="0"){return false;}
   IDialog("操作记录","/e/member/state.aspx?s="+Sid+"&table="+Table+"&id="+Id+"&workid="+Wid+"&viewstate=1",800,300);
   return false;
  } 
</script>
</div>
</div>