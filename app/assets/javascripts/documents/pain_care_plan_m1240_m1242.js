/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.PainCarePlanM1240M1242', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.painCarePlanM1240M1242',
    border: false,
    items: [
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1240) Has this patient had a formal Pain Assessment using a standardized, validated pain assessment tool (appropriate to the patient`s ability to communicate the severity of pain)?",
            labelAlign: 'top',
            width: "92%",
            cls: 'oasis_blue',
            itemId: 'formal_pain_assesment',
            columns: 1,
            margin: 5,
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1240_frml_pain_asmt",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - No standardized, validated assessment conducted'
                },
                {
                    xtype: 'radiofield',
                    name: "m1240_frml_pain_asmt",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Yes, and it does not indicate severe pain'
                },
                {
                    xtype: 'radiofield',
                    name: "m1240_frml_pain_asmt",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Yes, and it indicates severe pain'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1242) Frequency of Pain Interfering with patient`s activity or movement",
            labelAlign: 'top',
            cls: 'oasis_pink',
            width: "92%",
            itemId: 'freq_of_pain',
            columns: 1,
            margin: 5,
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1242_pain_freq_actvty_mvmt",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Patient has no pain'
                },
                {
                    xtype: 'radiofield',
                    name: "m1242_pain_freq_actvty_mvmt",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Patient has pain that does not interfere with activity or movement'
                },
                {
                    xtype: 'radiofield',
                    name: "m1242_pain_freq_actvty_mvmt",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Less often than daily'
                },
                {
                    xtype: 'radiofield',
                    name: "m1242_pain_freq_actvty_mvmt",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Daily, but not constantly'
                },
                {
                    xtype: 'radiofield',
                    name: "m1242_pain_freq_actvty_mvmt",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - All of the time'
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m1240Pain = main.down('radiofield[name=m1240_frml_pain_asmt]').getGroupValue();
        m1242Actvty = main.down('radiofield[name=m1242_pain_freq_actvty_mvmt]').getGroupValue();

        if(m1240Pain == null){
            errs.push(['M1240', "Select at least one Formal Pain Assessment using pain assessment Tool."]);
        }
        if(m1242Actvty == null){
            errs.push(['M1242', "Select at least one Frequency of Pain."]);
        }
        return errs;
    }
})
