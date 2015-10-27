/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.FunctionalLimitations', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.functionalLimitations',
    items:[
        {
            xtype: 'checkboxgroup',
            columns: 3,
            defaults: {
                width: 300,
                margin: '3px'
            },
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: '1-Amputation',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: '2-Bowel/Bladder (Incontinence)',
                    inputValue: '2'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: '3-Contracture',
                    inputValue: '3'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: '4-Hearing',
                    inputValue: '4'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: '5-Paralysis',
                    inputValue: '5'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: '6-Endurance',
                    inputValue: '6'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: '7-Ambulation',
                    inputValue: '7'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: '8-Speech',
                    inputValue: '8'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: '9-Legally blind',
                    inputValue: '9'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'functional_limitations',
                    boxLabel: 'A-Dyspnea with minimal exertion',
                    inputValue: '10'
                }
            ]
        },
        {
            xtype: 'checkboxfield',
            name: 'functional_limitations',
            boxLabel: 'B-Other (specify)',
            inputValue: '11',
            margin: '0 0 0 8'
        },
        {
            xtype: 'textareafield',
            name:  'functional_limitations_other',
            margin: '0 0 0 8',
            cols: 50
        }
    ]
})
