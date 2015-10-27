/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.EmergentCareM2300M2310', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.emergentCareM2300M2310',
    border: false,
    items: [

        {
            xtype: 'radiogroup',
            fieldLabel: "(M2300) Emergent Care: At the time of or at any time since the previous OASIS assessment has the patient utilized a hospital" +
                " emergency department (includes holding/observation status)?",
            cls: 'oasis_blue',
            item_id: 'emergent_care',
            width: "80%",
            labelAlign: 'top',
            columns: 1,
            margin: "5px",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m2300_emer_use_aftr_last_asmt",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - No',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M2400]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: "m2300_emer_use_aftr_last_asmt",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Yes, used hospital emergency department WITHOUT hospital admission'
                },
                {
                    xtype: 'radiofield',
                    name: "m2300_emer_use_aftr_last_asmt",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Yes, used hospital emergency department WITH hospital admission'
                },
                {
                    xtype: 'radiofield',
                    name: "m2300_emer_use_aftr_last_asmt",
                    inputValue: "UK",
                    margin: 5,
                    boxLabel: 'UK - Unknown',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M2400]</text>'
                }
            ]
        },
        {
            xtype: 'checkboxgroup',
            fieldLabel: '(M2310) Reason for Emergent Care: For what reason(s) did the patient seek and/or receive emergent care (with or'+
            ' without hospitalization)? (Mark all that apply.)',
            cls: 'oasis_blue',
            item_id: 'reason_emergent_care',
            width: "80%",
            labelAlign: 'top',
            columns: 1,
            margin: "5px",
            items: [
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_medication",
                    inputValue: "1",
                    boxLabel: '1 - Improper medication administration, adverse drug reactions medication side effects, toxicity, anaphylaxis'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_injry_by_fall",
                    inputValue: "1",
                    boxLabel: '2 - Injury caused by fall'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_rsprtry_infctn",
                    inputValue: "1",
                    boxLabel: '3 - Respiratory infection (for example, pneumonia, bronchitis)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_rsprtry_othr",
                    inputValue: "1",
                    boxLabel: '4 - Other respiratory problem'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_hrt_failr",
                    inputValue: "1",
                    boxLabel: '5 - Heart failure (for example, fluid overload)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_crdc_dsrthm",
                    inputValue: "1",
                    boxLabel: '6 - Cardiac dysrhythmia (irregular heartbeat)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_mi_chst_pain",
                    inputValue: "1",
                    boxLabel: '7 - Myocardial infarction or chest pain'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_othr_hrt_dease",
                    inputValue: "1",
                    boxLabel: '8 - Other heart disease'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_stroke_tia",
                    inputValue: "1",
                    boxLabel: '9 - Stroke (CVA) or TIA'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_hypoglyc",
                    inputValue: "1",
                    boxLabel: '10 - Hypo/Hyperglycemia, diabetes out of control'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_gi_prblm",
                    inputValue: "1",
                    boxLabel: '11 - GI bleeding, obstruction, constipation, impaction'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_dhydrtn_malntr",
                    inputValue: "1",
                    boxLabel: '12 - Dehydration, malnutrition'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_uti",
                    inputValue: "1",
                    boxLabel: '13 - Urinary tract infection'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_cthtr_cmplctn",
                    inputValue: "1",
                    boxLabel: '14 - IV catheter-related infection or complication'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_wnd_infctn_dtrortn",
                    inputValue: "1",
                    boxLabel: '15 - Wound infection or deterioration'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_uncntld_pain",
                    inputValue: "1",
                    boxLabel: '16 - Uncontrolled pain'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_mentl_bhvrl_prblm",
                    inputValue: "1",
                    boxLabel: '17 - Acute mental/behavioral health problem'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_dvt_pulmnry",
                    inputValue: "1",
                    boxLabel: '18 - Deep vein thrombosis, pulmonary embolus'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_other",
                    inputValue: "1",
                    boxLabel: '19 - Other than above reasons'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m2310_ecr_unknown",
                    inputValue: "1",
                    boxLabel: 'UK - Reason unknown'
                }
            ]
        }

    ],
    afterRender: function(){
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        this.m2300EmerUseAftrLastAsmt = this.super_main.down('[name=m2300_emer_use_aftr_last_asmt]');
        console.log(this.super_main.down('radiofield[name=m2300_emer_use_aftr_last_asmt]').getGroupValue());
        this.m2310ecrMedication = this.super_main.down('[name=m2310_ecr_medication]');
        this.m2310EcrInjryByFall = this.super_main.down('[name=m2310_ecr_injry_by_fall]');
        this.m2310EcrRsprtryInfctn = this.super_main.down('[name=m2310_ecr_rsprtry_infctn]');
        this.m2310EcrRsprtryOthr = this.super_main.down('[name=m2310_ecr_rsprtry_othr]');
        this.m2310EcrHrtFailr = this.super_main.down('[name=m2310_ecr_hrt_failr]');
        this.m2310EcrCrdcDsrthm = this.super_main.down('[name=m2310_ecr_crdc_dsrthm]');
        this.m2310EcrMiChstPain = this.super_main.down('[name=m2310_ecr_mi_chst_pain]');
        this.m2310EcrOthrHrtDease = this.super_main.down('[name=m2310_ecr_othr_hrt_dease]');
        this.m2310EcrStrokeTia = this.super_main.down('[name=m2310_ecr_stroke_tia]');
        this.m2310EcrHypoglyc = this.super_main.down('[name=m2310_ecr_hypoglyc]');
        this.m2310EcrGiPrblm = this.super_main.down('[name=m2310_ecr_gi_prblm]');
        this.m2310EcrDhydrtnMalntr = this.super_main.down('[name=m2310_ecr_dhydrtn_malntr]');
        this.m2310EcrUti = this.super_main.down('[name=m2310_ecr_uti]');
        this.m2310EcrCthtrCmplctn = this.super_main.down('[name=m2310_ecr_cthtr_cmplctn]');
        this.m2310EcrWndInfctnDtrortn = this.super_main.down('[name=m2310_ecr_wnd_infctn_dtrortn]');
        this.m2310EcrUncntldPain = this.super_main.down('[name=m2310_ecr_uncntld_pain]');
        this.m2310EcrMentlBhvrlPrblm = this.super_main.down('[name=m2310_ecr_mentl_bhvrl_prblm]');
        this.m2310EcrDvtPulmnry = this.super_main.down('[name=m2310_ecr_dvt_pulmnry]');
        this.m2310EcrOther = this.super_main.down('[name=m2310_ecr_other]');
        this.m2310EcrUnknown = this.super_main.down('[name=m2310_ecr_unknown]');
        this.ecrMedications  = [this.m2310ecrMedication, this.m2310EcrInjryByFall, this.m2310EcrRsprtryInfctn, this.m2310EcrRsprtryOthr,
            this.m2310EcrHrtFailr, this.m2310EcrCrdcDsrthm, this.m2310EcrMiChstPain, this.m2310EcrOthrHrtDease, this.m2310EcrStrokeTia,
            this.m2310EcrHypoglyc, this.m2310EcrGiPrblm, this.m2310EcrDhydrtnMalntr,
            this.m2310EcrUti, this.m2310EcrCthtrCmplctn, this.m2310EcrWndInfctnDtrortn, this.m2310EcrUncntldPain,
            this.m2310EcrMentlBhvrlPrblm, this.m2310EcrDvtPulmnry,
            this.m2310EcrOther, this.m2310EcrUnknown]
        var fields = [this.m2310ecrMedication, this.m2310EcrInjryByFall, this.m2310EcrRsprtryInfctn, this.m2310EcrRsprtryOthr,
            this.m2310EcrHrtFailr, this.m2310EcrCrdcDsrthm, this.m2310EcrMiChstPain, this.m2310EcrOthrHrtDease, this.m2310EcrStrokeTia,
            this.m2310EcrHypoglyc, this.m2310EcrGiPrblm, this.m2310EcrDhydrtnMalntr,
            this.m2310EcrUti, this.m2310EcrCthtrCmplctn, this.m2310EcrWndInfctnDtrortn, this.m2310EcrUncntldPain,
            this.m2310EcrMentlBhvrlPrblm, this.m2310EcrDvtPulmnry,
            this.m2310EcrOther]

        this.super_main.query("[name=m2300_emer_use_aftr_last_asmt]").forEach(function(s){
            s.on('change', function(el){
                if(el.getGroupValue() == "00" || el.getGroupValue() == "UK"){
                    Ext.each(this.ecrMedications, function(element){
                        element.disable().setValue(false);
                    },this);
                }else{
                    Ext.each(this.ecrMedications, function(element){
                        element.enable();
                    },this);
                }
            },this);
        },this);

        this.m2310EcrUnknown.on('change', function(el){
            if(el.value){
                Ext.each(fields, function(element){
                    element.setValue(false);
                }, this);
                if (el.value == false){el.setValue(true);}
            }
        }, this);

        Ext.each(fields, function(element){
            element.on('change', function(el){
                if(this.m2310EcrUnknown.value){
                    this.m2310EcrUnknown.setValue(false);
                }
            }, this)
        },this);


    },
    selectFirstOrNone: function(){
        this.m2300EmerUseAftrLastAsmt.on('change', function(){
            if(this.m2300EmerUseAftrLastAsmt.getGroupValue() == "00" || this.m2300EmerUseAftrLastAsmt.getGroupValue() == "UK"){
                Ext.each(this.ecrMedications, function(el){
                    el.setDisabled(true);
                }, this);
            }else{
                Ext.each(this.ecrMedications, function(el){
                    el.enable();
                }, this);
            }
        }, this);
    },
    onValidate: function(){
        var errs = new Array();
        m2300EmerUseAftrLastAsmt = this.super_main.down('radiofield[name=m2300_emer_use_aftr_last_asmt]');
        if(m2300EmerUseAftrLastAsmt.getGroupValue() == null){
            errs.push(['M2300', "Select one option whether patient utilized emergency care since last OASIS."]);
        }

        if(m2300EmerUseAftrLastAsmt.getGroupValue() == "01" || m2300EmerUseAftrLastAsmt.getGroupValue() == "02"){

            if(this.m2310ecrMedication.value == false && this.m2310EcrInjryByFall.value == false && this.m2310EcrRsprtryInfctn.value == false && this.m2310EcrRsprtryOthr.value == false &&
                this.m2310EcrHrtFailr.value == false && this.m2310EcrCrdcDsrthm.value == false && this.m2310EcrMiChstPain.value == false
                && this.m2310EcrInjryByFall.value == false && this.m2310ecrMedication.value == false && this.m2310EcrInjryByFall.value == false &&
                this.m2310EcrOthrHrtDease.value == false && this.m2310EcrStrokeTia.value == false && this.m2310EcrHypoglyc.value == false && this.m2310EcrGiPrblm.value == false &&
                this.m2310EcrDhydrtnMalntr.value == false && this.m2310EcrUti.value == false && this.m2310EcrCthtrCmplctn.value == false && this.m2310EcrWndInfctnDtrortn.value == false &&
                this.m2310EcrUncntldPain.value == false && this.m2310EcrMentlBhvrlPrblm.value == false && this.m2310EcrDvtPulmnry.value == false
                && this.m2310EcrOther.value == false && this.m2310EcrUnknown.value == false ){
                errs.push(['M2310', "Do not leave Reason for Emergent Care field empty, since 'Emergent Care' was selected to 'Yes'."])
            }

        }
        return errs;
    }
})
