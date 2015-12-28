<% @  Control Language="c#" Inherits="PageAdmin.mem_letdtl"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：<a href="index.aspx?s=<%=Request.QueryString["s"]%>">会员中心</a> &gt; <a href="<%=Get_Url("mem_letlst")%>">信息回复</a></li>
<li class="current_location_2"><a href="<%=Get_Url("mem_letlst")%>">信息回复</a></li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
 <table border="0" cellpadding="0" cellspacing="0" align="center" class="member_table">
 <tr>
  <td class="feedback_head"><%=Fb_Type%><%=Fb_Title%></td>
 </tr>
 <tr>
   <td class="feedback_reply_item">
    <div style="overflow-x:auto;padding:5px 5px 5px 5px"><%=Fb_Content%></div>
    <div align="right">状态：<%=Fb_State%>&nbsp;  发布人：<%=Fb_UserName%>&nbsp;  发布时间：<%=Fb_Date%></div>
  </td>
 </tr>
 </table>
<br>
<asp:Repeater id="P1" runat="server">
 <ItemTemplate>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="member_table">
  <tr>
   <td class="feedback_reply_item">
<div style="overflow-x:auto;padding:5px 5px 5px 5px" id="R_<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#DataBinder.Eval(Container.DataItem,"reply")%></div>
<div align="right">---- <%#DataBinder.Eval(Container.DataItem,"username")%>(姓名：<%#DataBinder.Eval(Container.DataItem,"truename")%>&nbsp; 部门：<%#DataBinder.Eval(Container.DataItem,"department")%> )回复于<%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%>&nbsp;<a href="javascript:Edit('<%#DataBinder.Eval(Container.DataItem,"id")%>')" style="display:<%#Show_Edit(DataBinder.Eval(Container.DataItem,"username").ToString())%>">[<span style="color:#ff0000">修改</span>]</a></div>
</td>
 </tr>
 </table><br>
 </ItemTemplate>
</asp:Repeater>

<asp:PlaceHolder id="P_1" Runat="server">
<form method="post">
<table border=0 cellpadding=0 cellspacing=0 align=center class="member_table">
  <tr>
   <td width="100px" class="feedback_reply_style" align="center">回复</td>
   <td  class="feedback_reply_style_last">
<textarea  id="fb_content"  name="fb_content"  Cols="55" rows="7"  class="tb"></textarea>
<script type="text/javascript" src="/e/incs/fckeditor/fckeditor.js"></script>
<script  type="text/javascript"> 
var FCKeditor = new FCKeditor("fb_content"); 
FCKeditor.BasePath = "/e/incs/fckeditor/"; 
FCKeditor.Height = 200; 
FCKeditor.Config['LinkBrowser'] = false;
FCKeditor.Config['ImageBrowser'] =false;
FCKeditor.Config['FlashBrowser'] = false;
FCKeditor.Config['LinkUpload'] = true;
FCKeditor.Config['ImageUpload'] =true;
FCKeditor.Config['FlashUpload'] =true;
FCKeditor.ToolbarSet ="Small"; 
FCKeditor.ReplaceTextarea(); 
</script>
 </tr>
 </table>
<table border=0 cellpadding="5" cellspacing=0  align=center class="member_table_1">
   <tr>
       <td height=30px align=center>
    <input type="hidden" value="<%=Fb_Siteid%>"  name="siteid">
    <input type="hidden" value="<%=Fb_Email%>"  name="email">
    <input type="hidden" value="" name="replayid" id="replayid">
     <input type="hidden" value="add"  name="post" id="post">
    <input type="submit" value="提 交"  onclick="return Check_Reply()" class="bt">&nbsp;
    <input type="button"  class="bt" value="返回" onclick="location.href='<%=Get_Url("mem_letlst")%>'">
     </td>
     </tr> 
 </table>
 </form>
</asp:PlaceHolder>
</div>
</div>
<script type="text/javascript">
function Edit(R_id)
 {
   var REditor = FCKeditorAPI.GetInstance("fb_content");
   document.getElementById("post").value="edit";
   document.getElementById("replayid").value=R_id;
   var Rcontent=document.getElementById("R_"+R_id).innerHTML;
   REditor.SetHTML(Rcontent);
 }
</script>