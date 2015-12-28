//不考虑http错误，仅考虑业务错误。
function doResponse(form, action, dook) {
	var success = action.result.result;
	if (success) {
		showInfo(action.result.msg);
		dook();
	} else {
		showError(action.result.msg);
	}
}
function doAjaxResponse(result, request, dook) {
	var obj = Ext.decode(result.responseText);
	var success = obj.result;
	if (success) {
		showInfo(obj.msg);
		dook();
	} else {
		showError(obj.msg);
	}
}
function convertTime(value) {
	return Ext.util.Format.date(new Date(value), 'Y年m月d日 H:i:s');
}
function convertDate(value) {
	return Ext.util.Format.date(new Date(value), 'Y年m月d日');
}
function tipAt(title, html, position) {
	var qt = new Ext.QuickTip( {
		title : title,
		html : html,
		autoHide : true
	});
	qt.showAt(position);
}
function tip(cmp, title, html) {
	var qt = new Ext.QuickTip( {
		target : cmp,
		title : title,
		html : html,
		autoHide : true
	});
	qt.showAt(cmp.getPosition());
}
// 将二维数组转为对象，数组里仅能有两个元素
// 此方法可方便地根据值得到对应的中文。
function arrayToObject(array) {
	var object = {};// 建立一个空的对象
	for ( var i = 0; i < array.length; i++) {// 循环数组元素
		object[array[i][0]] = array[i][1];
	}
	return object;
}
function reloadCaptcha() {
	var timenow = new Date().getTime();
	document.getElementById("captchaImg").src = path + '/captchaServlet?_dc='
			+ timenow;
}
function showInfo(content) {
	Ext.Msg.show( {
		title : NPC001,
		msg : content,
		icon : Ext.Msg.INFO,
		buttons : Ext.Msg.OK
	});
	setTimeout(function() {
		Ext.Msg.hide();
	}, 1000);
}
function showWarn(content) {
	Ext.Msg.show( {
		title : NPC001,
		msg : content,
		icon : Ext.Msg.WARNING,
		buttons : Ext.Msg.OK
	});
}
function showError(content) {
	Ext.Msg.show( {
		title : NPC002,
		msg : content,
		icon : Ext.Msg.ERROR,
		buttons : Ext.Msg.OK
	});
}
function getlengthB(str) {
	return str.replace(/[^\x00-\xff]/g, "**").length;
}

