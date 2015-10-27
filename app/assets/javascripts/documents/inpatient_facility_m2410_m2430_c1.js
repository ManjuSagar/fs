Ext.define('Ext.panel.InpatientFacilityM2410M2430C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.inpatientFacilityM2410M2430C1',
    border: false,
    items: [
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M2410) To which Inpatient Facility has the patient been admitted?',
            cls: 'oasis_blue',
            item_id: 'inpat_fac_adm',
            width: "60%",
            labelAlign: 'top',
            margin: 5,
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm2410_inpat_facility',
                    boxLabel: '1 - Hospital',
                    inputValue: '01',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M2430]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2410_inpat_facility',
                    boxLabel: '2 - Rehabilitation facility',
                    inputValue: '02',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M0903]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2410_inpat_facility',
                    boxLabel: '3 - Nursing home',
                    inputValue: '03',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M0903]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2410_inpat_facility',
                    boxLabel: '4 - Hospice',
                    inputValue: '04',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M0903]</text>'
                }
            ]
        },
        {
            xtype: 'checkboxgroup',
            fieldLabel: '(M2430) Reason for Hospitalization: For what reason(s) did the patient require hospitalization? (Mark all that apply.)',
            cls: 'oasis_blue',
            item_id: 'reason_for_hsptlztn',
            width: "60%",
            labelAlign: 'top',
            columns: 1,
            margin: "5px",
            items: [
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_med",
                    inputValue: "1",
                    boxLabel: '1 - Improper medication administration, adverse drug reactions, medication side effects, toxicity, anaphylaxis'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_injry_by_fall",
                    inputValue: "1",
                    boxLabel: '2 - Injury caused by fall'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_rsprtry_infctn",
                    inputValue: "1",
                    boxLabel: '3 - Respiratory infection (for example, pneumonia, bronchitis)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_rsprtry_othr",
                    inputValue: "1",
                    boxLabel: '4 - Other respiratory problem'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_hrt_failr",
                    inputValue: "1",
                    boxLabel: '5 - Heart failure (for example, fluid overload)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_crdc_dsrthm",
                    inputValue: "1",
                    boxLabel: '6 - Cardiac dysrhythmia (irregular heartbeat)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_mi_chst_pain",
                    inputValue: "1",
                    boxLabel: '7 - Myocardial infarction or chest pain'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_othr_hrt_dease",
                    inputValue: "1",
                    boxLabel: '8 - Other heart disease'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_stroke_tia",
                    inputValue: "1",
                    boxLabel: '9 - Stroke (CVA) or TIA'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_hypoglyc",
                    inputValue: "1",
                    boxLabel: '10 - Hypo/Hyperglycemia, diabetes out of control'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_gi_prblm",
                    inputValue: "1",
                    boxLabel: '11 - GI bleeding, obstruction, constipation, impaction'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_dhydrtn_malntr",
                    inputValue: "1",
                    boxLabel: '12 - Dehydration, malnutrition'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_ur_tract",
                    inputValue: "1",
                    boxLabel: '13 - Urinary tract infection'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_cthtr_cmplctn",
                    inputValue: "1",
                    boxLabel: '14 - IV catheter-related infection or complication'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_wnd_infctn",
                    inputValue: "1",
                    boxLabel: '15 - Wound infection or deterioration'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_pain",
                    inputValue: "1",
                    boxLabel: '16 - Uncontrolled pain'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_mentl_bhvrl_prblm",
                    inputValue: "1",
                    boxLabel: '17 - Acute mental/behavioral health problem'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_dvt_pulmnry",
                    inputValue: "1",
                    boxLabel: '18 - Deep vein thrombosis, pulmonary embolus'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_schld_trtmt",
                    inputValue: "1",
                    boxLabel: '19 - Scheduled treatment or procedure'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_other",
                    inputValue: "1",
                    boxLabel: '20 - Other than above reasons'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2430_hosp_uk",
                    inputValue: "1",
                    boxLabel: 'UK - Reason unknown',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M0903]</text>'
                }
            ]
        }
    ],
    afterRender: function(){
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];

        this.m2430_hosp_med = this.super_main.down('[name=m2430_hosp_med]');
        this.m2430_hosp_injry_by_fall = this.super_main.down('[name=m2430_hosp_injry_by_fall]');
        this.m2430_hosp_rsprtry_infctn = this.super_main.down('[name=m2430_hosp_rsprtry_infctn]');
        this.m2430_hosp_rsprtry_othr = this.super_main.down('[name=m2430_hosp_rsprtry_othr]');

        this.m2430_hosp_hrt_failr = this.super_main.down('[name=m2430_hosp_hrt_failr]');
        this.m2430_hosp_crdc_dsrthm = this.super_main.down('[name=m2430_hosp_crdc_dsrthm]');
        this.m2430_hosp_mi_chst_pain = this.super_main.down('[name=m2430_hosp_mi_chst_pain]');
        this.m2430_hosp_othr_hrt_dease = this.super_main.down('[name=m2430_hosp_othr_hrt_dease]');

        this.m2430_hosp_stroke_tia = this.super_main.down('[name=m2430_hosp_stroke_tia]');
        this.m2430_hosp_hypoglyc = this.super_main.down('[name=m2430_hosp_hypoglyc]');
        this.m2430_hosp_gi_prblm = this.super_main.down('[name=m2430_hosp_gi_prblm]');
        this.m2430_hosp_dhydrtn_malntr = this.super_main.down('[name=m2430_hosp_dhydrtn_malntr]');

        this.m2430_hosp_ur_tract = this.super_main.down('[name=m2430_hosp_ur_tract]');
        this.m2430_hosp_cthtr_cmplctn = this.super_main.down('[name=m2430_hosp_cthtr_cmplctn]');
        this.m2430_hosp_wnd_infctn = this.super_main.down('[name=m2430_hosp_wnd_infctn]');
        this.m2430_hosp_pain = this.super_main.down('[name=m2430_hosp_pain]');

        this.m2430_hosp_mentl_bhvrl_prblm = this.super_main.down('[name=m2430_hosp_mentl_bhvrl_prblm]');
        this.m2430_hosp_dvt_pulmnry = this.super_main.down('[name=m2430_hosp_dvt_pulmnry]');
        this.m2430_hosp_schld_trtmt = this.super_main.down('[name=m2430_hosp_schld_trtmt]');
        this.m2430_hosp_other = this.super_main.down('[name=m2430_hosp_other]');
        this.m2430_hosp_uk = this.super_main.down('[name=m2430_hosp_uk]');

        this.hospitals = ['m2430_hosp_med', 'm2430_hosp_injry_by_fall', 'm2430_hosp_rsprtry_infctn', 'm2430_hosp_rsprtry_othr',
            'm2430_hosp_hrt_failr', 'm2430_hosp_crdc_dsrthm', 'm2430_hosp_mi_chst_pain', 'm2430_hosp_othr_hrt_dease',
            'm2430_hosp_stroke_tia', 'm2430_hosp_hypoglyc', 'm2430_hosp_gi_prblm', 'm2430_hosp_dhydrtn_malntr',
            'm2430_hosp_ur_tract', 'm2430_hosp_cthtr_cmplctn', 'm2430_hosp_wnd_infctn', 'm2430_hosp_pain',
            'm2430_hosp_mentl_bhvrl_prblm', 'm2430_hosp_dvt_pulmnry', 'm2430_hosp_schld_trtmt', 'm2430_hosp_other',
            'm2430_hosp_uk']

        this.super_main.query("[name = m2410_inpat_facility]").forEach(function(s){
            s.on('change', function(el){
                if(el.getGroupValue() == "02" || el.getGroupValue() == "04"){
                    Ext.each(this.hospitals, function(element){
                        this.super_main.down('[name='+element+']').disable().setValue(false);
                    },this);

                }else{
                    Ext.each(this.hospitals, function(element){
                        this.super_main.down('[name='+element+']').enable();
                    },this);

                }

                if(el.getGroupValue() == "03"){
                    Ext.each(this.hospitals, function(element){
                        this.super_main.down('[name='+element+']').disable().setValue(false);
                    },this);
                }

                if(el.getGroupValue() == "01"){
                    Ext.each(this.hospitals, function(element){
                        this.super_main.down('[name='+element+']').enable();
                    },this);

                }
            }, this);
        }, this);

        var fields = ['m2430_hosp_med', 'm2430_hosp_injry_by_fall', 'm2430_hosp_rsprtry_infctn', 'm2430_hosp_rsprtry_othr',
            'm2430_hosp_hrt_failr', 'm2430_hosp_crdc_dsrthm', 'm2430_hosp_mi_chst_pain', 'm2430_hosp_othr_hrt_dease',
            'm2430_hosp_stroke_tia', 'm2430_hosp_hypoglyc', 'm2430_hosp_gi_prblm', 'm2430_hosp_dhydrtn_malntr',
            'm2430_hosp_ur_tract', 'm2430_hosp_cthtr_cmplctn', 'm2430_hosp_wnd_infctn', 'm2430_hosp_pain',
            'm2430_hosp_mentl_bhvrl_prblm', 'm2430_hosp_dvt_pulmnry', 'm2430_hosp_schld_trtmt', 'm2430_hosp_other']
        this.m2430_hosp_uk.on('change', function(el){
            if(el.value){
                Ext.each(fields, function(element){
                    this.super_main.down("[name="+element+"]").setValue(false);
                }, this);
                if (el.value == false){el.setValue(true);}
            }
        }, this);

        Ext.each(fields, function(element){
            this.super_main.down("[name="+element+"]").on('change', function(el){
                if(this.m2430_hosp_uk.value){
                    this.m2430_hosp_uk.setValue(false);
                }
            }, this)
        },this);


    },
    onValidate: function(){
        var errs = new Array();
        var m2410InpatFacility = this.super_main.down('radiofield[name=m2410_inpat_facility]');
        if(m2410InpatFacility.getGroupValue() == null){
            errs.push(['M2410', "Select one option to which inpatient facility the patient been admitted."]);
        }
        if(m2410InpatFacility.getGroupValue() == "01") {
            if (this.m2430_hosp_med.value == false && this.m2430_hosp_injry_by_fall.value == false && this.m2430_hosp_rsprtry_infctn.value == false && this.m2430_hosp_rsprtry_othr.value == false &&
                this.m2430_hosp_hrt_failr.value == false && this.m2430_hosp_crdc_dsrthm.value == false && this.m2430_hosp_mi_chst_pain.value == false && this.m2430_hosp_othr_hrt_dease.value == false &&
                this.m2430_hosp_stroke_tia.value == false && this.m2430_hosp_hypoglyc.value == false && this.m2430_hosp_gi_prblm.value == false && this.m2430_hosp_dhydrtn_malntr.value == false &&
                this.m2430_hosp_ur_tract.value == false && this.m2430_hosp_cthtr_cmplctn.value == false && this.m2430_hosp_wnd_infctn.value == false && this.m2430_hosp_pain.value == false &&
                this.m2430_hosp_mentl_bhvrl_prblm.value == false && this.m2430_hosp_dvt_pulmnry.value == false && this.m2430_hosp_schld_trtmt.value == false && this.m2430_hosp_other.value == false
                && this.m2430_hosp_uk.value == false) {
                errs.push(['M2430', "Select at least one reason for patient hospitaliation, since option 'Hospital' has been selected in inpatient facility admission."]);
            }
        }

        var m0100Value = this.super_main.down("[name=m0100_assmt_reason]").value;
        if(m0100Value == "09" && m2410InpatFacility.getGroupValue() != "NA"){
            errs.push(["M2410", "Inpatient Facility, the patient been admitted should be 'NA' since 'Discharge from Agency' has been selected in 'Clinical Record Items'."]);
        }
        if((m0100Value == "06" || m0100Value == "07") && m2410InpatFacility.getGroupValue() == "NA"){
            errs.push(["M2410", "Inpatient Facility, the patient been admitted should not be 'NA' since Transferred to an inpatient facility' has been selected in 'Clinical Record Items'. "]);
        }
        return errs;
    }
})
