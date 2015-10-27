/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.DiagnosisAndProcedureCodesM1010M1012', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.diagnosisAndProcedureCodesM1010M1012',
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
        },
        {
            xtype: 'label',
            text: '(M1012) List each Inpatient Procedure and the associated ICD-9-CM procedure code relevant to the plan of care.'
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
                    name: 'm1012_inp_prcdr1_icd',
                    fieldLabel: 'a',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1012_inp_prcdr3_icd',
                    fieldLabel: 'c',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'checkbox',
                    padding: 2,
                    name: 'm1012_inp_na_icd',
                    fieldLabel: '',
                    boxLabel: 'NA - Not applicable',
                    inputValue: '1'
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1012_inp_prcdr2_icd',
                    fieldLabel: 'b',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'netzkeremotecombo',
                    padding: 2,
                    name: 'm1012_inp_prcdr4_icd',
                    fieldLabel: 'd',
                    labelAlign: 'top',
                    store: [

                    ]
                },
                {
                    xtype: 'checkbox',
                    padding: 2,
                    name: 'm1012_inp_uk_icd',
                    fieldLabel: '',
                    boxLabel: 'UK - Unknown',
                    inputValue: '1'
                }
            ]
        }
    ],
    onValidate: function(){
        var errs = new Array();
        var fields = ["m1000_dc_ltc_14_da", "m1000_dc_snf_14_da", "m1000_dc_ipps_14_da", "m1000_dc_ltch_14_da",
            "m1000_dc_irf_14_da","m1000_dc_psych_14_da", "m1000_dc_oth_14_da"];
        Ext.each(fields, function(el){
            if(this.mainScope.down("[name="+el+"]").value == true && this.inp1Icd.value == null){
                errs.push(['M1010', "Enter at least one inpatient facility diagnosis code OR select 'NA' for M1000."]);
            }
            if(this.mainScope.down("[name="+el+"]").value == true && (this.prcdr1.value == null && this.prcdr2.value == null &&
                this.prcdr3.value == null && this.prcdr4.value == null && this.inpNa.value == false && this.inpUk.value == false)){
                errs.push(['M1012', "Enter at least one inpatient procedure code OR select 'NA' or 'Unknown'. "]);
            }
        },this);

        if(this.prcdr1.value == null & this.prcdr2.value != null){
            errs.push(['M1012', "Inpatient Procedure and the associated ICD-9-CM: 'a' is blank then 'b' also should be blank."]);
        }
        if(this.prcdr1.value && this.prcdr2.value && this.prcdr1.value == this.prcdr2.value){
            errs.push(['M1012', "Inpatient Procedure and the associated ICD-9-CM: 'b' value can't equal to 'a'."]);
        }
        if(this.prcdr2.value == null & this.prcdr3.value != null){
            errs.push(['M1012', "Inpatient Procedure and the associated ICD-9-CM: 'b' is blank then 'c' also should be blank."]);
        }
        if(this.prcdr2.value && this.prcdr3.value && this.prcdr2.value == this.prcdr3.value){
            errs.push(['M1012', "Inpatient Procedure and the associated ICD-9-CM: 'c' value can't equal to 'b'."]);
        }
        if(this.prcdr3.value == null & this.prcdr4.value != null){
            errs.push(['M1012', "Inpatient Procedure and the associated ICD-9-CM: 'c' is blank then 'd' also should be blank."]);
        }
        if(this.prcdr3.value && this.prcdr4.value && this.prcdr3.value == this.prcdr4.value){
            errs.push(['M1012', "Inpatient Procedure and the associated ICD-9-CM: 'd' value can't equal to 'c'."]);
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
            "m1010_14_day_inp5_icd", "m1010_14_day_inp6_icd", "m1012_inp_prcdr1_icd", "m1012_inp_prcdr2_icd",
            "m1012_inp_prcdr3_icd", "m1012_inp_prcdr4_icd"]
    },
    serverValidationRequiredFieldsSuffix: function(){
        return ["a", "b", "c", "d", "e", "f", "a", "b", "c", "d"]
    },
    changeOnNaOrUk: function(fields){
        Ext.each(fields, function(el){
            this.down("[name="+el+"]").setValue(null);
        },this);
    },
    initComponent: function(){
        this.callParent();
        var fields = ["m1012_inp_prcdr1_icd", "m1012_inp_prcdr3_icd","m1012_inp_prcdr2_icd","m1012_inp_prcdr4_icd"];
        Ext.each(fields, function(ele){
            this.down("[name="+ele+"]").on('select', function(el){
                if(el.value){

                    this.inpNa.setValue(false);
                    this.inpUk.setValue(false);

                }
            },this);
        },this);
        var inpNa = this.down('[name=m1012_inp_na_icd]');
        var inpUk = this.down('[name=m1012_inp_uk_icd]');;
        inpNa.on('change', function(el){
            if(el.value){
                this.changeOnNaOrUk(fields);
                this.inpUk.setValue(false);
            }
        },this);
        inpUk.on('change', function(el){
            if(el.value){
                this.changeOnNaOrUk(fields);
                this.inpNa.setValue(false);
            }
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
        this.prcdr1 = this.mainScope.down('[name=m1012_inp_prcdr1_icd]');
        this.prcdr2 = this.mainScope.down('[name=m1012_inp_prcdr2_icd]');
        this.prcdr3 = this.mainScope.down('[name=m1012_inp_prcdr3_icd]');
        this.prcdr4 = this.mainScope.down('[name=m1012_inp_prcdr4_icd]');
        this.inpNa = this.mainScope.down('[name=m1012_inp_na_icd]');
        this.inpUk = this.mainScope.down('[name=m1012_inp_uk_icd]');
    }
})
