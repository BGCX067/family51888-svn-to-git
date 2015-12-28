<% @  Control Language="c#" Inherits="PageAdmin.reg"%>
<div class="current_location">
<ul>
<li class="current_location_1">当前位置：会员中心 &gt; 会员注册</li>
<li class="current_location_2">会员注册</li>
</ul>
</div>
<div class="sublanmu_box">
<div class="sublanmu_content">
<asp:PlaceHolder id="P1" runat="server">
<div class="reg_box">
<form method="post" name="pa_member">
<script src="/e/js/zdyform.js" type="text/javascript"></script>
<table border="0" cellpadding="4" cellspacing=0  align=center width="95%">
<tr>
 <td align=right class="tdhead"><b>温馨提示：</b></td><td>为了更好的为您服务，请您详细填写以下注册信息。</td> 
</tr>
</table>
<table border="0" cellpadding=4 cellspacing=0  align=center width="95%">
<tr style="display:<%=RegTypeCount<2?"none":""%>">
 <td align=right class="tdhead">注册类型<span style="color:#ff0000">*</span></td>
 <td><%
string[] Amtypes=Amtype.Split(',');
string[] Amids=Amid.Split(',');
for(int i=0;i<RegTypeCount;i++)
 {
%><input type="radio" name="Reg_type" id="Reg_type" value="<%=Amids[i]%>" <%=i==0?"checked":""%>><%=Amtypes[i]%> &nbsp; 
<%}%></td>
</tr>

<tr>
 <td align=right>用户名<span style="color:#ff0000">*</span></td> 
 <td><input type="text" maxlength="16" name="username" id="username" class="m_tb" style="width:180px" onblur="check_repeat(this.value,'username')"> <span id="s_username">只能由字母、数字、下划线组成(4-16位)</span></td>
</tr

<tr>
 <td align=right>密 码<span style="color:#ff0000">*</span></td>
 <td><input type="password"  maxlength="16" name="password" id="password" class="m_tb" style="width:180px"> 只能由字母、数字、下划线组成(4-16位) </td>
</tr>

<tr>
 <td align=right>密码确认<span style="color:#ff0000">*</span></td>
 <td><input type="password"  maxlength="16" name="password1" id="password1" class="m_tb" style="width:180px"> 密码再次确认 </td>
</tr>
<asp:PlaceHolder id="P_Form" Runat="server"/>

<tr>
 <td align=right>验证码<span style="color:#ff0000">*</span></td>
 <td><input type='textbox' name='vcode' maxlength='4' style="width:80px" class="m_tb" onkeyup="if(isNaN(value))execCommand('undo')">&nbsp;<img src='/e/aspx/yzm.aspx' onclick='Code_Change("regcode")' align=absmiddle border=0 id='regcode' style='cursor:pointer;width:50px;height:18px'  alt='点击更换'></td>
</tr>
<tr><td colspan="2" align="center"><input id="bt_post" type="button"  value=" 同意会员注册协议，注册成为会员 " onclick="return Check_Reg('<%=security_code%>')" <%=RegTypeCount==0?"disabled":""%>><td></tr>
<tr style="display:<%=Agreement.Trim()==""?"none":""%>"><td colspan="2" align="center"><TextArea  Cols="60" rows="5"><%=Agreement%></textArea><td></tr>
</table>
<input name="post" type="hidden" value="add">
<span id="reservearea"></span>
</form>
</div>
</asp:PlaceHolder>

<asp:PlaceHolder id="P2" runat="server" visible="false">
<div align=center>
<img src=/e/images/public/suc.gif width="167px" vspace="5">
<br><%=Member_Check==0?"恭喜您，会员注册成功!":""%><%=Member_Check==2?"会员注册资料提交成功，请等待管理员审核!":""%>
<%=SendMailResult=="1"?"<br>用户名和密码已经发往您的注册邮箱。":""%>
<div style="padding-top:10px"><input type="button" class="m_bt" value=" 转到登录页面 " onclick="location.href='<%=GetUrl("login")%>'"></div>
</div>
</asp:PlaceHolder>

