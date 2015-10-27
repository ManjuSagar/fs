/**
 * Created by msuser1 on 22/12/14.
 */

Ext.define('Ext.panel.DiagnosisAndProcedureCodesM1011OtherFollowUp', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.diagnosisAndProcedureCodesM1011OtherFollowUp',
    border: false,
    margin: 5,
    items: [

        {
            xtype: 'label',
            text: '(M1011) List each Inpatient Diagnosis and ICD-10-CM code at the level of highest specificity for only those conditions actively treated during an inpatient stay having a discharge date within the last 14 days (no V, W, X, Y or Z codes or surgical codes): '
        },
        {
            xtype: 'panel',
            border: 0,
            height: 105,
            layout: {
                columns: 3,
                type: 'table'
            },
            items: [
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1011_14_day_inp1_icd',
                    fieldLabel: 'a',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1011_14_day_inp3_icd',
                    fieldLabel: 'c',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1011_14_day_inp5_icd',
                    fieldLabel: 'e',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1011_14_day_inp2_icd',
                    fieldLabel: 'b',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1011_14_day_inp4_icd',
                    fieldLabel: 'd',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1011_14_day_inp6_icd',
                    fieldLabel: 'f',
                    labelAlign: 'top',
                    store: [

                    ]
                }
            ]
        },
        {
            xtype: "checkboxfield",
            //fieldLabel: "NA",
            labelAlign: 'right',
            name: 'm1011_14_day_inp_na',
            margin: 5,
            boxLabel: "NA - Not applicable (patient was not discharged from an inpatient facility) ",
            inputValue: "1"
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
        m1011IcdNa = this.mainScope.down('[name=m1011_14_day_inp_na]').value;

        if(m1011IcdNa == false){
            if(this.inp1Icd.value == null && this.inp2Icd.value == null && this.inp3Icd.value == null && this.inp4Icd.value == null
             && this.inp5Icd.value == null && this.inp6Icd.value == null  && validationFlag){
                errs.push(['M1011', "Enter at least one inpatient facility diagnosis code OR select 'NA'."]);
            }
        }

        if(this.inp2Icd.value) {
                if (this.inp2Icd.value == this.inp1Icd.value) {
                    errs.push(['M1011', "Inpatient diagnosis 'b' cannot be the same as inpatient diagnosis 'a'."]);
                }
        }

        if(this.inp3Icd.value) {
            DiagCodes = [this.inp1Icd, this.inp2Icd]

            Ext.each(DiagCodes, function (el) {
                if (this.inp3Icd.value == el.value) {
                    errs.push(['M1011', "Inpatient diagnosis 'c' cannot be the same as inpatient diagnosis " +  this.getMessage(el.name) + "."]);
                }
            }, this);
        }

        if(this.inp4Icd.value) {
            DiagCodes = [this.inp1Icd, this.inp2Icd, this.inp3Icd]

            Ext.each(DiagCodes, function (el) {
                if (this.inp4Icd.value == el.value) {
                    errs.push(['M1011', "Inpatient diagnosis 'd' cannot be the same as inpatient diagnosis " +  this.getMessage(el.name) + "."]);
                }
            }, this);
        }

        if(this.inp5Icd.value) {
            DiagCodes = [this.inp1Icd, this.inp2Icd, this.inp3Icd, this.inp4Icd]

            Ext.each(DiagCodes, function (el) {
                if (this.inp5Icd.value == el.value) {
                    errs.push(['M1011', "Inpatient diagnosis 'e' cannot be the same as inpatient diagnosis " +  this.getMessage(el.name) + "."]);
                }
            }, this);
        }

        if(this.inp6Icd.value) {
            DiagCodes = [this.inp1Icd, this.inp2Icd, this.inp3Icd, this.inp4Icd, this.inp5Icd]

            Ext.each(DiagCodes, function (el) {
                if (this.inp6Icd.value == el.value) {
                    errs.push(['M1011', "Inpatient diagnosis 'f' cannot be the same as inpatient diagnosis " +  this.getMessage(el.name) +"."]);
                }
            }, this);
        }

        if(this.inp1Icd.value == null && this.inp2Icd.value != null){
            errs.push(['M1011', "If inpatient diagnosis 'a' is blank then inpatient diagnosis 'b' must also be blank."]);
        }

        if(this.inp2Icd.value == null && this.inp3Icd.value != null){
            errs.push(['M1011', "If inpatient diagnosis 'b' is blank then inpatient diagnosis 'c' must also be blank."]);
        }

        if(this.inp3Icd.value == null && this.inp4Icd.value != null){
            errs.push(['M1011', "If inpatient diagnosis 'c' is blank then inpatient diagnosis 'd' must also be blank."]);
        }

        if(this.inp4Icd.value == null && this.inp5Icd.value != null){
            errs.push(['M1011', "If inpatient diagnosis 'd' is blank then inpatient diagnosis 'e' must also be blank."]);
        }

        if(this.inp5Icd.value == null && this.inp6Icd.value != null){
            errs.push(['M1011', "If inpatient diagnosis 'e' is blank then inpatient diagnosis 'f' must also be blank."]);
        }

        return errs;
    },

    getMessage: function(code){
        icd_codes = {}
        icd_codes["m1011_14_day_inp1_icd"] = "'a'";
        icd_codes["m1011_14_day_inp2_icd"] = "'b'";
        icd_codes["m1011_14_day_inp3_icd"] = "'c'";
        icd_codes["m1011_14_day_inp4_icd"] = "'d'";
        icd_codes["m1011_14_day_inp5_icd"] = "'e'";
        icd_codes["m1011_14_day_inp6_icd"] = "'f'";
        return icd_codes[code]
    },

    serverValidationRequiredFields: function(){
        return ["m1011_14_day_inp1_icd", "m1011_14_day_inp2_icd", "m1011_14_day_inp3_icd", "m1011_14_day_inp4_icd",
            "m1011_14_day_inp5_icd", "m1011_14_day_inp6_icd"]
    },

    serverValidationRequiredFieldsSuffix: function(){
        return ["a", "b", "c", "d", "e", "f"]
    },

    selectIcdNa: function(){
        this.inpNa.on('change', function(el){
            if(el.value){
                Ext.each(this.m1011Fields, function(element){
                    this.query("[name="+element+"]")[0].setValue(null).disable();
                },this);
            }
            else {
                Ext.each(this.m1011Fields, function(element){
                    this.query("[name="+element+"]")[0].setValue(null).enable();
                },this);
            }
        },this);
    },

    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.inp1Icd = this.mainScope.down('[name=m1011_14_day_inp1_icd]');
        this.inp2Icd = this.mainScope.down('[name=m1011_14_day_inp2_icd]');
        this.inp3Icd = this.mainScope.down('[name=m1011_14_day_inp3_icd]');
        this.inp4Icd = this.mainScope.down('[name=m1011_14_day_inp4_icd]');
        this.inp5Icd = this.mainScope.down('[name=m1011_14_day_inp5_icd]');
        this.inp6Icd = this.mainScope.down('[name=m1011_14_day_inp6_icd]');
        this.inpNa = this.mainScope.down('checkboxfield[name=m1011_14_day_inp_na]');
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
        this.episodeDate = Ext.ComponentQuery.query('#patient_treatment_episode')[0];
        this.m1011Fields = ["m1011_14_day_inp1_icd", "m1011_14_day_inp2_icd", "m1011_14_day_inp3_icd", "m1011_14_day_inp4_icd", "m1011_14_day_inp5_icd", "m1011_14_day_inp6_icd"]

        this.selectIcdNa();
    }
})

