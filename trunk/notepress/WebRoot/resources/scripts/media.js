Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';

	var mediaStore = new Ext.data.JsonStore({
				id : 'mediaStore',
				url : path + '/media.query.do',
				root : 'root',
				fields : ['id', 'title', 'mediaPath']
			});
	mediaStore.load();
	var mediaMenu = [{
				text : '创建',
				iconCls : 'np-create',
				handler : function() {
					createMedia();
				}
			}, {
				text : '编辑',
				iconCls : 'np-update',
				handler : function() {
					updateMedia();
				}
			}, {
				text : '删除',
				iconCls : 'np-delete',
				handler : function() {
					deleteMedia();
				}
			}];
	var contextMenu = [{
				text : '标题',
				iconCls : 'np-copy',
				handler : function() {
					copyTitle();
				}
			}, {
				text : '地址',
				iconCls : 'np-copy',
				handler : function() {
					copyMediaPath();
				}
			}];
	var floatWindow = new Ext.Window({
				layout : 'fit',
				modal : true,
				width : 450,
				resizable : false,
				closeAction : 'close',
				buttonAlign : 'center',
				items : [{
							xtype : 'textfield',
							fieldLabel : '标题',
							width : 100,
							allowBlank : false
						}, {}]
			});
	function copyTitle() {
		window.clipboardData.setData("text",mediaDataView.getSelectedRecords()[0].data.title);
	}
	function copyMediaPath() {
		window.clipboardData.setData("text",mediaDataView.getSelectedRecords()[0].data.mediaPath);
	}
	var tpl = new Ext.XTemplate(
			'<tpl for=".">',
			'<div class="thumb-wrap">',
			'<div class="thumb"><img src="'
					+ path
					+ '{mediaPath}" title="{title}" width="160" height="90"></div>',
			'<span class="x-editable">{title}</span></div>', '</tpl>',
			'<div class="x-clear"></div>');

	var mediaDataView = new Ext.DataView({
				store : mediaStore,
				tpl : tpl,
				autoHeight : true,
				multiSelect : true,
				overClass : 'x-view-over',
				itemSelector : 'div.thumb-wrap',
				emptyText : '没有媒体',
				listeners : {
					mouseenter : {
						fn : function(dv, index, nodes, e) {
							e.preventDefault();
							if (index < 0) {
								return;
							}
							dv.select(index);

							var rightClickMenu = new Ext.menu.Menu({
										items : contextMenu
									});
							rightClickMenu.showAt(Ext.get(nodes).getXY());// 显示右键菜单
						}
					}
				}
			});

	var mediaPanel = new Ext.Panel({
				id : 'images-view',
				layout : 'fit',
				title : '媒体库',
				items : mediaDataView,
				tbar : new Ext.Toolbar(mediaMenu),
				bbar : new Ext.PagingToolbar({
							id : 'mediaGridPage',
							pageSize : 20,
							store : mediaStore,
							displayInfo : true
						})
			});

	var viewport = new Ext.Viewport({
				layout : 'fit',
				items : [mediaPanel]
			});

	var mediaFormItems = function() {
		return {
			mediaId : {
				xtype : 'hidden',
				id : 'id'
			},
			title : {
				xtype : 'textfield',
				id : 'title',
				fieldLabel : '名称',
				width : 320,
				allowBlank : false,
				validator : function(value) {
					if (getlengthB(value) > 50) {
						return false;
					}
					return true;
				},
				invalidText : '不能超过50个字节'
			},
			excerpt : {
				xtype : 'textarea',
				id : 'excerpt',
				fieldLabel : '摘要',
				width : 320,
				allowBlank : false
			}
		}
	}

	// 创建媒体
	var createMediaWindow;
	function createMedia() {
		var formItems = mediaFormItems();

		// 创建表单
		var createMediaFP = new Ext.form.FormPanel({
			id : 'createMediaForm',
			labelAlign : 'right',
			frame : true,
			labelSeparator : '：',
			labelWidth : 80,
			autoHeight : true,
			anchor : '100%',
			items : [formItems.mediaId, formItems.title, formItems.excerpt, {
				xtype : 'box',
				fieldLabel : '媒体',
				autoEl : {
					tag : 'div',
					html : '<span id="uploadThumbnailButtonPlaceHolder" ></span>最大限制：'
							+ fileSizeLimit + '字节，最佳比例：16:9。'
				}
			}, {
				xtype : 'box',
				fieldLabel : '预览',
				autoEl : {
					tag : 'div',
					html : '<img id="previewThumbnail" src="' + path
							+ '/upload/default.gif" width="320" height="180"/>'
				}
			}],
			buttons : [{
				text : '创建媒体',
				id : 'uploadMediaButton',
				iconCls : 'np-accept-32',
				scale : 'medium',
				handler : function() {// 提交表单并获取url的响应
					if (createMediaFP.getForm().isValid()) {
						if (swfu.getFile(0) != null) {// 如果有待上传文件
							swfu
									.addPostParam('id', Ext.getCmp('id')
													.getValue());
							swfu.addPostParam('title', encodeURI(Ext
											.getCmp('title').getValue()));
							swfu.addPostParam('excerpt', encodeURI(Ext
											.getCmp('excerpt').getValue()));
							swfu.startUpload();
						}
					}
				}
			}, {
				text : '关闭窗口',
				iconCls : 'np-reject-32',
				scale : 'medium',
				handler : function() {
					createMediaWindow.close();// 关闭创建故事窗口
				}
			}]
		});

		// 定义创建文件夹弹出窗口
		createMediaWindow = new Ext.Window({
					layout : 'fit',
					title : '创建媒体',
					modal : true,
					width : 450,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [createMediaFP]
				});
		createMediaWindow.on('close', function() {
					swfu.destroy();
				});
		createMediaWindow.show();
		// 定义swf配置对象
		var settings = {
			flash_url : path + "/resources/images/swfupload.swf",// swfupload的位置
			upload_url : path + "/media.upload.do;jsessionid=" + sessionId,
			file_types : fileTypes,// 允许的文件类型
			file_types_description : "图片文件",// 文件类型的描述
			file_size_limit : fileSizeLimit + " B",// 最大文件尺寸
			file_queue_limit : 1,// 文件队列的大小。0为不限制
			button_image_url : path + "/resources/images/blank.png",
			button_text : "<b>上传</b>",// 按钮文本，支持Html
			button_width : "61",// 按钮宽
			button_height : "22",// 按钮高
			button_text_left_padding : 15,// 设置Flash
			// Button上文字距离左侧的距离，可以使用负值。
			button_placeholder_id : "uploadThumbnailButtonPlaceHolder",// 按钮放置的位置
			button_action : SWFUpload.BUTTON_ACTION.SELECT_FILE,// 单文件上传
			button_cursor : SWFUpload.CURSOR.HAND,// 此参数可以设置鼠标划过Flash
			// Button时的光标状态。默认为SWFUpload.CURSOR.ARROW，如果设置为SWFUpload.CURSOR.HAND，则为手形
			// button_window_mode : SWFUpload.WINDOW_MODE.OPAQUE,
			moving_average_history_size : 40,
			// 事件处理函数
			file_queue_error_handler : fileQueueError,// 文件加入到上传队列失败后触发
			upload_start_handler : uploadStart,// 将文件往服务端上传之前触发此事件
			upload_progress_handler : uploadProgress,// 该事件由flash定时触发，提供三个参数分别访问上传文件对象、已上传的字节数，总共的字节数
			upload_success_handler : uploadSuccess
			// 当文件上传的处理已经完成（这里的完成只是指向目标处理程序发送了Files信息，只管发，不管是否成功接收），并且服务端返回了200的HTTP状态时，触发此事件。
		};

		var swfu = new SWFUpload(settings);// 创建swf对象
	}

	function updateMedia() {
		var formItems = mediaFormItems();
		if (mediaDataView.getSelectionCount() < 1) {
			showWarn(NPI004);
			return;
		}
		var mediaId = mediaDataView.getSelectedRecords()[0].data.id;

		// 修改表单
		var updateMediaFP = new Ext.form.FormPanel({
			id : 'updateMediaForm',
			url : path + '/media.upload.do',
			labelAlign : 'right',
			frame : true,
			labelSeparator : '：',
			labelWidth : 80,
			autoHeight : true,
			anchor : '100%',
			items : [formItems.mediaId, formItems.title, formItems.excerpt, {
				xtype : 'box',
				fieldLabel : '媒体',
				autoEl : {
					tag : 'div',
					html : '<span id="uploadThumbnailButtonPlaceHolder" ></span>最大限制：'
							+ fileSizeLimit + '字节，最佳比例：16:9。'
				}
			}, {
				xtype : 'box',
				fieldLabel : '预览',
				autoEl : {
					tag : 'div',
					html : '<img id="previewThumbnail" src="' + path
							+ '/upload/default.gif" width="320" height="180"/>'
				}
			}],
			buttons : [{
				text : '编辑媒体',
				id : 'uploadMediaButton',
				iconCls : 'np-accept-32',
				scale : 'medium',
				handler : function() {// 提交表单并获取url的响应

					if (updateMediaFP.getForm().isValid()) {
						// 编辑媒体时可能并不重新上传文件，仅修改标题和摘要。当出现这种情况时调用startUpload()将没有任何反应，
						// 因为文件队列中没有待上传的文件。因此，需要针对这种情况采用普通表单提交。

						if (swfu.getFile(0) != null) {// 如果有待上传文件
							swfu
									.addPostParam('id', Ext.getCmp('id')
													.getValue());
							swfu.addPostParam('title', encodeURI(Ext
											.getCmp('title').getValue()));
							swfu.addPostParam('excerpt', encodeURI(Ext
											.getCmp('excerpt').getValue()));
							swfu.startUpload();
						} else {
							updateMediaFP.getForm().submit({
										success : function(form, action) {
											doResponse(form, action,
													function() {
														// 在grid中增加一行
														// 关闭创建故事窗口
														mediaStore.reload();
														updateMediaWindow
																.close();
													});
										}
									});
						}

					}
				}
			}, {
				text : '关闭窗口',
				iconCls : 'np-reject-32',
				scale : 'medium',
				handler : function() {
					updateMediaWindow.close();// 关闭创建故事窗口
				}
			}]
		});
		updateMediaFP.getForm().load({
			url : path + '/media.read.do',
			params : {
				mediaId : mediaId
			},
			success : function(form, action) {
				// 加载数据后将发布日期的数据转换为指定格式
				var media = action.result.data;
				document.getElementById("previewThumbnail").src = path
						+ media.mediaPath;
			}
		});
		// 定义创建文件夹弹出窗口
		updateMediaWindow = new Ext.Window({
					layout : 'fit',
					title : '编辑媒体',
					modal : true,
					width : 450,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [updateMediaFP]
				});
		updateMediaWindow.on('close', function() {
					swfu.destroy();
				});
		updateMediaWindow.show();
		// 定义swf配置对象
		var settings = {
			flash_url : path + "/resources/images/swfupload.swf",// swfupload的位置
			upload_url : path + "/media.upload.do;jsessionid=" + sessionId,
			file_types : fileTypes,// 允许的文件类型
			file_types_description : "图片文件",// 文件类型的描述
			file_size_limit : fileSizeLimit + " B",// 最大文件尺寸
			file_queue_limit : 1,// 文件队列的大小。0为不限制
			button_image_url : path + "/resources/images/blank.png",
			button_text : "<b>上传</b>",// 按钮文本，支持Html
			button_width : "61",// 按钮宽
			button_height : "22",// 按钮高
			button_text_left_padding : 15,// 设置Flash
			// Button上文字距离左侧的距离，可以使用负值。
			button_placeholder_id : "uploadThumbnailButtonPlaceHolder",// 按钮放置的位置
			button_action : SWFUpload.BUTTON_ACTION.SELECT_FILE,// 单文件上传
			button_cursor : SWFUpload.CURSOR.HAND,// 此参数可以设置鼠标划过Flash
			moving_average_history_size : 40,
			// 事件处理函数
			file_queue_error_handler : fileQueueError,// 文件加入到上传队列失败后触发
			upload_start_handler : uploadStart,// 将文件往服务端上传之前触发此事件
			upload_progress_handler : uploadProgress,// 该事件由flash定时触发，提供三个参数分别访问上传文件对象、已上传的字节数，总共的字节数
			upload_success_handler : uploadSuccess
			// 当文件上传的处理已经完成（这里的完成只是指向目标处理程序发送了Files信息，只管发，不管是否成功接收），并且服务端返回了200的HTTP状态时，触发此事件。
		};

		var swfu = new SWFUpload(settings);// 创建swf对象
	}

	function deleteMedia() {
		if (mediaDataView.getSelectionCount() < 1) {
			showWarn(NPI004);
			return;
		}
		var mediaId = mediaDataView.getSelectedRecords()[0].data.id;

		var btn = Ext.Msg.confirm(NPC001, NPI007, function(btn, text) {
					if (btn == 'yes') {
						Ext.Ajax.request({
									url : path + '/media.delete.do',
									params : {
										mediaId : mediaId
									},
									success : function(result, request) {
										doAjaxResponse(result, request,
												function() {
													mediaStore.reload();
												})
									}
								});
					}
				});
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

	// 开始上传后的事件处理
	function uploadStart(file) {
		Ext.MessageBox.show({
					title : '请等待',
					msg : '正在上传...',
					progressText : '正在连接...',
					width : 300,
					progress : true
				});
	}

	function uploadProgress(file, bytesLoaded, bytesTotal) {
		// 更新进度条
		updateDisplay.call(this, file);
	}

	function uploadSuccess(file, serverData) {

		// 获取服务器端处理结果
		var result = Ext.decode(serverData);

		// 刷新上传成功的图片
		if (result.success) {
			document.getElementById("previewThumbnail").src = path + result.msg;
			mediaStore.reload();
			Ext.getCmp('uploadMediaButton').disable();
			showInfo(NPC003);
		} else {
			showError(result.msg);
		}
	}

	function updateDisplay(file) {
		// 获取文件上传进度
		var b = Number(file.percentUploaded);
		// 更新进度条里的进度
		Ext.MessageBox.updateProgress(b / 100, b.toFixed(2) + '% 完成');

	}
});