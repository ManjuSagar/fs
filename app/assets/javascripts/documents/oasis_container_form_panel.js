/**
 * Created by msuser1 on 10/12/14.
 */

function registerOasisFormEvents(component) {
    var super_main = Ext.ComponentQuery.query("#super_main")[0];
    var window = super_main.up('window');
    component.title = window.title;
    if(component.correctionNumber != false)
        component.title = component.title + " Correction: " + component.correctionNumber + " ";
    window.down("#card-prev").on("click", function() {            
            window.down("#item_chooser").select(comboPreviousItem(window.down("#item_chooser")));
            window.down("#item_chooser").fireEvent('select', window.down("#item_chooser"));

    }, component);
    window.down("#card-next").on("click", function() {
            var res = window.down("#item_chooser").getRawValue();
            if (component.asstDateConditionRequired && window.down("#item_chooser").getValue() > 2){
                var assessmentDate = Ext.ComponentQuery.query("[name=m0090_info_completed_dt]")[0];
                if(assessmentDate.value == null || assessmentDate.value == "" || assessmentDate.isValid() == false) {
                    window.down("#item_chooser").select(window.down("#item_chooser").store.getAt(2));
                    Ext.MessageBox.alert("Message", "Please enter the assessment completed date in 'M0090'.");
                }    else {
                    window.down("#item_chooser").select(comboNextItem(window.down("#item_chooser")));
                    window.down("#item_chooser").fireEvent('select', window.down("#item_chooser"));
                }
            }else {

                window.down("#item_chooser").select(comboNextItem(window.down("#item_chooser")));
                window.down("#item_chooser").fireEvent('select', window.down("#item_chooser"));
            }
    }, component);
    window.down("#item_chooser").on("select", function(cmb){
            dummyRequest();
            var res = window.down("#item_chooser").getRawValue();
            if (component.asstDateConditionRequired && cmb.value > 2){
                var assessmentDate = Ext.ComponentQuery.query("[name=m0090_info_completed_dt]")[0];
                if((assessmentDate.value == null || assessmentDate.value == "")  ) {
                    cmb.select(cmb.store.getAt(2));
                    super_main.down("#main").getLayout().setActiveItem(2);
                    window.setTitle(component.title+"[Clinical Record Items1 (M0080 - M0090)]");
                    Ext.MessageBox.alert("Message", "Please enter the assessment completed date in 'M0090'.");
                }else {
                    changeActivePanel(cmb, component);
                }
            } else {
                changeActivePanel(cmb, component);
            }

    }, component);

    var fields = component.query('textfield, textarea, datefield, numberfield, checkboxgroup, radiogroup, label');
    Ext.each(fields, function(field, index){
        if(field.isHeader != false) field.addCls("oasis_heading");
    }, component);
    Ext.defer(function(){
        component.up('window').down("#item_chooser").setReadOnly(false);
    }, 1000, component);

    var extendedOasisCheck = component.down("#extended_oasis_check");
    if(extendedOasisCheck){
        extendedOasisCheck.on("change", function(ele){
            resetComboItemsAndValue(ele, component);
        }, component);
    }
    if(!component.docIsInInitDraft) makePocPagesReadOnlyIfRequired(component);
}

function onPopulateValidSample(component) {
    component.setLoading(true);
    Ext.MessageBox.prompt('OASIS', 'Please enter HIPPS CODE:', function(btn, text){
        if(btn == "ok"){
            if(text.match(/[12345]{1}[ABC]{1}[FGH]{1}[KLMNP]{1}[STUVWX]{1}/)){
                component.getOasisSampleFormValues({hipps_code: text}, function(res){
                    var fields = res[0];
                    var values = res[1];
                    Ext.each(fields, function(field, index){
                        var f = component.down("[name="+field+"]");
                        if(f){
                            if(field.indexOf("_icd") != -1 && (f.xtype == 'combo' || f.xtype == 'netzkeremotecombo')){
                                f.store.load({params: {query: values[index]}});
                                f.setValue(values[index]);
                            }else{
                                f.setValue(values[index]);
                            }
                        }
                    }, component);
                    component.setLoading(false);
                }, component);
            } else {
                Ext.MessageBox.alert("Status", "HIPPS Code is invalid.");
                component.setLoading(false);
            }
        } else {
            component.setLoading(true);
        }
    },component);
}

