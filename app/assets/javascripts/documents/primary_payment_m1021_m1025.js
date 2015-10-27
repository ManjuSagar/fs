
Ext.define('Ext.panel.PrimaryPaymentM1021M1025', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.primaryPaymentM1021M1025',
    border: false,
    margin: 5,
    items: [

        {
            xtype: 'panel',
            border: 0,
            margin: 5,
            width: 873,
            layout: {
                align: 'stretch',
                type: 'hbox'
            },
            items: [
                {
                    xtype: 'label',
                    flex: 1,
                    width: 400,
                    text: '(M1021) Primary Diagnosis & (M1023) Other Diagnoses'
                },
                {
                    xtype: 'label',
                    flex: 1,
                    width: 400,
                    text: '(M1025) Optional Diagnoses (OPTIONAL) (not used for payment)'
                }
            ]
        },
        {
            xtype: 'panel',
            border: 0,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            items: [
                {
                    xtype: 'panel',
                    border: 0,
                    disabled: false,
                    floating: false,
                    width: 1027,
                    layout: {
                        align: 'middle',
                        type: 'hbox'
                    },
                    suspendLayout: false,
                    items: [
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 207,
                            text: 'Column 1'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 224,
                            text: 'Column 2'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 207,
                            text: 'Column 3'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 337,
                            text: 'Column 4'
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    disabled: false,
                    floating: false,
                    width: 1049,
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    suspendLayout: false,
                    items: [
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 207,
                            text: ' Diagnoses (Sequencing of diagnoses should reflect the seriousness of each condition and support the disciplines and services provided).'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 224,
                            text: 'ICD-10-CM and symptom  control rating for each  condition.  Note that the sequencing of  these ratings may not match  the sequencing of the  diagnoses.'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 207,
                            text: 'May be completed if a Z-code is assigned to column 2 and underlying diagnosis is resolved.'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 337,
                            text: 'Complete only if the Optional Diagnosis is a multiple coding situation (for example: a manifestation code).'
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    disabled: false,
                    floating: false,
                    width: 1049,
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    suspendLayout: false,
                    items: [
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 207,
                            text: 'Description '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 224,
                            text: 'ICD-10-CM /  Symptom Control Rating'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 207,
                            text: 'Description /  ICD-10-CM '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 337,
                            text: 'Description / ICD-10-CM'
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    disabled: false,
                    floating: false,
                    margin: 5,
                    width: 1049,
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    suspendLayout: false,
                    items: [
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1021_primary_diag_icd",
                            margin: '10 0 0 0',
                            padding: 2,
                            width: 207,
                            fieldLabel: '(M1021) Primary Diagnoses (V, W, X, Y codes NOT allowed) a1.',
                            cls: 'oasis_green',
                            itemId: 'pri_diag',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 214,
                            fieldLabel: '(M1021) Severity rating a2.',
                            cls: 'oasis_green',
                            itemId: 'sev_rate',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1021_primary_diag_severity',
                                    boxLabel: 'NA',
                                    checked: true,
                                    width: '41px',
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1021_primary_diag_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1021_primary_diag_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1021_primary_diag_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1021_primary_diag_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1021_primary_diag_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_a3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 209,
                            fieldLabel: '(M1025) Optional Diagnoses (V, W, X, Y, Z codes NOT allowed) a3.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_a3',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_a4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 209,
                            fieldLabel: '(M1025) Optional Diagnoses 2 (V, W, X, Y, Z codes NOT allowed) a4.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_a4',
                            labelAlign: 'top'
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    margin: 5,
                    disabled: false,
                    floating: false,
                    width: 1049,
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    suspendLayout: false,
                    items: [
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1023_oth_diag1_icd",
                            padding: 2,
                            margin: '10 0 0 0',
                            width: 207,
                            fieldLabel: '(M1023) Other Diagnoses (All ICD-10-CM codes allowed) b1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_b1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            padding: 2,
                            width: 214,
                            margin: '10 0 0 5',
                            fieldLabel: '(M1023) Severity rating b2.',
                            cls: 'oasis_green',
                            itemId: 'sev_rate_b2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1023_oth_diag1_severity',
                                    boxLabel: 'NA',
                                    checked: true,
                                    width: '41px',
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag1_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag1_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag1_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag1_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag1_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_b3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 209,
                            fieldLabel: '(M1025) Optional Diagnoses (V, W, X, Y, Z codes NOT allowed) b3.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_b3',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_b4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 209,
                            fieldLabel: '(M1025) Optional Diagnoses 2 (V, W, X, Y, Z codes NOT allowed) b4.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_b4',
                            labelAlign: 'top'
                        }
                    ]
                },{
                    xtype: 'panel',
                    border: 0,
                    margin: 5,
                    disabled: false,
                    floating: false,
                    width: 1049,
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    suspendLayout: false,
                    items: [
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1023_oth_diag2_icd",
                            margin: '10 0 0 0',
                            padding: 2,
                            width: 207,
                            fieldLabel: '(M1023) Other Diagnoses (All ICD-10-CM codes allowed) c1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_c1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            margin: '10 0 0 5',
                            padding: 2,
                            width: 214,
                            fieldLabel: '(M1023) Severity rating c2.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_c2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1023_oth_diag2_severity',
                                    boxLabel: 'NA',
                                    checked: true,
                                    width: '41px',
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag2_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag2_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag2_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag2_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag2_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_c3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 209,
                            fieldLabel: '(M1025) Optional Diagnoses (V, W, X, Y, Z codes NOT allowed) c3.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_c3',
                            labelAlign: "top"
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_c4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 209,
                            fieldLabel: '(M1025) Optional Diagnoses 2 (V, W, X, Y, Z codes NOT allowed) c4.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_c4',
                            labelAlign: 'top'
                        }
                    ]
                }
            ]
        }
    ],

    onValidate: function(){
        var errs = new Array();
        var fromDate = new Date("October 1, 2015");
        var chkEndDate = new Date("October 5, 2015");
        var episodeDate = this.episodeDate.getRawValue();
        var startDate = new Date(episodeDate.split(' ')[0]);
        var isAfterOct = (startDate > chkEndDate);
        var validationFlag = false;
        if (isAfterOct || this.infoCompletedDt.value >= fromDate) {
            validationFlag = true;
        }

        if(this.m1021PrimaryDiagIcd.value == null && validationFlag) {
            errs.push(['M1021', "Enter the primary diagnosis code."]);
        }
        if(this.m1021PrimaryDiagIcd.value && validationFlag) {
            res = this.checkCodeForSeverity(this.m1021PrimaryDiagIcd.value[0]);
            if(res && this.m1021PrimaryDiagSeverity.getGroupValue() == ' ') {
                errs.push(['M1021', "Select the primary diagnosis severity."]);
            }
            else {
                if (this.m1021PrimaryDiagIcd.value[0] == 'Z' && this.m1021PrimaryDiagSeverity.getGroupValue() != ' ') {
                    errs.push(['M1021', "If the primary diagnosis is blank then the primary diagnosis severity must also be blank."]);
                }
            }
            if (this.m1021PrimaryDiagSeverity.getGroupValue() == "00") {
                errs.push(['M1021', "The primary diagnosis severity must be between 01 and 04."]);
            }
        }

        if(this.m1023_oth_diag1_icd.value && validationFlag) {

            if (this.m1023_oth_diag1_icd.value == this.m1021PrimaryDiagIcd.value) {
                errs.push(['M1023', "The other diagnosis code 'b1' cannot be the same as the primary diagnosis code 'a1'."]);
            }

            res = this.checkCodeForSeverity(this.m1023_oth_diag1_icd.value[0]);
            if(res && this.m1023_oth_diag1_severity.getGroupValue() == ' ') {
                errs.push(['M1023', "Select the other diagnosis code 'b2' severity."]);
            }
        }
        else {
            if (this.m1023_oth_diag1_icd.value == null && this.m1023_oth_diag1_severity.getGroupValue() != ' ' ) {
                errs.push(['M1023', "If the other diagnosis 'b1' is blank then the other diagnosis 'b2' severity must also be blank."]);
            }
            if (this.m1023_oth_diag1_icd.value == null && this.m1023_oth_diag2_icd.value != null) {
                errs.push(['M1023', "Since other diagnoses code 'b1' is blank, then other diagnoses code 'c1' must be blank."]);
            }
        }

        if(this.m1023_oth_diag2_icd.value && validationFlag){
            otherDiags2 = [this.m1021PrimaryDiagIcd, this.m1023_oth_diag1_icd]

            Ext.each(otherDiags2, function(el){
                if(this.m1023_oth_diag2_icd.value == el.value){
                    errs.push(["M1023", "The other diagnosis code 'c1' cannot be the same as the "  + this.getMessage(el.name)]);
                }
            },this);

            res = this.checkCodeForSeverity(this.m1023_oth_diag2_icd.value[0]);
            if(res && this.m1023_oth_diag2_severity.getGroupValue() == ' ') {
                errs.push(['M1023', "Select the other diagnosis code 'c2' severity."]);
            }
        }else {
            if (this.m1023_oth_diag2_icd.value == null && this.m1023_oth_diag2_severity.getGroupValue() != ' ') {
                errs.push(['M1023', "If the other diagnosis 'c1' is blank then the other diagnosis 'c2' severity must also be blank."]);
            }
        }

        if(this.m1025_opt_diag_icd_a3.value){
            if(this.m1021PrimaryDiagIcd.value !=null && this.m1021PrimaryDiagIcd.value[0]!='Z'){
                errs.push(['M1021', "If the optional diagnosis code 'a3' is not blank, then primary diagnoses code should be a 'Z' code."]);
            }

        }else if(this.m1025_opt_diag_icd_a3.value == null  && this.m1025_opt_diag_icd_a4.value != null){
            errs.push(['M1025', "If the optional diagnosis code 'a3' is blank then the optional diagnosis code 'a4' must also be blank."]);
        }

        if (this.m1025_opt_diag_icd_a4.value) {
            if(this.m1021PrimaryDiagIcd.value !=null && this.m1021PrimaryDiagIcd.value[0]!='Z'){
                errs.push(['M1021', "If the optional diagnosis code 'a4' is not blank, then primary diagnoses code should be a 'Z' code."]);
            }
        }

        //for b3, b4
        if(this.m1025_opt_diag_icd_b3.value){

            if(this.m1025_opt_diag_icd_b3.value == this.m1025_opt_diag_icd_a3.value) {
                errs.push(["M1025", "The optional diagnosis code 'b3' cannot be same as the optional diagnosis code 'a3'."]);
            }

            if(this.m1023_oth_diag1_icd.value == null){
                errs.push(['M1025', "If the other diagnosis code 'b1' is blank then the optional diagnosis code 'b3' must also be blank."]);
            }else{
                if(this.m1023_oth_diag1_icd && this.m1023_oth_diag1_icd.value[0]!='Z'){
                    errs.push(['M1023', "If the optional diagnosis code 'b3' is not blank, then other diagnoses code 'b1' should be a 'Z' code."]);
                }
            }
        }

        if(this.m1025_opt_diag_icd_b4.value) {

                if(this.m1023_oth_diag1_icd.value != null && this.m1023_oth_diag1_icd.value[0]!='Z'){
                    errs.push(['M1023', "If the optional diagnosis code 'b4' is not blank, then other diagnoses code 'b1' should be a 'Z' code."]);
                }

            if(this.m1025_opt_diag_icd_b3.value == null){
                errs.push(['M1025', "If the optional diagnosis code 'b3' is blank then the optional diagnosis code 'b4' must also be blank."]);
            }

            if(this.m1025_opt_diag_icd_b4.value == this.m1025_opt_diag_icd_a4.value) {
                errs.push(["M1025", "The optional diagnosis 'b4' cannot be same as the optional diagnosis code 'a4'."]);
            }
        }

        //for c3, c4
        if(this.m1025_opt_diag_icd_c3.value){

            if(this.m1023_oth_diag2_icd.value == null){
                errs.push(['M1025', "If the other diagnosis code 'c1' is blank then the optional diagnosis code 'c3' must also be blank."]);
            }else{
                if(this.m1023_oth_diag2_icd && this.m1023_oth_diag2_icd.value[0]!='Z'){
                    errs.push(['M1023', "If the optional diagnosis code 'c3' is not blank, then other diagnoses code 'c1' should be a 'Z' code."]);
                }
            }
            optionalDiagsC3 = [this.m1025_opt_diag_icd_a3, this.m1025_opt_diag_icd_b3];
            Ext.each(optionalDiagsC3, function(el) {
                if(this.m1025_opt_diag_icd_c3.value == el.value) {
                    errs.push(["M1025", "The optional diagnosis code 'c3' cannot be same as the "+ this.getMessage(el.name)]);
                }
            }, this);
        }

        if (this.m1025_opt_diag_icd_c4.value) {

            if(this.m1023_oth_diag2_icd.value != null && this.m1023_oth_diag2_icd.value[0] != 'Z') {
                errs.push(['M1023', "If the optional diagnosis code 'c4' is not blank, then other diagnoses code 'c1' should be a 'Z' code."]);
            }
            if(this.m1025_opt_diag_icd_c3.value == null){
                errs.push(['M1025', "If the optional diagnosis code 'c3' is blank then the optional diagnosis code 'c4' must also be blank."]);
            }

            optionalDiagsC4 = [this.m1025_opt_diag_icd_a4, this.m1025_opt_diag_icd_b4];
            Ext.each(optionalDiagsC4, function(el) {
                if(this.m1025_opt_diag_icd_c4.value == el.value) {
                    errs.push(["M1025", "The optional diagnosis 'c4' cannot be same as the "+ this.getMessage(el.name)]);
                }
            },this);
        }
        return errs;
    },

    getMessage: function(code){
        icd_codes = {}
        icd_codes["m1021_primary_diag_icd"] = "primary diagnosis code 'a1'.";
        icd_codes["m1023_oth_diag1_icd"] = "other diagnosis code 'b1'.";
        icd_codes["m1023_oth_diag2_icd"] = "other diagnosis code 'c1'.";
        icd_codes["m1023_oth_diag3_icd"] = "other diagnosis code 'd1'.";
        icd_codes["m1023_oth_diag4_icd"] = "other diagnosis code 'e1'.";
        icd_codes["m1023_oth_diag5_icd"] = "other diagnosis code 'f1'.";

        icd_codes["m1025_opt_diag_icd_a3"] = "optional diagnosis code 'a3'.";
        icd_codes["m1025_opt_diag_icd_b3"] = "optional diagnosis code 'b3'.";
        icd_codes["m1025_opt_diag_icd_a4"] = "optional diagnosis code 'a4'.";
        icd_codes["m1025_opt_diag_icd_b4"] = "optional diagnosis code 'b4'.";

        return icd_codes[code]
    },

    checkCodeForSeverity: function(code) {
        if (code !='V' && code !='W' && code !='X' && code !='Y' && code !='Z') {
            return true;
        }
    },

   resetDiagSeverity: function(icds) {
        Ext.each(icds, function(icd) {
            icd[0].on('select', function(el) {
                if(el.value[0]=='V' || el.value[0]=='W' || el.value[0]=='X' || el.value[0]=='Y' || el.value[0]=='Z') {
                    this.query("[name="+icd[1].name+"]").forEach(function(n) {n.setValue(' ');});
                }
            }, this);

            icd[0].on('change', function(el){
                if(el.value==" " || el.value== null){
                    this.query("[name="+icd[1].name+"]").forEach(function(n){ n.setValue(' ');});
                }
            },this);
        }, this);
    },

    enableFields: function(fieldList){
        Ext.each(fieldList, function(individualField, i){
            var fields = this.mainScope.query("[name="+individualField+"]");
            Ext.each(fields, function(f, j){
                f.enable();
            }, this);
        }, this);
    },

    disableFields: function(fieldList){
        Ext.each(fieldList, function(individualField, i){
            var fields = this.mainScope.query("[name="+individualField+"]");
            Ext.each(fields, function(f, j){
                f.disable();
            }, this);
        }, this);
    },

    serverValidationRequiredFields: function(){
        return ["m1021_primary_diag_icd", "m1025_opt_diag_icd_a3", "m1025_opt_diag_icd_a4",
            "m1025_opt_diag_icd_b3", "m1025_opt_diag_icd_b4", "m1025_opt_diag_icd_c3", "m1025_opt_diag_icd_c4"]
    },

    serverValidationRequiredFieldsSuffix: function(){
        return ["a1", "a3", "a4", "b3", "b4", "c3", "c4"]
    },

    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.m1021PrimaryDiagIcd = this.mainScope.down("[name=m1021_primary_diag_icd]");
        this.m1021PrimaryDiagSeverity = this.mainScope.down("[name=m1021_primary_diag_severity]");
        this.m1023_oth_diag1_icd = this.mainScope.down("[name=m1023_oth_diag1_icd]");
        this.m1023_oth_diag2_icd = this.mainScope.down("[name=m1023_oth_diag2_icd]");
        this.m1023_oth_diag3_icd = this.mainScope.down("[name=m1023_oth_diag3_icd]");
        this.m1023_oth_diag4_icd = this.mainScope.down("[name=m1023_oth_diag4_icd]");
        this.m1023_oth_diag5_icd = this.mainScope.down("[name=m1023_oth_diag5_icd]");
        this.m1023_oth_diag1_severity = this.mainScope.down("[name=m1023_oth_diag1_severity]");
        this.m1023_oth_diag2_severity = this.mainScope.down("[name=m1023_oth_diag2_severity]");
        this.m1025_opt_diag_icd_a3 = this.mainScope.down("[name=m1025_opt_diag_icd_a3]");
        this.m1025_opt_diag_icd_a4 = this.mainScope.down("[name=m1025_opt_diag_icd_a4]");
        this.m1025_opt_diag_icd_b3 = this.mainScope.down("[name=m1025_opt_diag_icd_b3]");
        this.m1025_opt_diag_icd_b4 = this.mainScope.down("[name=m1025_opt_diag_icd_b4]");
        this.m1025_opt_diag_icd_c3 = this.mainScope.down("[name=m1025_opt_diag_icd_c3]");
        this.m1025_opt_diag_icd_c4 = this.mainScope.down("[name=m1025_opt_diag_icd_c4]");
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
        this.episodeDate = Ext.ComponentQuery.query('#patient_treatment_episode')[0];

        this.m1023ICDs = [this.m1021PrimaryDiagIcd, this.m1023_oth_diag1_icd, this.m1023_oth_diag2_icd];

        this.icdsAndSeverity = [[this.m1021PrimaryDiagIcd, this.m1021PrimaryDiagSeverity],
                                [this.m1023_oth_diag1_icd, this.m1023_oth_diag1_severity],
                                [this.m1023_oth_diag2_icd, this.m1023_oth_diag2_severity]];

        this.resetDiagSeverity(this.icdsAndSeverity);

        this.m1025SeverityAndPriFieldsName = [["m1021_primary_diag_severity", "m1025_opt_diag_icd_a3", "m1025_opt_diag_icd_a4"],
            ["m1023_oth_diag1_severity", "m1025_opt_diag_icd_b3", "m1025_opt_diag_icd_b4" ],
            ["m1023_oth_diag2_severity", "m1025_opt_diag_icd_c3", "m1025_opt_diag_icd_c4"]];
        this.codeIsInvalidCodeDisableFields = [["m1021_primary_diag_severity"],
            ["m1023_oth_diag1_severity" ], ["m1023_oth_diag2_severity"]];

        Ext.each(this.m1023ICDs, function(field, index){
            field.on('select', function(el){
                if(el.value[0] == "V" || el.value[0] == "W" || el.value[0] == "X" || el.value[0] == "Y" || el.value[0] == "Z" ){
                    this.disableFields(this.codeIsInvalidCodeDisableFields[index]);
                }else if(el.value[0] != "V" || el.value[0] != "W" || el.value[0] != "X" || el.value[0] != "Y" || el.value[0] != "Z" ){
                    this.enableFields(this.m1025SeverityAndPriFieldsName[index]);
                }
            }, this);
        }, this);
    }
})
