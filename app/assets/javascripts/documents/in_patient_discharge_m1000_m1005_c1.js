/**
 * Created by msuser1 on 22/12/14.
 */

Ext.define('Ext.panel.InPatientDischargeM1000M1005C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.inPatientDischargeM1000M1005C1',
    border: false,
    margin: 5,
    items: [
        {

            xtype: 'checkboxgroup',
            fieldLabel: '(M1000) From which of the following Inpatient Facilities was the patient discharged within the past 14 days? (Mark all that apply.)',
            labelAlign: 'top',
            columns: 1,
            margin: "5px",
            items: [
                {
                    xtype: 'checkboxfield',
                    name: "m1000_dc_ltc_14_da",
                    inputValue: "1",
                    boxLabel: '1 - Long-term nursing facility ( N F )'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1000_dc_snf_14_da",
                    inputValue: "1",
                    boxLabel: '2 - Skilled nursing facility ( S N F / T C U )'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1000_dc_ipps_14_da",
                    inputValue: "1",
                    boxLabel: '3 - Short-stay acute hospital ( I P P S )'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1000_dc_ltch_14_da",
                    inputValue: "1",
                    boxLabel: '4 - Long-term care hospital ( L T C H )'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1000_dc_irf_14_da",
                    inputValue: "1",
                    boxLabel: '5 - Inpatient rehabilitation hospital or unit ( I R F )'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1000_dc_psych_14_da",
                    inputValue: "1",
                    boxLabel: '6 - Psychiatric hospital or unit'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1000_dc_oth_14_da",
                    inputValue: "1",
                    boxLabel: '7 - Other (specify)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1000_dc_none_14_da",
                    inputValue: "1",
                    boxLabel: 'NA - Patient was not discharged from an inpatient facility',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1016]</text>'
                }
            ]
        },
        {
            xtype: "textfield",
            name: "m1000_other_dc",
            labelAlign: "top",
            width: "50%",
            margin: "5px",
            fieldLabel: "Other"
        },
        {
            xtype: "datefield",
            name: "m1005_inp_discharge_dt",
            labelAlign: "top",
            width: "50%",
            margin: "10 5 5 5",
            fieldLabel: "(M1005) Inpatient Discharge Date (most recent)"
        },
        {
            xtype: "label",
            text: "(M1005) Inpatient Discharge Date (most recent): UK",
            margin: '0 0 0 5'
        },
        {
            xtype: "checkboxfield",
            name: "m1005_inp_dschg_unknown",
            labelAlign: "top",
            margin: '0 0 5 5',
            inputValue: "1",
            fieldLabel: "",
            boxLabel: 'UK: Unknown'
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        var dischargeUnKnown = main.down("checkboxfield[name=m1005_inp_dschg_unknown]");
        if(this.m1000_dc_ltc_14_da.value == false && this.m1000_dc_snf_14_da.value == false && this.m1000_dc_ipps_14_da.value == false
            && this.m1000_dc_ltch_14_da.value == false && this.m1000_dc_irf_14_da.value == false && this.m1000_dc_psych_14_da.value == false &&
            this.m1000_dc_oth_14_da.value == false && this.m1000_dc_none_14_da.value == false ){
            errs.push(['M1000', "Select at least one inpatient facility from which the patient has been discharged within the last 14 days OR select 'NA'."])
        }

        if(this.dischargeDate.value == null && this.m1000_dc_none_14_da.value == false && dischargeUnKnown.value == false){
            errs.push(["M1005", "Enter the inpatient facility discharge date OR select 'Unknown'."]);
        }else{
            if(this.dischargeDate.isValid() == false){
                errs.push(["M1005", "The inpatient facility discharge date must be in the 'mm/dd/yyyy' format."]);
            }
            if(this.dischargeDate.value > new Date()){
                errs.push(["M1005", "The inpatient facility discharge date must be less than or equal to current date."]);
            }

            if(this.assessmentReason.value == '01' && this.startCareDate.value !=null && this.dischargeDate.value !=null){
                days = Math.floor(this.startCareDate.value - this.dischargeDate.value)/86400000;
                if (days < 0 || (days >= 0 && days > 14)){
                    errs.push(["M1005", "The inpatient facility discharge date must be within 14 days prior to the start of care date, with the start of care date counting as day 0."])
                }
            }
            if(this.assessmentReason.value == '03' && this.rocDate.value !=null && this.dischargeDate.value !=null){
                days = Math.floor(this.rocDate.value - this.dischargeDate.value)/86400000;
                if (days < 0 || (days >= 0 && days > 14)){
                    errs.push(["M1005", "The inpatient facility discharge date must be within 14 days prior to the resumption of care date, with the resumption of care date counting as day 0."])
                }
            }

            if(this.rocDate.value == null && this.dischargeDate.isValid() == true){
                if(this.startCareDate.value < this.dischargeDate.value || this.infoCompletedDate.value < this.dischargeDate.value){
                    errs.push(["M1005", "The inpatient facility discharge date cannot be after the start of care and assessment completed date."])
                }
            }else if (this.rocDate.value && this.rocDate.isValid()){
                if(this.infoCompletedDate.value < this.dischargeDate.value || this.rocDate.value < this.dischargeDate.value){
                    errs.push(["M1005", "The inpatient facility discharge date cannot be after the resumption of care date and assessment completed date."]);
                }
            }
        }
        return errs;

    },
    checkDate: function(dischargeDate){
        if(this.assessmentReason.value == 1){
            var startDate = Ext.Date.add(this.startCareDate.value, Ext.Date.DAY, -14);

            days = Math.floor(this.startCareDate.value - dischargeDate.value)/86400000;
            //if (days >= 0 && days <= 14){
            if((dischargeDate.value - startDate) <= 14){
                alert("hey i am discharging");
            }else{
                alert("days should be grater than equal to zero and less than 14 days ");
            }

        }else{
            alert("hey i am terminating");
        }
    },
    notApplicableChecked: function(fields, notApplicable, dischargeDate, inpatientAssociatedFieldsIcd9, inpatientAssociatedFieldsIcd10, dischargeUnKnown){
        Ext.each(fields, function(element, i){
            this.query("checkbox[name="+element+"]")[0].setValue(false);
        }, this);
        dischargeDate.disable().setValue();
        dischargeUnKnown.disable().setValue(false);
        if (notApplicable.value == false){notApplicable.setValue(true);}
        Ext.each(inpatientAssociatedFieldsIcd9, function(el){
            var field = this.up("#super_main").query("[name="+el+"]")[0];
            field.disable();
            if(field.xtype == "radiofield" || field.xtype == "checkboxfield")
                field.setValue(false);
            else
                field.setValue();
        }, this);
        Ext.each(inpatientAssociatedFieldsIcd10, function(el){
            var field = this.up("#super_main").query("[name="+el+"]")[0];
            field.disable();
            if(field.xtype == "radiofield" || field.xtype == "checkboxfield")
                field.setValue(false);
            else
                field.setValue();
        }, this);
    },
    notApplicableUnchecked: function(dischargeDate,dischargeUnKnown, inpatientAssociatedFieldsIcd9, inpatientAssociatedFieldsIcd10){
        dischargeDate.enable();
        dischargeUnKnown.enable();
        Ext.each(inpatientAssociatedFieldsIcd9, function(el){
            this.up("#super_main").query("[name="+el+"]")[0].enable();
        }, this);
        Ext.each(inpatientAssociatedFieldsIcd10, function(el){
            this.up("#super_main").query("[name="+el+"]")[0].enable();
        }, this);
    },
    selectNotApplicable: function(notApplicable, fields, dischargeDate, inpatientAssociatedFieldsIcd9, inpatientAssociatedFieldsIcd10, dischargeUnKnown){
        notApplicable.on('change', function(el){            
            if(this.infoCompletedDt.value < this.fromDate){
                if(el.value){
                    this.notApplicableChecked(fields, notApplicable, dischargeDate, inpatientAssociatedFieldsIcd9, inpatientAssociatedFieldsIcd10, dischargeUnKnown);
                }else{
                    this.notApplicableUnchecked(dischargeDate,dischargeUnKnown,inpatientAssociatedFieldsIcd9, inpatientAssociatedFieldsIcd10  );
                }
            }   
            else if(this.infoCompletedDt.value >= this.fromDate){
                if(el.value){
                    this.notApplicableChecked(fields, notApplicable, dischargeDate, inpatientAssociatedFieldsIcd9, inpatientAssociatedFieldsIcd10, dischargeUnKnown);
                }else{
                    this.notApplicableUnchecked(dischargeDate,dischargeUnKnown,inpatientAssociatedFieldsIcd9, inpatientAssociatedFieldsIcd10);
                }
            }    
        },this);
    },
    initComponent: function(){
        this.callParent();
        var fields = ["m1000_dc_ltc_14_da", "m1000_dc_snf_14_da", "m1000_dc_ipps_14_da", "m1000_dc_ltch_14_da",
            "m1000_dc_irf_14_da","m1000_dc_psych_14_da", "m1000_dc_oth_14_da"];
        var inpatientAssociatedFieldsIcd9 = ["m1010_14_day_inp1_icd","m1010_14_day_inp3_icd","m1010_14_day_inp5_icd",
            "m1010_14_day_inp2_icd","m1010_14_day_inp4_icd","m1010_14_day_inp6_icd"];
        var inpatientAssociatedFieldsIcd10 = ["m1011_14_day_inp1_icd", "m1011_14_day_inp2_icd", "m1011_14_day_inp3_icd" ,
            "m1011_14_day_inp4_icd", "m1011_14_day_inp5_icd", "m1011_14_day_inp6_icd"];
        var notApplicable = this.down('checkbox[name=m1000_dc_none_14_da]');
        var otherTextField = this.down('textfield[name=m1000_other_dc]');
        var dischargeDate = this.down("datefield[name=m1005_inp_discharge_dt]");
        var dischargeUnKnown = this.down("checkboxfield[name=m1005_inp_dschg_unknown]");
        otherTextField.disable();
        this.selectNotApplicable(notApplicable, fields, dischargeDate, inpatientAssociatedFieldsIcd9, inpatientAssociatedFieldsIcd10, dischargeUnKnown);
        dischargeDate.on('select',function(el){
            if(dischargeDate.value && dischargeDate.isValid()){
                if(el.value){
                    dischargeUnKnown.setValue(false);
                }
            }
        },this);
        dischargeUnKnown.on('change', function(el){
            if(el.value) {
                dischargeDate.setValue(null);
            }
        }, this) ;

        Ext.each(fields, function(element){
            this.query("checkbox[name="+element+"]")[0].on('change', function(el){
                if(el.name == 'm1000_dc_oth_14_da'){
                    if(el.value){
                        otherTextField.enable();
                    }else{
                        otherTextField.disable().setValue();
                    }
                }
                if(notApplicable.value){
                    notApplicable.setValue(false);
                }
            }, this)
        },this);

    },
    afterRender: function(){
        this.callParent();
        this.fromDate = new Date("October 1, 2015");
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.assessmentReason = this.mainScope.down('textfield[name=m0100_assmt_reason]');
        this.startCareDate = this.mainScope.down('datefield[name=m0030_start_care_dt]');
        this.dischargeDate = this.mainScope.down("datefield[name=m1005_inp_discharge_dt]");
        this.rocDate = this.mainScope.down("datefield[name=m0032_roc_dt]");
        this.infoCompletedDate = this.mainScope.down("datefield[name=m0090_info_completed_dt]");
        this.m1000_dc_ltc_14_da = this.mainScope.down("[name=m1000_dc_ltc_14_da]");
        this.m1000_dc_snf_14_da = this.mainScope.down("[name=m1000_dc_snf_14_da]");
        this.m1000_dc_ipps_14_da = this.mainScope.down("[name=m1000_dc_ipps_14_da]");
        this.m1000_dc_ltch_14_da = this.mainScope.down("[name=m1000_dc_ltch_14_da]");
        this.m1000_dc_irf_14_da = this.mainScope.down("[name=m1000_dc_irf_14_da]");
        this.m1000_dc_psych_14_da = this.mainScope.down("[name=m1000_dc_psych_14_da]");
        this.m1000_dc_oth_14_da = this.mainScope.down("[name=m1000_dc_oth_14_da]");
        this.m1000_dc_none_14_da = this.mainScope.down("[name=m1000_dc_none_14_da]");
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
    }
})
