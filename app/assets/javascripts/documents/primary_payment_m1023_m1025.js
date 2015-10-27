
Ext.define('Ext.panel.PrimaryPaymentM1023M1025', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.primaryPaymentM1023M1025',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'panel',
            border: 0,
            margin: 5,
            width: 853,
            layout: {
                align: 'stretch',
                type: 'hbox'
            },
            items: [
                {
                    xtype: 'label',
                    flex: 1,
                    width: 376,
                    text: '(M1021) Primary Diagnosis & (M1023) Other Diagnoses'
                },
                {
                    xtype: 'label',
                    flex: 1,
                    width: 787,
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
                            width: 218,
                            text: 'Column 1'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 203,
                            text: 'Column 2'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 218,
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
                            width: 218,
                            text: 'Diagnoses (Sequencing of diagnoses should reflect the seriousness of each condition and support the disciplines and services provided). '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 203,
                            text: 'ICD-10-CM and symptom  control rating for each  condition.  Note that the sequencing of  these ratings may not match  the sequencing of the  diagnoses.'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 218,
                            text: 'May be completed if a Z-code is  assigned to Column 2  and the underlying diagnosis is resolved.'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 337,
                            text: 'Complete only if the Optional Diagnoses is a multiple coding situation (for example: a manifestation code). '
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
                            width: 218,
                            text: 'Description '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 203,
                            text: 'ICD-10-CM /  Symptom Control Rating'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 212,
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
                            name: "m1023_oth_diag3_icd",
                            margin: '10 0 0 0',
                            padding: 2,
                            width: 197,
                            fieldLabel: '(M1023) Other Diagnoses (All ICD-10-CM codes allowed) d1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_d1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 214,
                            fieldLabel: '(M1023) Severity rating d2.',
                            cls: 'oasis_green',
                            itemId: 'sev_rate_d2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1023_oth_diag3_severity',
                                    boxLabel: 'NA',
                                    width: '41px',
                                    checked: true,
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag3_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag3_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag3_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag3_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag3_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_d3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 212,
                            fieldLabel: '(M1025) Optional Diagnoses (V, W, X, Y, Z codes NOT allowed) d3.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_d3',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_d4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 208,
                            fieldLabel: '(M1025) Optional Diagnoses 2 (V, W, X, Y, Z codes NOT allowed) d4.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_d4',
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
                            name: "m1023_oth_diag4_icd",
                            padding: 2,
                            margin: '10 0 0 0',
                            width: 197,
                            fieldLabel: '(M1023) Other Diagnoses (All ICD-10-CM codes allowed) e1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_e1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            padding: 2,
                            width: 214,
                            margin: '10 0 0 5',
                            fieldLabel: '(M1023) Severity rating e2.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_e2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1023_oth_diag4_severity',
                                    boxLabel: 'NA',
                                    width: '41px',
                                    checked: true,
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag4_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag4_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag4_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag4_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag4_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_e3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 212,
                            fieldLabel: '(M1025) Optional Diagnoses (V, W, X, Y, Z codes NOT allowed) e3.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_e3',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_e4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 207,
                            fieldLabel: '(M1025) Optional Diagnoses 2 (V, W, X, Y, Z codes NOT allowed) e4.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_e4',
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
                            name: "m1023_oth_diag5_icd",
                            margin: '10 0 0 0',
                            padding: 2,
                            width: 197,
                            fieldLabel: '(M1023) Other Diagnoses (All ICD-10-CM codes allowed) f1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_f1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            margin: '10 0 0 5',
                            padding: 2,
                            width: 214,
                            fieldLabel: '(M1023) Severity rating f2.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_f2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1023_oth_diag5_severity',
                                    boxLabel: 'NA',
                                    width: '41px',
                                    checked: true,
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag5_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag5_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag5_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag5_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1023_oth_diag5_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_f3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 212,
                            fieldLabel: '(M1025) Optional Diagnoses (V, W, X, Y, Z codes NOT allowed) f3.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_f3',
                            labelAlign: "top"
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1025_opt_diag_icd_f4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 207,
                            fieldLabel: '(M1025) Optional Diagnoses 2 (V, W, X, Y, Z codes NOT allowed) f4.',
                            cls: 'oasis_green',
                            itemId: 'opt_diag_f4',
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
       //for d1,d2
       if(this.m1023_oth_diag3_icd.value && validationFlag){
            otherDiags3 = [this.m1021PrimaryDiagIcd, this.m1023_oth_diag1_icd, this.m1023_oth_diag2_icd]
            if(this.m1023_oth_diag2_icd.value == null ){
                errs.push(['M1023', "Since other diagnosis code 'c1' is blank, then other diagnosis code 'd1' must also be blank."]);
            }
            Ext.each(otherDiags3, function(el){
                if(this.m1023_oth_diag3_icd.value == el.value){
                    errs.push(['M1023', "The other diagnosis code 'd1' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
            
            if(this.checkValue(this.m1023_oth_diag3_icd) &&  this.m1023_oth_diag3_severity.getGroupValue()!= ' '){
                errs.push(['M1023', "Since other diagnosis code 'd1' first character is 'V or W or X or Y or Z (i.e., V-Code)', then other diagnosis severity 'd2' must also be blank."])
            }
            if(!this.checkValue(this.m1023_oth_diag3_icd) && this.m1023_oth_diag3_severity.getGroupValue() == ' '){
                errs.push(['M1023', "Select the other diagnosis 'd2' severity."]);
            }
        }else {
            if (this.m1023_oth_diag3_icd.value == null && this.m1023_oth_diag3_severity.getGroupValue() != ' ') {
                errs.push(['M1023', "Since other diagnosis code 'd1' is blank, then other diagnosis severity 'd2' must also be blank."]);
            }
        }

        //for e1,e2
        if(this.m1023_oth_diag4_icd.value && validationFlag){
            otherDiags4 = [this.m1021PrimaryDiagIcd, this.m1023_oth_diag1_icd, this.m1023_oth_diag3_icd, this.m1023_oth_diag2_icd]

            if(this.m1023_oth_diag3_icd.value == null ){
                errs.push(['M1023', "Since other diagnosis code 'd1' is blank, then other diagnosis code 'e1' must also be blank."]);
            }

            Ext.each(otherDiags4, function(el){
                if(this.m1023_oth_diag4_icd.value == el.value){
                    errs.push(['M1023', "The other diagnosis code 'e1' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);

            if(this.checkValue(this.m1023_oth_diag4_icd) && this.m1023_oth_diag4_severity.getGroupValue()!= ' ' ){
                errs.push(['M1023', "Since other diagnosis code 'e1' first character is 'V or W or X or Y or Z(i.e., V-Code)', then other diagnosis severity 'e2' must also be blank."])
            }
            if(!this.checkValue(this.m1023_oth_diag4_icd) && this.m1023_oth_diag4_severity.getGroupValue() == ' ' ){
                errs.push(['M1023', "Select the other diagnosis 'e2' severity."]);
            }
        }else {
            if (this.m1023_oth_diag4_icd.value == null && this.m1023_oth_diag4_severity.getGroupValue() != ' ') {
                errs.push(['M1023', "Since other diagnosis code 'e1' is blank, then other diagnosis severity 'e2' must also be blank."]);
            }
        }

        //for f1,f2    
        if(this.m1023_oth_diag5_icd.value && validationFlag){
            otherDiags5 = [this.m1021PrimaryDiagIcd, this.m1023_oth_diag1_icd, this.m1023_oth_diag3_icd, this.m1023_oth_diag2_icd, this.m1023_oth_diag4_icd]

            if(this.m1023_oth_diag4_icd.value == null && this.m1023_oth_diag5_icd.value != null){
                errs.push(['M1023', "Since other diagnosis code 'e1' is blank, then other diagnosis code 'f1' must also be blank."]);
            }

            Ext.each(otherDiags5, function(el){
                if(this.m1023_oth_diag5_icd.value == el.value){
                    errs.push(['M1023', "The other diagnosis code 'f1' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
        
            if(this.checkValue(this.m1023_oth_diag5_icd) && this.m1023_oth_diag5_severity.getGroupValue() != ' '){
                errs.push(['M1023', "Since other diagnoses code 'f1' first character is 'V or W or X or Y or Z(i.e., V-Code)', then other diagnosis severity 'f2' must also be blank."])
            }
            if(!this.checkValue(this.m1023_oth_diag5_icd) && this.m1023_oth_diag5_severity.getGroupValue() == ' '){
                errs.push(['M1023', "Select the other diagnosis code 'f2' severity."]);
            }
        }else {
            if (this.m1023_oth_diag5_icd.value == null && this.m1023_oth_diag5_severity.getGroupValue() != ' ') {
                errs.push(['M1023', "Since other diagnosis code 'f1' is blank, then other diagnosis severity 'f2' must also be blank."]);
            }
        }

        //for d3
        if(this.m1025_opt_diag_icd_d3.value){            
            optDiagsd3 = [this.m1025_opt_diag_icd_a3, this.m1025_opt_diag_icd_b3, this.m1025_opt_diag_icd_c3]

            if(this.m1023_oth_diag3_icd.value == null){
                errs.push(['M1025', "Since other diagnosis code 'd1' is blank, then optional diagnosis code 'd3' must also be blank."]);
            }else{
                if(this.m1023_oth_diag3_icd && this.m1023_oth_diag3_icd.value[0] != 'Z'){
                    errs.push(['M1023', "If the optional diagnosis code 'd3' is not blank, then other diagnosis code 'd1' should be a 'Z' code"]);
                }
            }

            Ext.each(optDiagsd3, function(el){
                if(this.m1025_opt_diag_icd_d3.value == el.value){
                    errs.push(['M1025', "The optional diagnosis code 'd3' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
        } 

        //for d4
        if(this.m1025_opt_diag_icd_d4.value){
            optDiagsd4 = [this.m1025_opt_diag_icd_a4, this.m1025_opt_diag_icd_b4, this.m1025_opt_diag_icd_c4 ]
            
            if(this.m1025_opt_diag_icd_d3.value == null){
                errs.push(['M1025', "Since optional diagnosis code 'd3' is blank, then optional diagnosis code 'd4' must also be blank."]);
            }else{
                if(this.m1023_oth_diag3_icd.value && this.m1023_oth_diag3_icd.value[0] != 'Z'){
                    errs.push(['M1023', "If the optional diagnosis code 'd4' is not blank, then other diagnosis code 'd1' should be a 'Z' code"]);
                }
            }
            Ext.each(optDiagsd4, function(el){
                if(this.m1025_opt_diag_icd_d4.value == el.value){
                    errs.push(['M1025', "The optional diagnosis code 'd4' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
        }

        //for e3
        if(this.m1025_opt_diag_icd_e3.value){
            optDiagse3 = [this.m1025_opt_diag_icd_a3, this.m1025_opt_diag_icd_b3, this.m1025_opt_diag_icd_c3,this.m1025_opt_diag_icd_d3]
            
            if(this.m1023_oth_diag4_icd.value == null){
                errs.push(['M1025', "Since other diagnosis code 'e1' is blank, then optional diagnosis code 'e3' must also be blank."]);
            }else{
                if(this.m1023_oth_diag4_icd.value[0]!= 'Z'){
                    errs.push(['M1023', "If the optional diagnosis code 'e3' is not blank, then other diagnosis code 'e1' should be a 'Z' code"]);
                }
            }

            Ext.each(optDiagse3, function(el){
                if(this.m1025_opt_diag_icd_e3.value == el.value){
                    errs.push(['M1025', "The optional diagnosis code 'e3' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
        } 

        //for e4
        if(this.m1025_opt_diag_icd_e4.value){
            optDiagse4 = [this.m1025_opt_diag_icd_a4, this.m1025_opt_diag_icd_b4, this.m1025_opt_diag_icd_c4,this.m1025_opt_diag_icd_d4 ]
            
            if(this.m1025_opt_diag_icd_e3.value == null){
                errs.push(['M1025', "Since optional diagnosis code 'e3' is blank, then optional diagnosis code 'e4' must also be blank."]);
            }else{
                if(this.m1023_oth_diag4_icd.value && this.m1023_oth_diag4_icd.value[0]!= 'Z'){
                    errs.push(['M1023', "If the optional diagnosis code 'e4' is not blank, then other diagnosis code 'e1' should be a 'Z' code"]);
                }
            }
            Ext.each(optDiagse4, function(el){
                if(this.m1025_opt_diag_icd_e4.value == el.value){
                    errs.push(['M1025', "The optional diagnosis code 'e4' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
        }
        
        //for f3
        if(this.m1025_opt_diag_icd_f3.value){
            optDiagsf3 = [this.m1025_opt_diag_icd_a3, this.m1025_opt_diag_icd_b3, this.m1025_opt_diag_icd_c3,this.m1025_opt_diag_icd_d3, this.m1025_opt_diag_icd_e3 ]
            
            Ext.each(optDiagsf3, function(el){
                if(this.m1025_opt_diag_icd_f3.value == el.value){
                    errs.push(['M1025', "The optional diagnosis code 'f3' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);            

            if(this.m1023_oth_diag5_icd.value == null){
                errs.push(['M1025', "Since other diagnosis code 'f1' is blank, then optional diagnosis code 'f3' must also be blank."]);
            }else{
                if(this.m1023_oth_diag5_icd.value[0] != 'Z'){
                    errs.push(['M1023', "If the optional diagnosis code 'f3' is not blank, then other diagnosis code 'f1' should be a 'Z' code"]);
                }
            }
        }

        //for f4
        if(this.m1025_opt_diag_icd_f4.value){
            optDiagsf4 = [this.m1025_opt_diag_icd_a4, this.m1025_opt_diag_icd_b4, this.m1025_opt_diag_icd_c4,this.m1025_opt_diag_icd_d4, this.m1025_opt_diag_icd_e4 ]
            
            if(this.m1025_opt_diag_icd_f3.value == null){
                errs.push(['M1025', "Since optional diagnosis code 'f3' is blank, then optional diagnosis code 'f4' must also be blank."]);
            }else{
                if(this.m1023_oth_diag5_icd.value && this.m1023_oth_diag5_icd.value[0] != 'Z'){
                    errs.push(['M1023', "If the optional diagnosis code 'f4' is not blank, then other diagnosis code 'f1' should be a 'Z' code"]);
                }
            }
            Ext.each(optDiagsf4, function(el){
                if(this.m1025_opt_diag_icd_f4.value == el.value){
                    errs.push(['M1025', "The optional diagnosis code 'f4' cannot be the same as the " + this.getMessage(el.name)]);
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
        icd_codes["m1025_opt_diag_icd_c3"] = "optional diagnosis code 'c3'.";
        icd_codes["m1025_opt_diag_icd_d3"] = "optional diagnosis code 'd3'.";
        icd_codes["m1025_opt_diag_icd_e3"] = "optional diagnosis code 'e3'.";        
        
        icd_codes["m1025_opt_diag_icd_a4"] = "optional diagnosis code 'a4'.";
        icd_codes["m1025_opt_diag_icd_b4"] = "optional diagnosis code 'b4'.";
        icd_codes["m1025_opt_diag_icd_c4"] = "optional diagnosis code 'c4'.";
        icd_codes["m1025_opt_diag_icd_d4"] = "optional diagnosis code 'd4'.";
        icd_codes["m1025_opt_diag_icd_e4"] = "optional diagnosis code 'e4'.";

        return icd_codes[code]
    },

    serverValidationRequiredFields: function(){
        return ["m1025_opt_diag_icd_d3", "m1025_opt_diag_icd_d4", "m1025_opt_diag_icd_e3", "m1025_opt_diag_icd_e4", "m1025_opt_diag_icd_f3", "m1025_opt_diag_icd_f4"]
    },

    serverValidationRequiredFieldsSuffix: function(){
        return ["d3", "d4", "e3", "e4", "f3", "f4"]
    },

    resetSeverity: function(resetIcdList){
        Ext.each(resetIcdList,function(icdList){
            icdList[0].on("select",function(el){
                if(el.value == " " || el.value == null){
 					this.query("[name="+icdList[1].name+"]").forEach(function(n){ n.setValue(' ');});
                } else if(this.checkValue(el)){                   
                    this.query("[name="+icdList[1].name+"]").forEach(function(n){ n.setValue(' ');}); 
                }

                icdList[0].on("change", function(el){
                    if(el.value == " " || el.value == null){                        
                        this.query("[name="+icdList[1].name+"]").forEach(function(n){ n.setValue(' ');});                       
                	}       
                },this);
            },this);
        },this);
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

    checkValue: function(diag_icds){
      return ((diag_icds.value[0] == "V" || diag_icds.value[0] == "W" || diag_icds.value[0] == "X" || diag_icds.value[0] == "Y"  || diag_icds.value[0] == "Z" ) ? true : false);
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
        this.m1023_oth_diag3_severity = this.mainScope.down("[name=m1023_oth_diag3_severity]");
        this.m1023_oth_diag4_severity = this.mainScope.down("[name=m1023_oth_diag4_severity]");
        this.m1023_oth_diag5_severity = this.mainScope.down("[name=m1023_oth_diag5_severity]");
        this.m1025_opt_diag_icd_a3 = this.mainScope.down("[name=m1025_opt_diag_icd_a3]");
        this.m1025_opt_diag_icd_a4 = this.mainScope.down("[name=m1025_opt_diag_icd_a4]");
        this.m1025_opt_diag_icd_b3 = this.mainScope.down("[name=m1025_opt_diag_icd_b3]");
        this.m1025_opt_diag_icd_b4 = this.mainScope.down("[name=m1025_opt_diag_icd_b4]");
        this.m1025_opt_diag_icd_c3 = this.mainScope.down("[name=m1025_opt_diag_icd_c3]");
        this.m1025_opt_diag_icd_c4 = this.mainScope.down("[name=m1025_opt_diag_icd_c4]");
        this.m1025_opt_diag_icd_d3 = this.mainScope.down("[name=m1025_opt_diag_icd_d3]");
        this.m1025_opt_diag_icd_d4 = this.mainScope.down("[name=m1025_opt_diag_icd_d4]");
        this.m1025_opt_diag_icd_e3 = this.mainScope.down("[name=m1025_opt_diag_icd_e3]");
        this.m1025_opt_diag_icd_e4 = this.mainScope.down("[name=m1025_opt_diag_icd_e4]");
        this.m1025_opt_diag_icd_f3 = this.mainScope.down("[name=m1025_opt_diag_icd_f3]");
        this.m1025_opt_diag_icd_f4 = this.mainScope.down("[name=m1025_opt_diag_icd_f4]");
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
        this.episodeDate = Ext.ComponentQuery.query('#patient_treatment_episode')[0];

        this.m1023ICDs = [this.m1023_oth_diag3_icd, this.m1023_oth_diag4_icd, this.m1023_oth_diag5_icd];        
        this.codeEnableDisableList = [["m1023_oth_diag3_severity"], ["m1023_oth_diag4_severity" ], 
                                      ["m1023_oth_diag5_severity"]];
        this.resetIcdList = [[this.m1023_oth_diag3_icd, this.m1023_oth_diag3_severity ],
                             [this.m1023_oth_diag4_icd, this.m1023_oth_diag4_severity ],
                             [this.m1023_oth_diag5_icd, this.m1023_oth_diag5_severity ]];           
        this.resetSeverity(this.resetIcdList); 

        Ext.each(this.m1023ICDs, function(field, index){
            field.on('select', function(el){
                if(this.checkValue(el)){                    
                    this.disableFields(this.codeEnableDisableList[index]);
                }else if(!this.checkValue(el)){
                    this.enableFields(this.codeEnableDisableList[index]);
                }
            }, this);
        }, this);

    }
})