function onValidate(component, flag) {
    var activeItem = component.down("#main").getLayout().getActiveItem();
    if(typeof(activeItem.onValidate) == "function") {
        var errors = activeItem.onValidate(component);
        var fields = getServerSideValidationFields(activeItem, component);
        var doc_type = component.up("window").down("[name=m0100_assmt_reason]").value;
        var episode = component.up("window").down("[name=treatment_episode_id]");
        var episode_id = null;
        if(episode){
            episode_id = episode.value;
        }
        if(fields[0].length > 0) {
            component.checkServerValidationForFields({fields: fields[0], values: fields[1], suffixes: fields[2], doc_type: doc_type,
                episode_id: episode_id}, function(res){
                errors = errors.concat(res);
                errorsDisplay(errors, activeItem, component, flag);
            }, component);
        } else{
            errorsDisplay(errors, activeItem, component, flag);
        }
    } else {
        Ext.MessageBox.alert("Information", "No Errors Found");
    }
}

function errorsDisplay(errors, activeItem, component,flag){
    if (errors.length == 0)
        Ext.MessageBox.alert("Information", "No Errors Found");
    else{
        Ext.each(errors, function(err, index){
            errors[index].push(activeItem.name.split("_").reverse()[0])
        }, component);
        component.launchErrorsGrid([errors, errors.length, flag]);
    }
}


function getServerSideValidationFields( panelWithValidate, component ){
    var server_side_error_required_fields = [];
    var server_side_error_required_field_values = [];
    var server_side_error_required_fields_suffix = [];

    if(typeof(panelWithValidate.serverValidationRequiredFields) == "function") {
        server_side_error_required_fields = panelWithValidate.serverValidationRequiredFields();
        if(typeof(panelWithValidate.serverValidationRequiredFieldsSuffix) == "function") server_side_error_required_fields_suffix = panelWithValidate.serverValidationRequiredFieldsSuffix();
        Ext.each(server_side_error_required_fields, function(field_name, index){
            var field = component.down("[name=" + field_name + "]");
            var value = field.value;
            if(value == null || value == undefined) value = field.rawValue;
            server_side_error_required_field_values.push(value);
        }, component);
    }

    return [server_side_error_required_fields, server_side_error_required_field_values, server_side_error_required_fields_suffix];
}

function getPanelHavingValidateMethod( item, component ) {
    if(item.name.indexOf("panel_") != 0) return null;
    var panels = item.query('panel');
    var panelHavingValidate = null;
    Ext.each(panels, function(panel, index) {
        if(typeof(panel.onValidate) == "function")
            panelHavingValidate = panel;
    }, component);
    return panelHavingValidate;
}

