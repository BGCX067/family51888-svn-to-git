Ext.onReady(function() {
	Ext.QuickTips.init();

	// ==========================开始栏目列表==========================//

	// 定义tree
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
				id : '0'
			});
	tree.setRootNode(root);

	// 在viewport中显示tree
	var viewport = new Ext.Viewport({
				layout : 'fit',
				items : [tree]
			});
	// 给tree增加右键事件
	tree.on('contextmenu', treeContextHandler);

	// 定义右键菜单
	var contextMenu = new Ext.menu.Menu({
				items : [{
							itemId : 'create',
							text : '增加子栏目',
							iconCls : 'np-create',
							handler : createCategory
						}, '-', {
							itemId : 'update',
							text : '编辑栏目',
							iconCls : 'np-update',
							handler : updateCategory
						}, {
							itemId : 'delete',
							text : '删除栏目',
							iconCls : 'np-delete',
							handler : deleteCategory
						}]
			});

	// 显示右键菜单
	function treeContextHandler(node, e) {
		node.select();// 选中当前行
		// 在当前行的锚点显示菜单
		// contextMenu.show(node.ui.getAnchor());
		// 在鼠标的位置显示菜单
		contextMenu.showAt(e.getXY());
		if (node.getDepth() <= 1) {
			contextMenu.getComponent('update').disable();
			contextMenu.getComponent('delete').disable();
		} else {
			contextMenu.getComponent('update').enable();
			contextMenu.getComponent('delete').enable();
		}
	}
	// ==========================结束栏目列表==========================//

	// ==========================开始表单项目==========================//

	// 定义故事表单项目
	var categoryFormItems = function() {

		return {
			categoryId : {
				xtype : 'hidden',
				id : 'id',
				fieldLabel : '栏目ID'
			},
			categoryParentId : {
				xtype : 'hidden',
				id : 'categoryParentId',
				fieldLabel : '父栏目ID'
			},
			categoryName : {
				xtype : 'textfield',
				id : 'categoryName',
				fieldLabel : '栏目名称',
				allowBlank : false,
				width : 200
			},
			categorySort : {
				xtype : 'numberfield',
				id : 'categorySort',
				fieldLabel : '栏目顺序',
				allowBlank : false,
				value : 0
			}
		};
	}

	// ==========================结束表单项目==========================//

	// 创建子栏目
	function createCategory() {
		// 获取当前栏目的id
		var currentNode = tree.getSelectionModel().getSelectedNode()

		var parentId = currentNode.id;
		// 得到表单项目
		var formItems = categoryFormItems();
		formItems.categoryParentId.value = parentId;
		var createCategoryFP = new Ext.form.FormPanel({
			id : 'createCategoryForm',
			labelAlign : 'right',
			url : path + '/category.create.do',
			frame : true,
			labelSeparator : '：',
			labelWidth : 80,
			autoHeight : true,
			anchor : '100%',
			items : [formItems.categoryId, formItems.categoryParentId,
					formItems.categoryName, formItems.categorySort],
			buttons : [{
				text : '创建栏目',
				iconCls : 'np-accept-32',
				scale : 'medium',
				handler : function() {
					createCategoryFP.getForm().submit({
						success : function(form, action) {
							doResponse(form, action, function() {

								// 在tree中增加一个节点
								var newNode = new Ext.tree.AsyncTreeNode({
											id : action.result.data.id,
											text : action.result.data.categoryName,
											draggable : false,
											leaf : true,
											iconCls : 'np-column-file'
										});

								currentNode.appendChild(newNode);
								// 如果当前节点没有展开，则展开它
								if (!currentNode.isExpanded()) {
									currentNode.expand();
								}
								// 如果当前节点是叶子，则将其图标改为非叶子
								if (currentNode.isLeaf()) {
									currentNode.leaf = false;
									currentNode.getUI().getIconEl().src = path
											+ '/resources/icons/silk/style_add.png';
								}
								// 关闭创建栏目窗口
								createCategoryWindow.close();
							})
						}
					});
				}
			}, {
				text : '关闭窗口',
				iconCls : 'np-reject-32',
				scale : 'medium',
				handler : function() {
					createCategoryWindow.close();
				}
			}]
		});
		// 定义创建栏目弹出窗口
		var createCategoryWindow = new Ext.Window({
					layout : 'fit',
					title : '创建栏目',
					width : 400,
					modal : true,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [createCategoryFP]
				});
		createCategoryWindow.show();
	}
	function updateCategory() {
		// 获取当前栏目的id
		var currentNode = tree.getSelectionModel().getSelectedNode()

		var categoryId = currentNode.id;
		// 得到表单项目
		var formItems = categoryFormItems();
		var updateCategoryFP = new Ext.form.FormPanel({
					id : 'updateCategoryForm',
					labelAlign : 'right',
					url : path + '/category.update.do',
					frame : true,
					labelSeparator : '：',
					labelWidth : 80,
					autoHeight : true,
					anchor : '100%',
					items : [formItems.categoryId, formItems.categoryName,
							formItems.categorySort],
					buttons : [{
						text : '保存栏目',
						iconCls : 'np-accept-32',
						scale : 'medium',
						handler : function() {
							updateCategoryFP.getForm().submit({
								success : function(form, action) {
									// 参数form的类型是BasicForm，不是FormPanel
									doResponse(form, action, function() {

												// 也可以通过Ext.getCmp('updateCategoryForm').findById('categoryName').getValue()取字段的值。
												// 设置节点文本
												currentNode
														.setText(form
																.findField('categoryName')
																.getValue());
												// 关闭编辑栏目窗口，此代码需在form.findField('')的前面，因为窗口关闭后，相应的FormPanel也将被销毁
												// ，所以会得到一个空的对象。
												updateCategoryWindow.close();
											})
								}
							});
						}
					}, {
						text : '关闭窗口',
						iconCls : 'np-reject-32',
						scale : 'medium',
						handler : function() {
							updateCategoryWindow.close();
						}
					}]
				});

		updateCategoryFP.getForm().load({
					url : path + '/category.read.do',
					params : {
						categoryId : categoryId
					}
				});
		// 定义编辑栏目弹出窗口
		var updateCategoryWindow = new Ext.Window({
					layout : 'fit',
					title : '编辑栏目',
					width : 400,
					modal : true,
					resizable : false,
					closeAction : 'close',
					buttonAlign : 'center',
					items : [updateCategoryFP]
				});
		updateCategoryWindow.show();
	}
	function deleteCategory() {
		// 获取当前栏目的id
		var currentNode = tree.getSelectionModel().getSelectedNode()

		var categoryId = currentNode.id;
		var btn = Ext.Msg.confirm(NPC001, NPI001, function(btn, text) {
					if (btn == 'yes') {
						// 如果没有子节点，则可以删除
						if (!currentNode.hasChildNodes()) {

							// 发送删除请求和参数
							Ext.Ajax.request({
										url : path + '/category.delete.do',
										params : {
											categoryId : categoryId
										},
										success : function(result, request) {
											doAjaxResponse(result, request,
													function() {
														// 删除此节点
														currentNode.remove();
													})
										}
									});
						} else {
							// 如果还有子节点，则不能删除
							Ext.Msg.show({
										title : NPC001,
										msg : NPE001,
										icon : Ext.Msg.ERROR,
										buttons : Ext.Msg.OK
									});
						}
					} else {

					}
				});

	}

});