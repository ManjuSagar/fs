/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.MedicationsM2004M2030', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.medicationsM2004M2030',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'radiogroup',
            fieldLabel: "(M2004) Medication Intervention: If there were any clinically significant medication issues at the time of, or at any time since the previous OASIS"+
                " assessment, was a physician or the physician-designee contacted within one calendar day"+
                " to resolve any identical clinically significant medication issues, including reconciliation?",
            cls: 'oasis_blue',
            item_id: 'sign_medic_issues',
            width: "98%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m2004_mdctn_intrvtn",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - No'
                },
                {
                    xtype: 'radiofield',
                    name: "m2004_mdctn_intrvtn",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Yes'
                },
                {
                    xtype: 'radiofield',
                    name: "m2004_mdctn_intrvtn",
                    inputValue: "NA",
                    margin: 5,
                    boxLabel: 'NA - Patient not taking any drugs'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            fieldLabel: "(M2015) Patient/Caregiver Drug Education Intervention: At the time of, or at any time since the previous OASIS assessment, was the"+
                " patient/caregiver instructed by agency staff or other health care provider to monitor the effectiveness of drug"+
                " therapy,adverse drug reactions, and significant side effects, and how and when to report problems that may occur?",
            cls: 'oasis_blue',
            item_id: 'drug_edu_interven',
            width: "98%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m2015_drug_edctn_intrvtn",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - No'
                },
                {
                    xtype: 'radiofield',
                    name: "m2015_drug_edctn_intrvtn",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Yes'
                },
                {
                    xtype: 'radiofield',
                    name: "m2015_drug_edctn_intrvtn",
                    inputValue: "NA",
                    margin: 5,
                    boxLabel: 'NA - Patient not taking any drugs'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            fieldLabel: "(M2020) Management of Oral Medications: Patient's current ability to prepare and take all oral medications reliably"+
                " and safely, including administration of the correct dosage at the appropriate times/intervals. Excludes"+
                " injectable and IV medications. (NOTE: This refers to ability, not compliance or willingness.)",
            cls: 'oasis_blue',
            item_id: 'mgmt_oral_med',
            width: "98%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m2020_crnt_mgmt_oral_mdctn",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Able to independently take the correct oral medication(s) and proper dosage(s) at the correct times.'
                },
                {
                    xtype: 'radiofield',
                    name: "m2020_crnt_mgmt_oral_mdctn",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Able to take medication(s) at the correct times if:'+
                        '(a) individual dosages are prepared in advance by another person; OR'+
                        '(b) another person develops a drug diary or chart.'
                },
                {
                    xtype: 'radiofield',
                    name: "m2020_crnt_mgmt_oral_mdctn",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Able to take medication(s) at the correct times if given reminders by another person at the'+
                        'appropriate times'
                },
                {
                    xtype: 'radiofield',
                    name: "m2020_crnt_mgmt_oral_mdctn",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Unable to take medication unless administered by another person'
                },
                {
                    xtype: 'radiofield',
                    name: "m2020_crnt_mgmt_oral_mdctn",
                    inputValue: "NA",
                    margin: 5,
                    boxLabel: 'NA - No oral medications prescribed.'
                }
            ]
        },              {
            xtype: 'radiogroup',
            fieldLabel: "(M2030) Management of Injectable Medications: Patient's current ability to prepare and take all prescribed"+
                " injectable medications reliably and safely, including administration of correct dosage at the appropriate"+
                " times/intervals. Excludes IV medications.",
            cls: 'oasis_green',
            item_id: 'inj_medications2',
            width: "98%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Able to independently take the correct medication(s) and proper dosage(s) at the correct times.'
                },
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Able to take injectable medication(s) at the correct times if:'+
                        '(a) individual syringes are prepared in advance by another person; OR'+
                        '(b) another person develops a drug diary or chart.'
                },
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Able to take medication(s) at the correct times if given reminders by another person based on the'+
                        ' frequency of the injection'
                },
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Unable to take injectable medication unless administered by another person.'
                },
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "NA",
                    margin: 5,
                    boxLabel: 'NA - No injectable medications prescribed.'
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();

        var m2004MdctnIntrvtn = main.down("[name=m2004_mdctn_intrvtn]").getGroupValue();
        var m2015DrugEdctnIntrvtn = main.down("[name=m2015_drug_edctn_intrvtn]").getGroupValue();
        var m2020Value = main.down("[name=m2020_crnt_mgmt_oral_mdctn]").getGroupValue();
        var m2030Value = main.down("[name=m2030_crnt_mgmt_injctn_mdctn]").getGroupValue();

        if(m2004MdctnIntrvtn == null){
            errs.push(['M2004', "Choose (Yes/No/NA), whether patient have medical interventions since previous OASIS assessment."]);
        }

        if(m2015DrugEdctnIntrvtn == null){
            errs.push(['M2015', "Patient/Caregiver Drug Education Intervention is required"]);
        }
        if(m2020Value == null){
            errs.push(['M2020', "Management of Oral Medications cannot be blank."]);
        }
        if(m2030Value == null){
            errs.push(['M2030', "Management of Injectable Medications cannot be blank."]);
        }

        return errs;
    }
})