<asp:PlaceHolder id="P_act" runat="server" visible="false"><form runat="server">
<div align=center style="line-height:25px">
<img src=/e/images/public/suc.gif width="167px" vspace="5">
<br>
<asp:label id="lb_emailtishi"  runat="server" text="注册成功，请到您的注册邮箱中查收验证邮件，并按提示操作。"/> 
<asp:label id="lb_emailerror"  runat="server" text="发送失败，邮箱格式错误。" visible="false" />
<asp:label id="lb_emailhasreged"  runat="server" visible="false">对不起，邮箱<font color=#ff0000><%=Email%></font>已经被注册，请更换一个邮箱重新发送。</asp:Label>
<asp:label id="lb_sendsuccess" runat="server" text="发送成功，请尽快查收验证邮件并按提示操作。" visible="false" /> 
<asp:label id="lb_sendfalse"  runat="server" text="发送失败，请更换一个邮箱重新发送、或联系客服人员。" visible="false" /> 
<asp:label id="lb_sendrepeat"  runat="server" text="请不要重复操作╰_╯，如有还未收到邮件请稍后再试，或联系客服人员处理。" visible="false" /> 
<div style="display:<%=ShowChangeMail=="0"?"none":""%>">如未收到验证邮件，<a href='javascript:ShowChangeMail()' style='color:#ff0000;'>请点击这里重新发送</a>。</div>
<div id="ChangeMail" style="display:none">
<asp:TextBox Id="Bt_Email" runat="server" cssclass="tb"/> <asp:Button OnClick="ChangeActMail" Text=" 发送 " class="m_bt" runat="server"/>
</div>
<div style="padding-top:10px"><input type="button" class="m_bt" value=" 转到登录页面 " onclick="location.href='<%=GetUrl("login")%>'"></div>
</div>
<asp:Label id="Lb_truename" Visible="false" runat="server" />
<asp:Label id="Lb_username" Visible="false" runat="server" />
<asp:Label id="Lb_password" Visible="false" runat="server" />
<asp:Label id="Lb_vode" Visible="false" runat="server" />
<asp:Label id="Lb_mailto" Visible="false" runat="server" />
</form>
<script type="text/javascript">
function ShowChangeMail()
 {
  document.getElementById("ChangeMail").style.display="";
 }
</script>
</asp:PlaceHolder>
<asp:PlaceHolder id="P3" runat="server"  visible="false">
<div align="center">
<img src=/e/images/public/suc.gif width="167px" vspace="10"><br>
<asp:label id="lb_nosecurity"  runat="server" Visible="false"  text="注册失败，数据提交方式发现异常。"/> 
<asp:Label id="Lb_regcolse" Visible="false" runat="server" Text="对不起，用户注册功能已被关闭。"/>
<asp:Label id="Lb_cookieerror" Visible="false" runat="server" Text="对不起，验证码无效。"/>
<asp:Label id="Lb_yzmerror" Visible="false" runat="server" Text="对不起，验证码输入错误，请返回重新输入。"/>
<asp:Label id="Lb_iuser" Visible="false" runat="server" Text="对不起，用户名只能由数字、字母和下划线组成。"/>
<asp:Label id="Lb_iemail" Visible="false" runat="server" Text="对不起，E-Mail格式错误。"/>
<asp:Label id="Lb_imtype" Visible="false" runat="server" Text="对不起，系统未开放可注册的会员类别。"/>
<asp:Label id="Lb_timelimit" Visible="false" runat="server" Text="您好，您已经注册过了，请不要重复注册。"/>
<asp:Label id="Lb_forbiduser" Visible="false" runat="server">对不起，用户名<font color=#ff0000><%=UserName%></font>被禁止注册，请更换一个用户名重新注册。</asp:Label>
<asp:Label id="Lb_userexists" Visible="false" runat="server">对不起，用户名<font color=#ff0000><%=UserName%></font>已经被注册，请更换一个用户名重新注册。</asp:Label>
<asp:Label id="Lb_emailexists" Visible="false" runat="server">对不起，邮箱<font color=#ff0000><%=Email%></font>已经被注册，请更换一个邮箱重新注册。</asp:Label>
<asp:Label id="Lb_forbidkeyword" Visible="false" runat="server">对不起，提交的内容包含被禁止的关键词：<font color=#ff0000><%=Forbid_Keyword%></font>。</asp:Label>
<div style="padding-top:10px"><input type="button" class="m_bt" value=" 返 回 " onclick="history.back()"></div>
<br><br>
</div>
</asp:PlaceHolder>
</div>
</div>