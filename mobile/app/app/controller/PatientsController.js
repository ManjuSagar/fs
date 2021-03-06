/*
 * File: app/controller/PatientsController.js
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

Ext.define('MyApp.controller.PatientsController', {
    extend: 'Ext.app.Controller',

    config: {
        refs: {
            navView: {
                selector: '#nav_view',
                xtype: 'navigationview'
            }
        },

        control: {
            "list#patients_list": {
                itemtap: 'onPatientTap'
            },
            "button#add_routesheet": {
                tap: 'onAddRoutesheet'
            }
        }
    },

    onPatientTap: function(dataview, index, target, record, e, eOpts) {
        MyApp.selectedPatient = record;
        var patientInfo = Ext.create("MyApp.view.PatientInfo", {title: "Patient Info"});
        this.getNavView().push(patientInfo);
        var patientMetaStore = Ext.StoreManager.lookup("PatientMetaStore");
        patientMetaStore.removeAll();

        var map = [["Name", "full_name"], 
        ["Certification Period", "episode"],
        ["Gender", "gender"],
        ["Age", "age"],
        ["Location", "location"],
        ["Phone", "phone_number"]           
        ];

        Ext.each(map, function(item) {
            var metaRecord = Ext.create("MyApp.model.PatientMetadata");
            metaRecord.set("name", item[0]);
            metaRecord.set("value", MyApp.selectedPatient.get(item[1]));
            patientMetaStore.add(metaRecord);               
        });

    },

    onAddRoutesheet: function(button, e, eOpts) {
        var routesheetForm = Ext.create("MyApp.view.RoutesheetForm", {title: "Add Routesheet"});
        var routesheet = Ext.create("MyApp.model.Routesheet");
        var startTime = new Date();
        var endTime = new Date(startTime);
        endTime.setMinutes(startTime.getMinutes() + 60);

        this.visitTypeStore = Ext.StoreManager.lookup("VisitTypeStore");
        this.visitTypeStore.removeAll();
        var visitTypes = MyApp.selectedPatient.get("visit_types").toString();
        console.log(visitTypes);
        if (visitTypes != "") {
            Ext.each(Ext.JSON.decode(visitTypes), function(visit_type) {
                var visitType = new MyApp.model.VisitType();
                visitType.set("id", visit_type[0]);
                visitType.set("description", visit_type[1]);    
                this.visitTypeStore.add(visitType);
            }, this);
        }
        routesheet.set("visit_date", startTime);
        routesheet.set("start_time", startTime);
        routesheet.set("end_time", endTime);
        routesheet.set("patient_id", MyApp.selectedPatient.get("id"));
        routesheet.set("patient_name", MyApp.selectedPatient.get("full_name"));
        routesheet.set("treatment_id", MyApp.selectedPatient.get("treatment_id"));
        routesheet.set("episode_id", MyApp.selectedPatient.get("episode_id"));
        routesheetForm.setRecord(routesheet);

        this.getNavView().push(routesheetForm);
        this.getNavView().down("#save_routesheet").show();

    }

});