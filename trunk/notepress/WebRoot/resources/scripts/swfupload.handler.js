// 成功加入队列后的事件处理
function fileQueued(file) {
	// 目前无需处理
}

// 加入队列失败的事件处理
function fileQueueError(file, error, message) {
	if (error == SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
		showError("超出文件队列！");
	}
	if (error == SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT) {
		showError(file.name + "大小为" + file.size + "字节，超出服务器限制！");
	}
	if (error == SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE) {
		showError(file.name + "大小为零！");
	}
	if (error == SWFUpload.QUEUE_ERROR.INVALID_FILETYPE) {
		showError(file.name + "文件类型为" + file.type + "，超出服务器限制！");
	}
}
// 文件对话框关闭后的事件处理
function fileDialogComplete() {
	this.startUpload();// 启动上传

}

// 开始上传后的事件处理
function uploadStart(file) {

	Ext.MessageBox.show( {
		title : '请等待',
		msg : '正在上传...',
		progressText : '正在连接...',
		width : 300,
		progress : true,
		closable : false,
		animEl : 'uploadThumbnailButtonPlaceHolder'
	});

}

function uploadProgress(file, bytesLoaded, bytesTotal) {

	updateDisplay.call(this, file);
}

function uploadSuccess(file, serverData) {
	// 更新进度条
	// updateDisplay.call(this, file);
	var result = Ext.decode(serverData);

	if (result.success) {
		var record = Ext.getCmp(thumbnailTarget + 'ListGP').getSelectionModel()
				.getSelected();
		record.set("thumbnail", result.msg);
		document.getElementById("previewThumbnail").src = path + result.msg;
		showInfo("文件已经成功上传！");
	} else {
		showError(result.msg);
	}
	// showInfo("文件已经成功上传！");
	// 预览上传成功的图片
}

// 上传完成后的事件处理
function uploadComplete(file) {

}

function updateDisplay(file) {
	var b = Number(file.percentUploaded);
	Ext.MessageBox.updateProgress(b / 100, b.toFixed(2) + '% 完成');
}