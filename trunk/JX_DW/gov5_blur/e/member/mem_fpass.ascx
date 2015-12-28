<% @  Control Language="c#" Inherits="PageAdmin.mem_fpass"%>
<div class="current_location">
<ul><li class="current_location_1">当前位置：会员中心 &gt; 找回密码</li>
<li class="current_location_2">会员登陆</li></ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<asp:PlaceHolder id="P1" runat="server" >
<div class="findpass_box">
<form method="post" name="pa_member">
<li class="findpass_item_1">用户名： </li>
<li class="findpass_item_2">&nbsp;<input  type="text" size="20" maxlength="16" class="m_tb" name="username"   id="username"  />
</li>

<li class="findpass_item_jiange"></li>

<li class="findpass_item_1">注册邮箱： </li>
<li class="findpass_item_2">&nbsp;<input  type="text" size="20" maxlength="45" class="m_tb" name="email" id="email" /> 请填注册时所填的邮箱
</li>

<li class="findpass_item_jiange"></li>
<li class="findpass_item_jiange"></li>
<li class="findpass_submit_box"><input type="hidden" name="submit"  value="yes"><input type="submit"  value="找回密码"  onclick="return Find_Pass()" ></li>
<li class="findpass_tishi_box">忘记邮箱或用户名请联系管理员</li>
 <li class="clear"></li>
</ul>
</form>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder id="P2" runat="server"  visible="false">
<div align=center>
<img src="/e/images/public/suc.gif" space="5"><br>
对不起，用户名或邮箱填写错误。
<div style="padding-top:10px"><input type="button" class="m_bt" value=" 返 回 "  onclick="location.href=location.href"></div>
<br><br>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder id="P3" runat="server"  visible="false">
<div align=center>
<img src=/e/images/public/suc.gif width="167px" vspace="5">
<br>您的密码已经发送到您的注册邮箱(<%=SendResult=="1"?"邮件发送成功":"邮件发送失败"%>)!
<div style="padding-top:10px"><input type="button" class="m_bt" value=" 转到登录页面 "  onclick="location.href='<%=GetUrl("login")%>'"></div>
<br><br>
</div>
</asp:PlaceHolder>
</div>
</div>