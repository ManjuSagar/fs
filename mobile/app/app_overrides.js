
timer = null;
callback_function = null;
data_version = null;

function user_settings() {
	var setting = Ext.StoreManager.lookup("SettingStore");
	if (setting.getCount() > 0) {
		return setting.getAt(0);
	}
}

function storesToBeLoadedFromServer(){
	return ["Patient"];
}

function checkIfStoresLoaded() {
	var all_stores = storesToBeLoadedFromServer();
	for(var i=0;i<all_stores.length;i++) {
		var store = Ext.data.StoreManager.lookup(all_stores[i] + 'Store');
		if (store.isLoaded() == false) {
			return false;
		}
	}
	clearInterval(timer);
	if (callback_function)
		callback_function();
	Ext.Viewport.setMasked(false);
	return true;
}

function applyPermissions() {
	var roles = user_settings().get("roles");
	var mainController = MyApp.app.getController("MainController");
	if (roles.indexOf("view_sales_history") > -1)
		mainController.getMainTab().getTabBar().getAt(1).show();
	else
		mainController.getMainTab().getTabBar().getAt(1).hide();

	if (roles.indexOf("change_price") > -1) {
			mainController.getMainTab().getTabBar().getAt(2).show();
			mainController.getMainTab().getTabBar().getAt(3).show();
	} else {
			mainController.getMainTab().getTabBar().getAt(2).hide();
			mainController.getMainTab().getTabBar().getAt(3).hide();
	}
}

function activateApp() {
	loadSettings();
}

function updateVersionInfo() {
	//BUILD_VERSION=1;
	var version_text = "Copyright © 2013 FasterNotes v" + BUILD_VERSION;
	MyApp.app.getController("MainController").getMainTab().down("#version_info").setHtml(version_text);
}

function loadSettings() {
	var setting = Ext.StoreManager.lookup("SettingStore");
	setting.loaded = false;
	setting.load();
}

function instantiateHistoryItemStoreIfRequired() {
	if (Ext.StoreManager.lookup("HistoryItemStore") == null) {
		Ext.StoreManager.register(new MyApp.store.ItemStore({storeId:"HistoryItemStore"}));
	}
}

function onNetworkCheck(success_function, failure_function, scope) {
	Ext.Ajax.request({
		url: '/app/Main/check_network',
	    method: 'GET',
	    failure: function (response) {},
	    success: function (response, opts) {
	    	if (response.responseText == "true") {
		    	if (success_function)
		    		success_function.call(scope);
		    } else {
		    	if (failure_function)
		    		failure_function.call(scope);
		    }
	    }
	});
}

function refreshDataIfRequired(callback_func) {
		var settings = user_settings();
		if (settings == null) {
			MyApp.app.getController("MainController").getMainTab().setActiveItem(4);		
			return;
		}
//		instantiateHistoryItemStoreIfRequired();
		//applyPermissions();
		updateVersionInfo();

	var url = settings.get("server_url") + "/mobile/version";
		Ext.data.JsonP.request({
			params: {username: settings.get("username"), password: settings.get("password")},
      url:  url,
			callbackKey: 'callback',
			success: function(result) {
				if(data_version != result.version) {
					data_version = result.version;
					refresh_stores(callback_func);
				}
			},
			failure: function(result) {
		        var errorMsg = "Unexpected error occurred.\nPlease try again later.";
		        if (result.error !== undefined ) {
					errorMsg = result.error;
				}
				Ext.Msg.alert("Error", errorMsg);
			}
	});
}

function refresh_stores(callback_func) {
	Ext.Viewport.setMasked({
			xtype: 'loadmask',
			message: 'Signing in...'
	});
	callback_function = callback_func;
	timer = setInterval("checkIfStoresLoaded()", 100);
	var all_stores = storesToBeLoadedFromServer();
	console.log(all_stores.length);
	for(var i=0;i<all_stores.length;i++) {		
		var store = Ext.data.StoreManager.lookup(all_stores[i] + 'Store');
		if (user_settings()) {
			store.loaded = false;
			configure_server_url_and_params(store);
			store.load();
		}
	}
	
}