function validateIndividualPanels(onlyErrorsList, component, flag, hippsRequiredDocFlag){
    var errors = [];
    var fields = [[], [], [], []];
    Ext.each(component.down("#main").items.items, function(item) {
        var panelWithValidate = item;
        if(panelWithValidate) {
            individual_panel_fields = getServerSideValidationFields(panelWithValidate, component);
            fields[0] = fields[0].concat(individual_panel_fields[0]);
            fields[1] = fields[1].concat(individual_panel_fields[1]);
            fields[2] = fields[2].concat(individual_panel_fields[2]);
            Ext.each(individual_panel_fields[0], function(f, i){
                fields[3].push(item.name.split("_").reverse()[0]);
            }, component);
        }
    }, component);
    var doc_type = component.up("window").down("[name=m0100_assmt_reason]").value;
    var episode = component.up("window").down("[name=treatment_episode_id]");
    var episode_id = null;
    if(episode){
        episode_id = episode.value;
    }
    component.checkServerValidationForFields({fields: fields[0], values: fields[1], suffixes: fields[2], panel_numbers: fields[3],
        doc_type: doc_type, episode_id: episode_id}, function(res){
        errors = errors.concat(res);
        var items = component.down("#main").items.items;
        Ext.each(items, function(item) {
            var panelWithValidate = item;
            if(panelWithValidate && typeof(panelWithValidate.onValidate) == "function") {
                var new_errors = panelWithValidate.onValidate(component);
                Ext.each(new_errors, function(err, index){
                    new_errors[index].push(item.name.split("_").reverse()[0]);
                }, component);
                errors = errors.concat(new_errors);
            }
        }, component);
        component.down('#valid').setValue(errors.length === 0);
        if (errors.length == 0){
            if (onlyErrorsList) {
                var msg = ""
                var window = component.up("window");
                var form = window.items.first();
                if (form.documentIsInDraftStatus == true)
                    msg = "Your document has been submitted for QA.";
                else
                    msg = "Your record has been saved.";

                applyChanges(false, msg, form);
            } else if(hippsRequiredDocFlag == true){
                component.launchErrorsGrid([errors, errors.length, flag, hippsRequiredDocFlag]);
            } else {
                Ext.MessageBox.alert("Information", "No Errors Found")
            }
        } else {
            component.launchErrorsGrid([errors, errors.length, flag, hippsRequiredDocFlag]);
        }
    }, component);
}

function launchErrorsGrid( args, component) {
    var store = new Ext.data.ArrayStore({
        fields: [
            {name: 'field'},
            {name: 'msg'},
            {name: 'panel_num'}
        ]
    });

    // manually load local data
    store.loadData(args[0]);
    var grid = new Ext.grid.GridPanel({
        header: false,
        border: false,
        modal: true,
        itemId: "errors_grid",
        //region: 'center',
        flex: 1,
        split: true,
        columns: [{
            id       :'field',
            header   : 'Field Name',
            width    : 80,
            sortable : true,
            dataIndex: 'field'
        },{
            id       :'msg',
            header   : 'Error Message',
            flex: 1,
            sortable : true,
            dataIndex: 'msg',
            tdCls: 'wrap'
        },{
            id       :'panel_num',
            header   : 'Panel Num',
            hidden   : true,
            dataIndex: 'panel_num'
        }],
        store: store,
        layout:'fit',
        autoScroll: true
    });


    grid.on("itemdblclick", function(view, record){
        var window = component.up('window');
        window.down("#item_chooser").setValue(parseInt(record.get("panel_num")));
        window.down("#item_chooser").fireEvent('select', window.down("#item_chooser"));
        grid.up("window").close();
    }, component);
    var window = component.up("window");
    var form = window.items.first();
    
    if(form.isDirty()){
        var values = form.getForm().getValues();
    }

    form.getForm().getFields().each(function(field){
        field.resetOriginalValue( );
    });



    var episode = component.up("window").down("[name=treatment_episode_id]");
    var episode_id = null;
    if(episode){
        episode_id = episode.value;
    }
    if(args[2] == true && args[3] == true) {
        var w = new Ext.window.Window({
            width: "70%",
            height: "80%",
            modal: true,
            header: true,
            itemId: "hhrg",
            layout: {type: 'vbox', align: 'stretch'},
            buttons: [
                {
                    text: "",
                    tooltip: "OK",
                    iconCls: "cancel_icon",
                    listeners: {
                        click: function () {
                            w.close();
                        }
                    }
                }
            ],
            listeners: {
                afterRender: function (cmp) {
                    errorsGrid = Ext.ComponentQuery.query('#errors_grid')[0];
                    //For Resolution problems we did this way, height setting dynamically
                    gridHeight = (cmp.getHeight() - 276);
                    errorsGrid.setHeight(gridHeight);
                }
            }
        });
        w.show();
        component.loadNetzkeComponent({
            name: "hipps_grouper_chart",
            params: {component_params: {values: values, episode_id: episode_id}},
            container: w,
            callback: function (w) {
                w.add(grid);
            }
        }, component);
    }else{
        var w = new Ext.window.Window({
            width: "60%",
            height: "60%",
            modal: true,
            layout:'fit',
            items: grid,
            buttons: [
                {
                    text: "",
                    tooltip: "OK",
                    iconCls: "cancel_icon",
                    listeners: {
                        click: function () {
                            w.close();
                        }
                    }
                }
            ],
            title: "Errors - No. of errors: " + args[1]
        });
        w.show();
    }

}

