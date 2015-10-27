/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.MedicationsM2000M2030', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.medicationsM2000M2030',
    border: 0,
    height: 1300,
    items: [
        {
            xtype: 'panel',
            layout: {
                align: 'stretch',
                type: 'hbox'
            },
            items: [
                {
                    xtype: 'panel',
                    flex: 1.55,
                    border: 0,
                    layout: {
                        align: 'stretch',
                        type: 'vbox'
                    },
                    items: [
                        {
                            xtype: 'radiogroup',
                            height: 180,
                            layout: {
                                align: 'stretch',
                                type: 'vbox'
                            },
                            fieldLabel: '(M2000) Drug Regimen Review: Does a complete drug regimen review indicate potential clinically significant medication issues (for example, adverse drug reactions, ineffective drug therapy, significant side effects, drug interactions, duplicate therapy, omissions, dosage errors, or noncompliance [non-adherence])?',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm2000_drug_rgmn_rvw',
                                    boxLabel: '0 - Not assessed/reviewed',
                                    inputValue: '00',
                                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M2010]</text>'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2000_drug_rgmn_rvw',
                                    boxLabel: '1 - No problems found during review',
                                    inputValue: '01',
                                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M2010]</text>'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2000_drug_rgmn_rvw',
                                    boxLabel: '2 - Problems found during review',
                                    inputValue: '02'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2000_drug_rgmn_rvw',
                                    boxLabel: 'NA - Patient is not taking any medications',
                                    inputValue: 'NA',
                                    afterBoxLabelTpl: ' <text class="oasis_yellow"> [Go to M2040]</text>'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            height: 110,
                            layout: {
                                align: 'stretch',
                                type: 'vbox'
                            },
                            fieldLabel: '(M2002) Medication Follow-up: Was a physician or the physician-designee contacted within one calendar day to resolve clinically significant medication issues, including reconciliation?',
                            cls: 'oasis_blue',
                            itemId: 'med_follow_up',
                            width: "98%",
                            margin: "0 5 5 0",
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm2002_mdctn_flwp',
                                    boxLabel: '0 - No',
                                    inputValue: '0'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2002_mdctn_flwp',
                                    boxLabel: '1 - Yes',
                                    inputValue: '1'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            height: 170,
                            width: 470,
                            layout: {
                                align: 'stretch',
                                type: 'vbox'
                            },
                            fieldLabel: '(M2010) Patient/Caregiver High Risk Drug Education: Has the patient/caregiver received instruction on special precautions for all high-risk medications (such as hypoglycemics, anticoagulants, etc.) and how and when to report problems that may occur?',
                            cls: 'oasis_blue',
                            itemId: 'drug_edu',
                            width: "98%",
                            margin: "0 5 0 0",
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm2010_high_risk_drug_edctn',
                                    boxLabel: '0 - No',
                                    inputValue: '00'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2010_high_risk_drug_edctn',
                                    boxLabel: '1 - Yes',
                                    inputValue: '01'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2010_high_risk_drug_edctn',
                                    boxLabel: 'NA - Patient not taking any high risk drugs OR patient/caregiver fully knowledgeable about special precautions associated with all high-risk medications',
                                    inputValue: 'NA'
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    flex: 1.60,
                    border: 0,
                    height: 586,
                    layout: {
                        align: 'stretch',
                        type: 'vbox'
                    },
                    items: [
                        {
                            xtype: 'radiogroup',
                            height: 241,
                            width: 580,
                            layout: {
                                align: 'stretch',
                                type: 'vbox'
                            },
                            fieldLabel: '(M2020) Management of Oral Medications: Patient\'s current ability to prepare and take all oral medications reliably and safely, including administration of the correct dosage at the appropriate times/intervals. Excludes injectable and IV medications. (NOTE: This refers to ability, not compliance or willingness.)',
                            cls: 'oasis_blue',
                            itemId: 'mgmt_orl_med',
                            width: "98%",
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    flex: 0.1,
                                    name: 'm2020_crnt_mgmt_oral_mdctn',
                                    boxLabel: '0 - Able to independently take the correct oral medication(s) and proper dosage(s) at the correct times.',
                                    inputValue: '00'
                                },
                                {
                                    xtype: 'radiofield',
                                    flex: 0.1,
                                    name: 'm2020_crnt_mgmt_oral_mdctn',
                                    boxLabel: '1 - Able to take medication(s) at the correct times if: (a) individual dosages are prepared in advance by another person; OR (b) another person develops a drug diary or chart.',
                                    inputValue: '01'
                                },
                                {
                                    xtype: 'radiofield',
                                    flex: 0.1,
                                    name: 'm2020_crnt_mgmt_oral_mdctn',
                                    boxLabel: '2 - Able to take medication(s) at the correct times if given reminders by another person at the appropriate times',
                                    inputValue: '02'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2020_crnt_mgmt_oral_mdctn',
                                    boxLabel: '3 - Unable to take medication unless administered by another person. ',
                                    inputValue: '03'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2020_crnt_mgmt_oral_mdctn',
                                    boxLabel: 'NA - No oral medications prescribed.',
                                    inputValue: 'NA'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            width: 558,
                            layout: {
                                align: 'stretch',
                                type: 'vbox'
                            },
                            fieldLabel: '(M2030) Management of Injectable Medications: Patient\'s current ability to prepare and take all prescribed injectable medications reliably and safely, including administration of correct dosage at the appropriate times/intervals. Excludes IV medications.',
                            cls: 'oasis_green',
                            itemId: 'inj_medications',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    height: 30,
                                    name: 'm2030_crnt_mgmt_injctn_mdctn',
                                    boxLabel: '0 - Able to independently take the correct medication(s) and proper dosage(s) at the correct times.',
                                    inputValue: '00'
                                },
                                {
                                    xtype: 'radiofield',
                                    height: 45,
                                    name: 'm2030_crnt_mgmt_injctn_mdctn',
                                    boxLabel: '1 - Able to take injectable medication(s) at the correct times if:    (a) individual syringes are prepared in advance by another person; OR (b) another person develops a drug diary or chart.',
                                    inputValue: '01'
                                },
                                {
                                    xtype: 'radiofield',
                                    height: 50,
                                    name: 'm2030_crnt_mgmt_injctn_mdctn',
                                    boxLabel: '2 - Able to take medication(s) at the correct times if given reminders by another person based on the frequency of the injection',
                                    inputValue: '02'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2030_crnt_mgmt_injctn_mdctn',
                                    boxLabel: '3 - Unable to take injectable medication unless administered by another person. ',
                                    inputValue: '03'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm2030_crnt_mgmt_injctn_mdctn',
                                    boxLabel: 'NA - No injectable medications prescribed.',
                                    inputValue: 'NA'
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m2000Value = main.down("[name=m2000_drug_rgmn_rvw]").getGroupValue();
        m2002Value = main.down("[name=m2002_mdctn_flwp]").getGroupValue();
        m2010Value = main.down("[name=m2010_high_risk_drug_edctn]").getGroupValue();
        m2020Value = main.down("[name=m2020_crnt_mgmt_oral_mdctn]").getGroupValue();
        m2030Value = main.down("[name=m2030_crnt_mgmt_injctn_mdctn]").getGroupValue();

        if(m2000Value == null){
            errs.push(['M2000', "Choose the option whether Drug Regimen Review accomplished."]);
        }

        if(m2000Value == "00" || m2000Value == "01"){
            if(m2010Value == null){
                errs.push(['M2010', "Patient/Caregiver High Risk Drug Education can't be blank."]);
            }
            if(m2020Value == null){
                errs.push(['M2020', "Management of Oral Medications can't be blank."]);
            }
            if(m2030Value == null){
                errs.push(['M2030', "Management of Injectable Medications can't be blank."]);
            }
        }

        if(m2000Value == "02"){
            if(m2002Value == null){
                errs.push(['M2002', "Medication Follow-up can't be blank."]);
            }
            if(m2010Value == null){
                errs.push(['M2010', "Patient/Caregiver High Risk Drug Education can't be blank."]);
            }
            if(m2020Value == null){
                errs.push(['M2020', "Management of Oral Medications can't be blank."]);
            }
            if(m2030Value == null){
                errs.push(['M2030', "Management of Injectable Medications can't be blank."]);
            }
        }
        return errs;
    },
    m2000ToM2030FieldsEventHandling: function(radio_group_array){
        this.query("[name=m2000_drug_rgmn_rvw]").forEach(function(s){
            s.on('change', function(el){
                if(el.getGroupValue() == "NA"){
                    radio_group_array[1].query("[xtype=radiofield]").forEach(function(el){el.disable().setValue(false)});
                    radio_group_array[2].query("[xtype=radiofield]").forEach(function(el){el.disable().setValue(false)});
                    radio_group_array[3].query("[xtype=radiofield]").forEach(function(el){el.disable().setValue(false)});
                    radio_group_array[4].query("[xtype=radiofield]").forEach(function(el){el.disable().setValue(false)});
                }
                else if(el.getGroupValue() == "00" || el.getGroupValue() == "01"){
                    radio_group_array[1].query("[xtype=radiofield]").forEach(function(el){el.disable().setValue(false)});
                    radio_group_array[2].query("[xtype=radiofield]").forEach(function(el){el.enable().setValue(false)});
                    radio_group_array[3].query("[xtype=radiofield]").forEach(function(el){el.enable().setValue(false)});
                    radio_group_array[4].query("[xtype=radiofield]").forEach(function(el){el.enable().setValue(false)});
                }else{
                    radio_group_array[1].query("[xtype=radiofield]").forEach(function(el){el.enable().setValue(false)});
                    radio_group_array[2].query("[xtype=radiofield]").forEach(function(el){el.enable().setValue(false)});
                    radio_group_array[3].query("[xtype=radiofield]").forEach(function(el){el.enable().setValue(false)});
                    radio_group_array[4].query("[xtype=radiofield]").forEach(function(el){el.enable().setValue(false)});
                }
            }, this);
        },this);
    },
    initComponent: function(){
        this.callParent();
        radio_group_array = this.query("[xtype=radiogroup]");
        this.m2000ToM2030FieldsEventHandling(radio_group_array);
    }
})
