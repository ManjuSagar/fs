/**
 * Created by msuser1 on 10/12/14.
 */
Ext.define('Ext.panel.PrimaryPaymentM1022M1024', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.primaryPaymentM1022M1024',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'panel',
            border: 0,
            margin: 5,
            width: 753,
            layout: {
                align: 'stretch',
                type: 'hbox'
            },
            items: [
                {
                    xtype: 'label',
                    flex: 1.2,
                    width: 376,
                    text: '(M1020) Primary Diagnosis & (M1022) Other Diagnoses'
                },
                {
                    xtype: 'label',
                    flex: 1,
                    width: 747,
                    text: '(M1024) Payment Diagnoses (OPTIONAL)'
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
                            width: 208,
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
                            width: 208,
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
                            width: 208,
                            text: 'Diagnoses (Sequencing of diagnoses should reflect the seriousness of each condition and support the disciplines and services provided.) '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 203,
                            text: 'ICD-9-C M and symptom  control rating for each  condition.  Note that the sequencing of  these ratings may not match  the sequencing of the  diagnoses  '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 208,
                            text: 'Complete if a V-code is  assigned under certain  circumstances to Column 2  in place of a case mix  diagnosis**.  '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 337,
                            text: 'Complete only if the V-code in Column 2 is reported in place of a case mix diagnosis that is a multiple coding situation (e.g., a manifestation code). '
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
                            width: 208,
                            text: 'Description '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 203,
                            text: 'ICD-9-C M /  Symptom Control Rating'
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 208,
                            text: 'Description/  ICD-9-C M '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 337,
                            text: 'Description/ ICD-9-C M'
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
                            name: "m1022_oth_diag3_icd",
                            margin: '10 0 0 0',
                            padding: 2,
                            width: 197,
                            fieldLabel: '(M1022) Other Diagnoses (v-codes and E-codes are allowed) d1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_d1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 214,
                            fieldLabel: '(M1022) Severity rating d2.',
                            cls: 'oasis_green',
                            itemId: 'sev_rate_d2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1022_oth_diag3_severity',
                                    boxLabel: 'NA',
                                    width: '41px',
                                    checked: true,
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag3_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag3_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag3_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag3_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag3_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_d3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 202,
                            fieldLabel: '(M1024) Payment Diagnoses (OPTIONAL V or E codes not allowed) d3.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_d3',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_d4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 197,
                            fieldLabel: '(M1024) Payment Diagnoses 2 (OPTIONAL V or E - codes not allowed) d4.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_d4',
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
                            name: "m1022_oth_diag4_icd",
                            padding: 2,
                            margin: '10 0 0 0',
                            width: 197,
                            fieldLabel: '(M1022) Other Diagnoses (v-codes and E-codes are allowed) e1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_e1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            padding: 2,
                            width: 214,
                            margin: '10 0 0 5',
                            fieldLabel: '(M1022) Severity rating e2.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_e2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1022_oth_diag4_severity',
                                    boxLabel: 'NA',
                                    width: '41px',
                                    checked: true,
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag4_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag4_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag4_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag4_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag4_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_e3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 202,
                            fieldLabel: '(M1024) Payment Diagnoses (OPTIONAL V or E codes not allowed) e3.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_e3',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_e4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 197,
                            fieldLabel: '(M1024) Payment Diagnoses 2 (OPTIONAL V or E - codes not allowed) e4.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_e4',
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
                            name: "m1022_oth_diag5_icd",
                            margin: '10 0 0 0',
                            padding: 2,
                            width: 197,
                            fieldLabel: '(M1022) Other Diagnoses (v-codes and E-codes are allowed) f1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_f1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            margin: '10 0 0 5',
                            padding: 2,
                            width: 214,
                            fieldLabel: '(M1022) Severity rating f2.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_f2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1022_oth_diag5_severity',
                                    boxLabel: 'NA',
                                    width: '41px',
                                    checked: true,
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag5_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag5_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag5_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag5_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag5_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_f3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 202,
                            fieldLabel: '(M1024) Payment Diagnoses (OPTIONAL V or E codes not allowed) f3.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_f3',
                            labelAlign: "top"
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_f4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 197,
                            fieldLabel: '(M1024) Payment Diagnoses 2 (OPTIONAL V or E - codes not allowed) f4.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_f4',
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
        if (!isAfterOct && this.infoCompletedDt.value < fromDate) {
            validationFlag = true;
        }
        // These two are not available in m1024
        /*
         if(this.m1022_oth_diag1_icd.value){
         otherDiags = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag2_icd, this.m1022_oth_diag3_icd, this.m1022_oth_diag4_icd, this.m1022_oth_diag5_icd]

         Ext.each(otherDiags, function(el){
         if(this.m1022_oth_diag1_icd.value == el.value){
         errs.push(['M1020', 'M1022_OTH_DIAG1_ICD cannot be equal to '+ el.name]);
         }
         },this);
         if(this.m1022_oth_diag1_icd.value[0] == 'E' &&  this.m1022_oth_diag1_severity.getGroupValue()!=null){
         errs.push(['M1020', 'If byte 1 of M1022_OTH_DIAG1_ICD="E" (i.e., it is an E-code), then M1022_OTH_DIAG1_SEVERITY must be blank'])
         }
         if(this.m1022_oth_diag1_icd.value[0] == 'V' &&  this.m1022_oth_diag1_severity.getGroupValue()!=null){
         errs.push(['M1020', 'If byte 1 of M1022_OTH_DIAG1_ICD is a space and byte 2 is equal to "V" (i.e., it is a V-code), then M1022_OTH_DIAG1_SEVERITY must be blank'])
         }
         if(this.m1022_oth_diag1_icd.value[0] !='V' && this.m1022_oth_diag1_icd.value[0] !='E' && this.m1022_oth_diag1_severity.getGroupValue() == null){
         errs.push(['M1020', 'M1022_OTH_DIAG1_SEVERITY  cannot be blank']);
         }

         }else{
         if(this.m1022_oth_diag1_icd.value == null && this.m1022_oth_diag1_severity.getGroupValue()!=null){
         errs.push(['M1020', 'If M1022_OTH_DIAG1_ICD is blank, then M1022_OTH_DIAG1_SEVERITY must be blank']);

         }
         }

         if(this.m1022_oth_diag2_icd.value){
         otherDiags2 = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag1_icd, this.m1022_oth_diag3_icd, this.m1022_oth_diag4_icd, this.m1022_oth_diag5_icd]

         Ext.each(otherDiags2, function(el){
         if(this.m1022_oth_diag2_icd.value == el.value){
         errs.push(['M1020', 'M1022_OTH_DIAG2_ICD cannot be equal to '+ el.name]);
         }
         },this);
         if(this.m1022_oth_diag2_icd.value[0] == 'E' &&  this.m1022_oth_diag2_severity.getGroupValue()!=null){
         errs.push(['M1020', 'If byte 1 of M1022_OTH_DIAG2_ICD="E" (i.e., it is an E-code), then M1022_OTH_DIAG2_SEVERITY must be blank'])
         }
         if(this.m1022_oth_diag2_icd.value[0] == 'V' &&  this.m1022_oth_diag2_severity.getGroupValue()!=null){
         errs.push(['M1020', 'If byte 1 of M1022_OTH_DIAG2_ICD is a space and byte 2 is equal to "V" (i.e., it is a V-code), then M1022_OTH_DIAG2_SEVERITY must be blank'])
         }
         if(this.m1022_oth_diag2_icd.value[0] !='V' && this.m1022_oth_diag2_icd.value[0] !='E' && this.m1022_oth_diag2_severity.getGroupValue() == null){
         errs.push(['M1020', 'M1022_OTH_DIAG2_SEVERITY  cannot be blank']);
         }

         }else{
         if(this.m1022_oth_diag2_icd.value == null && this.m1022_oth_diag2_severity.getGroupValue()!=null){
         errs.push(['M1020', "If the other diagnosis 'C1' is blank then the other diagnosis 'C1' severity must also be blank."]);

         }
         if(this.m1022_oth_diag2_icd.value == null && this.m1022_oth_diag3_icd.value !=null){
         errs.push(['M1020', "If the other diagnosis code 'C1' is blank then the other diagnosis code 'D1' must also be blank."]);
         }
         }
         */
        if(this.m1022_oth_diag3_icd.value && validationFlag){
            otherDiags3 = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag1_icd, this.m1022_oth_diag2_icd, this.m1022_oth_diag4_icd, this.m1022_oth_diag5_icd]

            Ext.each(otherDiags3, function(el){
                if(this.m1022_oth_diag3_icd.value == el.value){
                    errs.push(['M1022', 'M1022_OTH_DIAG3_ICD cannot be equal to '+ el.name]);
                }
            },this);
            if(this.m1022_oth_diag3_icd.value[0] == 'E' &&  this.m1022_oth_diag3_severity.getGroupValue()!= ' '){
                errs.push(['M1022', "Since Other Diagnoses 3 ICD code first character is 'E'(i.e.,E-Code), then other Diagnoses 3 severity must be blank."])
            }
            if(this.m1022_oth_diag3_icd.value[0] == 'V' &&  this.m1022_oth_diag3_severity.getGroupValue()!= ' '){
                errs.push(['M1022', "Since Other Diagnoses 3 ICD first character is 'V(i.e., V-Code)', then other Diagnoses 2 severity must be blank."])
            }
            if(this.m1022_oth_diag3_icd.value[0] !='V' && this.m1022_oth_diag3_icd.value[0] !='E' && this.m1022_oth_diag3_severity.getGroupValue() == ' '){
                errs.push(['M1022', "Other diagnoses 3 severity cannot be blank."]);
            }
        }else {
            if (this.m1022_oth_diag3_icd.value == null && this.m1022_oth_diag3_severity.getGroupValue() != ' ') {
                errs.push(['M1022', "Since Other diagnoses 3 ICD code is blank, then Other diagnoses 3 severity 'd2' must be blank."]);
            }
        }

        if(this.m1022_oth_diag4_icd.value && validationFlag){
            otherDiags4 = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag1_icd, this.m1022_oth_diag3_icd, this.m1022_oth_diag2_icd, this.m1022_oth_diag5_icd]

            if(this.m1022_oth_diag3_icd.value == null ){
                errs.push(['M1022', "Since Other diagnoses 3 ICD code is blank, then Other diagnoses 4 ICD code must be blank."]);
            }

            Ext.each(otherDiags4, function(el){
                if(this.m1022_oth_diag4_icd.value == el.value){
                    errs.push(['M1022', 'M1022_OTH_DIAG4_ICD cannot be equal to '+ el.name]);
                }
            },this);
            if(this.m1022_oth_diag4_icd.value[0] == 'E' && this.m1022_oth_diag4_severity.getGroupValue()!= ' ' ){
                errs.push(['M1022', "Since Other Diagnoses 4 ICD code first character is 'E'(i.e.,E-Code), then other Diagnoses 4 severity 'e2' must be blank."])
            }
            if(this.m1022_oth_diag4_icd.value[0] == 'V' && this.m1022_oth_diag4_severity.getGroupValue()!= ' ' ){
                errs.push(['M1022', "Since Other Diagnoses 4 ICD first character is 'V(i.e., V-Code)', then other Diagnoses 4 severity 'e2' must be blank."])
            }
            if(this.m1022_oth_diag4_icd.value[0] !='V' && this.m1022_oth_diag4_icd.value[0] !='E' && this.m1022_oth_diag4_severity.getGroupValue() == ' ' ){
                errs.push(['M1022', "Other diagnoses 4 severity 'e2' cannot be blank."]);
            }
        }else {
            if (this.m1022_oth_diag4_icd.value == null && this.m1022_oth_diag4_severity.getGroupValue() != ' ') {
                errs.push(['M1022', "Since Other diagnoses 4 ICD code is blank, then Other diagnoses 4 severity 'e2' must be blank."]);
            }
        }

        if(this.m1022_oth_diag5_icd.value && validationFlag){
            otherDiags5 = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag1_icd, this.m1022_oth_diag3_icd, this.m1022_oth_diag2_icd, this.m1022_oth_diag4_icd]

            if(this.m1022_oth_diag4_icd.value == null && this.m1022_oth_diag5_icd.value != null){
                errs.push(['M1022', "Since Other diagnoses 4 ICD code is blank, then Other diagnoses 5 ICD code must be blank."]);
            }

            Ext.each(otherDiags5, function(el){
                if(this.m1022_oth_diag5_icd.value == el.value){
                    errs.push(['M1022', 'M1022_OTH_DIAG5_ICD cannot be equal to '+ el.name]);
                }
            },this);
            if(this.m1022_oth_diag5_icd.value[0] == 'E' && this.m1022_oth_diag5_severity.getGroupValue() != ' ' ){
                errs.push(['M1022', "Since Other Diagnoses 5 ICD code first character is 'E'(i.e.,E-Code), then Other Diagnoses 5 severity 'f2' must be blank."])
            }
            if(this.m1022_oth_diag5_icd.value[0] == 'V' && this.m1022_oth_diag5_severity.getGroupValue() != ' '){
                errs.push(['M1022', "Since Other Diagnoses 5 ICD first character is 'V(i.e., V-Code)', then other Diagnoses 5 severity 'f2' must be blank."])
            }
            if(this.m1022_oth_diag5_icd.value[0] != 'V' && this.m1022_oth_diag5_icd.value[0] != 'E' && this.m1022_oth_diag5_severity.getGroupValue() == ' '){
                errs.push(['M1022', "Other diagnoses 5 severity 'f2' cannot be blank."]);
            }
        }else {
            if (this.m1022_oth_diag5_icd.value == null && this.m1022_oth_diag5_severity.getGroupValue() != ' ') {
                errs.push(['M1022', "Since Other diagnoses 5 ICD code is blank, then Other diagnoses 5 severity 'f2' must be blank."]);
            }
        }

        //for d3,d4
        if(this.m1024_pmt_diag_icd_d3.value){

            pmtDiagsd3 = [this.m1024_pmt_diag_icd_a3, this.m1024_pmt_diag_icd_b3, this.m1024_pmt_diag_icd_c3];

            Ext.each(pmtDiagsd3, function(el){
                if(this.m1024_pmt_diag_icd_d3.value == el.value){
                    errs.push(['M1024', "The payment diagnosis code 'd3' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);

            if(this.m1022_oth_diag3_icd.value == null){
                errs.push(['M1024', "Since Other diagnoses 3 ICD is blank, then payment diagnoses 'd3' ICD must be blank."]);
            }else{
                if(this.m1022_oth_diag3_icd.value[0] != 'V'){
                    errs.push(['M1022', "If the payment diagnoses 'd3' is not blank, then other diagnosis 3 ICD should be a V-code"]);
                }
            }
        } if(this.m1024_pmt_diag_icd_d3.value == null  && this.m1024_pmt_diag_icd_d4.value != null){
            errs.push(['M1024', "Since Payment diagnoses 'd3' is blank, then payment diagnoses 'd4' must be blank."]);
        }

        if(this.m1024_pmt_diag_icd_d4.value){
            pmtDiagsd4 = [this.m1024_pmt_diag_icd_a4, this.m1024_pmt_diag_icd_b4, this.m1024_pmt_diag_icd_c4];

            Ext.each(pmtDiagsd4, function(el){
                if(this.m1024_pmt_diag_icd_d4.value == el.value){
                    errs.push(['M1024', "The payment diagnosis code 'd4' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
        }

        //for e3,e4
        if(this.m1024_pmt_diag_icd_e3.value){

            pmtDiagse3 = [this.m1024_pmt_diag_icd_a3, this.m1024_pmt_diag_icd_b3, this.m1024_pmt_diag_icd_c3, this.m1024_pmt_diag_icd_d3];

            Ext.each(pmtDiagse3, function(el){
                if(this.m1024_pmt_diag_icd_e3.value == el.value){
                    errs.push(['M1024', "The payment diagnosis code 'e3' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
            
            if(this.m1022_oth_diag4_icd.value == null){
                errs.push(['M1024', "Since Other diagnoses 4 ICD is blank, then payment diagnoses 'e3' ICD must be blank."]);
            }else{
                if(this.m1022_oth_diag4_icd.value[0]!='V'){
                    errs.push(['M1022', "If the payment diagnoses 'e3' is not blank, then other diagnosis 4 ICD should be a V-code"]);
                }
            }
        } if(this.m1024_pmt_diag_icd_e3.value == null  && this.m1024_pmt_diag_icd_e4.value != null){
            errs.push(['M1024', "Since Payment diagnoses 'e3' is blank, then payment diagnoses 'e4' must be blank."]);
        }

        if(this.m1024_pmt_diag_icd_e4.value){
            pmtDiagse4 = [this.m1024_pmt_diag_icd_a4, this.m1024_pmt_diag_icd_b4, this.m1024_pmt_diag_icd_c4,this.m1024_pmt_diag_icd_d4];

            Ext.each(pmtDiagse4, function(el){
                if(this.m1024_pmt_diag_icd_e4.value == el.value){
                    errs.push(['M1024', "The payment diagnosis code 'e4' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
        }



        //for f3,f4
        if(this.m1024_pmt_diag_icd_f3.value){

            pmtDiagsf3 = [this.m1024_pmt_diag_icd_a3, this.m1024_pmt_diag_icd_b3, this.m1024_pmt_diag_icd_c3, this.m1024_pmt_diag_icd_d3, this.m1024_pmt_diag_icd_e3]
            
            Ext.each(pmtDiagsf3, function(el){
                if(this.m1024_pmt_diag_icd_f3.value == el.value){
                    errs.push(['M1024', "The payment diagnosis code 'f3' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this); 

            if(this.m1022_oth_diag5_icd.value == null){
                errs.push(['M1024', "Since Other diagnoses 5 ICD is blank, then payment diagnoses 'f3' ICD must be blank."]);
            }else{
                if(this.m1022_oth_diag5_icd.value[0] != 'V'){
                    errs.push(['M1022', "If the payment diagnoses 'f3' is not blank, then other diagnosis 5 ICD should be a V-code"]);
                }
            }
        }if(this.m1024_pmt_diag_icd_f3.value == null  && this.m1024_pmt_diag_icd_f4.value != null){
            errs.push(['M1024', "Since Payment diagnoses 'f3' is blank, then payment diagnoses 'f4' must be blank."]);
        }

        if(this.m1024_pmt_diag_icd_f4.value){
            pmtDiagsf4 = [this.m1024_pmt_diag_icd_a4 , this.m1024_pmt_diag_icd_b4, this.m1024_pmt_diag_icd_c4, this.m1024_pmt_diag_icd_d4, this.m1024_pmt_diag_icd_e4]
            Ext.each(pmtDiagsf4, function(el){
                if(this.m1024_pmt_diag_icd_f4.value == el.value){
                    errs.push(['M1024', "The payment diagnosis code 'f4' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
        }

        return errs;

    },

    getMessage: function(code){
        icd_codes = {}
        icd_codes["m1020_primary_diag_icd"] = "primary diagnosis code 'a1'.";
        icd_codes["m1022_oth_diag1_icd"] = "other diagnosis code 'b1'.";
        icd_codes["m1022_oth_diag2_icd"] = "other diagnosis code 'c1'.";
        icd_codes["m1022_oth_diag3_icd"] = "other diagnosis code 'd1'.";
        icd_codes["m1022_oth_diag4_icd"] = "other diagnosis code 'e1'.";
        icd_codes["m1022_oth_diag5_icd"] = "other diagnosis code 'f1'.";

        icd_codes["m1024_pmt_diag_icd_a3"] = "payment diagnosis code 'a3'.";
        icd_codes["m1024_pmt_diag_icd_b3"] = "payment diagnosis code 'b3'.";
        icd_codes["m1024_pmt_diag_icd_c3"] = "payment diagnosis code 'c3'.";
        icd_codes["m1024_pmt_diag_icd_d3"] = "payment diagnosis code 'd3'.";
        icd_codes["m1024_pmt_diag_icd_e3"] = "payment diagnosis code 'e3'.";        
        
        icd_codes["m1024_pmt_diag_icd_a4"] = "payment diagnosis code 'a4'.";
        icd_codes["m1024_pmt_diag_icd_b4"] = "payment diagnosis code 'b4'.";
        icd_codes["m1024_pmt_diag_icd_c4"] = "payment diagnosis code 'c4'.";
        icd_codes["m1024_pmt_diag_icd_d4"] = "payment diagnosis code 'd4'.";
        icd_codes["m1024_pmt_diag_icd_e4"] = "payment diagnosis code 'e4'.";

        return icd_codes[code]
    },

    pmtDiagIcdCodes: function(errs){
        if(this.m1024_pmt_diag_icd_a3.value){
            if(this.m1020PrimaryDiagIcd.value[0]!='V'){
                errs.push(['M1024', "Primary Diagnoses code should be a V-code."]);
            }
        } else if(this.m1024_pmt_diag_icd_a3.value == null  && this.m1024_pmt_diag_icd_a4.value!==null){
            errs.push(['M1024', "If the payment diagnosis code 'A3' is blank then the payment diagnosis code 'A4' must also be blank."]);
        }
    },
    serverValidationRequiredFields: function(){
        return ["m1022_oth_diag3_icd", "m1022_oth_diag4_icd", "m1022_oth_diag5_icd", "m1024_pmt_diag_icd_d3", "m1024_pmt_diag_icd_d4",
            "m1024_pmt_diag_icd_e3", "m1024_pmt_diag_icd_e4", "m1024_pmt_diag_icd_f3", "m1024_pmt_diag_icd_f4"]
    },
    serverValidationRequiredFieldsSuffix: function(){
        return ["d1", "e1", "f1", "d3", "d4", "e3", "e4", "f3", "f4"]
    },
    disableSeverity: function(){
        Ext.each(this.M1024SeverityAndPmtFieldsName, function(fieldsSet, index){
            Ext.each(fieldsSet, function(fName, i){
                fields = this.mainScope.query("[name="+fName+"]");
                Ext.each(fields, function(individualField, j){
                    individualField.disable();
                }, this);
            }, this);
        }, this);
    },
    resetM1022OthDiag5Severity: function(){
        this.m1022_oth_diag5_icd.on('select', function(el){
            if(el.value==" " || el.value == null){
                this.query("[name=m1022_oth_diag5_severity]").forEach(function(n){ n.setValue(' ');});
            }else{
                if(el.value[0]=='V' || el.value[0]=='E' ){
                    this.query("[name=m1022_oth_diag5_severity]").forEach(function(n){ n.setValue(' ');});
                }
            }
        },this);

        this.m1022_oth_diag5_icd.on('change', function(el){
            if(el.value==" " || el.value== null){
                this.query("[name=m1022_oth_diag5_severity]").forEach(function(n){ n.setValue(' ');});
            }
        },this);
    },
    resetM1022OthDiag4Severity: function(){
        this.m1022_oth_diag4_icd.on('select', function(el){
            if(el.value==" " || el.value == null){
                this.query("[name=m1022_oth_diag4_severity]").forEach(function(n){ n.setValue(' ');});
            }else{
                if(el.value[0]=='V' || el.value[0]=='E' ){
                    this.query("[name=m1022_oth_diag4_severity]").forEach(function(n){ n.setValue(' ');});
                }
            }
        },this);

        this.m1022_oth_diag4_icd.on('change', function(el){
            if(el.value==" " || el.value== null){
                this.query("[name=m1022_oth_diag4_severity]").forEach(function(n){ n.setValue(' ');});
            }
        },this);
    },
    resetM1022OthDiag3Severity: function(){
        this.m1022_oth_diag3_icd.on('select', function(el){
            if(el.value==" " || el.value == null){
                this.query("[name=m1022_oth_diag3_severity]").forEach(function(n){ n.setValue(' ');});
            }else{
                if(el.value[0]=='V' || el.value[0]=='E' ){
                    this.query("[name=m1022_oth_diag3_severity]").forEach(function(n){ n.setValue(' ');});
                }
            }
        },this);

        this.m1022_oth_diag3_icd.on('change', function(el){
            if(el.value==" " || el.value== null){
                this.query("[name=m1022_oth_diag3_severity]").forEach(function(n){ n.setValue(' ');});
            }
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
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.m1020PrimaryDiagIcd = this.mainScope.down("[name=m1020_primary_diag_icd]");
        this.m1020PrimaryDiagSeverity = this.mainScope.down("[name=m1020_primary_diag_severity]");
        this.m1022_oth_diag1_icd = this.mainScope.down("[name=m1022_oth_diag1_icd]");
        this.m1022_oth_diag2_icd = this.mainScope.down("[name=m1022_oth_diag2_icd]");
        this.m1022_oth_diag3_icd = this.mainScope.down("[name=m1022_oth_diag3_icd]");
        this.m1022_oth_diag4_icd = this.mainScope.down("[name=m1022_oth_diag4_icd]");
        this.m1022_oth_diag5_icd = this.mainScope.down("[name=m1022_oth_diag5_icd]");
        this.m1022_oth_diag1_severity = this.mainScope.down("[name=m1022_oth_diag1_severity]");
        this.m1022_oth_diag2_severity = this.mainScope.down("[name=m1022_oth_diag2_severity]");
        this.m1022_oth_diag3_severity = this.mainScope.down("[name=m1022_oth_diag3_severity]");
        this.m1022_oth_diag4_severity = this.mainScope.down("[name=m1022_oth_diag4_severity]");
        this.m1022_oth_diag5_severity = this.mainScope.down("[name=m1022_oth_diag5_severity]");
        this.m1024_pmt_diag_icd_a3 = this.mainScope.down("[name=m1024_pmt_diag_icd_a3]");
        this.m1024_pmt_diag_icd_a4 = this.mainScope.down("[name=m1024_pmt_diag_icd_a4]");
        this.m1024_pmt_diag_icd_b3 = this.mainScope.down("[name=m1024_pmt_diag_icd_b3]");
        this.m1024_pmt_diag_icd_b4 = this.mainScope.down("[name=m1024_pmt_diag_icd_b4]");
        this.m1024_pmt_diag_icd_c3 = this.mainScope.down("[name=m1024_pmt_diag_icd_c3]");
        this.m1024_pmt_diag_icd_c4 = this.mainScope.down("[name=m1024_pmt_diag_icd_c4]");
        this.m1024_pmt_diag_icd_d3 = this.mainScope.down("[name=m1024_pmt_diag_icd_d3]");
        this.m1024_pmt_diag_icd_d4 = this.mainScope.down("[name=m1024_pmt_diag_icd_d4]");
        this.m1024_pmt_diag_icd_e3 = this.mainScope.down("[name=m1024_pmt_diag_icd_e3]");
        this.m1024_pmt_diag_icd_e4 = this.mainScope.down("[name=m1024_pmt_diag_icd_e4]");
        this.m1024_pmt_diag_icd_f3 = this.mainScope.down("[name=m1024_pmt_diag_icd_f3]");
        this.m1024_pmt_diag_icd_f4 = this.mainScope.down("[name=m1024_pmt_diag_icd_f4]");
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
        this.episodeDate = Ext.ComponentQuery.query('#patient_treatment_episode')[0];
        this.resetM1022OthDiag3Severity();
        this.resetM1022OthDiag4Severity();
        this.resetM1022OthDiag5Severity();

        this.m1022ICDs = [this.m1022_oth_diag3_icd, this.m1022_oth_diag4_icd, this.m1022_oth_diag5_icd];
        this.M1024SeverityAndPmtFieldsName = [["m1022_oth_diag3_severity", "m1024_pmt_diag_icd_d3", "m1024_pmt_diag_icd_d4"],
            ["m1022_oth_diag4_severity", "m1024_pmt_diag_icd_e3", "m1024_pmt_diag_icd_e4" ],
            ["m1022_oth_diag5_severity", "m1024_pmt_diag_icd_f3", "m1024_pmt_diag_icd_f4"]];
        this.codeIsVcodeDisableFieldsList = [["m1022_oth_diag3_severity"],
            ["m1022_oth_diag4_severity" ],
            ["m1022_oth_diag5_severity"]];

        Ext.each(this.m1022ICDs, function(field, index){
            field.on('select', function(el){
                if(el.value == null && el.value == ""){
                    this.disableFields(this.M1024SeverityAndPmtFieldsName[index]);
                }else if(el.value[0] != "V" && el.value[0] != "E"){
                    this.enableFields(this.M1024SeverityAndPmtFieldsName[index]);
                }else if(el.value[0] == "V" || el.value[0] == "E"){
                    this.disableFields(this.codeIsVcodeDisableFieldsList[index]);
                }
            }, this);
        }, this);
    }

})
