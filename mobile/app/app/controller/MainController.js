/*
 * File: app/controller/MainController.js
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

Ext.define('MyApp.controller.MainController', {
    extend: 'Ext.app.Controller',

    config: {
        refs: {
            mainTab: {
                selector: '#main_tab',
                xtype: 'tabpanel'
            },
            navView: {
                selector: '#nav_view',
                xtype: 'Ext.navigation.View'
            }
        },

        control: {
            "#settings": {
                tap: 'onSettingsTap'
            },
            "*": {
                orientationchange: 'onViewportOrientationChange'
            }
        }
    },

    onSettingsTap: function(button, e, eOpts) {
        //var settingsView = Ext.create("MyApp.view.SettingsContainer", {title: "Settings"});
        //this.getNavView().push(settingsView);
        this.getMainTab().setActiveItem(3);
    },

    onViewportOrientationChange: function(viewport, newOrientation, width, height, eOpts) {

    },

    signIn: function(username, password, server_url, success_fn, failure_fn) {
        var me = this;

        Ext.data.JsonP.request({
            url: server_url + '/mobile/authenticate',
            callbackKey: 'callback',
            params: {
                "user[username]":  username,
                "user[password]":  password,
            },
            success: success_fn,
            failure: failure_fn
        });

    },

    onSuccessLoginResponse: function(result) {
        var mainController = MyApp.app.getController("MainController");
        if (result.error) {
            Ext.Msg.alert("Failure", result.error, function() {
                mainController.getMainTab().setActiveItem(4);
            });
        } else {
            mainController.getMainTab().setActiveItem(0);
        }
    },

    onFailureLoginResponse: function(result) {
        Ext.Msg.alert("Error", "Unexpected error occurred.\nPlease try again later.", function () {
            MyApp.app.getController("MainController").getMainTab().setActiveItem(4);
        });

    },

    launch: function() {
        loadSettings();
    }

});