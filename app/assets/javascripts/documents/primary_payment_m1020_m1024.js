/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.PrimaryPaymentM1020M1024', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.primaryPaymentM1020M1024',
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
                            text: ' Diagnoses (Sequencing of diagnoses should reflect the seriousness of each condition and support the disciplines and services provided.) '
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
                            text: 'Complete if a V-code is  assigned under certain  circumstances to Column 2  in place of a case mix  diagnosis.  '
                        },
                        {
                            xtype: 'label',
                            padding: '10px',
                            width: 337,
                            text: 'Complete only if the V-code in Column 2 is reported in place of a case mix diagnosis that is a multiple coding situation (for example: a manifestation code). '
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
                            name: "m1020_primary_diag_icd",
                            margin: '10 0 0 0',
                            padding: 2,
                            width: 197,
                            fieldLabel: '(M1020) Primary Diagnoses (v-codes are allowed) a1.',
                            labelStyle: 'width: 150px',
                            cls: 'oasis_green',
                            itemId: 'pri_diag',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 214,
                            fieldLabel: '(M1020) Severity rating a2.',
                            cls: 'oasis_green',
                            itemId: 'sev_rate',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1020_primary_diag_severity',
                                    boxLabel: 'NA',
                                    checked: true,
                                    width: '41px',
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1020_primary_diag_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1020_primary_diag_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1020_primary_diag_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1020_primary_diag_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1020_primary_diag_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_a3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 202,
                            fieldLabel: '(M1024) Payment Diagnoses (OPTIONAL V or E codes not allowed) a3.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_a3',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_a4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 197,
                            fieldLabel: '(M1024) Payment Diagnoses 2 (OPTIONAL V or E - codes not allowed) a4.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_a4',
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
                            name: "m1022_oth_diag1_icd",
                            padding: 2,
                            margin: '10 0 0 0',
                            width: 197,
                            fieldLabel: '(M1022) Other Diagnoses (v-codes and E-codes are allowed) b1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_b1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            padding: 2,
                            width: 214,
                            margin: '10 0 0 5',
                            fieldLabel: '(M1022) Severity rating b2.',
                            cls: 'oasis_green',
                            itemId: 'sev_rate_b2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1022_oth_diag1_severity',
                                    boxLabel: 'NA',
                                    checked: true,
                                    width: '41px',
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag1_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag1_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag1_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag1_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag1_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_b3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 202,
                            fieldLabel: '(M1024) Payment Diagnoses (OPTIONAL V or E codes not allowed) b3.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_b3',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_b4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 197,
                            fieldLabel: '(M1024) Payment Diagnoses 2 (OPTIONAL V or E - codes not allowed) b4.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_b4',
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
                            name: "m1022_oth_diag2_icd",
                            margin: '10 0 0 0',
                            padding: 2,
                            width: 197,
                            fieldLabel: '(M1022) Other Diagnoses (v-codes and E-codes are allowed) c1.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_c1',
                            labelAlign: 'top'
                        },
                        {
                            xtype: 'radiogroup',
                            margin: '10 0 0 5',
                            padding: 2,
                            width: 214,
                            fieldLabel: '(M1022) Severity rating c2.',
                            cls: 'oasis_green',
                            itemId: 'oth_diag_c2',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1022_oth_diag2_severity',
                                    boxLabel: 'NA',
                                    checked: true,
                                    width: '41px',
                                    inputValue: ' '
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag2_severity",
                                    inputValue: '00',
                                    boxLabel: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag2_severity",
                                    inputValue: '01',
                                    boxLabel: '1'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag2_severity",
                                    inputValue: '02',
                                    boxLabel: '2'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag2_severity",
                                    inputValue: '03',
                                    boxLabel: '3'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1022_oth_diag2_severity",
                                    inputValue: '04',
                                    boxLabel: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_c3",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 202,
                            fieldLabel: '(M1024) Payment Diagnoses (OPTIONAL V or E codes not allowed) c3.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_c3',
                            labelAlign: "top"
                        },
                        {
                            xtype: 'netzkeremotecombo',
                            name: "m1024_pmt_diag_icd_c4",
                            padding: 2,
                            margin: '10 0 0 5',
                            width: 197,
                            fieldLabel: '(M1024) Payment Diagnoses 2 (OPTIONAL V or E - codes not allowed) c4.',
                            cls: 'oasis_green',
                            itemId: 'pmt_diag_c4',
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
        if(this.m1020PrimaryDiagIcd.value == null && validationFlag){
            errs.push(['M1020', "Enter the primary diagnosis code."]);
        }
        if(this.m1020PrimaryDiagIcd.value && validationFlag) {
            //if (this.m1020PrimaryDiagSeverity.getGroupValue() != 'on') {
                if (this.m1020PrimaryDiagIcd.value[0] != 'V' && this.m1020PrimaryDiagSeverity.getGroupValue() == ' ') {
                    errs.push(['M1020', "Select the primary diagnosis severity."]);
                } else {
                    if (this.m1020PrimaryDiagIcd.value[0] == 'V' && this.m1020PrimaryDiagSeverity.getGroupValue() != ' ') {
                        errs.push(['M1020', "If the primary diagnosis is blank then the primary diagnosis severity must also be blank."]);
                    }
                }
                if (this.m1020PrimaryDiagSeverity.getGroupValue() == "00") {
                    errs.push(['M1020', "The primary diagnosis severity must be between 01 and 04."]);
                }
        }
        if(this.m1022_oth_diag1_icd.value && validationFlag){
            otherDiags = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag2_icd, this.m1022_oth_diag3_icd, this.m1022_oth_diag4_icd, this.m1022_oth_diag5_icd]

            Ext.each(otherDiags, function(el){
                if(this.m1022_oth_diag1_icd.value == el.value){
                    errs.push(['M1022', "The other diagnosis code 'B1' cannot be the same as the " + this.getMessage(el.name)]);
                }
            },this);
            if(this.m1022_oth_diag1_icd.value[0] == 'E' && this.m1022_oth_diag1_severity.getGroupValue()!=' ' ){
                errs.push(['M1022', "If the first character of the other diagnosis code 'B1' is 'E' (i.e., E-code), then the other diagnosis 'B1' severity must be blank."])
            }
            if(this.m1022_oth_diag1_icd.value[0] == 'V' && this.m1022_oth_diag1_severity.getGroupValue()!=' '){
                errs.push(['M1022', "If the first character of the other diagnosis code 'B1' is 'V' (i.e., E-code), then the other diagnosis 'B1' severity must be blank."])
            }
            if(this.m1022_oth_diag1_icd.value[0] !='V' && this.m1022_oth_diag1_icd.value[0] !='E' && this.m1022_oth_diag1_severity.getGroupValue() == ' '){
                errs.push(['M1022', "Select the other diagnosis code 'B1' severity."]);
            }
        }else {
            if (this.m1022_oth_diag1_icd.value == null && this.m1022_oth_diag1_severity.getGroupValue() != ' ' ) {
                errs.push(['M1022', "If the other diagnosis 'B1' is blank then the other diagnosis 'B1' severity must also be blank."]);
            }
            if (this.m1022_oth_diag1_icd.value == null&& this.m1022_oth_diag2_icd.value != null) {
                    errs.push(['M1022', "Since Other diagnoses 1 ICD code is blank, then Other diagnoses 2 ICD code must be blank."]);
                }
            }

        if(this.m1022_oth_diag2_icd.value && validationFlag){
            otherDiags2 = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag1_icd, this.m1022_oth_diag3_icd, this.m1022_oth_diag4_icd, this.m1022_oth_diag5_icd]

            Ext.each(otherDiags2, function(el){
                if(this.m1022_oth_diag2_icd.value == el.value){
                    errs.push(["M1022", "The other diagnosis code 'C1' cannot be the same as the "  + this.getMessage(el.name)]);
                }
            },this);
            if(this.m1022_oth_diag2_icd.value[0] == 'E' && this.m1022_oth_diag2_severity.getGroupValue() != ' '){
                errs.push(['M1022', "If the first character of the other diagnosis code 'C1' is 'E' (i.e., E-code), then the other diagnosis 'C1' severity must be blank."])
            }
            if(this.m1022_oth_diag2_icd.value[0] == 'V' && this.m1022_oth_diag2_severity.getGroupValue() != ' '){
                errs.push(['M1022', "If the first character of the other diagnosis code 'C1' is 'V' (i.e., E-code), then the other diagnosis 'C1' severity must be blank."])
            }
            if(this.m1022_oth_diag2_icd.value[0] !='V' && this.m1022_oth_diag2_icd.value[0] !='E' && this.m1022_oth_diag2_severity.getGroupValue() == ' '){
                errs.push(['M1022', "Select the other diagnosis code 'C1' severity."]);
            }
        }else {
            if (this.m1022_oth_diag2_icd.value == null && this.m1022_oth_diag2_severity.getGroupValue() != ' ') {
                errs.push(['M1022', "If the other diagnosis 'C1' is blank then the other diagnosis 'C1' severity must also be blank."]);
            }
        }
        //In This page m1022_oth_diag3_icd, m1022_oth_diag4,...5 not available
        /*if(this.m1022_oth_diag3_icd.value){
         otherDiags3 = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag1_icd, this.m1022_oth_diag2_icd, this.m1022_oth_diag4_icd, this.m1022_oth_diag5_icd]

         Ext.each(otherDiags3, function(el){
         if(this.m1022_oth_diag3_icd.value == el.value){
         errs.push(['M1020', 'M1022_OTH_DIAG3_ICD cannot be equal to '+ el.name]);
         }
         },this);
         if(this.m1022_oth_diag3_icd.value[0] == 'E' &&  this.m1022_oth_diag3_severity.getGroupValue()!=null){
         errs.push(['M1020', 'If byte 1 of M1022_OTH_DIAG3_ICD="E" (i.e., it is an E-code), then M1022_OTH_DIAG3_SEVERITY must be blank'])
         }
         if(this.m1022_oth_diag3_icd.value[0] == 'V' &&  this.m1022_oth_diag3_severity.getGroupValue()!=null){
         errs.push(['M1020', 'If byte 1 of M1022_OTH_DIAG3_ICD is a space and byte 2 is equal to "V" (i.e., it is a V-code), then M1022_OTH_DIAG3_SEVERITY must be blank'])
         }
         if(this.m1022_oth_diag3_icd.value[0] !='V' && this.m1022_oth_diag3_icd.value[0] !='E' && this.m1022_oth_diag3_severity.getGroupValue() == null){
         errs.push(['M1020', 'M1022_OTH_DIAG3_SEVERITY  cannot be blank']);
         }

         }else{
         if(this.m1022_oth_diag3_icd.value == null && this.m1022_oth_diag3_severity.getGroupValue()!=null){
         errs.push(['M1022', "Since Other diagnoses 3 ICD code is blank, then Other diagnoses 3 severity 'd' must be blank."]);
         }
         }

         if(this.m1022_oth_diag4_icd.value){
         otherDiags4 = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag1_icd, this.m1022_oth_diag3_icd, this.m1022_oth_diag2_icd, this.m1022_oth_diag5_icd]

         if(this.m1022_oth_diag3_icd.value == null && this.m1022_oth_diag4_icd.value != null){
         errs.push(['M1022', "Since Other diagnoses 3 ICD code is blank, then Other diagnoses 4 ICD code must be blank."]);
         }

         Ext.each(otherDiags4, function(el){
         if(this.m1022_oth_diag4_icd.value == el.value){
         errs.push(['M1020', 'M1022_OTH_DIAG4_ICD cannot be equal to '+ el.name]);
         }
         },this);
         if(this.m1022_oth_diag4_icd.value[0] == 'E' &&  this.m1022_oth_diag4_severity.getGroupValue()!=null){
         errs.push(['M1020', 'If byte 1 of M1022_OTH_DIAG4_ICD="E" (i.e., it is an E-code), then M1022_OTH_DIAG4_SEVERITY must be blank'])
         }
         if(this.m1022_oth_diag4_icd.value[0] == 'V' &&  this.m1022_oth_diag4_severity.getGroupValue()!=null){
         errs.push(['M1020', 'If byte 1 of M1022_OTH_DIAG4_ICD is a space and byte 2 is equal to "V" (i.e., it is a V-code), then M1022_OTH_DIAG4_SEVERITY must be blank'])
         }
         if(this.m1022_oth_diag4_icd.value[0] !='V' && this.m1022_oth_diag4_icd.value[0] !='E' && this.m1022_oth_diag4_severity.getGroupValue() == null){
         errs.push(['M1020', 'M1022_OTH_DIAG4_SEVERITY  cannot be blank']);
         }

         }else{
         if(this.m1022_oth_diag4_icd.value == null && this.m1022_oth_diag2_severity.getGroupValue()!=null){
         errs.push(['M1022', "Since Other diagnoses 4 ICD code is blank, then Other diagnoses 4 severity 'e' must be blank."]);
         }
         }

         if(this.m1022_oth_diag5_icd.value){
         otherDiags5 = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag1_icd, this.m1022_oth_diag3_icd, this.m1022_oth_diag2_icd, this.m1022_oth_diag4_icd]

         if(this.m1022_oth_diag4_icd.value == null && this.m1022_oth_diag5_icd.value != null){
         errs.push(['M1022', "Since Other diagnoses 4 ICD code is blank, then Other diagnoses 5 ICD code must be blank."]);
         }

         Ext.each(otherDiags4, function(el){
         if(this.m1022_oth_diag5_icd.value == el.value){
         errs.push(['M1020', 'M1022_OTH_DIAG5_ICD cannot be equal to '+ el.name]);
         }
         },this);
         if(this.m1022_oth_diag5_icd.value[0] == 'E' &&  this.m1022_oth_diag4_severity.getGroupValue()!=null){
         errs.push(['M1020', "Since Other Diagnoses 5 ICD code first character is 'E'(i.e.,E-Code), then Other Diagnoses 5 severity 'f' must be blank."])
         }
         if(this.m1022_oth_diag5_icd.value[0] == 'V' &&  this.m1022_oth_diag5_severity.getGroupValue()!=null){
         errs.push(['M1020', "Since Other Diagnoses 5 ICD first character is 'V(i.e., V-Code)', then other Diagnoses 5 severity 'f' must be blank."])
         }
         if(this.m1022_oth_diag5_icd.value[0] !='V' && this.m1022_oth_diag5_icd.value[0] !='E' && this.m1022_oth_diag5_severity.getGroupValue() == null){
         errs.push(['M1020', "Other diagnoses 5 severity 'f' cannot be blank."]);
         }

         }else{
         if(this.m1022_oth_diag5_icd.value == null && this.m1022_oth_diag2_severity.getGroupValue()!=null){
         errs.push(['M1022', "Since Other diagnoses 5 ICD code is blank, then Other diagnoses 5 severity 'f' must be blank."]);
         }
         } */

        //pmt_diag_icd_codes(errs)
        //for a3, a4

        if(this.m1024_pmt_diag_icd_a3.value){
            if(this.m1020PrimaryDiagIcd.value !=null && this.m1020PrimaryDiagIcd.value[0]!='V'){
                errs.push(['M1020', "If the payment diagnosis code 'A3' is not blank, then Primary Diagnoses code should be a V-code."]);
            }
        }else if(this.m1024_pmt_diag_icd_a3.value == null  && this.m1024_pmt_diag_icd_a4.value!==null){
            errs.push(['M1024', "If the payment diagnosis code 'A3' is blank then the payment diagnosis code 'A4' must also be blank."]);
        }
        //for b3, b4
        if(this.m1024_pmt_diag_icd_b3.value){

            if(this.m1024_pmt_diag_icd_b3.value == this.m1024_pmt_diag_icd_a3.value) {
                errs.push(["M1024", "The payment diagnosis code 'B3' cannot be same as the payment diagnosis code 'A3'."]);
            }

            if(this.m1022_oth_diag1_icd.value == null){
                errs.push(['M1024', "If the other diagnosis code 'B1' is blank then the payment diagnosis code 'B3' must also be blank."]);
            }else{
                if(this.m1022_oth_diag1_icd && this.m1022_oth_diag1_icd.value[0]!='V'){
                    errs.push(['M1022', "If the payment diagnosis code 'B3' is not blank, then Other diagnoses 1 ICD code must be a V-code."]);
                }
            }
        }

        if(this.m1024_pmt_diag_icd_b4.value) {
            if(this.m1024_pmt_diag_icd_b4.value == this.m1024_pmt_diag_icd_a4.value) {
                errs.push(["M1024", "The payment diagnosis code 'B4' cannot be same as the payment diagnosis code 'A4'."]);
            }
        }

        if(this.m1024_pmt_diag_icd_b3.value == null && this.m1024_pmt_diag_icd_b4.value!=null){
            errs.push(['M1024', "If the payment diagnosis code 'B3' is blank then the payment diagnosis code 'B4' must also be blank."]);
        }
        //for c3, c4
        if(this.m1024_pmt_diag_icd_c3.value){
            if(this.m1022_oth_diag2_icd.value == null){
                errs.push(['M1024', "If the other diagnosis code 'C1' is blank then the payment diagnosis code 'C3' must also be blank."]);
            }else{
                if(this.m1022_oth_diag2_icd && this.m1022_oth_diag2_icd.value[0]!='V'){
                    errs.push(['M1022', "If the payment diagnosis code 'C3' is not balnk, then other diagnoses 2 ICD code must be a V-code."]);
                }
            }

            paymentDiagsC3 = [this.m1024_pmt_diag_icd_a3, this.m1024_pmt_diag_icd_b3];
            Ext.each(paymentDiagsC3, function(el) {
                if(this.m1024_pmt_diag_icd_c3.value == el.value) {
                    errs.push(["M1024", "The payment diagnosis code 'C3' cannot be same as the "+ this.getMessage(el.name)]);
                }
            }, this);
        } 

        if(this.m1024_pmt_diag_icd_c4.value) {
            paymentDiagsC4 = [this.m1024_pmt_diag_icd_a4, this.m1024_pmt_diag_icd_b4];
            Ext.each(paymentDiagsC4, function(el) {
                if(this.m1024_pmt_diag_icd_c4.value == el.value) {
                    errs.push(["M1024", "The optional diagnosis 'C4' cannot be same as the "+ this.getMessage(el.name)]);
                }
            },this);
        }

        if(this.m1024_pmt_diag_icd_c3.value == null  && this.m1024_pmt_diag_icd_c4.value!=null){
            errs.push(['M1024', "If the payment diagnosis code 'C3' is blank then the payment diagnosis code 'C4' must also be blank."]);
        }
        /*
         //for d3,d4
         if(this.m1024_pmt_diag_icd_d3.value){
         if(this.m1022_oth_diag3_icd.value == null){
         errs.push(['M1020', "Since Other diagnoses 3 ICD is blank, then payment diagnoses 'd3' ICD must be blank."]);
         }else{
         if(this.m1022_oth_diag3_icd.value[0]!='V'){
         errs.push(['M1020', 'M1022_OTH_DIAG3_ICD should be a V-code']);
         }
         }
         } if(this.m1024_pmt_diag_icd_d3.value == null  && this.m1024_pmt_diag_icd_d4.value!=null){
         errs.push(['M1020', "Since Payment diagnoses 'd3' is blank, then payment diagnoses 'd4' must be blank."]);
         }
         //for e3,e4
         if(this.m1024_pmt_diag_icd_e3.value){
         if(this.m1022_oth_diag4_icd.value == null){
         errs.push(['M1020', "Since Other diagnoses 4 ICD is blank, then payment diagnoses 'e3' ICD must be blank."]);
         }else{
         if(this.m1022_oth_diag4_icd.value[0]!='V'){
         errs.push(['M1020', 'M1022_OTH_DIAG4_ICD should be a V-code']);
         }
         }
         } if(this.m1024_pmt_diag_icd_e3.value == null  && this.m1024_pmt_diag_icd_e4.value!=null){
         errs.push(['M1020', "Since Payment diagnoses 'e3' is blank, then payment diagnoses 'e4' must be blank."]);
         }
         //for f3,f4
         if(this.m1024_pmt_diag_icd_f3.value){
         if(this.m1022_oth_diag5_icd.value == null){
         errs.push(['M1020', "Since Other diagnoses 5 ICD is blank, then payment diagnoses 'f3' ICD must be blank."]);
         }else{
         if(this.m1022_oth_diag5_icd.value[0]!='V'){
         errs.push(['M1020', 'M1022_OTH_DIAG5_ICD should be a V-code']);
         }
         }
         }if(this.m1024_pmt_diag_icd_f3.value == null  && this.m1024_pmt_diag_icd_f4.value!=null){
         errs.push(['M1020', "Since Payment diagnoses 'f3' is blank, then payment diagnoses 'f4' must be blank."]);
         }

         */
        return errs;

    },
    getMessage: function(code){
        icd_codes = {}
        icd_codes["m1020_primary_diag_icd"] = "primary diagnosis code 'A1'";
        icd_codes["m1022_oth_diag1_icd"] = "other diagnosis code 'B1'";
        icd_codes["m1022_oth_diag2_icd"] = "other diagnosis code 'C1'";
        icd_codes["m1022_oth_diag3_icd"] = "other diagnosis code 'D1'";
        icd_codes["m1022_oth_diag4_icd"] = "other diagnosis code 'E1'";
        icd_codes["m1022_oth_diag5_icd"] = "other diagnosis code 'F1'";

        icd_codes["m1024_pmt_diag_icd_a3"] = "payment diagnosis code 'A3'.";
        icd_codes["m1024_pmt_diag_icd_b3"] = "payment diagnosis code 'B3'.";
        icd_codes["m1024_pmt_diag_icd_a4"] = "payment diagnosis code 'A4'.";
        icd_codes["m1024_pmt_diag_icd_b4"] = "payment diagnosis code 'B4'.";

        return icd_codes[code]
    },
    pmtDiagIcdCodes: function(errs){
        if(this.m1024_pmt_diag_icd_a3.value){
            if(this.m1020PrimaryDiagIcd.value[0]!='V'){
                errs.push(['M1020', "Primary Diagnoses code should be a V-code."]);
            }
        }else if(this.m1024_pmt_diag_icd_a3.value == null  && this.m1024_pmt_diag_icd_a4.value!==null){
            errs.push(['M1024', "If the payment diagnosis code 'A3' is blank then the payment diagnosis code 'A4' must also be blank."]);
        }
    },
    disableSeverityAndPaymentDiagnoses: function(){
        Ext.each(this.M1024SeverityAndPriFieldsName, function(fieldsSet, index){
            Ext.each(fieldsSet, function(fName, i){
                fields = this.mainScope.query("[name="+fName+"]");
                Ext.each(fields, function(individualField, j){
                    individualField.disable();
                }, this);
            }, this);
        }, this);
    },
    resetM1022OthDiag2Severity: function(){
        this.m1022_oth_diag2_icd.on('select', function(el){
            if(el.value==" " || el.value == null){
                this.query("[name=m1022_oth_diag2_severity]").forEach(function(n){ n.setValue(' ');});
            } else {
                if(el.value[0]=='V' || el.value[0]=='E' ){
                    this.query("[name=m1022_oth_diag2_severity]").forEach(function(n){ n.setValue(' ');});
                }
            }
        },this);

        this.m1022_oth_diag2_icd.on('change', function(el){
            if(el.value==" " || el.value== null){
                this.query("[name=m1022_oth_diag2_severity]").forEach(function(n){ n.setValue(' ');});
            }
        },this);
    },
    resetM1022OthDiag1Severity: function(){
        this.m1022_oth_diag1_icd.on('select', function(el){
            if(el.value==" " || el.value == null){
                this.query("[name=m1022_oth_diag1_severity]").forEach(function(n){ n.setValue(' ');});
            } else {
                if(el.value[0]=='V' || el.value[0]=='E' ){
                    this.query("[name=m1022_oth_diag1_severity]").forEach(function(n){ n.setValue(' ');});
                }
            }
        },this);

        this.m1022_oth_diag1_icd.on('change', function(el){
            if(el.value==" " || el.value== null){
                this.query("[name=m1022_oth_diag1_severity]").forEach(function(n){ n.setValue(' ');});
            }
        },this);
    },
    resetPrimaryDiagSeverity: function(){
        this.m1020PrimaryDiagIcd.on('select', function(el){
            if(el.value==" " || el.value == null){
                this.query("[name=m1020_primary_diag_severity]").forEach(function(n){ n.setValue(' ');});
            } else {
                if(el.value[0]=='V' || el.value[0]=='E' ){
                    this.query("[name=m1020_primary_diag_severity]").forEach(function(n){ n.setValue(' ');});
                }
            }
        },this);

        this.m1020PrimaryDiagIcd.on('change', function(el){
            if(el.value==" " || el.value== null){
                this.query("[name=m1020_primary_diag_severity]").forEach(function(n){ n.setValue(' ');});
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
    serverValidationRequiredFields: function(){
        return ["m1020_primary_diag_icd", "m1022_oth_diag1_icd", "m1022_oth_diag2_icd", "m1024_pmt_diag_icd_a3", "m1024_pmt_diag_icd_a4",
            "m1024_pmt_diag_icd_b3", "m1024_pmt_diag_icd_b4", "m1024_pmt_diag_icd_c3", "m1024_pmt_diag_icd_c4"]
    },
    serverValidationRequiredFieldsSuffix: function(){
        return ["a1", "b1", "c1", "a3", "a4", "b3", "b4", "c3", "c4"]
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
        //this.resetDiagSeverity();
        this.resetPrimaryDiagSeverity();
        this.resetM1022OthDiag1Severity();
        this.resetM1022OthDiag2Severity();
        //this.resetDiagSeverity();
        //this.resetM1022OthDiag3Severity();
        //this.resetM1022OthDiag4Severity();
        //this.resetM1022OthDiag5Severity();
        this.m1022ICDs = [this.m1020PrimaryDiagIcd, this.m1022_oth_diag1_icd, this.m1022_oth_diag2_icd];
        this.M1024SeverityAndPriFieldsName = [["m1020_primary_diag_severity", "m1024_pmt_diag_icd_a3", "m1024_pmt_diag_icd_a4"],
            ["m1022_oth_diag1_severity", "m1024_pmt_diag_icd_b3", "m1024_pmt_diag_icd_b4" ],
            ["m1022_oth_diag2_severity", "m1024_pmt_diag_icd_c3", "m1024_pmt_diag_icd_c4"]];
        this.codeIsVcodeDisableFields = [["m1020_primary_diag_severity"],
            ["m1022_oth_diag1_severity" ],
            ["m1022_oth_diag2_severity"]];

        Ext.each(this.m1022ICDs, function(field, index){
            field.on('select', function(el){
                if(el.value == null && el.value == ""){
                    this.disableFields(this.M1024SeverityAndPriFieldsName[index]);
                }else if(el.value[0] != "V" && el.value[0] != "E"){
                    this.enableFields(this.M1024SeverityAndPriFieldsName[index]);
                }else if(el.value[0] == "V" || el.value[0] == "E"){
                    this.disableFields(this.codeIsVcodeDisableFields[index]);
                }
            }, this);
        }, this);
    }
})
