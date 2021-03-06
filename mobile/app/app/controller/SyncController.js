/*
 * File: app/controller/SyncController.js
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

Ext.define('MyApp.controller.SyncController', {
    extend: 'Ext.app.Controller',

    config: {
        refs: {
            syncLabel: {
                selector: '#sync_label',
                xtype: 'Ext.Label'
            }
        },

        control: {
            "button#sync": {
                tap: 'onSync'
            }
        }
    },

    onSync: function(button, e, eOpts) {
        onNetworkCheck(function() {
            Ext.Viewport.setMasked({
                xtype: 'loadmask',
                message: 'Synchronizing...'
            });

            var syncDate = new Date();
            var values = [Ext.Date.format(syncDate, 'g:i A'), Ext.Date.format(syncDate, "F jS, Y")];
            var t = new Ext.Template("Last synchronized at {0},<br/>on {1}");
            this.getSyncLabel().setHtml(t.apply(values));

            var settings = user_settings();
            var username = settings.get("username");
            var password = settings.get("password");
            var url = settings.get("server_url") + "/mobile/sync";


            this.routesheetStore = Ext.StoreManager.lookup("RoutesheetStore");
            var totalRecords = this.routesheetStore.getCount();
            var me = this;
            var syncLog = '';
            Ext.Ajax.request({
                url: '/app/Sync/sync',
                method: 'POST',
                params: {k:'v'},
                failure: function (response) { 
                    console.log(response);
                    Ext.Msg.alert("Sync", "Server is not responding.<br/>Please try again later.");
                    Ext.Viewport.setMasked(false);
                },
                success: function (response, opts) {
                    var jsonResponse = Ext.decode(response.responseText);
                    Ext.each(jsonResponse.success_ids, function(item) {
                        var routesheet = me.routesheetStore.findRecord("id", item);
                        me.routesheetStore.remove(routesheet);	            
                    });
                    me.routesheetStore.sync();		                 
                    Ext.each(jsonResponse.failure_ids, function(item) {
                        var routesheet = me.routesheetStore.findRecord("id", item.routesheet_id);
                        //Assume routesheet record exists...for now!
                        syncLog += "Patient : " + routesheet.get("patient_name") + "<br/>" + item.error_message + "<br/>";
                    });

                    Ext.Viewport.setMasked(false);

                    if (syncLog == '') {
                        Ext.Msg.alert("Success", totalRecords.toString() + " routesheets synced to server.");
                    } else {
                        Ext.Msg.alert("Error", jsonResponse.failure_ids.length.toString() + " routesheets had errors during sync.<br/>" + syncLog);
                        settings.set("latest_sync_log", syncLog);
                        settings.set("last_sync_time", new Date());
                        var settingsController = MyApp.app.getController("SettingsController");
                        settingsController.updateUserSetting(settings);
                    }
                }
            });
        }, function() {
            Ext.Msg.alert("Error", "Internet connection not available.<br/>Please try again later.");
        }, this);

    }

});