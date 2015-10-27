/**
 * Created by msuser1 on 10/12/14.
 */

function onDocumentApprove(component) {
    component.approveDocument({}, function(res){
        if(res == false){
            var msg = "ROC HIPPS Code is not same as RC HIPPS Code. Discharge the Patient."
            Ext.MessageBox.alert("<b><i>Warning:</i></b>", msg);
        }else {
            var grid = Ext.ComponentQuery.query("#" + component.gridItemId)[0];
            grid.store.load();
            component.up("window").close();
        }
    }, component);
}

function onDocumentEdit(editAction, approveAction, ok, component) {
     var fieldSignNotRequired = component.down("#field_signature_not_required");
     var superVisoryVisitdoc = Ext.ComponentQuery.query('#super_visory_visits_id')[0];
     var msg = "Editing this document will delete all field staff signature(s). The field staff(s) will need to re-sign"
     msg += " the document in order for the signature(s) to appear on the printed document. Do you still want to edit this document?"
     
    if (superVisoryVisitdoc){
        changeDocStatus(editAction, approveAction, ok, false, component);
    }
    else if (fieldSignNotRequired.value) {
        changeDocStatus(editAction, approveAction, ok, true, component);
    }
    else {
        Ext.MessageBox.confirm("<b><i>Warning:</i></b>", msg, function(btn){
            if(btn == "yes" || btn == "ok"){
                changeDocStatus(editAction, approveAction, false, false, component);
            }
        }, component);
    }
}

function changeDocStatus(editAction, approveAction, ok, changeOkText, component) {
    editAction.hide();
    approveAction.hide();
    if ( changeOkText ) {
        ok.setText("Submit for QA");
        var window = component.up('window');
        window.actions.saveDraft.show();
    }
    component.changeDocumentStatusToDraft({}, function(){
        var form = component.up('form');
        var container = component.up('window');
        var grid = Ext.ComponentQuery.query("#" + component.gridItemId)[0];
        grid.store.load();
        component.loadNetzkeComponent({name: 'add_document', params: {}, container: container,
            callback: function() {
            }, scope: component
        });
    }, component);
}

function onPrint(component) {
    if(component.isDirty()) {
        Ext.MessageBox.confirm("Confirmation", "Do you want to save the changes and print?", function(btn){
            if(btn == "yes"){
                component.saveAndPrint = true;
                component.onApply({draft_save: true});
            } else
                component.viewReport({record_id: component.record.id});
        }, component);
    }
    else
        component.viewReport({record_id: component.record.id});

}

function launchDocumentReport(reportOptions) {
    var reportUrl = reportOptions[0];
    reportUrl = window.location.protocol + "//" + window.location.host + reportUrl;
    var reportTitle = reportOptions[1];
    if (Ext.isGecko) {
        window.location = reportUrl;
    } else {
        Ext.create('Ext.window.Window', {
            width : 800,
            height: 600,
            layout : 'fit',
            title : reportTitle,
            items : [{
                xtype : "component",
                id: 'myIframe',
                autoEl : {
                    tag : "iframe",
                    href : ""
                }
            }]
        }).show();

        Ext.getDom('myIframe').src = reportUrl;
    }
}

function onAfterRender(component) {
    freeFormTemplateWindowEvents(component);
    component.setLoading(true);
    var comboBoxes = component.query("netzkeremotecombo");
    Ext.each(comboBoxes, function(comboField, index){
        comboField.triggerAction = 'query';
        if(comboField.value){
            comboField.store.load({params: {query: comboField.value}});
            comboField.setValue(comboField.value);
        }
    }, component);
    component.setLoading(false);
    component.setContext({document_id: component.record.id});

    var medications = Ext.ComponentQuery.query('#view_medications')[0];
    if(medications){
        medications.on('click', function(){
            component.onMedicationsClick();
            });
    }

    var orders = Ext.ComponentQuery.query('#view_orders')[0];
    if(orders){
        orders.on('click', function(){
            component.onViewOrders();
        });
    }

    var g = Ext.ComponentQuery.query('#correction_request')[0];
    if(g){
        if(g.events.click.isEvent == undefined) {
            g.on('click', function(){

                var w = new Ext.window.Window({
                    width: 300,
                    height: 370,
                    bbar: false,
                    fbar: false,
                    modal: true,
                    border: false,
                    layout:'fit',
                    title: "Correction Request",
                    itemId: 'correction_request_window',
                    buttons: false,
                    modal: false,
                    alwaysOnTop: true
                });
                w.show();
                w.setPosition(800, 80);
                component.loadNetzkeComponent({name: "document_notes", params: {component_params: {document_id: component.record.id}}, container:w, callback: function(w){
                    w.show();
                }});
            },component);
        }
    }

    var window = component.up('window');
    window.on('close', function(){
        var crWindow = Ext.ComponentQuery.query("#correction_request_window")[0];
        if(crWindow) crWindow.close();
    }, component);


    var gem = Ext.ComponentQuery.query('#gem')[0];
    if(gem){
      if(gem.events.click.isEvent == undefined) {
        component.displayGemWindow(gem, component, component.record.id);
      }
    }

    var window = component.up('window');
    window.on('close', function(){
        var gemWindow = Ext.ComponentQuery.query("#gem_window")[0];
        if(gemWindow) gemWindow.close();
    }, component);
}


