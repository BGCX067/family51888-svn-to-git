/**
 * 管理文件内容
 * 
 * @param folderId
 *            文件夹id
 * @return 无
 */
function file(folderId, folderName) {
	// 定义文件状态
	var statusTypeData = [["0", "未审核"], ["1", "已发布"], ["2", "已拒绝"],
			["3", "已锁定"], ["4", "已隐藏"]];
	var languageTypeData = [["中文", "中文"], ["英文", "英文"], ["多语言", "多语言"]];
	var languageTypeStore = new Ext.data.SimpleStore({
				fields : ['value', 'text'],
				data : languageTypeData
			});
	var osTypeData = [["所有系统", "所有系统"], ['Windows', 'Windows系统'],
			["Linux", "Linux系统"], ["Mac", "Mac系统"], ["其他系统", "其他系统"]];
	var osTypeStore = new Ext.data.SimpleStore({
				fields : ['value', 'text'],
				data : osTypeData
			});
	var licenseTypeData = [["Apache", "Apache License V2.0"],
			["BSD", "BSD License"], ["CC3", "署名-非商业性使用-相同方式共享 3.0"],
			["CPL", "Common Public License"],
			["EPL", "Eclipse Public License"],
			["GPL", "GNU General Public License"],
			["GPLv3", "GNU General Public License version 3.0"],
			["LGPL", "Lesser General Public License"], ["MIT", "MIT License"],
			["MPL", "Mozilla Public License"]];
	var licenseTypeStore = new Ext.data.SimpleStore({
				fields : ['value', 'text'],
				data : licenseTypeData
			});
	// 定义工具栏菜单。右键菜单同此定义
	var fileMenu = [{
				text : '创建',
				iconCls : 'np-create',
				handler : function() {
					createFile();
				}
			}, {
				text : '编辑',
				iconCls : 'np-update',
				handler : function() {
					updateFile();
				}
			}, {
				text : '删除',
				iconCls : 'np-delete',
				handler : function() {
					deleteFile();
				}
			}, '-', {
				text : '发布',
				iconCls : 'np-accept',
				handler : function() {
					updateFileStatus(1);
				}
			}, {
				text : '拒绝',
				iconCls : 'np-reject',
				handler : function() {
					updateFileStatus(2);
				}
			}, {
				text : '锁定',
				iconCls : 'np-lock',
				handler : function() {
					updateFileStatus(3);
				}
			}, {
				text : '隐藏',
				iconCls : 'np-hide',
				handler : function() {
					updateFileStatus(4);
				}
			}, '-', {
				text : '普通',
				iconCls : 'np-common',
				handler : function() {
					updateFileAttr(0);
				}
			}, {
				text : '头条',
				iconCls : 'np-header',
				handler : function() {
					updateFileAttr(1);
				}
			}, {
				text : '幻灯',
				iconCls : 'np-ppt',
				handler : function() {
					updateFileAttr(2);
				}
			}, '-', {
				text : '推荐',
				iconCls : 'np-recommend',
				handler : function() {
					recommend(1);
				}
			}, {
				text : '取消',
				iconCls : 'np-unrecommend',
				handler : function() {
					recommend(0);
				}
			}, '-', {
				text : '置顶',
				iconCls : 'np-tops',
				menu : [{
							text : '取消置顶',
							iconCls : 'np-untop',
							handler : function() {
								top(0);
							}
						}, {
							text : '置顶一天',
							iconCls : 'np-top',
							handler : function() {
								top(1);
							}
						}, {
							text : '置顶二天',
							iconCls : 'np-top',
							handler : function() {
								top(2);
							}
						}, {
							text : '置顶三天',
							iconCls : 'np-top',
							handler : function() {
								top(3);
							}
						}, {
							text : '置顶一周',
							iconCls : 'np-top',
							handler : function() {
								top(7);
							}
						}, {
							text : '置顶一月',
							iconCls : 'np-top',
							handler : function() {
								top(30);
							}
						}, {
							text : '置顶三月',
							iconCls : 'np-top',
							handler : function() {
								top(90);
							}
						}, {
							text : '置顶半年',
							iconCls : 'np-top',
							handler : function() {
								top(180);
							}
						}, {
							text : '置顶一年',
							iconCls : 'np-top',
							handler : function() {
								top(365);
							}
						}]
			}, '-', {
				text : '缩略图',
				iconCls : 'np-thumbnail',
				handler : function() {
					thumbnail();
				}
			}];

	var fileToolbar = new Ext.Toolbar(fileMenu);// 定义文件列表上方的工具栏，载入菜单

	// 定义文件列表的选择模型--单选
	var singleSelectSM = new Ext.grid.CheckboxSelectionModel({
				singleSelect : true
			});

	// 定义文件列表的列模型
	var fileListCM = new Ext.grid.ColumnModel([new Ext.grid.RowNumberer(),
			singleSelectSM, {
				header : '标识',
				dataIndex : 'id',
				hidden : true,
				hideable : false
				// 隐藏列，用于修改删除。
		}	, {
				header : '状态',
				width : .1,
				dataIndex : 'fileStatus',
				renderer : function(value, column, record) {// 显示文件的各种状态
					var fileStatus = record.get('fileStatus');
					var fileAttr = record.get('fileAttr');
					var recommend = record.get('recommend');
					var fileStatusClass = "";
					if (fileStatus == 0) {
						fileStatusClass = "np-nopublish";
					}
					if (fileStatus == 1) {
						fileStatusClass = "np-accept";
					}
					if (fileStatus == 2) {
						fileStatusClass = "np-reject";
					}
					if (fileStatus == 3) {
						fileStatusClass = "np-lock";
					}
					if (fileStatus == 4) {
						fileStatusClass = "np-hide";
					}
					var fileAttrClass = "";
					if (fileAttr == 0) {
						fileAttrClass = "np-common";
					}
					if (fileAttr == 1) {
						fileAttrClass = "np-header";
					}
					if (fileAttr == 2) {
						fileAttrClass = "np-ppt";
					}

					var recommendClass = "";
					if (recommend == 0) {
						recommendClass = "np-unrecommend";
					}
					if (recommend == 1) {
						recommendClass = "np-recommend";
					}

					var fileStatusImg = "<span class='" + fileStatusClass
							+ " width16'></span>";
					var fileAttrImg = "<span class='" + fileAttrClass
							+ " width16'></span>";
					var recommendImg = "<span class='" + recommendClass
							+ " width16'></span>";
					return fileStatusImg + fileAttrImg + recommendImg;
				}
			}, {
				header : '标题',
				width : .5,
				dataIndex : 'title'
			}, {
				header : '缩略图',
				hidden : true,
				dataIndex : 'thumbnail'
			}, {
				header : '大小',
				width : .1,
				dataIndex : 'size'
			}, {
				header : '作者',
				width : .1,
				dataIndex : 'author'
			}, {
				header : '来源',
				width : .1,
				dataIndex : 'source'
			}, {
				header : '发布时间',
				width : .15,
				dataIndex : 'releaseDate',
				type : 'date',
				renderer : function(value) {
					return convertDate(value);// 将毫秒转换为本地日期格式
				}
			}, {
				header : '更新时间',
				width : .15,
				dataIndex : 'updateTime',
				renderer : function(value) {
					return convertTime(value);// 将毫秒转换为本地日期格式
				}
			}]);

	// 定义文件列表的数据来源
	var fileListStore = new Ext.data.JsonStore({
				url : path + '/file.query.do',// 此url返回符合ext grid的json串
				root : 'root',
				fields : ['id', 'title', 'thumbnail', 'size', 'author',
						'source', 'fileStatus', 'fileAttr', 'recommend',
						'releaseDate', 'updateTime'],
				baseParams : {
					folderId : folderId
				}
			});

	fileListStore.load();// 加载文件列表的数据

	// 定义文件列表
	var fileListGP = new Ext.grid.GridPanel({
				id : 'fileListGP',
				region : 'center',
				cm : fileListCM,
				closable : true,
				stripeRows : true,
				loadMask : true,
				loadingText : '加载中...',
				store : fileListStore,
				autoExpandColumn : 'title',
				columnLines : true,
				layout : 'fit',
				viewConfig : {
					forceFit : true
				},
				tbar : fileToolbar,
				bbar : new Ext.PagingToolbar({
							id : 'fileGridPage',
							pageSize : 20,
							store : fileListStore,
							displayInfo : true
						})
			});

	// 给行增加右键菜单
	fileListGP.on("rowcontextmenu", function(grid, rowIndex, e) {
				e.preventDefault();
				if (rowIndex < 0) {
					return;
				}
				var model = grid.getSelectionModel();
				model.selectRow(rowIndex);// 选择某行

				var rightClickMenu = new Ext.menu.Menu({
							items : fileMenu
						});
				rightClickMenu.showAt(e.getXY());// 显示右键菜单
			});

	// 定义创建文件夹弹出窗口
	var fileListWindow = new Ext.Window({
				layout : 'fit',
				title : folderName + '列表',
				width : 900,
				height : 532,
				maximizable : true,
				modal : true,
				resizable : false,
				closeAction : 'close',
				items : [fileListGP]
			});
	fileListWindow.show();

	var fileFormItems = function() {
		return {
			fileId : {
				xtype : 'hidden',
				id : 'id'
			},
			folderId : {
				xtype : 'hidden',
				id : 'folderId',
				value : folderId
			},
			version : {
				xtype : 'textfield',
				id : 'version',
				fieldLabel : '版本',
				width : 200,
				value : '1.0',
				allowBlank : false
			},
			title : {
				xtype : 'textfield',
				id : 'title',
				fieldLabel : '标题',
				allowBlank : false,
				width : 516
			},
			tag : {
				xtype : 'textfield',
				id : 'tag',
				fieldLabel : '标签',
				allowBlank : false,
				width : 516,
				validator : function(value) {
					var v = value.replace("；", ";");
					var tagArray = v.split(";");
					if (tagArray.length < 2) {
						return false;
					}
					return true;
				},
				invalidText : '请至少设置两个标签，用;或；分隔'
			},
			releaseDate : {
				xtype : 'datefield',
				id : 'releaseDate',
				fieldLabel : '发布时间',
				allowBlank : false,
				editable : false,
				width : 200,
				value : new Date()
			},
			author : {
				xtype : 'textfield',
				id : 'author',
				fieldLabel : '作者',
				allowBlank : false,
				width : 200,
				value : '道长A'
			},
			translator : {
				xtype : 'textfield',
				id : 'translator',
				fieldLabel : '译者',
				allowBlank : true,
				width : 200
			},
			language : {
				xtype : 'combo',
				hiddenName : 'language',
				store : languageTypeStore,
				fieldLabel : '语言',
				triggerAction : 'all',
				emptyText : '请选择',
				mode : 'local',
				allowBlank : false,
				editable : false,
				valueField : 'value',
				displayField : 'text',
				selectOnFocus : true
			},
			os : {
				xtype : 'combo',
				forceSelection : true,
				store : osTypeStore,
				hiddenName : "os",
				fieldLabel : '操作系统',
				emptyText : '请选择',
				triggerAction : 'all',
				mode : 'local',
				allowBlank : false,
				editable : false,
				valueField : 'value',
				displayField : 'text',
				selectOnFocus : true
			},
			license : {
				xtype : 'combo',
				hiddenName : 'license',
				store : licenseTypeStore,
				fieldLabel : '许可协议',
				triggerAction : 'all',
				emptyText : '请选择',
				mode : 'local',
				allowBlank : false,
				editable : false,
				valueField : 'value',
				displayField : 'text',
				selectOnFocus : true
			},
			source : {
				xtype : 'textfield',
				id : 'source',
				fieldLabel : '出处',
				allowBlank : false,
				width : 200,
				value : 'AJava'
			},
			sourceUrl : {
				xtype : 'textfield',
				id : 'sourceUrl',
				fieldLabel : '原始地址',
				allowBlank : true,
				width : 516
			},
			viceTitle : {
				xtype : 'textfield',
				id : 'viceTitle',
				fieldLabel : '副标题',
				allowBlank : true,
				width : 516
			},
			excerpt : {
				xtype : 'textarea',
				id : 'excerpt',
				fieldLabel : '摘要',
				allowBlank : false,
				width : 516,
				height : 120
			},
			content : {
				xtype : 'textarea',
				id : 'content',
				fieldLabel : '内容',
				allowBlank : true,
				width : 550
			}
		};
	};

	// 创建额外数据表单项目
	var extraDataItems = function() {
		var extraDataLength = 3;
		var extraData = [];
		extraData[0] = {
			xtype : 'numberfield',
			id : 'accessScore',
			fieldLabel : '所需积分',
			allowBlank : false,
			value : 0,
			allowNegative : false,// 不能输入负数
			allowDecimals : false,
			maxValue : 10000
			// 不能输入小数
		};

		extraData[1] = {
			xtype : 'numberfield',
			id : 'accessCost',
			fieldLabel : '花费积分',
			allowBlank : false,
			value : 0,
			allowNegative : false,// 不能输入负数
			allowDecimals : false,
			maxValue : 100
			// 不能输入小数
		};

		extraData[2] = {
			xtype : 'radiogroup',
			fieldLabel : '回复状态',
			id : 'replyStatusRadio',
			items : [{
						boxLabel : '允许回复',
						inputValue : 1,
						name : 'replyStatus',
						checked : true
					}, {
						boxLabel : '禁止回复',
						name : 'replyStatus',
						inputValue : 0
					}]
		};
		extraData[3] = {
			xtype : 'textfield',
			id : 'size',
			fieldLabel : '文件大小'
		};
		extraData[4] = {
			xtype : 'textarea',
			id : 'url',
			fieldLabel : '下载地址',
			width : 516,
			height : 200
		};

		// 创建自定义的附加数据表单项目
		for (var i = 0; i < fileData.length; i++) {
			extraData[i + 5] = {
				name : fileData[i][0],
				xtype : 'textfield',
				fieldLabel : fileData[i][1],
				allowBlank : fileData[i][2],
				maxLength : fileData[i][3]
			};
		}
		return extraData;
	}
	var ckeditor;
	// 创建文本
	function createFile() {
		var formItems = fileFormItems();
		var extraData = extraDataItems();

		var createFileFP = new Ext.form.FormPanel({
			id : 'createFileForm',
			url : path + '/file.create.do',
			labelAlign : 'right',
			frame : true,
			labelSeparator : '：',
			labelWidth : 80,
			autoHeight : true,
			anchor : '100%',
			items : [{
				xtype : 'tabpanel',
				plain : true,
				activeTab : 0,
				height : 500,
				deferredRender : false,
				defaults : {
					bodyStyle : 'padding:10px'
				},
				items : [{
					title : '基本信息',
					layout : 'form',
					items : [formItems.folderId, formItems.fileId,
							formItems.title, formItems.viceTitle,
							formItems.tag, {
								layout : 'column',
								items : [{
									columnWidth : .5,
									layout : 'form',
									items : [formItems.version,
											formItems.author,
											formItems.translator, formItems.os]
								}, {
									columnWidth : .5,
									layout : 'form',
									items : [formItems.releaseDate,
											formItems.source,
											formItems.language,
											formItems.license]
								}]
							}, formItems.sourceUrl, formItems.excerpt]
				}, {
					cls : 'x-plain',
					title : '主要内容',
					layout : 'fit',
					items : formItems.content
				}, {
					title : '额外信息',
					layout : 'form',
					defaults : {
						width : 230
					},
					items : extraData
				}]
			}],
			buttons : [{
				text : '创建内容',
				iconCls : 'np-accept-32',
				scale : 'medium',
				handler : function() {
					// 将编辑器的数据更新到content中。
					CKEDITOR.instances.content.updateElement();
					if (CKEDITOR.instances.content.getData() == '<p>\u000a\u0009&nbsp;</p>'
							|| CKEDITOR.instances.content.getData().length == 0) {
						showWarn(NPI003);
						return false;
					}
					createFileFP.getForm().submit({
								success : function(form, action) {
									doResponse(form, action, function() {
												// 在grid中增加一行
												// 关闭创建故事窗口
												fileListStore.reload();
												createFileWindow.close();
											});
								}
							});
				}
			}, {
				text : '关闭窗口',
				iconCls : 'np-reject-32',
				scale : 'medium',
				handler : function() {
					createFileWindow.close();
				}
			}]
		});

		// 定义创建文件夹弹出窗口
		var createFileWindow = new Ext.Window({
					layout : 'fit',
					title : '创建内容',
					width : 780,
					modal : true,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [createFileFP]
				});
		createFileWindow.show();
		createFileWindow.on('close', function() {
					CKEDITOR.remove(ckeditor);
				});
		ckeditor = CKEDITOR.replace('content', {
					toolbar : [
							['Source', 'Preview'],
							['Cut', 'Copy', 'Paste', 'PasteText',
									'PasteFromWord'],
							['Undo', 'Redo', '-', 'Find', 'Replace', '-',
									'SelectAll', 'RemoveFormat'],
							['Image', 'Flash', 'Table', 'HorizontalRule',
									'Smiley', 'SpecialChar', 'PageBreak'],
							'/',
							['Bold', 'Italic', 'Underline', 'Strike', '-',
									'Subscript', 'Superscript'],
							['NumberedList', 'BulletedList', '-', 'Outdent',
									'Indent', 'Blockquote', 'CreateDiv'],
							['JustifyLeft', 'JustifyCenter', 'JustifyRight',
									'JustifyBlock'],
							['Link', 'Unlink', 'Anchor'], '/',
							['Styles', 'Format', 'Font', 'FontSize'],
							['TextColor', 'BGColor']],
					height : 330
				});

	}

	// 修改文件
	function updateFile() {
		var fileRecord = fileListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (fileRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var fileId = fileRecord.data.id;// 得到当前行id

		var formItems = fileFormItems();
		var extraData = extraDataItems();
		var updateFileFP = new Ext.form.FormPanel({
			id : 'updateFileForm',
			url : path + '/file.update.do',
			labelAlign : 'right',
			frame : true,
			labelSeparator : '：',
			labelWidth : 80,
			autoHeight : true,
			anchor : '100%',
			items : [{
				xtype : 'tabpanel',
				plain : true,
				activeTab : 0,
				height : 500,
				deferredRender : false,
				defaults : {
					bodyStyle : 'padding:10px'
				},
				items : [{
					title : '基本信息',
					layout : 'form',
					items : [formItems.folderId, formItems.fileId,
							formItems.title, formItems.viceTitle,
							formItems.tag, {
								layout : 'column',
								items : [{
									columnWidth : .5,
									layout : 'form',
									items : [formItems.version,
											formItems.author,
											formItems.translator, formItems.os]
								}, {
									columnWidth : .5,
									layout : 'form',
									items : [formItems.releaseDate,
											formItems.source,
											formItems.language,
											formItems.license]
								}]
							}, formItems.sourceUrl, formItems.excerpt]
				}, {
					cls : 'x-plain',
					title : '主要内容',
					layout : 'fit',
					items : formItems.content
				}, {
					title : '额外信息',
					layout : 'form',
					defaults : {
						width : 230
					},
					items : extraData
				}]
			}],
			buttons : [{
				text : '编辑内容',
				iconCls : 'np-accept-32',
				scale : 'medium',
				handler : function() {
					// 将编辑器的数据更新到content中。
					CKEDITOR.instances.content.updateElement();
					if (CKEDITOR.instances.content.getData() == '<p>\u000a\u0009&nbsp;</p>'
							|| CKEDITOR.instances.content.getData().length == 0) {
						showWarn(NPI003);
						return false;
					}
					updateFileFP.getForm().submit({
								success : function(form, action) {
									doResponse(form, action, function() {
												// 在grid中增加一行
												// 关闭创建故事窗口
												fileListStore.reload();
												updateFileWindow.close();
											});
								}
							});
				}
			}, {
				text : '关闭窗口',
				iconCls : 'np-reject-32',
				scale : 'medium',
				handler : function() {
					updateFileWindow.close();
				}
			}]
		});
		updateFileFP.getForm().load({
			url : path + '/file.read.do',
			params : {
				fileId : fileId
			},
			success : function(form, action) {
				// 加载数据后将发布日期的数据转换为指定格式
				var file = action.result.data;
				CKEDITOR.instances.content.setData(Ext.getCmp('content')
						.getValue());
				Ext.getCmp('releaseDate').setValue(new Date(file.releaseDate));
				Ext.getCmp('replyStatusRadio').setValue(file.replyStatus);
			}
		});
		// 定义编辑文本弹出窗口
		var updateFileWindow = new Ext.Window({
					layout : 'fit',
					title : '编辑内容',
					width : 780,
					modal : true,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [updateFileFP]
				});
		updateFileWindow.show();

		updateFileWindow.on('close', function() {
					CKEDITOR.remove(ckeditor);
				});
		ckeditor = CKEDITOR.replace('content', {
					toolbar : [
							['Source', 'Preview'],
							['Cut', 'Copy', 'Paste', 'PasteText',
									'PasteFromWord'],
							['Undo', 'Redo', '-', 'Find', 'Replace', '-',
									'SelectAll', 'RemoveFormat'],
							['Image', 'Flash', 'Table', 'HorizontalRule',
									'Smiley', 'SpecialChar', 'PageBreak'],
							'/',
							['Bold', 'Italic', 'Underline', 'Strike', '-',
									'Subscript', 'Superscript'],
							['NumberedList', 'BulletedList', '-', 'Outdent',
									'Indent', 'Blockquote', 'CreateDiv'],
							['JustifyLeft', 'JustifyCenter', 'JustifyRight',
									'JustifyBlock'],
							['Link', 'Unlink', 'Anchor'], '/',
							['Styles', 'Format', 'Font', 'FontSize'],
							['TextColor', 'BGColor']],
					height : 330
				});

	}

	// 删除文件
	function deleteFile() {
		var fileRecord = fileListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (fileRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var fileId = fileRecord.data.id;// 得到当前行id

		var btn = Ext.Msg.confirm(NPC001, NPI007, function(btn, text) {
					if (btn == 'yes') {
						Ext.Ajax.request({
									url : path + '/file.delete.do',
									params : {
										fileId : fileId
									},
									success : function(result, request) {
										doAjaxResponse(result, request,
												function() {
													fileListStore.reload();
												});
									}
								});
					}
				});
	}

	/**
	 * 修改文件状态
	 * 
	 * @param fileStatus
	 *            文件状态 1-发布；2-拒绝；3-锁定；4-隐藏
	 * @return 无
	 */
	function updateFileStatus(fileStatus) {
		var fileRecord = fileListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (fileRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var fileId = fileRecord.data.id;// 得到当前行id

		Ext.Ajax.request({
					url : path + '/file.status.do',
					params : {
						fileId : fileId,
						fileStatus : fileStatus
					},
					success : function(result, request) {
						doAjaxResponse(result, request, function() {
									fileListStore.reload();
								});
					}
				});
	}

	/**
	 * 修改推荐状态
	 * 
	 * @param status
	 *            推荐状态 0-不推荐；1-推荐
	 * @return 无
	 */
	function recommend(status) {
		var fileRecord = fileListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (fileRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var fileId = fileRecord.data.id;// 得到当前行id

		Ext.Ajax.request({
					url : path + '/file.recommend.do',
					params : {
						fileId : fileId,
						recommend : status
					},
					success : function(result, request) {
						doAjaxResponse(result, request, function() {
									fileListStore.reload();
								});
					}
				});
	}

	/**
	 * 修改文件属性
	 * 
	 * @param fileAttr
	 *            0-普通；1-幻灯；2-头条
	 * @return 无
	 */
	function updateFileAttr(fileAttr) {
		var fileRecord = fileListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (fileRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var fileId = fileRecord.data.id;// 得到当前行id

		Ext.Ajax.request({
					url : path + '/file.attr.do',
					params : {
						fileId : fileId,
						fileAttr : fileAttr
					},
					success : function(result, request) {
						doAjaxResponse(result, request, function() {
									fileListStore.reload();
								});
					}
				});
	}

	/**
	 * 修改置顶时间
	 * 
	 * @param topTime
	 *            0-取消置顶；1-一天；2-二天；3-三天；7-一周；30-一个月；90-三个月；180-半年；365-一年
	 * @return 无
	 */
	function top(topTime) {
		var fileRecord = fileListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (fileRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var fileId = fileRecord.data.id;// 得到当前行id
		Ext.Ajax.request({
					url : path + '/file.top.do',
					params : {
						fileId : fileId,
						top : topTime
					},
					success : function(result, request) {
						doAjaxResponse(result, request, function() {
									fileListStore.reload();
								});
					}
				});
	}
	function deleteThumbnail() {
		var fileRecord = fileListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (fileRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var fileId = fileRecord.data.id;// 得到当前行id

	}

	// 处理缩略图
	function thumbnail() {
		thumbnailTarget = "file";
		var fileRecord = fileListGP.getSelectionModel().getSelected();// 返回选中的第一行的记录
		if (fileRecord == null) {// 如果没有选择一条记录，则弹出提示
			showWarn(NPI004);
			return;
		}
		var fileId = fileRecord.data.id;// 得到当前行id
		var thumbnail = fileRecord.data.thumbnail;// 得到当前行的缩略图
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
					var record = fileListGP.getSelectionModel().getSelected();
					if (record.data.thumbnail == STORY.DEFAULT_THUMBNAIL) {
						showWarn("这个文件没有设置缩略图。");
						return;
					}
					Ext.Ajax.request({
						url : path + '/thumbnail.delete.do',
						params : {
							id : fileId,
							target : thumbnailTarget
						},
						success : function(result, request) {
							doAjaxResponse(result, request, function() {
								var record = fileListGP.getSelectionModel()
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
			upload_url : path + "/thumbnail.upload.do",// 服务器端处理上传文件的servlet
			file_types : fileTypes,// 允许的文件类型
			file_types_description : "图片文件",// 文件类型的描述
			file_size_limit : fileSizeLimit + " B",// 最大文件尺寸
			file_queue_limit : 0,// 文件队列的大小。0为不限制
			debug : true,// 调试
			post_params : {
				id : fileId,
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