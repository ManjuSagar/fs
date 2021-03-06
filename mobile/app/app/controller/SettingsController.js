/*
 * File: app/controller/SettingsController.js
 *
 * This file was generated by Sencha Architect version 2.2.2.
 * http://www.sencha.com/products/architect/
 *
 * This file requires use of the Sencha Touch 2.0.x library, under independent license.
 * License of Sencha Architect does not include license for Sencha Touch 2.0.x. For more
 * details see http://www.sencha.com/license or contact license@sencha.com.
 *
 * This file will be auto-generated each and everytime you save your project.
 *
 * Do NOT hand edit this file.
 */

Ext.define('MyApp.controller.SettingsController', {
    extend: 'Ext.app.Controller',

    config: {
        refs: {
            mainTab: {
                selector: '#main_tab',
                xtype: 'tabpanel'
            }
        },

        control: {
            "#sign_in": {
                tap: 'onSignIn'
            },
            "#settings_form": {
                painted: 'onFormpanelPainted'
            }
        }
    },

    onSignIn: function(button, e, eOpts) {
        this.routesheetStore = Ext.StoreManager.lookup("RoutesheetStore");
        var data = button.getParent().getParent().down("#settings_form").getValues();
        var totalRoutesheets = this.routesheetStore.getCount();
        if ( totalRoutesheets > 0) {
            Ext.Msg.confirm("Warning", 
            "There are " + totalRoutesheets.toString() + " routesheet(s) that are yet to be synced to server.<br/>Do you want to delete and continue?", function(btn) {
                if(btn == 'no') {
                    return;
                } else {
                    this.routesheetStore.removeAll();
                    this.routesheetStore.sync();
                    this.saveSettings(data);
                }

            }, this);
        } else {
            this.saveSettings(data);
        }

    },

    onFormpanelPainted: function(component, eOpts) {
        var settingStore = Ext.StoreManager.lookup("SettingStore");
        if (settingStore.getCount() > 0) {
            var data = settingStore.getAt(0).data;
            component.setValues(data);
        } else {
            this.getMainTab().getTabBar().hide();
        }
    },

    onSaveSuccess: function(result) {
        Ext.Viewport.setMasked(false);
        var mainController = MyApp.app.getController("MainController");

        var data = mainController.getMainTab().getActiveItem().down("#settings_form").getValues();
        var settings = Ext.create("MyApp.model.Settings");
        settings.setData(data);
        var settingsController = MyApp.app.getController("SettingsController");
        settingsController.updateUserSetting(settings);

        //Set the data version to null so that the data refresh is enforced.
        data_version = null;
        refreshDataIfRequired();
        mainController.onSuccessLoginResponse(result);

        mainController.getMainTab().getTabBar().show();
    },

    onSaveFailure: function(result) {
        Ext.Viewport.setMasked(false);
        var mainController = MyApp.app.getController("MainController");
        mainController.onFailureLoginResponse(result);
    },

    updateUserSetting: function(settingsInstance) {
        settingsInstance.set("id",1);
        var settingStore = Ext.StoreManager.lookup("SettingStore");
        settingStore.removeAll();
        settingStore.add(settingsInstance);
        settingStore.sync();
    },

    saveSettings: function(data) {
        var username = data.username;
        var password = data.password;
        var store_number = data.store_number;
        var server_url = data.server_url;

        var mainController = MyApp.app.getController("MainController");

        Ext.Viewport.setMasked({
            xtype: 'loadmask',
            message: 'Saving...'
        });

        mainController.signIn(username, password, server_url, this.onSaveSuccess, this.onSaveFailure);

    }

});