function documentOnApply(params, component) {
    var superMain = component.down('#super_main');
    var validateAll = component.down('#validate_all');
    var draftSave = params.draft_save;
    var fieldSignNotRequierd = component.down("#field_signature_not_required");
    if (fieldSignNotRequierd && fieldSignNotRequierd.value){
        if(superMain && typeof(superMain.onValidateAll == "function") && draftSave == undefined) {
            superMain.validateIndividualPanels(true);
        } else {
            applyChanges(draftSave, "Your record has been saved.", component);
        }
    } else {
        applyChanges(draftSave, "Your record has been saved.", component);
    }
}

function applyChanges(draftSave, msg, component) {
    if (component.fireEvent('apply', component)) {
        //While editing form and saving changed fields: some fields are disabled then those fields are not sent to server side.
        //To send those fields to server side we used this temporary patch
        //Enabling disabled fields
        //Begin
        var disabledFields = [];
        Ext.each(component.getForm().getFields().items, function(field, index){
            if(field.disabled){
                disabledFields.push(field);
                field.setDisabled(false);
            }
        }, component);
        //End
        var values = component.getForm().getValues();
        //Manually deleted combo box not taking current value issue.
        Ext.each(component.query('combo'), function(field, index){
            if(values[field.name] == null){
                values[field.name] = null;
            }
        }, component);
        //For radio field: value is not selected then getValues() not added that field.
        //So using this we are adding radiofield value as null
        //Begin
        Ext.each(disabledFields, function(field, index){
            if(field.xtype == "radiofield" && values[field.name] == null){
                values[field.name] = null;
            }else if(field.xtype == "radiogroup"){
                var radio = field.down('radiofield')
                if(radio) values[radio.name] = radio.getGroupValue();
            }else if((field.xtype == 'netzkeremotecombo' || field.xtype == 'combo') && values[field.name] == null){
                values[field.name] = null;
            }
        }, component);
        //End

        for (var fieldName in values) {
            var field = component.getForm().findField(fieldName);

            // TODO: move the following checks to the server side (through the :display_only option)

            // do not submit values from disabled fields
            if (!field || field.disabled) {
                delete values[fieldName];
            }

            // do not submit values from read-only association fields
            if (field
                && field.name.indexOf("__") !== -1
                && (field.readOnly || !field.isXType('combobox'))
                && (!field.nestedAttribute) // except for "nested attributes"
                ) {
                delete values[fieldName];
            }

            // do not submit values from displayfields
            if (field.isXType('displayfield')) {
                delete values[fieldName];
            }

            // do not submit displayOnly fields
            if (field.displayOnly) {
                delete values[fieldName];
            }
        }
        if(component.signDateAndPasswordRequired){
            var w = component.up('window');
            var date = w.down('#sign_date');
            var password = w.down('#sign_password');
            values["signature_date"] = date.value;
            values["sign_password"] = password.value;
        }
        // WIP: commented out on 2011-05-11 because of fatal errors
        // apply mask
        // if (!this.applyMaskCmp) this.applyMaskCmp = new Ext.LoadMask(this.bwrap, this.applyMask);
        // this.applyMaskCmp.show();
        values["draft_save"] = (draftSave == true);
        // We must use a different approach when the form is multipart, as we can't use the endpoint
        if (component.fileUpload) {
            component.getForm().submit({ // normal submit
                url: component.endpointUrl("netzke_submit"),
                params: {
                    data: Ext.encode(values) // here are the correct values that may be different from display values
                },
                failure: function(form, action){
                    try {
                        var respObj = Ext.decode(action.response.responseText);
                        delete respObj.success;
                        component.bulkExecute(respObj);
                        component.fireEvent('submitsuccess');
                        //Disabling fields: Those fields are disabled in form.
                        //Begin
                        Ext.each(disabledFields, function(field, index){
                            field.setDisabled(true);
                        }, component);
                        //End
                    }
                    catch(e) {
                        Ext.Msg.alert('File upload error', action.response.responseText);
                    }
                    if (component.applyMaskCmp) component.applyMaskCmp.hide();
                },
                success: function(form, action) {
                    try {
                        var respObj = Ext.decode(action.response.responseText);
                        delete respObj.success;
                        component.bulkExecute(respObj);
                        component.fireEvent('submitsuccess');
                    }
                    catch(e) {
                        Ext.Msg.alert('File upload error', action.response.responseText);
                    }
                    if (component.applyMaskCmp) component.applyMaskCmp.hide();
                },
                scope: component
            });
        } else {
            component.netzkeSubmit(Ext.apply((component.baseParams || {}), {data:Ext.encode(values)}), function(success){
                // For visit form success value is returning object, so temporarily we checking success == true

                if (success == true) {
                    if (component.mode == "lockable") component.setReadonlyMode(true);
                    if(component.saveAndPrint) {
                        component.saveAndPrint = false;
                        component.viewReport({record_id: component.record.id});
                    } else if (component.notifyOnSave == undefined || component.notifyOnSave == true) {
                        Ext.MessageBox.alert("Success", msg, function(){
                            component.fireEvent("submitsuccess");
                        }, component);
                    } else {
                        component.fireEvent("submitsuccess");
                    }
                }else{
                    //Disabling fields: Those fields are disabled in form.
                    //Begin
                    Ext.each(disabledFields, function(field, index){
                        field.setDisabled(true);
                    }, component);
                    //End
                };
                if (component.applyMaskCmp) component.applyMaskCmp.hide();
            }, component);
        }
    }
    component.fireEvent('afterApply', component);
}

