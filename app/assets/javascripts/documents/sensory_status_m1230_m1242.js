/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.SensoryStatusM1230M1242', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.sensoryStatusM1230M1242',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1230) Speech and Oral (Verbal) Expression of Language (in patient`s own language)",
            cls: "oasis_blue",
            item_id: 'speech_and_oral',
            width: "90%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Expresses complex ideas, feelings, and needs clearly, completely, and easily in all situations with no observable impairment.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Minimal difficulty in expressing ideas and needs (may take extra time; makes occasional errors in word choice, grammar or speech intelligibility; needs minimalprompting or assistance).'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Expresses simple ideas or needs with moderate difficulty (needs prompting or assistance,errors in word choice, organization or speech intelligibility). Speaks in phrases or short sentences.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Has severe difficulty expressing basic ideas or needs and requires maximal assistance or guessing by listener. Speech limited to single words or short phrases.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Unable to express basic needs even with maximal prompting or assistance but is not comatose or unresponsive (for example: speech is nonsensical or unintelligible).'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - Patient nonresponsive or unable to speak.'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1242) Frequency of Pain Interfering with patient`s activity or movement",
            labelAlign: 'top',
            cls: 'oasis_pink',
            item_id: 'fre_of_pain1',
            width: "90%",
            columns: 1,
            margin: "10 5",
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
        m1230Speech = main.down('radiofield[name=m1230_speech]').getGroupValue();
        m1242Actvty = main.down('radiofield[name=m1242_pain_freq_actvty_mvmt]').getGroupValue();
        if(m1230Speech == null){
            errs.push(['M1230', "Select at least one way how the patient is able to convey the Speech and Oral Communication."]);
        }
        if(m1242Actvty == null){
            errs.push(['M1242', "Select at least one Frequency of Pain."]);
        }
        return errs;
    }
})
