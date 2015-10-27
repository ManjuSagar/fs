/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.MedicationsPocAllergies', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.medicationsPocAllergies',
    border: 0,
    layout: {
        type: 'vbox',
    },
    items:[
        {
            xtype: 'checkboxgroup',
            margin: '5px',
            columns: 5,
            defaults:{
                width: 120
            },
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'allergies',
                    boxLabel: 'None Known',
                    inputValue: "1",
                },
                {
                    xtype: 'checkboxfield',
                    name: 'allergies',
                    boxLabel: "Aspirin",
                    inputValue: "2",
                },
                {
                    xtype: 'checkboxfield',
                    name: 'allergies',
                    boxLabel: "Penicillin",
                    inputValue: "3",
                },
                {
                    xtype: 'checkboxfield',
                    name: 'allergies',
                    boxLabel: "Sulfa",
                    inputValue: "4",
                },
                {
                    xtype: 'checkboxfield',
                    name: 'allergies',
                    boxLabel: "Pollen",
                    inputValue: "5",
                },
                {
                    xtype: 'checkboxfield',
                    name: 'allergies',
                    boxLabel: "Eggs",
                    inputValue: "6",
                },
                {
                    xtype: 'checkboxfield',
                    name: 'allergies',
                    boxLabel: "Milk products",
                    inputValue: "7",
                },
                {
                    xtype: 'checkboxfield',
                    name: 'allergies',
                    boxLabel: "Insect bites",
                    inputValue: "8",
                },
                {
                    xtype: 'checkboxfield',
                    name: 'allergies',
                    boxLabel: "Other",
                    inputValue: "9",
                },
                {
                    xtype: 'textfield',
                    name: 'other_allergies',
                },
            ]
        },


    ]
})
