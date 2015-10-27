/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.MedicationsPocIvSupplies', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.medicationsPocIvSupplies',
    border: 0,
    layout: {
        type: 'vbox',
    },
    items:[
        {
            xtype: 'checkboxgroup',
            columns: 5,
            defaults: {
                width: 160,
                margin: '3px'
            },
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'IV start kit',
                    inputValue: '1',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'IV pole',
                    inputValue: '2',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'IV tubing',
                    inputValue: '3',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Alcohol swabs',
                    inputValue: '4',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Tape',
                    inputValue: '5',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Injection caps',
                    inputValue: '6',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Central line dressing',
                    inputValue: '7',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Angiocatheter size',
                    inputValue: '8',
                },
                {
                    xtype: 'textfield',
                    name: 'angiocatheter_size',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Extension tubings',
                    inputValue: '9',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Batteries size',
                    inputValue: '10',
                },
                {
                    xtype: 'textfield',
                    name: 'batteries_size',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Syringes size',
                    inputValue: '11',
                },
                {
                    xtype: 'textfield',
                    name: 'syringes_size',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Infusion pump',
                    inputValue: '12',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'iv_supplies',
                    boxLabel: 'Other',
                    inputValue: '13',
                },
                {
                    xtype: 'textfield',
                    name: 'other_iv_supplies',
                },

            ]
        }
    ]
})
