/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.RespiratoryCardiacM1500M1510', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.respiratoryCardiacM1500M1510',
    border: false,
    items: [
        {
            xtype: 'radiogroup',
            width: 759,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1500) Symptoms in Heart Failure Patients: If patient has been diagnosed with heart failure, did the patient exhibit symptoms indicated by clinical heart failure guidelines (including dyspnea, orthopnea, edema, or weight gain) at the time of or at any time since the previous OASIS assessment?',
            cls: 'oasis_blue',
            item_id: 'symp_heart_failure',
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1500_symtm_hrt_failr_ptnts',
                    boxLabel: '0 - No',
                    inputValue: '00',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M2004]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1500_symtm_hrt_failr_ptnts',
                    boxLabel: '1 - Yes',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1500_symtm_hrt_failr_ptnts',
                    boxLabel: '2 - Not assessed',
                    inputValue: '02',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M2004]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1500_symtm_hrt_failr_ptnts',
                    boxLabel: 'NA - Patient does not have diagnosis of heart failure',
                    inputValue: 'NA',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M2004]</text>'
                }
            ]
        },
        {
            xtype: 'checkboxgroup',
            width: 759,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1510) Heart Failure Follow-up: If patient has been diagnosed with heart failure and has exhibited symptoms indicative of heart failure at the time of or any time since the previous OASIS assessment, what action(s) has (have) been taken to respond? (Mark all that apply.)',
            cls: 'oasis_blue',
            item_id: 'heart_failure_followup',
            labelAlign: 'top',
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'm1510_hrt_failr_no_actn',
                    boxLabel: '0 - No action taken',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1510_hrt_failr_physn_cntct',
                    boxLabel: '1 - Patient`s physician (or other primary care practitioner) contacted the same day',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1510_hrt_failr_er_trtmt',
                    boxLabel: '2 - Patient advised to get emergency treatment (for example, call 911 or go to emergency room)',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1510_hrt_failr_physn_trtmt',
                    boxLabel: '3 - Implemented physician-ordered patient-specific established parameters for treatment',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1510_hrt_failr_clncl_intrvtn',
                    boxLabel: '4 - Patient education or other clinical interventions',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1510_hrt_failr_care_plan_chg',
                    boxLabel: '5 - Obtained change in care plan orders (for example, increased monitoring by agency, change in visit frequency, telehealth.)',
                    inputValue: '1'
                }
            ]
        }
    ],
    afterRender: function(){
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        this.m1500SymtmHrtFailrPtnts = this.super_main.down('radiofield[name=m1500_symtm_hrt_failr_ptnts]').getGroupValue();
        var m1500SymtmHrtFailrPtnts = this.super_main.down('radiofie[name=m1500_symtm_hrt_failr_ptnts]');
        this.m1510HrtFailrNoActn = this.super_main.down('[name=m1510_hrt_failr_no_actn]');
        this.m1510HrtFailrPhysnCntct = this.super_main.down('[name=m1510_hrt_failr_physn_cntct]');
        this.m1510HrtFailrErTrtmt = this.super_main.down('[name=m1510_hrt_failr_er_trtmt]');
        this.m1510HrtFailrPhysnTrtmt = this.super_main.down('[name=m1510_hrt_failr_physn_trtmt]');
        this.m1510HrtFailrClnclIntrvtn = this.super_main.down('[name=m1510_hrt_failr_clncl_intrvtn]');
        this.m1510HrtFailrCarePlanChg = this.super_main.down('[name=m1510_hrt_failr_care_plan_chg]');

        var heartFailures = ['m1510_hrt_failr_no_actn', 'm1510_hrt_failr_physn_cntct', 'm1510_hrt_failr_er_trtmt', 'm1510_hrt_failr_physn_trtmt',
            'm1510_hrt_failr_clncl_intrvtn', 'm1510_hrt_failr_care_plan_chg']

        this.super_main.query("[name = m1500_symtm_hrt_failr_ptnts]").forEach(function(s){
            s.on('change', function(el){
                if(el.getGroupValue() == "00" || el.getGroupValue() == "02" || el.getGroupValue() == "NA" ){
                    Ext.each(heartFailures, function(element){
                        this.super_main.down('checkbox[name='+element+']').disable().reset();
                    },this);
                }else{
                    Ext.each(heartFailures, function(element){
                        this.super_main.down('checkbox[name='+element+']').enable();
                    },this);
                }
            }, this);
        }, this);

        var heartFollowUp = [this.m1510HrtFailrPhysnCntct, this.m1510HrtFailrErTrtmt, this.m1510HrtFailrPhysnTrtmt,
            this.m1510HrtFailrClnclIntrvtn, this.m1510HrtFailrCarePlanChg]
        this.m1510HrtFailrNoActn.on('change', function(ele){
            if(ele.value == "1"){
                Ext.each(heartFollowUp, function(h, i){
                    h.disable().reset();
                }, this);
            } else {
                Ext.each(heartFollowUp, function(h, i){
                    h.enable().reset();
                }, this);
            }
        }, this);

    },
    onValidate: function(){
        var errs = new Array();
        var m1500SymtmHrtFailrPtnts = this.super_main.down('radiofield[name=m1500_symtm_hrt_failr_ptnts]');
        if(m1500SymtmHrtFailrPtnts.getGroupValue() == null){
            errs.push(['M1500', "Select one option, whether the patient's exhibiting the Symptoms in Heart Failure as per clinical guidelines."]);
        }

        if(m1500SymtmHrtFailrPtnts.getGroupValue() == "01"){
            if(this.m1510HrtFailrNoActn.value == false  &&  this.m1510HrtFailrPhysnCntct.value == false && this.m1510HrtFailrPhysnTrtmt.value == false &&
                this.m1510HrtFailrClnclIntrvtn.value == false && this.m1510HrtFailrCarePlanChg.value == false && this.m1510HrtFailrErTrtmt.value == false){
                errs.push(['M1510',"Do not leave Heart Failure Follow up empty, since Symptoms in Heart Failure is selected as 'Yes'."]);
            }
        }
        return errs;
    }
})
