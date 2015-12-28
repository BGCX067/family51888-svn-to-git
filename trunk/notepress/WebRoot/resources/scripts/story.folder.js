/**
 * 文件夹管理。含列表、创建、编辑、删除功能
 * 
 * @param storyId
 *            故事id
 * @param folderType
 *            文件夹类型。1-文本；2-图片；3-文件；4-视频
 * @return 无
 */
function folder(storyId) {

	// 定义工具栏菜单。右键菜单同此定义
	var folderMenu = [{
				text : '创建文件夹',
				iconCls : 'np-create-folder',
				handler : function() {
					createFolder();// 创建文件夹
				}
			}, {
				text : '编辑文件夹',
				iconCls : 'np-update-folder',
				handler : function() {
					updateFolder();// 编辑文件夹
				}
			}, {
				text : '删除文件夹',
				iconCls : 'np-delete-folder',
				handler : function() {
					deleteFolder();// 删除文件夹
				}
			}, {
				text : '缩略图',
				iconCls : 'np-thumbnail',
				handler : function() {
					thumbnail();
				}
			}, '-', {
				text : '文件夹内容',
				iconCls : 'np-folder',
				handler : function() {
					var folderRecord = folderListGP.getSelectionModel()
							.getSelected();// 获取列表选中行的记录
					if (folderRecord == null) {// 如果没有选择一条记录，则弹出提示
						showWarn(NPI004);
						return;
					}
					var folderId = folderRecord.data.id;// 得到选择的文件夹id
					var folderName = folderRecord.data.title
					file(folderId, folderName);// 打开处理文件夹内容的窗口
				}
			}];

	var folderToolbar = new Ext.Toolbar(folderMenu);// 定义文件夹列表上方的工具栏，载入菜单

	// 定义文件夹列表的选择模型--单选
	var singleSelectSM = new Ext.grid.CheckboxSelectionModel({
				singleSelect : true
			});

	// 定义文件夹列表的列模型
	var folderListCM = new Ext.grid.ColumnModel([new Ext.grid.RowNumberer(),
			singleSelectSM, {
				header : '标识',
				dataIndex : 'id',
				hidden : true,
				hideable : false
				// 隐藏列，用于获取记录标识。
		}	, {
				header : '文件夹标题',
				width : .4,
				dataIndex : 'title'
			}, {
				header : '创建时间',
				width : .3,
				dataIndex : 'createTime',
				type : 'date',
				renderer : function(value) {
					return convertTime(value);// 将毫秒转换为本地日期格式
				}
			}, {
				header : '更新时间',
				width : .3,
				dataIndex : 'updateTime',
				renderer : function(value) {
					return convertTime(value);// 将毫秒转换为本地日期格式
				}
			}]);

	// 定义文件夹列表的数据来源
	var folderListStore = new Ext.data.JsonStore({
				url : path + '/folder.query.do',// 此url返回符合Ext Grid的Json串
				root : 'root',
				fields : ['id', 'title', 'createTime', 'updateTime'],
				baseParams : {
					storyId : storyId
				}
			});

	// 加载文件夹列表的数据
	folderListStore.load();

	// 定义文件夹列表
	var folderListGP = new Ext.grid.GridPanel({
				id : 'folderListGP',
				region : 'center',
				cm : folderListCM,
				closable : true,
				stripeRows : true,
				loadMask : true,
				loadingText : '加载中...',
				store : folderListStore,
				autoExpandColumn : 'title',
				columnLines : true,
				layout : 'fit',
				viewConfig : {
					forceFit : true
				},
				tbar : folderToolbar,
				bbar : new Ext.PagingToolbar({
							id : 'folderGridPage',
							pageSize : 20,
							store : folderListStore,
							displayInfo : true
						})
			});

	// 给行增加右键菜单
	folderListGP.on("rowcontextmenu", function(grid, rowIndex, e) {
				e.preventDefault();
				if (rowIndex < 0) {
					return;
				}
				var model = grid.getSelectionModel();
				model.selectRow(rowIndex);// 选择某行
				var rightClickMenu = new Ext.menu.Menu({// 定义菜单项
					items : folderMenu
				});

				rightClickMenu.showAt(e.getXY());// 显示右键菜单
			});

	// 定义文件夹列表窗口
	var folderListWindow = new Ext.Window({
				layout : 'fit',
				title : '文件夹',
				width : 680,
				height : 350,
				modal : true,
				resizable : false,
				closeAction : 'close',
				items : [folderListGP],
				buttons : [{
							text : '关闭窗口',
							iconCls : 'np-reject-32',
							scale : 'medium',
							handler : function() {
								folderListWindow.close();
							}
						}]
			});

	folderListWindow.show();// 显示文件夹列表窗口

	// 定义文件夹表单项目，创建和编辑表单均适用此项目
	var folderFormItems = function() {
		return {
			folderId : {// 文件夹id
				xtype : 'hidden',
				id : 'id'
			},
			storyId : {// 故事id
				xtype : 'hidden',
				id : 'storyId',
				value : storyId
			},
			folderTitle : {
				xtype : 'textfield',
				id : 'title',
				fieldLabel : '文件夹标题',
				allowBlank : false,
				width : 400
			},
			folderContent : {// 文件夹摘要
				xtype : 'htmleditor',
				id : 'content',
				fieldLabel : '文件夹摘要',
				allowBlank : false,
				width : 550,
				validateValue : function() {// 如果此值为空，则弹出提示。
					var value = this.getRawValue();
					var valid = (this.allowBlank || (value.length > 0 && value != '<br>'))
							? true
							: false;
					if (!valid) {
						tip(this, NPC001, NPI003);
						return false;
					} else {
						return true;
					}
				}
			}
		};
	};

	// 创建文件夹
	function createFolder() {
		var formItems = folderFormItems();// 创建表单项目

		// 创建表单
		var createFolderFP = new Ext.form.FormPanel({
					id : 'createFolderForm',
					url : path + '/folder.create.do',
					labelAlign : 'right',
					frame : true,
					labelSeparator : '：',
					labelWidth : 80,
					autoHeight : true,
					anchor : '100%',
					items : [formItems.folderId, formItems.storyId,
							formItems.folderTitle, formItems.folderContent],
					buttons : [{
						text : '创建文件夹',
						iconCls : 'np-accept-32',
						scale : 'medium',
						handler : function() {// 提交表单并获取url的响应
							createFolderFP.getForm().submit({
										success : function(form, action) {
											doResponse(form, action,
													function() {
														folderListStore
																.reload();// 重载表格数据
														createFolderWindow
																.close();// 关闭创建故事窗口
													});
										}
									});
						}
					}, {
						text : '关闭窗口',
						iconCls : 'np-reject-32',
						scale : 'medium',
						handler : function() {
							createFolderWindow.close();// 关闭创建故事窗口
						}
					}]
				});

		// 定义创建文件夹弹出窗口
		var createFolderWindow = new Ext.Window({
					layout : 'fit',
					title : '创建文件夹',
					width : 680,
					modal : true,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [createFolderFP]
				});
		createFolderWindow.show();
	}

	// 编辑文件夹
	function updateFolder() {
		var folderRecord = folderListGP.getSelectionModel().getSelected();// 获取列表选中行的记录
		if (folderRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var folderId = folderRecord.data.id;// 得到选择的文件夹id

		var formItems = folderFormItems();// 创建表单项目
		formItems.folderId.value = folderId;// 设置表单中文件夹id的值

		// 创建表单
		var updateFolderFP = new Ext.form.FormPanel({
					id : 'updateFolderForm',
					url : path + '/folder.update.do',
					labelAlign : 'right',
					frame : true,
					labelSeparator : '：',
					labelWidth : 80,
					autoHeight : true,
					anchor : '100%',
					items : [formItems.folderId, formItems.folderTitle,
							formItems.folderContent],
					buttons : [{
						text : '保存文件夹',
						iconCls : 'np-accept-32',
						scale : 'medium',
						handler : function() {
							updateFolderFP.getForm().submit({
										success : function(form, action) {
											doResponse(form, action,
													function() {
														folderListStore
																.reload();// 重载表格数据
														updateFolderWindow
																.close();// 关闭创建故事窗口
													});
										}
									});
						}
					}, {
						text : '关闭窗口',
						iconCls : 'np-reject-32',
						scale : 'medium',
						handler : function() {
							updateFolderWindow.close();
						}
					}]
				});
		updateFolderFP.getForm().load({
					url : path + '/folder.read.do',
					params : {
						folderId : folderId
					}
				});
		// 定义编辑故事弹出窗口
		var updateFolderWindow = new Ext.Window({
					layout : 'fit',
					title : '编辑文件夹',
					width : 680,
					modal : true,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [updateFolderFP]
				});
		updateFolderWindow.show();
	}

	// 删除文件夹
	function deleteFolder() {
		var folderRecord = folderListGP.getSelectionModel().getSelected();// 获取列表选中行的记录
		if (folderRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var folderId = folderRecord.data.id;// 得到选择的文件夹id
		var btn = Ext.Msg.confirm(NPC001, NPI006, function(btn, text) {
					if (btn == 'yes') {
						Ext.Ajax.request({
									url : path + '/folder.delete.do',
									params : {
										folderId : folderId
									},
									success : function(result, request) {
										doAjaxResponse(result, request,
												function() {
													folderListStore.reload();// 重载表格数据
												})
									}
								});
					}
				});
	}

	// 处理缩略图
	function thumbnail() {
		thumbnailTarget = "folder";
		var folderRecord = folderListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (folderRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var folderId = folderRecord.data.id;// 得到当前行id
		var thumbnail = folderRecord.data.thumbnail;// 得到当前行的缩略图
		if (thumbnail == null || thumbnail == undefined) {
			thumbnail = STORY.DEFAULT_THUMBNAIL;
		}
		// 定义缩略图弹出窗口
		var thumbnailWindow = new Ext.Window({
			layout : 'fit',
			title : '缩略图',
			modal : true,
			resizable : false,
			closeAction : 'close',
			buttonAlign : 'right',
			items : [{
				id : 'previewThumbnailPanel',
				region : 'north',
				title : '预览',
				autoWidth : true,
				autoHeight : true,
				html : '<img id="previewThumbnail" src="' + path + thumbnail
						+ '" width="320" height="180"/>'
			}, {
				id : 'uploadThumbnailPanel',
				region : 'center',
				height : 50,
				title : '上传',
				html : '<div style="align:center;width:100%"><span id="uploadThumbnailButtonPlaceHolder" ></span></div>'
			}],
			buttons : [{
				text : '删除缩略图',
				iconCls : 'np-delete-32',
				scale : 'medium',
				handler : function() {
					var record = folderListGP.getSelectionModel().getSelected();
					if (record.data.thumbnail == STORY.DEFAULT_THUMBNAIL) {
						showWarn("这个文件夹没有设置缩略图。");
						return;
					}
					Ext.Ajax.request({
						url : path + '/thumbnail.delete.do',
						params : {
							id : folderId,
							target : thumbnailTarget
						},
						success : function(result, request) {
							doAjaxResponse(result, request, function() {
								var record = folderListGP.getSelectionModel()
										.getSelected();
								record.set("thumbnail", STORY.DEFAULT_THUMBNAIL);
								document.getElementById("previewThumbnail").src = path
										+ STORY.DEFAULT_THUMBNAIL;
							});
						}
					});
				}
			}, {
				text : '关闭窗口',
				iconCls : 'np-reject-32',
				scale : 'medium',
				handler : function() {
					thumbnailWindow.close();
				}
			}]
		});

		thumbnailWindow.show();

		var settings = {
			flash_url : path + "/resources/images/swfupload.swf",// swfupload的位置
			upload_url : path + "/thumbnail.upload.do",// 服务器端处理上传文件的servlet
			file_types : fileTypes,// 允许的文件类型
			file_types_description : "图片文件",// 文件类型的描述
			file_size_limit : fileSizeLimit + " B",// 最大文件尺寸
			file_queue_limit : 0,// 文件队列的大小。0为不限制
			debug : true,// 调试
			post_params : {
				id : folderId,
				target : thumbnailTarget
			},
			button_image_url : path + "/resources/images/blank.png",
			button_text : "<b>上传</b>",// 按钮文本，支持Html
			button_width : "61",// 按钮宽
			button_height : "22",// 按钮高
			button_text_left_padding : 15,// 设置Flash Button上文字距离左侧的距离，可以使用负值。
			button_placeholder_id : "uploadThumbnailButtonPlaceHolder",// 按钮放置的位置
			button_action : SWFUpload.BUTTON_ACTION.SELECT_FILE,// 单文件上传
			button_cursor : SWFUpload.CURSOR.HAND,// 此参数可以设置鼠标划过Flash
			// Button时的光标状态。默认为SWFUpload.CURSOR.ARROW，如果设置为SWFUpload.CURSOR.HAND，则为手形
			// button_window_mode : SWFUpload.WINDOW_MODE.OPAQUE,
			moving_average_history_size : 40,
			// 事件处理函数
			file_queued_handler : fileQueued,// 文件加入到上传队列成功后触发
			file_queue_error_handler : fileQueueError,// 文件加入到上传队列失败后触发
			file_dialog_complete_handler : fileDialogComplete,// 文件选择框关闭后，文件处理完成时触发
			upload_start_handler : uploadStart,// 将文件往服务端上传之前触发此事件
			upload_progress_handler : uploadProgress,// 该事件由flash定时触发，提供三个参数分别访问上传文件对象、已上传的字节数，总共的字节数
			// upload_error_handler : uploadError,// 只要上传被终止或者没有成功完成，那么该事件都将被触发
			upload_success_handler : uploadSuccess,// 当文件上传的处理已经完成（这里的完成只是指向目标处理程序发送了Files信息，只管发，不管是否成功接收），并且服务端返回了200的HTTP状态时，触发此事件。
			upload_complete_handler : uploadComplete
			// 当上传队列中的一个文件完成了一个上传周期，无论是成功(uoloadSuccess触发)还是失败(uploadError触发)，此事件都会被触发
		};

		var swfu = new SWFUpload(settings);

	}
}