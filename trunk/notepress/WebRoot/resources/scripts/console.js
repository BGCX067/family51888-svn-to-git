Ext.onReady(function() {
	var loadMask = new Ext.LoadMask(Ext.getBody(), {
				msg : '操作进行中...'
			});
	Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
	var IFrameComponent = Ext.extend(Ext.BoxComponent, {
				onRender : function(ct, position) {
					this.el = ct.createChild({
								tag : 'iframe',
								id : this.id,
								name : this.name,
								frameBorder : 0,
								src : this.url
							});
				}
			});

	// 北部面板-LOGO信息
	var northPanel = new Ext.BoxComponent({
		region : 'north',
		height : 60,
		autoEl : {
			tag : 'div',
			html : '<img src="'+path+'/resources/images/logo.png" /><p>NotePress网站管理系统，是一款采用Java+MySql开发，基于ExtJs 3.X UI的免费产品。</p>'
		}
	});

	// 南部面板-版权信息
	var southPanel = {
		region : 'south',
		split : true,
		height : 100,
		minSize : 100,
		maxSize : 200,
		collapsible : true,
		title : '版权',
		margins : '0 0 0 0'
	}

	// 中部面板--主工作区
	var centerPanel = new Ext.TabPanel({
				region : 'center',
				deferredRender : false,
				activeTab : 0,
				enableTabScroll : true,
				defaults : {
					autoScroll : true
				},
				plugins : new Ext.ux.TabCloseMenu(),
				items : [{
							contentEl : 'welcomeTabPanel',
							title : '欢迎',
							autoScroll : true
						}]
			});

	// 点击西部面板中的菜单，在主工作区中增加一个Tab
	function addTab(text, url) {

		// 是否存在相同的Tab，通过Tab的title来判断
		var isExistSameTab = false;
		var count = centerPanel.items.getCount();

		for (var i = 0; i < count; ++i) {
			if (text == centerPanel.items.get(i).title) {
				isExistSameTab = true;
				centerPanel.activate(centerPanel.items.get(i));
				break;
			}
		}

		// 循环所有面板，如果已存在相同的面板，则将isExistSameTab设置为true

		// 如果不存在相同的Tab，则增加Tab；否则，激活这个Tab
		if (!isExistSameTab) {
			var centerFrame = new IFrameComponent({
						border : false,
						region : 'center',
						title : text,
						closable : true,
						url : url
					});
			centerPanel.add(centerFrame).show();
		}
	}
	// 会员控制面板菜单
	var memberMenuItems = [];
	// 循环会员菜单数组，产生按钮菜单
	for (var i = 0; i < memberMenuArray.length; i++) {
		memberMenuItems[i] = {
			xtype : 'button',
			text : memberMenuArray[i][0],
			flex : 1,
			margins : '5 0 5 0',
			url : memberMenuArray[i][1],// 此属性是自定义的
			handler : function() {
				addTab(this.text, this.url);
			}
		}
	}
	
	// 西部面板
	var westPanel = {
		region : 'west',
		title : '控制面板',
		split : true,
		width : 200,
		minSize : 175,
		maxSize : 400,
		collapsible : true,
		margins : '0 0 0 5',
		layout : {
			type : 'accordion',
			animate : true
		},
		// 手风琴
		items : [{
					contentEl : 'west',
					title : '会员面板',
					border : false,
					layout : {
						type : 'vbox',
						padding : '5',
						align : 'stretch'
					},
					defaults : {
						margins : '0 0 5 0'
					},
					items : memberMenuItems
				}]
	}
	var viewport = new Ext.Viewport({
				layout : 'border',
				items : [westPanel, centerPanel]
			});
	
});
