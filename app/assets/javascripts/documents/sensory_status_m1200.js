/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.SensoryStatusM1200', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.sensoryStatusM1200',
    border: false,
    items: [
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1200) Vision (with corrective lenses if the patient usually wears them)",
            width: "75%",
            cls: 'oasis_green',
            item_id: 'pat_vision1',
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1200_vision",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Normal vision: sees adequately in most situations; can see medication labels, newsprint.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1200_vision",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Partially impaired: cannot see medication labels or newsprint, but can see obstacles in path, and the surrounding layout; can count fingers at arm`s length.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1200_vision",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Severely impaired: cannot locate objects without hearing or touching them or patient nonresponsive.'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1242) Frequency of Pain Interfering with patient`s activity or movement",
            cls: 'oasis_pink',
            item_id: 'fre_of_pain2',
            width: "75%",
            labelAlign: 'top',
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
        m1200Vision = main.down('radiofield[name=m1200_vision]').getGroupValue();
        m1242Actvty = main.down('radiofield[name=m1242_pain_freq_actvty_mvmt]').getGroupValue();
        if(m1200Vision == null){
            errs.push(['M1200', "Select one item from Vision."]);
        }
        if(m1242Actvty == null){
            errs.push(['M1242', "Select at least one Frequency of Pain."]);
        }
        return errs;
    }
})
