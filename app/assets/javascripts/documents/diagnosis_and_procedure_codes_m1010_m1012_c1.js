/**
 * Created by msuser1 on 22/12/14.
 */

Ext.define('Ext.panel.DiagnosisAndProcedureCodesM1010M1012C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.diagnosisAndProcedureCodesM1010M1012C1',
    border: false,
    margin: 5,
    items: [

        {
            xtype: 'label',
            text: '(M1010) List each Inpatient Diagnosis and ICD-9-CM code at the level of highest specificity for only those conditions treated during an inpatient stay within the last 14 days (no E-codes, or V-codes): '
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
                    name: 'm1010_14_day_inp1_icd',
                    fieldLabel: 'a',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1010_14_day_inp3_icd',
                    fieldLabel: 'c',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1010_14_day_inp5_icd',
                    fieldLabel: 'e',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1010_14_day_inp2_icd',
                    fieldLabel: 'b',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1010_14_day_inp4_icd',
                    fieldLabel: 'd',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1010_14_day_inp6_icd',
                    fieldLabel: 'f',
                    labelAlign: 'top',
                    store: [




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
      
        if((this.m1000_dc_ltc_14_da.value == true || this.m1000_dc_snf_14_da.value == true || this.m1000_dc_ipps_14_da.value == true
        ||  this.m1000_dc_ltch_14_da.value == true || this.m1000_dc_irf_14_da.value == true || this.m1000_dc_psych_14_da.value == true
            || this.m1000_dc_oth_14_da.value == true) && this.inp1Icd.value == null && validationFlag ) {
            errs.push(['M1010', "Enter at least one inpatient facility diagnosis code OR select 'NA' for M1000."]);
        }

        if(this.inp1Icd.value == null && this.inp2Icd.value != null){
            errs.push(['M1010', "If inpatient diagnosis 'a' is blank then inpatient diagnosis 'b' must also be blank."]);
        }else{
            if(this.inp2Icd.value != null && this.inp1Icd.value == this.inp2Icd.value){
                errs.push(['M1010', "Inpatient diagnosis 'b' cannot be the same as inpatient diagnosis 'a'."]);
            }
        }

        if(this.inp2Icd.value == null && this.inp3Icd.value != null){
            errs.push(['M1010', "If inpatient diagnosis 'b' is blank then inpatient diagnosis 'c' must also be blank."]);
        }else{
            if(this.inp3Icd.value != null && this.inp2Icd.value == this.inp3Icd.value){
                errs.push(['M1010', "Inpatient diagnosis 'c' cannot be the same as inpatient diagnosis 'b'."]);
            }
        }

        if(this.inp3Icd.value == null && this.inp4Icd.value != null){
            errs.push(['M1010', "If inpatient diagnosis 'c' is blank then inpatient diagnosis 'd' must also be blank."]);
        }else{
            if(this.inp4Icd.value != null && this.inp3Icd.value == this.inp4Icd.value){
                errs.push(['M1010', "Inpatient diagnosis 'd' cannot be the same as inpatient diagnosis 'c'."]);
            }
        }

        if(this.inp4Icd.value == null && this.inp5Icd.value != null){
            errs.push(['M1010', "If inpatient diagnosis 'd' is blank then inpatient diagnosis 'e' must also be blank."]);
        }else{
            if(this.inp5Icd.value != null && this.inp4Icd.value == this.inp5Icd.value){
                errs.push(['M1010', "Inpatient diagnosis 'e' cannot be the same as inpatient diagnosis 'd'."]);
            }
        }

        if(this.inp5Icd.value == null && this.inp6Icd.value != null){
            errs.push(['M1010', "If inpatient diagnosis 'e' is blank then inpatient diagnosis 'f' must also be blank."]);
        }else{
            if(this.inp6Icd.value != null && this.inp5Icd.value == this.inp6Icd.value){
                errs.push(['M1010', "Inpatient diagnosis 'f' cannot be the same as inpatient diagnosis 'e'."]);
            }
        }

        return errs;
    },
    serverValidationRequiredFields: function(){
        return ["m1010_14_day_inp1_icd", "m1010_14_day_inp2_icd", "m1010_14_day_inp3_icd", "m1010_14_day_inp4_icd",
            "m1010_14_day_inp5_icd", "m1010_14_day_inp6_icd"]
    },
    serverValidationRequiredFieldsSuffix: function(){
        return ["a", "b", "c", "d", "e", "f"]
    },
    changeOnNaOrUk: function(fields){
        Ext.each(fields, function(el){
            this.down("[name="+el+"]").setValue(null);
        },this);
    },

    afterRender: function(){
        this.callParent();
        var combos = this.query("netzkeremotecombo");
        Ext.each(combos, function(combo, index) {
            //combo.assignStore();
        }, this);

        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.inp1Icd = this.mainScope.down('[name=m1010_14_day_inp1_icd]');
        this.inp2Icd = this.mainScope.down('[name=m1010_14_day_inp2_icd]');
        this.inp3Icd = this.mainScope.down('[name=m1010_14_day_inp3_icd]');
        this.inp4Icd = this.mainScope.down('[name=m1010_14_day_inp4_icd]');
        this.inp5Icd = this.mainScope.down('[name=m1010_14_day_inp5_icd]');
        this.inp6Icd = this.mainScope.down('[name=m1010_14_day_inp6_icd]');
        this.m1000_dc_ltc_14_da = this.mainScope.down("[name=m1000_dc_ltc_14_da]");
        this.m1000_dc_snf_14_da = this.mainScope.down("[name=m1000_dc_snf_14_da]");
        this.m1000_dc_ipps_14_da = this.mainScope.down("[name=m1000_dc_ipps_14_da]");
        this.m1000_dc_ltch_14_da = this.mainScope.down("[name=m1000_dc_ltch_14_da]");
        this.m1000_dc_irf_14_da = this.mainScope.down("[name=m1000_dc_irf_14_da]");
        this.m1000_dc_psych_14_da = this.mainScope.down("[name=m1000_dc_psych_14_da]");
        this.m1000_dc_oth_14_da = this.mainScope.down("[name=m1000_dc_oth_14_da]");        
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
        this.episodeDate = Ext.ComponentQuery.query('#patient_treatment_episode')[0];

    }
})
