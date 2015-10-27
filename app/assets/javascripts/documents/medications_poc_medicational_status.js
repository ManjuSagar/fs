/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.MedicationsPocMedicationalStatus', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.medicationsPocMedicationalStatus',
    border: 0,
    layout: {
        type: 'vbox',
    },
    items:[
        {
            xtype: 'radiogroup',
            margin: '5px',
            layout: {
                align: 'stretch',
                type: 'hbox'
            },
            labelWidth: 300,
            width: 700,
            height: 30,
            items: [
                {
                    xtype: 'radiofield',
                    name: 'medication_status',
                    boxLabel: 'Medication regimen completed',
                    inputValue: '1',
                    margin: '3px'
                },
                {
                    xtype: 'radiofield',
                    name: 'medication_status',
                    boxLabel: 'Medication regimen reviewed ',
                    inputValue: '2 ',
                    margin: '3px'
                },
                {
                    xtype: 'radiofield',
                    name: 'medication_status',
                    boxLabel: 'No change',
                    inputValue: '3',
                    margin: '3px'
                },
                {
                    xtype: 'radiofield',
                    name: 'medication_status',
                    boxLabel: 'Order obtained',
                    inputValue: '4',
                    margin: '3px'
                }
            ]
        },
        {
            xtype: 'checkboxgroup',
            margin: '7px',
            columns: 3,
            fieldLabel: 'Check if any of the following were identified',
            labelAlign: 'top',
            defaults: {
                width: 290
            },
            height: 100,
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'identification',
                    margin: '0 0 0 20',
                    boxLabel: 'Potential adverse effects/drug reactions',
                    inputValue: '1',
                },
                {
                    xtype: 'checkboxfield',
                    name: 'identification',
                    boxLabel: "Ineffective drug therapy",
                    inputValue: "3"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'identification',
                    boxLabel: "Significant side effects",
                    inputValue: "4"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'identification',
                    margin: '0 0 0 20',
                    boxLabel: "Significant drug interactions",
                    inputValue: "5"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'identification',
                    boxLabel: "Duplicate drug therapy",
                    inputValue: "6"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'identification',
                    boxLabel: "Non-compliance with drug therapy",
                    inputValue: "7"
                },
            ]
        },
        {
            xtype: 'fieldset',
            border: 0,
            layout: {
                type: "vbox"
            },
            margin: '3px',
            items: [
                {
                    xtype: 'radiogroup',
                    margin: '2px',
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    labelWidth: 300,
                    width: 600,
                    height: 20,
                    fieldLabel: 'Financial ability to pay for medications',
                    xlabelAlign: 'top',
                    items: [
                        {
                            xtype: 'radiofield',
                            name: 'medication_financial_ability',
                            boxLabel: 'Yes',
                            inputValue: 'Y',
                            width: 100,
                        },
                        {
                            xtype: 'radiofield',
                            name: 'medication_financial_ability',
                            boxLabel: 'No ',
                            inputValue: 'N',
                            width: 100,
                        }
                    ]
                },
                {
                    xtype: 'radiogroup',
                    margin: '2px',
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    labelWidth: 300,
                    width: 900,
                    height: 50,
                    fieldLabel: 'If no, was MSW referral made?',
                    xlabelAlign: 'top',
                    items: [
                        {
                            xtype: 'radiofield',
                            name: 'msw_referral',
                            boxLabel: 'Yes',
                            inputValue: 'Y',
                            width: 100,
                        },
                        {
                            xtype: 'radiofield',
                            name: 'msw_referral',
                            boxLabel: 'No ',
                            inputValue: 'N',
                            width: 100,
                        },
                        {
                            xtype: 'textareafield',
                            name: 'msw_referral_comment',
                            isHeader: false,
                            fieldLabel: 'Comment',
                            labelWidth: 80,
                            height: 70,
                            cols:30
                        }
                    ]
                }

            ]
        },

    ]
})
