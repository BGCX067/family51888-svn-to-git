var STORY = {
	DEFAULT_THUMBNAIL : "/upload/default.gif"
};

Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'side';

	// 定义工具栏菜单。右键菜单同此定义
	var storyMenu = [{
				text : '创建故事',
				iconCls : 'np-create',
				handler : function() {
					createStory();// 创建故事
				}
			}, {
				text : '编辑故事',
				iconCls : 'np-update',
				handler : function() {
					updateStory();// 编辑故事
				}
			}, {
				text : '删除故事',
				iconCls : 'np-delete',
				handler : function() {
					deleteStory();// 删除故事
				}
			}, {
				text : '缩略图',
				iconCls : 'np-thumbnail',
				handler : function() {
					thumbnail();
				}
			}, '-', {
				text : '文件夹管理',
				iconCls : 'np-text',
				handler : function() {
					var storyRecord = storyListGP.getSelectionModel()
							.getSelected();// 返回选中的第一行的记录
					if (storyRecord == null) {// 如果没有选择一条记录，则弹出提示
						showWarn(NPI004);
						return;
					}
					var storyId = storyRecord.data.id;// 得到当前故事id
					folder(storyId);
				}
			}];

	var storyToolbar = new Ext.Toolbar(storyMenu);// 定义故事列表上方的工具栏，载入菜单

	// 定义故事列表的选择模型--单选
	var singleSelectSM = new Ext.grid.CheckboxSelectionModel({
				singleSelect : true
			});

	// 定义故事列表的列模型
	var storyListCM = new Ext.grid.ColumnModel([new Ext.grid.RowNumberer(),
			singleSelectSM, {
				header : '标识',
				dataIndex : 'id',
				hidden : true,
				hideable : false
				// 隐藏列，用于修改删除。
		}	, {
				header : '故事标题',
				width : .4,
				dataIndex : 'title'
			}, {
				header : '栏目名称',
				width : .1,
				dataIndex : 'categoryId'
			}, {
				header : '创建时间',
				width : .15,
				dataIndex : 'createTime',
				type : 'date',
				renderer : function(value) {
					return convertTime(value);// 将毫秒转换为本地日期格式
				}
			}, {
				header : '更新时间',
				width : .15,
				dataIndex : 'updateTime',
				renderer : function(value) {
					return convertTime(value);// 将毫秒转换为本地日期格式
				}
			}, {
				header : '缩略图',
				dataIndex : 'thumbnail',
				hidden : true,
				hideable : false
				// 隐藏列，用于修改删除。
		}]);

	// 定义故事列表的数据来源
	var storyListStore = new Ext.data.JsonStore({
				url : path + '/story.query.do',// 此url返回符合ext grid的json串
				root : 'root',
				fields : ['id', 'title', 'createTime', 'updateTime',
						'categoryId', 'thumbnail']
			});

	storyListStore.load();// 加载故事列表的数据

	// 定义故事列表
	var storyListGP = new Ext.grid.GridPanel({
				id : 'storyListGP',
				region : 'center',
				cm : storyListCM,
				closable : true,
				stripeRows : true,
				loadMask : true,
				loadingText : '加载中...',
				store : storyListStore,
				autoExpandColumn : 'title',
				columnLines : true,
				layout : 'fit',
				viewConfig : {
					forceFit : true
				},
				tbar : storyToolbar,
				bbar : new Ext.PagingToolbar({
							id : 'storyGridPage',
							pageSize : 20,
							store : storyListStore,
							displayInfo : true
						})
			});

	// 定义列表的容器，这样才可以让列表的高和宽自动扩展。
	var viewport = new Ext.Viewport({
				layout : 'fit',
				items : [storyListGP]
			});

	// 给行增加右键菜单
	storyListGP.on("rowcontextmenu", function(grid, rowIndex, e) {
				e.preventDefault();
				if (rowIndex < 0) {
					return;
				}
				var model = grid.getSelectionModel();
				model.selectRow(rowIndex);// 选择某行

				var rightClickMenu = new Ext.menu.Menu({
							items : storyMenu
						});
				rightClickMenu.showAt(e.getXY());// 显示右键菜单
			});

	// 定义故事表单项目，创建和编辑表单均适用此项目
	var storyFormItems = function() {
		return {
			storyId : {
				xtype : 'hidden',
				id : 'id'
			},
			categoryId : {
				xtype : 'hidden',
				id : 'categoryId'
			},
			storyTitle : {
				xtype : 'textfield',
				id : 'title',
				fieldLabel : '故事标题',
				allowBlank : false,
				width : 400
			},
			storyContent : {
				xtype : 'htmleditor',
				id : 'content',
				fieldLabel : '故事摘要',
				allowBlank : false,
				width : 660,
				validateValue : function() {
					var value = this.getRawValue();
					var valid = (this.allowBlank || (value.length > 0 && value != '<br>'))
							? true
							: false;
					if (!valid) {
						tip(this, NPC001, NPI003)
						return false;
					} else {
						return true;
					}
				}
			}
		};
	}

	// 创建故事的第一步，选择栏目
	function createStory() {
		// 首先选择一个栏目，然后打开故事创建窗口

		// 定义栏目tree
		var tree = new Ext.tree.TreePanel({
					useArrows : true,
					animate : true,
					autoScroll : true,
					useArrows : true,
					enableDD : true,
					containerScroll : true,
					rootVisible : false,
					dropConfig : {
						appendOnly : true
					},
					loader : new Ext.tree.TreeLoader({
								dataUrl : path + '/category.query.do'
							})
				});

		// 设置根目录
		var root = new Ext.tree.AsyncTreeNode({
					text : '',
					draggable : false,
					id : '1'// 表示文章
				});
		tree.setRootNode(root);
		tree.on('DblClick', treeDblClickHandler);

		// 定义双击事件处理函数
		function treeDblClickHandler(node, e) {

			if (node == null || !node.isLeaf()) {
				showWarn(NPI002);
				return;
			}
			node.select();// 选中当前行
			categoryListWindow.close();
			doCreateStory(node.id);// 打开创建故事窗口
		}

		// 定义栏目弹出窗口
		var categoryListWindow = new Ext.Window({
					layout : 'fit',
					title : '第一步：为故事选择一个栏目',
					width : 250,
					height : 300,
					modal : true,
					resizable : false,
					closeAction : 'close',
					items : [tree],
					buttons : [{
						text : '选择好了',
						iconCls : 'np-accept-32',
						scale : 'medium',
						handler : function() {// 获取选择的栏目ID，传递到创建故事窗口
							var currentNode = tree.getSelectionModel()
									.getSelectedNode();// 获取选择的栏目节点
							if (currentNode == null || !currentNode.isLeaf()) {// 如果节点为空或非叶子节点，则弹出提示
								showWarn(NPI002);
								return;
							}

							var id = currentNode.id;// 选中的栏目Id
							categoryListWindow.close();// 关闭栏目列表窗口
							doCreateStory(currentNode.id);// 打开创建故事窗口
						}
					}, {
						text : '关闭窗口',
						iconCls : 'np-reject-32',
						scale : 'medium',
						handler : function() {
							categoryListWindow.close();// 关闭栏目列表窗口
						}
					}]
				});

		categoryListWindow.show();// 显示栏目列表窗口
	}

	// 创建故事
	function doCreateStory(categoryId) {
		var formItems = storyFormItems();
		formItems.categoryId.value = categoryId;

		var createStoryFP = new Ext.form.FormPanel({
					id : 'createStoryForm',
					url : path + '/story.create.do',
					labelAlign : 'right',
					frame : true,
					labelSeparator : '：',
					labelWidth : 80,
					autoHeight : true,
					anchor : '100%',
					items : [formItems.storyId, formItems.categoryId,
							formItems.storyTitle, formItems.storyContent],
					buttons : [{
						text : '创建故事',
						iconCls : 'np-accept-32',
						scale : 'medium',
						handler : function() {
							createStoryFP.getForm().submit({
										success : function(form, action) {
											doResponse(form, action,
													function() {
														// 在grid中增加一行
														// 关闭创建故事窗口
														storyListStore.load();
														createStoryWindow
																.close();
													})
										}
									});
						}
					}, {
						text : '取消故事',
						iconCls : 'np-reject-32',
						scale : 'medium',
						handler : function() {
							createStoryWindow.close();
						}
					}]
				});
		// 定义创建故事弹出窗口
		var createStoryWindow = new Ext.Window({
					layout : 'fit',
					title : '创建故事',
					width : 800,
					modal : true,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [createStoryFP]
				});
		createStoryWindow.show();
	}

	// 编辑故事
	function updateStory() {
		var storyRecord = storyListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (storyRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var storyId = storyRecord.data.id;// 得到当前故事id

		var formItems = storyFormItems();
		formItems.storyId.value = storyId;

		var updateStoryFP = new Ext.form.FormPanel({
			id : 'updateStoryForm',
			url : path + '/story.update.do',
			labelAlign : 'right',
			frame : true,
			labelSeparator : '：',
			labelWidth : 80,
			autoHeight : true,
			anchor : '100%',
			items : [formItems.storyId, formItems.storyTitle,
					formItems.storyContent],
			buttons : [{
						text : '保存故事',
						iconCls : 'np-accept-32',
						scale : 'medium',
						handler : function() {
							updateStoryFP.getForm().submit({
										success : function(form, action) {
											doResponse(form, action,
													function() {
														storyListStore.reload();
														// 在grid中增加一行
														// 关闭创建故事窗口
														updateStoryWindow
																.close();
													})
										}
									});
						}
					}, {
						text : '取消故事',
						iconCls : 'np-reject-32',
						scale : 'medium',
						handler : function() {
							updateStoryWindow.close();
						}
					}]
		});
		updateStoryFP.getForm().load({
					url : path + '/story.read.do',
					params : {
						storyId : storyId
					}
				});
		// 定义编辑故事弹出窗口
		var updateStoryWindow = new Ext.Window({
					layout : 'fit',
					title : '编辑故事',
					width : 800,
					modal : true,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [updateStoryFP]
				});
		updateStoryWindow.show();
	}

	// 删除故事
	function deleteStory() {
		var storyRecord = storyListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (storyRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var storyId = storyRecord.data.id;// 得到当前故事id
		var btn = Ext.Msg.confirm(NPC001, NPI005, function(btn, text) {
					if (btn == 'yes') {
						Ext.Ajax.request({
									url : path + '/story.delete.do',
									params : {
										storyId : storyId
									},
									success : function(result, request) {
										doAjaxResponse(result, request,
												function() {
													storyListStore.reload();
												})
									}
								});
					}
				});
	}

	// 处理缩略图
	function thumbnail() {
		thumbnailTarget = "story";
		var storyRecord = storyListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (storyRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var storyId = storyRecord.data.id;// 得到当前行id
		var thumbnail = storyRecord.data.thumbnail;// 得到当前行的缩略图

		if (thumbnail == null || thumbnail == undefined) {
			thumbnail = STORY.DEFAULT_THUMBNAIL;
		}

		// 定义缩略图弹出窗口
		var thumbnailWindow = new Ext.Window({
			layout : 'fit',
			title : '缩略图',
			modal : true,
			width : 200,
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
						+ '" width="160" height="90"/>'
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
					var record = storyListGP.getSelectionModel().getSelected();
					if (record.data.thumbnail == STORY.DEFAULT_THUMBNAIL) {
						showWarn("这个故事没有设置缩略图。");
						return;
					}
					Ext.Ajax.request({
						url : path + '/thumbnail.delete.do',
						params : {
							id : storyId,
							target : thumbnailTarget
						},
						success : function(result, request) {
							doAjaxResponse(result, request, function() {
								var record = storyListGP.getSelectionModel()
										.getSelected();
								record
										.set("thumbnail",
												STORY.DEFAULT_THUMBNAIL);
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
			upload_url : path + "/thumbnail.upload.do;jsessionid=" + sessionId,// 服务器端处理上传文件的servlet
			file_types : fileTypes,// 允许的文件类型
			file_types_description : "图片文件",// 文件类型的描述
			file_size_limit : fileSizeLimit + " B",// 最大文件尺寸
			file_queue_limit : 0,// 文件队列的大小。0为不限制
			debug : true,// 调试
			post_params : {
				id : storyId,
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
			//upload_error_handler : uploadError,// 只要上传被终止或者没有成功完成，那么该事件都将被触发
			upload_success_handler : uploadSuccess,// 当文件上传的处理已经完成（这里的完成只是指向目标处理程序发送了Files信息，只管发，不管是否成功接收），并且服务端返回了200的HTTP状态时，触发此事件。
			upload_complete_handler : uploadComplete
			// 当上传队列中的一个文件完成了一个上传周期，无论是成功(uoloadSuccess触发)还是失败(uploadError触发)，此事件都会被触发
		};

		var swfu = new SWFUpload(settings);

	}
});
