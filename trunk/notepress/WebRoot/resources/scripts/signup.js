var path = "";
function reloadCaptcha() {
	$('#captchaImg').attr("src",
			path + '/captchaServlet?_dc=' + new Date().getTime());
}
function getlengthB(str) {
	return str.replace(/[^\x00-\xff]/g, "**").length;
}
$(document).ready(function() {

	var loginHtml = "<div class=\"container span-8 last\">";
	loginHtml += "<h5 class=\"title-color round-box\">登录到AJava</h5>";
	loginHtml += "<form id=\"loginForm\" action=\"" + path
			+ "/login\" method=\"post\"> ";
	loginHtml += "<div class=\"round-box\"><label>账户名称：</label><input type=\"text\" id=\"j_username\" name=\"j_username\" style=\"width:200px\"/></div>";
	loginHtml += "<div class=\"round-box\"><label>账户密码：</label><input type=\"password\" id=\"j_password\" name=\"j_password\" style=\"width:200px\"/></div>";
	loginHtml += "<div class=\"round-box\"><label>验证文字：</label><input type=\"text\" id=\"j_captcha\" name=\"j_captcha\" style=\"width:200px\"/></div>";
	loginHtml += "<div class=\"round-box\"><img id=\"captchaImg\" class=\"logo\" src=\"\" /><a href=\"javascript:reloadCaptcha();\">换一张</a><span id=\"login_span\" class=\"hide error-color round-box\"></span></div>";
	loginHtml += "<div class=\"round-box\"><label>登录选项：</label><input type=\"checkbox\" id=\"_spring_security_remember_me\" name=\"_spring_security_remember_me\"/><label for=\"_spring_security_remember_me\">两周内不用再次登录</label></div>";
	loginHtml += "<div class=\"round-box\"><button type=\"submit\"><img src=\"resources/images/icons/tick.png\" alt=\"\"/>登录到AJava</button><button type=\"button\" class=\"close-floatbox\"><img src=\"resources/images/icons/cross.png\" alt=\"\"/>关闭窗口</button></div>";
	loginHtml += "</form>";
	loginHtml += "</div>";
	$("#login").click(function() {
		$.floatbox({
					content : loginHtml,
					fade : true
				});
		function validateJUserName() {
			var username = $("#j_username").val();
			if (username == '') {
				$('#login_span').text("账户名称不能为空！").fadeIn();
				return false;
			} else {
				$('#login_span').fadeOut();
				return true;
			}
		}
		$("#j_username").blur(validateJUserName);
		function validateJPassword() {
			// $('#login_span').fadeOut();
			var password = $("#j_password").val();
			if (password == '') {
				$('#login_span').text("账户密码不能为空！").fadeIn();
				return false;
			} else {
				$('#login_span').fadeOut();
				return true;
			}
		}
		$("#j_password").blur(validateJPassword);
		$("#j_captcha").focus(reloadCaptcha);
		function validateJCaptcha() {
			// $('#login_span').fadeOut();
			var captcha = $("#j_captcha").val();
			if (captcha == '') {
				$('#login_span').text("验证文字不能为空！").fadeIn();
				return false;
			} else {
				$('#login_span').fadeOut();
				return true;
			}
		}
		$("#j_captcha").blur(validateJCaptcha);
		function validateLogin() {
			if (validateJUserName() && validateJPassword()
					&& validateJCaptcha()) {
				return true;
			} else {
				return false;
			}
		}
		function hanlderLogin(responseText) {
			var o = $.parseJSON(responseText);
			if (o.success) {
				$('#login_span').text("登陆成功！").fadeIn();
				if (window.location.href.indexOf("/signup") > -1) {
					window.location.href = "/member.index";
				} else {
					window.location.reload();
				}
			} else {
				$('#login_span').text(o.msg).fadeIn();
			}
		}
		$("#loginForm").ajaxForm({
					"beforeSubmit" : validateLogin,
					"success" : hanlderLogin
				});
	});

});