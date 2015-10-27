/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.RespiratoryCardiacM1400M1510', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.respiratoryCardiacM1400M1510',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'radiogroup',
            width: 757,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1400) When is the patient dyspneic or noticeably Short of Breath?',
            cls: 'oasis_pink',
            itemId: 'pat_dysn1',
            width: "98%",
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '0 - Patient is not short of breath ',
                    inputValue: '00'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '1 - When walking more than 20 feet, climbing stairs',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '2 - With moderate exertion (e.g., while dressing, using commode or bedpan, walking distances less than 20 feet) ',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '3 - With minimal exertion (e.g., while eating, talking, or performing other ADLs) or with agitation',
                    inputValue: '03'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '4 - At rest (during day or night)',
                    inputValue: '04'
                }
            ]
        },
        {
            xtype: 'checkboxgroup',
            width: 757,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1410) Respiratory Treatments utilized at home: (Mark all that apply.)',
            labelAlign: 'top',
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'm1410_resptx_oxygen',
                    boxLabel: '1 - Oxygen (intermittent or continuous)',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1410_resptx_ventilator',
                    boxLabel: '2 - Ventilator (continually or at night)',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1410_resptx_airpress',
                    boxLabel: '3 - Continuous / Bi-level positive airway pressure ',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1410_resptx_none',
                    boxLabel: '4 - None of the above ',
                    inputValue: '1'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            width: 757,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1500) Symptoms in Heart Failure Patients: If patient has been diagnosed with heart failure, did the patient exhibit'+
                "symptoms indicated by clinical heart failure guidelines (including dyspnea, orthopnea, edema, or weight gain)"+
                'at any point since the previous OASIS assessment?',
            cls: 'oasis_blue',
            itemId: 'symp_heart_failure2',
            width: "98%",
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1500_symtm_hrt_failr_ptnts',
                    boxLabel: '0 - No',
                    inputValue: '00',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1600]</text>'
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
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1600]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1500_symtm_hrt_failr_ptnts',
                    boxLabel: 'NA - Patient does not have diagnosis of heart failure',
                    inputValue: 'NA',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1600]</text>'
                },
            ]
        },
        {
            xtype: 'checkboxgroup',
            width: 757,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1510) Heart Failure Follow-up: If patient has been diagnosed with heart failure and has exhibited symptoms'+
                "indicative of heart failure since the previous OASIS assessment, what action(s) has (have) been taken to"+
                'respond? (Mark all that apply.)',
            cls: 'oasis_blue',
            itemId: 'symp_indicative_heart_failure2',
            width: "98%",
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
                    boxLabel: '2 - Patient advised to get emergency treatment (e.g., call 911 or go to emergency room)',
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
                    boxLabel: '5 - Obtained change in care plan orders (e.g., increased monitoring by agency, change in visit'+
                        'frequency, telehealth, etc.)',
                    inputValue: '1'
                }
            ]
        }

    ],
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];

        this.noneOfAbove = this.super_main.down('checkbox[name=m1410_resptx_none]');
        this.fields = ["m1410_resptx_oxygen", "m1410_resptx_ventilator", "m1410_resptx_airpress"];
        this.m1410Oxygen = this.super_main.down("[name=m1410_resptx_oxygen]");
        this.m1410Ventilator = this.super_main.down("[name=m1410_resptx_ventilator]");
        this.m1410AirPress = this.super_main.down("[name=m1410_resptx_airpress]");
        this.m1410None = this.super_main.down("[name=m1410_resptx_none]");
        this.selectNoneOfAbove();
        this.selectOtherValues();

        this.m1500SymtmHrtFailrPtnts = this.super_main.down('radiofield[name=m1500_symtm_hrt_failr_ptnts]').getGroupValue();
        var m1500SymtmHrtFailrPtnts = this.super_main.down('radiofie[name=m1500_symtm_hrt_failr_ptnts]');


        this.m1510HrtFailrNoActn = this.super_main.down('[name=m1510_hrt_failr_no_actn]');
        this.m1510HrtFailrPhysnCntct = this.super_main.down('[name=m1510_hrt_failr_physn_cntct]');
        this.m1510HrtFailrErTrtmt = this.super_main.down('[name=m1510_hrt_failr_er_trtmt]');
        this.m1510HrtFailrPhysnTrtmt = this.super_main.down('[name=m1510_hrt_failr_physn_trtmt]');
        this.m1510HrtFailrClnclIntrvtn = this.super_main.down('[name=m1510_hrt_failr_clncl_intrvtn]');
        this.m1510HrtFailrCarePlanChg = this.super_main.down('[name=m1510_hrt_failr_care_plan_chg]');

        heartFailures = ['m1510_hrt_failr_no_actn', 'm1510_hrt_failr_physn_cntct', 'm1510_hrt_failr_er_trtmt', 'm1510_hrt_failr_physn_trtmt',
            'm1510_hrt_failr_clncl_intrvtn', 'm1510_hrt_failr_care_plan_chg']

        /* this.noneOfAbove.on('change',function(el){
         console.log("hello");
         if(el.value){
         Ext.each(this.fields, function(element){
         console.log("element"+element);
         this.down("checkbox[name="+element+"]").setValue(false);
         }, this);
         }
         }, this);

         Ext.each(this.fields, function(element){
         this.down("[name="+element+"]").on('change',function(el){
         if(el.value){
         this.m1410None.setValue(false);
         }
         }, this);
         }, this);   */



        this.super_main.query("[name = m1500_symtm_hrt_failr_ptnts]").forEach(function(s){
            s.on('change', function(el){
                if(el.getGroupValue() == "00" || el.getGroupValue() == "02" || el.getGroupValue() == "NA" ){
                    Ext.each(heartFailures, function(element){
                        this.super_main.down('checkbox[name='+element+']').disable().setValue(false);
                    },this);
                }else{
                    Ext.each(heartFailures, function(element){
                        this.super_main.down('checkbox[name='+element+']').enable().setValue(false);
                    },this);
                }
            }, this);
        }, this);

        var heartFollowUp = [this.m1510HrtFailrPhysnCntct, this.m1510HrtFailrErTrtmt, this.m1510HrtFailrPhysnTrtmt,
            this.m1510HrtFailrClnclIntrvtn, this.m1510HrtFailrCarePlanChg]
        this.m1510HrtFailrNoActn.on('change', function(ele){
            if(ele.value == "1"){
                Ext.each(heartFollowUp, function(h, i){
                    h.disable().setValue(false);
                }, this);
            } else {
                Ext.each(heartFollowUp, function(h, i){
                    h.enable().setValue(false);
                }, this);
            }
        }, this);
    },
    selectNoneOfAbove: function(){
        this.noneOfAbove.on('change',function(el){
            if(el.value){
                Ext.each(this.fields, function(element){
                    console.log("element"+element);
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
            }
        }, this);
    },
    selectOtherValues: function(){
        Ext.each(this.fields, function(element){
            this.down("[name="+element+"]").on('change',function(el){
                if(el.value){
                    this.m1410None.setValue(false);
                }
            }, this);
        }, this);
    },
    onValidate: function(main){
        var errs = new Array();
        var m1500SymtmHrtFailrPtnts = this.super_main.down('radiofield[name=m1500_symtm_hrt_failr_ptnts]');

        m1400Dyspneic = this.super_main.down('radiofield[name=m1400_when_dyspneic]').getGroupValue();
        if(m1400Dyspneic == null){
            errs.push(['M1400', "Select the reason when patient feel noticeably short of breath."]);
        }
        if(this.m1410Oxygen.value == false && this.m1410Ventilator.value == false && this.m1410AirPress.value == false && this.m1410None.value == false){
            errs.push(['M1410', "Select at least one mode of treatment from 'Respiratory Treatments utilized at home'."])
        }

        if(m1500SymtmHrtFailrPtnts.getGroupValue() == null){
            errs.push(['M1500', "Symptoms In Heart Failure Patients is required."]);
        }

        if(m1500SymtmHrtFailrPtnts.getGroupValue() == "01"){
            if(this.m1510HrtFailrNoActn.value == false  &&  this.m1510HrtFailrPhysnCntct.value == false && this.m1510HrtFailrErTrtmt.value == false &&
                this.m1510HrtFailrPhysnTrtmt.value == false && this.m1510HrtFailrClnclIntrvtn.value == false && this.m1510HrtFailrCarePlanChg.value == false){
                errs.push(['M1510', "Do not leave Heart Failure Follow up field empty, since Symptoms in Heart Failure is selected as 'Yes'."]);
            }
        }
        return errs;
    }
})
