/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.TypesSourcesOfAssistance', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.typesSourcesOfAssistance',
    layout: {
        type: 'table',
        columns: 1,
        tableAttrs: {
            style: {
                width: '98%',
                height:'100%'
            }
        }
    },
    items:[
        {
            xtype: 'fieldset',
            margin: '3px',
            height: '100%',
            layout: {
                type: 'hbox',
                align: "stretch"

            },
            title: 'APPLIANCES / SPECIAL EQUIPMENT/ORGANIZATIONS',
            items:[
                {
                    xtype: 'panel',
                    border: 0,
                    flex: 1,
                    layout: {
                        type: 'vbox',
                    },
                    margin: '3px',
                    items: [
                        {
                            xtype: 'checkboxfield',
                            name: 'source_of_assistance',
                            boxLabel: 'Brace/orthotics(specify)',
                            inputValue: '1',
                            width: 200,
                        },

                        {
                            xtype: 'textareafield',
                            name: 'brace_orthotics',
                            cols: 57,
                            height: 70,
                            margin: '0 0 0 24'
                        },


                        {
                            xtype: 'checkboxfield',
                            name: 'source_of_assistance',
                            boxLabel: 'Transfer equipment:',
                            inputValue: '2',
                        },
                        {
                            xtype: 'radiogroup',
                            margin: '0 0 0 20',
                            layout: {
                                align: 'stretch',
                                type: 'hbox'
                            },
                            labelWidth: 50,
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'transfer_equipment',
                                    boxLabel: 'Board',
                                    inputValue: '1',
                                    width: 115,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'transfer_equipment',
                                    boxLabel: "Lift",
                                    inputValue: "2",
                                    width: 75,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'transfer_equipment',
                                    boxLabel: "Bedside Commode",
                                    inputValue: "3",
                                    width: 160,
                                },
                            ]
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'source_of_assistance',
                            boxLabel: 'Prosthesis',
                            inputValue: '3',
                            width: 100,
                        },
                        {
                            xtype: 'checkboxgroup',
                            columns: 3,
                            height: 60,
                            margin: '0 0 0 20',
                            items:[
                                {
                                    xtype: 'checkboxfield',
                                    name: 'prosthesis',
                                    boxLabel: 'RUE',
                                    inputValue: 'RUE',
                                    width: 115,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'prosthesis',
                                    boxLabel: 'RLE',
                                    inputValue: 'RLE',
                                    width: 75,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'prosthesis',
                                    boxLabel: 'LUE',
                                    inputValue: 'LUE',
                                    width: 160,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'prosthesis',
                                    boxLabel: 'LLE',
                                    inputValue: 'LLE',
                                    width: 115,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'prosthesis',
                                    boxLabel: 'Other',
                                    inputValue: 'Other',
                                    width: 75,
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'prosthesis_other',
                                    width: 240
                                },

                            ]

                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'source_of_assistance',
                            boxLabel: 'Grab bars',
                            inputValue: '4',
                            width: 80,
                        },
                        {
                            xtype: 'checkboxgroup',
                            columns: 3,
                            height: 40,
                            margin: '0 0 0 20',
                            items:[
                                {
                                    xtype: 'checkboxfield',
                                    name: 'grab_bars',
                                    boxLabel: 'Bathroom',
                                    inputValue: '1',
                                    width: 115,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'grab_bars',
                                    boxLabel: 'Other',
                                    inputValue: '2',
                                    width: 75,
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'grab_bars_other',
                                    width: 240
                                },

                            ]

                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'source_of_assistance',
                            boxLabel: 'Hospital bed',
                            inputValue: '5',
                            width: 100,
                        },
                        {
                            xtype: 'checkboxgroup',
                            layout: 'hbox',
                            height: 40,
                            margin: '0 0 0 20',
                            items:[
                                {
                                    xtype: 'checkboxfield',
                                    name: 'hospital_bed',
                                    boxLabel: 'Semi-electric',
                                    inputValue: '1',
                                    width: 115,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'hospital_bed',
                                    boxLabel: 'Crank',
                                    inputValue: '2',
                                    width: 75,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'hospital_bed',
                                    boxLabel: 'Special',
                                    inputValue: '3',
                                    width: 75,
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'hospital_bed_text',
                                },

                            ]

                        },{
                            xtype: 'checkboxfield',
                            name: 'source_of_assistance',
                            boxLabel: 'Medical Alert',
                            inputValue: '6',
                        },{
                            xtype: 'textareafield',
                            name: 'medical_alert',
                            margin: '0 0 0 20',
                            cols: 40,
                            height: 70,
                        },

                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    flex: 1,
                    layout: {
                        type: 'vbox'
                    },
                    margin: '3px',
                    items: [
                        {
                            xtype: 'checkboxfield',
                            name: 'source_of_assistance',
                            boxLabel: 'Needs (specify)',
                            inputValue: '9',
                        },
                        {
                            xtype: 'textareafield',
                            name: 'needs',
                            margin: '0 0 0 20',
                            cols: 41,
                            height: 70,
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'source_of_assistance',
                            boxLabel: 'Oxygen',
                            inputValue: '7',
                            width: 100,
                        },
                        {
                            xtype: 'textfield',
                            name: 'oxygen_hme_co',
                            margin: '3 0 0 20',
                            fieldLabel: 'HME Co',
                            isHeader: false
                        },
                        {
                            xtype: 'textfield',
                            name: 'oxygen_hme_rep',
                            margin: '3 0 0 20',
                            fieldLabel: 'HME Rep',
                            isHeader: false
                        },
                        {
                            xtype: 'textfield',
                            name: 'oxygen_phone',
                            margin: '3 0 0 20',
                            fieldLabel: 'Phone',
                            isHeader: false
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'source_of_assistance',
                            boxLabel: 'Organizations providing equipment',
                            inputValue: '8',
                        },
                        {
                            xtype: 'textareafield',
                            name: 'organizations_providing_equipment',
                            margin: '0 0 0 20',
                            cols: 41,
                            height: 70,
                        },
                    ]

                }
            ]
        }
    ]
})
