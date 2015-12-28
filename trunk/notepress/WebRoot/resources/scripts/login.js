Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';

	var loginFormItems = function() {

		return {
			j_username : {
				xtype : 'textfield',
				id : 'j_username',
				fieldLabel : '用户',
				allowBlank : false,
				anchor : '70%'
			},
			j_password : {
				xtype : 'textfield',
				inputType : 'password',
				id : 'j_password',
				fieldLabel : '密码',
				allowBlank : false,
				anchor : '70%'
			},
			_spring_security_remember_me : {
				xtype : 'checkbox',
				id : '_spring_security_remember_me',
				boxLabel : '两周内自动登录',
				fieldLabel : '选项'
			},
			j_captcha : {
				xtype : 'textfield',
				id : 'j_captcha',
				fieldLabel : '验证码',
				allowBlank : false,
				anchor : '70%'
			},
			captcha : {
				fieldLabel : ' ',
				labelSeparator : '',
				xtype : 'box',
				autoEl : {
					tag : 'div',
					html : '<img id="captchaImg" src="'
							+ path
							+ '/captchaServlet" /><a href="javascript:reloadCaptcha();">换一张</a>'
				}
			}
		}
	};

	var formItems = loginFormItems();
	var loginFP = new Ext.form.FormPanel({
				id : 'loginForm',
				labelAlign : 'right',
				frame : true,
				labelSeparator : '：',
				labelWidth : 80,
				autoHeight : true,
				anchor : '100%',
				keys : [{
							key : [10, 13],
							fn : login
						}],
				onSubmit : Ext.emptyFn,
				submit : function() {
					// 有疑问的地方
					this.getEl().dom.action = path + '/login';
					this.getEl().dom.submit();
				},
				items : [formItems.j_username, formItems.j_password,
						formItems.j_captcha, formItems.captcha,
						formItems._spring_security_remember_me],
				buttons : [{
							text : '登录系统',
							iconCls : 'login',
							scale : 'medium',
							handler : login
						}, {
							text : '重置表单',
							iconCls : 'reset',
							scale : 'medium',
							handler : reset
						}]
			});
	function reset() {
		loginFP.form.reset();
	}
	function login() {
		if (loginFP.form.isValid()) {
			loginFP.form.submit();
		}
	}

	var loginWindow = new Ext.Window({
				layout : 'fit',
				title : '登录控制台',
				closable : false,
				draggable : false,
				width : 400,
				resizable : false,
				closeAction : 'close',
				buttonAlign : 'center',
				items : [loginFP]
			});

	loginWindow.show();
	if (error == '1') {
		showError(NPI008);
	} else if (error == '2') {
		showError(NPI009);
	}
});