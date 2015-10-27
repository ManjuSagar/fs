/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.MedicationsM2004M2015C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.medicationsM2004M2015C1',
    border: false,
    items: [
        {
            xtype: 'radiogroup',
            fieldLabel: "(M2004) Medication Intervention: If there were any clinically significant medication issues at the time of, or at any time since the previous OASIS"+
                " assessment, was a physician or the physician-designee contacted within one calendar"+
                " to resolve any identified clinically significant medication issues, including reconciliation?",
            cls: 'oasis_blue',
            item_id: 'med_interven',
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
                    boxLabel: 'NA - No clinically significant medication issues identified at the time of or at any time since the previous OASIS assessment'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            fieldLabel: "(M2015) Patient/Caregiver Drug Education Intervention: At the time of, or at any time since the previous OASIS assessment, was the"+
                " patient/caregiver instructed by agency staff or other health care provider to monitor the effectiveness of drug"+
                " therapy, adverse drug reactions, and significant side effects, and how and when to report problems that may occur?",
            cls: 'oasis_blue',
            item_id: 'drug_edu1',
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
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m2004MdctnIntrvtn = main.down('radiofield[name=m2004_mdctn_intrvtn]').getGroupValue();
        m2015DrugEdctnIntrvtn = main.down('radiofield[name=m2015_drug_edctn_intrvtn]').getGroupValue();

        if(m2004MdctnIntrvtn == null){
            errs.push(['M2004', "Choose (Yes/No/NA), whether patient have medical interventions since previous OASIS assessment."]);
        }

        if(m2015DrugEdctnIntrvtn == null){
            errs.push(['M2015', "Choose (Yes/No/NA), whether patient/caregiver have drug education interventions."]);
        }

        return errs;
    }
})