function dummyRequest(){
    Ext.Ajax.request({
        async: false,
        url: '/welcome/switching_tabs',
        method: 'GET'
    });
}

function makePocPagesReadOnlyIfRequired( component ) {
    if(component.pocFieldsReadOnly){
        var panels = component.query('panel');
        Ext.each(panels, function(panel, index){
            if(panel.pocPage) {
                var fields = panel.query('slider, textfield, textarea, datefield, numberfield,checkboxfield, radiofield, checkboxgroup, radiogroup');
                Ext.each(fields, function(field, index){
                    field.setReadOnly(component.pocFieldsReadOnly);
                }, component);
            }
        }, component);
    } else if(component.pocFieldsReadOnly == false){
        var panels = component.query('panel');
        Ext.each(panels, function(panel, index){
            if(panel.oasisPage) {
                var fields = panel.query('slider, textfield, textarea, datefield, numberfield,checkboxfield, radiofield, checkboxgroup, radiogroup');
                Ext.each(fields, function(field, index){
                    field.setReadOnly(!component.pocFieldsReadOnly);
                }, component);
            }
        }, component);
    }
}

function resetComboItemsAndValue(ele, component) {
    var goTo = component.up('window').down('#item_chooser');
    var currentIndex = comboCurrentIndex(goTo);
    var display = goTo.store.getAt(currentIndex).raw[1];
    var str = display.split(" ");
    str = str.join('');
    str = str.replace(/\//, '', "gi");
    str = str.toLowerCase();
    var index = component.pageListPosition[str];
    goTo.store.removeAll();
    if (ele.value) {
        index = index[1];
        goTo.store.add(component.extendedOasisPageList);
    } else {
        index = index[0];
        goTo.store.add(component.normalOasisPageList);
    }
    goTo.setValue(goTo.store.getAt(index));
    goTo.fireEvent('select', goTo);
}

function comboNextItem( combo ) {
    var store = combo.getStore();
    var next_index  = comboCurrentIndex(combo) + 1;
    return store.getAt( next_index );
}

function comboPreviousItem( combo ) {
    var store = combo.getStore();
    var prev_index  = comboCurrentIndex(combo) - 1;
    return store.getAt( prev_index );
}

function comboCurrentIndex( combo ) {
    var store = combo.getStore();
    var value = combo.getValue();
    return store.find( combo.valueField, value );
}

function changeActivePanel( cmb, component ){
    var super_main = Ext.ComponentQuery.query("#super_main")[0];
    var window = super_main.up("window");
    super_main.down("#main").getLayout().setActiveItem(cmb.value);
    window.setTitle(component.title+"["+cmb.getRawValue()+"]");
    // window.down("#main").getLayout().getActiveItem().setTitle(cmb.getRawValue());
    if (comboCurrentIndex(cmb) == (cmb.store.count() - 1))
        window.down("#card-next").disable();
    else
        window.down("#card-next").enable();

    if (cmb.value == 0)
        window.down("#card-prev").disable();
    else
        window.down("#card-prev").enable();
}