function configure_server_url_and_params(store) {
	var settings = user_settings();
	if (settings) {
		var service_path = store.getProxy().config.service_url_path;
		clearExtraParams(store);
		url = settings.get("server_url") + service_path
		store.getProxy().setUrl(url);
		store.getProxy().setExtraParam("username", settings.get("username"));
		store.getProxy().setExtraParam("password", settings.get("password"));
	}
}

function scan_upc_callback(upc_code) {
	var settings = user_settings();
	if ((settings.get("scan_upc_default_function") === 'I') && 
		(settings.get("roles").indexOf("view_sales_history") > -1)) {
		show_sales_history_view_with_upc(upc_code);
	} else {
		show_edit_view_with_upc(upc_code);
	}
}

function show_sales_history_view_with_upc(upc_code) {
	  var store = Ext.StoreManager.lookup("ItemMetadataStore");
    configure_store_url_and_params(store);
    store.getProxy().setExtraParam("upc_code", upc_code);

		Ext.Viewport.setMasked({
				xtype: 'loadmask',
				message: 'Searching...'
		});

		store.on("load", show_sales_history_view);
		store.load();
}

function show_edit_view_with_upc(upc_code) {
		var store = Ext.StoreManager.lookup("ItemStore");
		configure_store_url_and_params(store)
		store.getProxy().setExtraParam("upc_code", upc_code);

		Ext.Viewport.setMasked({
				xtype: 'loadmask',
				message: 'Searching...'
		});
		store.on("load", show_edit_item_view);
		store.load();
}

function show_sales_history_view() {
		Ext.Viewport.setMasked(false);
		var store = Ext.StoreManager.lookup("ItemMetadataStore");
		store.removeListener("load", show_sales_history_view);
		var navView = MyApp.app.getController("MainController").getMainTab().down("#scan_nav_view");
		var count = store.getCount();
		if (count > 0) {
			var view = Ext.create("MyApp.view.SalesHistoryContainer", {title: "Item Details"});
			navView.push(view);					
			navView.getNavigationBar().getBackButton().hide();
			navView.down("#scan_upc").show();
			navView.down("#change_price").hide();
		} else {
			Ext.Msg.alert("Error", "Item not found!.\n Please try again.", 
				function () {
					scan_bar_code();
				}
			);
		}
}

function show_edit_item_view() {
		Ext.Viewport.setMasked(false);
		var store = Ext.StoreManager.lookup("ItemStore");
		store.removeListener("load", show_edit_item_view);
		var navView = MyApp.app.getController("MainController").getMainTab().down("#scan_nav_view");
		var items_count = store.getCount();
		if (items_count > 0) {
			var record = store.getAt(0);
			var view = Ext.create("MyApp.view.ItemContainer", {title: "Item Details"});
			var editprice_form = view.down("#item_form");
			editprice_form.setRecord(record);
			var settings = user_settings();
			if (settings.get("competitor_info_id")) {
				editprice_form.setValues({competitor_info_id: settings.get("competitor_info_id")});
			}
			navView.push(view);					
			navView.getNavigationBar().getBackButton().hide();
			navView.down("#scan_upc").show();
			navView.down("#change_price").show();
		} else {
			Ext.Msg.alert("Error", "Item not found!.\n Please try again.", 
				function () {
					scan_bar_code();
				}
			);
		}
}

function scan_bar_code() {
	MyApp.app.getController("MainController").getMainTab().down("#scan_nav_view").down("#scan_upc").hide();
	Ext.Ajax.request({
			url: "/app/Barcode/scan_barcode",
			callback: function(response) {
			//console.log(response.responseText);
			}
	});
}

function clearExtraParams(store) {
	var extraParams = store.getProxy().getExtraParams();
	Ext.iterate(extraParams, function(key, value) {
		delete extraParams[key];
	});
}