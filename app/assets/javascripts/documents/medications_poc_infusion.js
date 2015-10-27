/**
 * Created by msuser1 on 10/12/14.
 */
Ext.define('Ext.panel.MedicationsPocInfusion', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.medicationsPocInfusion',
    border: 0,
    layout: {
        type: 'vbox',
    },
    items: [
        {
            xtype: 'checkboxfield',
            name: 'infusion',
            margin: '3px',
            boxLabel: '<b>N/A</b>',
            inputValue: 'NA',
            width: 80,
        },
        {
            xtype: "panel",
            border: false,
            header: false,
            layout: "hbox",
            items: [
                {xtype: "panel",
                    border: false,
                    header: false,
                    layout: "hbox",
                    items: [
                        {
                            xtype: "panel",
                            border: false,
                            header: false,
                            layout: 'vbox',
                            margin: 5,
                            items: [
                                {
                                    border: false,
                                    header: false,
                                    layout: {type: "table", columns: 3},
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'infusion',
                                            boxLabel: 'Peripheral line',
                                            inputValue: '1',
                                            width: 170,
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'infusion',
                                            boxLabel: "Midline catheter",
                                            inputValue: "2",
                                            width: 170
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'infusion',
                                            boxLabel: "Central line",
                                            inputValue: "3",
                                        },
                                    ]
                                },
                                {  border: false,
                                    header: false,
                                    layout: {type: "table", columns: 2},
                                    items: [
                                        {
                                            xtype: 'textfield',
                                            fieldLabel: 'Type/brand',
                                            isHeader: false,
                                            name: 'infusion_type',
                                            labelWidth: 165,
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel: 'Size/gauge/length',
                                            margin: '0 0 0 5',
                                            isHeader: false,
                                            labelWidth: 210,
                                            labelAlign: "right",
                                            name: 'infusion_length',
                                        },
                                    ]
                                },{
                                    border: false,
                                    header: false,
                                    layout: {type: "table", columns: 4},
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'infusion',
                                            boxLabel: 'Groshong',
                                            inputValue: '4',
                                            width: 170,
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'infusion',
                                            boxLabel: 'Non-Groshong ',
                                            inputValue: '5 ',
                                            width: 170,
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'infusion',
                                            boxLabel: 'Tunneled',
                                            inputValue: '6',
                                            width: 150,
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'infusion',
                                            boxLabel: 'Non-Tunneled ',
                                            inputValue: '7',
                                            width: 120,
                                        }

                                    ]
                                },{
                                    border: false,
                                    header: false,
                                    layout: {type: "table", columns: 2},
                                    items: [
                                        {
                                            xtype: 'textfield',
                                            isHeader: false,
                                            fieldLabel: 'Insertion site',
                                            name: 'insertion_site',
                                            labelWidth: 165,
                                        },
                                        {
                                            xtype: 'datefield',
                                            isHeader: false,
                                            fieldLabel: 'Insertion date',
                                            margin: '0 0 0 5',
                                            labelWidth: 210,
                                            name: 'insertion_site_date',
                                            labelAlign: "right"
                                        },
                                    ]
                                },            {
                                    xtype: 'radiogroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox'
                                    },
                                    width: 600,
                                    height: 20,
                                    fieldLabel: 'Lumens',
                                    labelWidth: 165,
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: 'lumens',
                                            boxLabel: 'Single',
                                            inputValue: 'S',
                                            width: 170
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'lumens',
                                            boxLabel: 'Double ',
                                            inputValue: 'D ',
                                            width: 150
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'lumens',
                                            boxLabel: 'Triple ',
                                            inputValue: 'T '
                                        }
                                    ]
                                },            {
                                    xtype: 'fieldcontainer',
                                    margin: '3px',
                                    layout: {
                                        type: 'hbox'
                                    },
                                    items: [
                                        {
                                            xtype: 'textfield',
                                            isHeader: false,
                                            fieldLabel: 'Flush solution/frequency',
                                            name: 'flush_solution_frequency',
                                            labelWidth: 165,
                                        },
                                        {
                                            xtype: 'textfield',
                                            isHeader: false,
                                            fieldLabel: 'Injection cap change frequency',
                                            labelWidth: 210,
                                            labelAlign: "right",
                                            name: 'injection_frequency',
                                        },
                                    ]
                                },            {
                                    xtype: 'radiogroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox'
                                    },
                                    width: 350,
                                    height: 20,
                                    fieldLabel: 'Patient',
                                    labelWidth: 165,
                                    defaults: {
                                        width: 100
                                    },
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: 'patient',
                                            boxLabel: 'Yes',
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'patient',
                                            boxLabel: 'No ',
                                            inputValue: 'N ',
                                        }
                                    ]
                                },
                                {
                                    border: false,
                                    header: false,
                                    layout: {type: "table", columns: 3},
                                    items: [
                                        {
                                            xtype: 'textfield',
                                            name: 'dressing_change_frequency',
                                            fieldLabel: 'Dressing change frequency',
                                            labelWidth: 168,
                                            margin: "0 5 0 0"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'dressing_frequency',
                                            boxLabel: "Sterile",
                                            inputValue: "1",
                                            width: 150
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'dressing_frequency',
                                            boxLabel: "Clean",
                                            inputValue: "2",
                                            width: 80
                                        },

                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox'
                                    },
                                    fieldLabel: 'Performed by',
                                    defaults: {
                                        width: 80
                                    },
                                    labelWidth: 165,
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: 'performed_by',
                                            boxLabel: 'Self',
                                            inputValue: 'SF',
                                            width: 100
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'performed_by',
                                            boxLabel: 'RN ',
                                            inputValue: 'RN ',
                                            width: 70
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'performed_by',
                                            boxLabel: 'Caregiver',
                                            inputValue: 'CG',
                                            width: 150
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'performed_by',
                                            boxLabel: 'Other ',
                                            inputValue: 'OTH ',
                                            width: 62,
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'other_performed_by',
                                            width: 161
                                        },


                                    ]
                                },
                                {
                                    xtype: 'fieldcontainer',
                                    layout: {
                                        type: 'hbox',
                                    },
                                    items: [
                                        {
                                            xtype: 'textfield',
                                            isHeader: false,
                                            fieldLabel: 'Site/skin condition',
                                            name: 'site_skin_condition',
                                            labelWidth: 168,
                                        },
                                        {
                                            xtype: 'textfield',
                                            isHeader: false,
                                            fieldLabel: 'External catheter length',
                                            labelWidth: 210,
                                            labelAlign: "right",
                                            name: 'external_catheter_length',
                                        },
                                    ]
                                },
                                {
                                    xtype: 'textareafield',
                                    fieldLabel: 'Other',
                                    isHeader: false,
                                    labelWidth: 169,
                                    name: 'other_infusion',
                                    height: 30,
                                    width: 719
                                },{
                                    xtype: 'checkboxgroup',
                                    columns: 4,
                                    fieldLabel: 'Purpose of intravenous access',
                                    labelAlign: 'top',
                                    height: 50,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'purpose_of_intravenous_access',
                                            boxLabel: 'Antibiotic therapy',
                                            margin: '0 0 0 5',
                                            inputValue: '1',
                                            width: 165,
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'purpose_of_intravenous_access',
                                            boxLabel: 'Pain control',
                                            inputValue: '2',
                                            width: 170
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'purpose_of_intravenous_access',
                                            boxLabel: 'Chemotherapy',
                                            inputValue: '4',
                                            width: 150
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'purpose_of_intravenous_access',
                                            boxLabel: 'Maintain venous access',
                                            width: 165,
                                            inputValue: '5'
                                        },

                                    ]
                                },{
                                    border: false,
                                    header: false,
                                    layout: {type: "table", columns: 5},
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'purpose_of_intravenous_access',
                                            boxLabel: 'Hydration',
                                            margin: '0 0 0 10',
                                            inputValue: '6',
                                            width: 165
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'purpose_of_intravenous_access',
                                            boxLabel: 'Parenteral nutrition',
                                            inputValue: '7',
                                            width: 170
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'purpose_of_intravenous_access',
                                            boxLabel: 'Lab draws',
                                            inputValue: '3',
                                            width: 150
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'purpose_of_intravenous_access',
                                            boxLabel: 'Other',
                                            inputValue: '8',
                                            margin: "0 5 0 0"
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'purpose_of_intravenous_access_other',
                                            inputValue: 'Other',
                                            labelWidth: 60
                                        },
                                    ]


                                },{
                                    xtype: 'panel',
                                    border: 0,
                                    layout: 'hbox',
                                    items:[
                                        {
                                            xtype: 'fieldcontainer',
                                            margin: '3px',
                                            layout: {
                                                type: 'vbox',
                                            },
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'infusion',
                                                    boxLabel: 'Infusion care provided during visit',
                                                    inputValue: '11',

                                                },
                                                {
                                                    xtype: 'textareafield',
                                                    margin: '0 0 0 20',
                                                    name: "infusion_care_provided_during_visit",
                                                    cols: 37
                                                },
                                            ]
                                        },

                                        {
                                            xtype: 'textareafield',
                                            margin: '10 0 0 40',
                                            name: "interventions",
                                            isHeader: false,
                                            fieldLabel: 'Interventions / Instructions /Comments ',
                                            labelAlign: 'top',
                                            cols: 47
                                        }

                                    ]

                                }


                            ]

                        }
                    ]
                },
                {
                    border: false,
                    header: false,
                    xtype: 'panel',
                    items: [
                        {
                            border: false,
                            header: false,
                            xtype: 'panel',
                            items: [
                                {
                                    xtype: 'panel',
                                    border: 0,
                                    layout: 'hbox',
                                    items:[
                                        {
                                            xtype: 'panel',
                                            border: 0,
                                            layout: 'vbox',
                                            items:[
                                                {
                                                    xtype: 'fieldset',
                                                    margin: '3px',
                                                    layout: {
                                                        type: 'vbox',
                                                    },
                                                    width: 500,
                                                    height: 130,
                                                    title: 'PICC Specific',
                                                    items:[
                                                        {
                                                            xtype: 'textfield',
                                                            isHeader: false,
                                                            fieldLabel: 'Circumference of arm',
                                                            labelWidth: 133,
                                                            name: 'circumference_of_arm',
                                                            width: 263,
                                                        },
                                                        {
                                                            xtype: 'radiogroup',
                                                            layout: {
                                                                align: 'stretch',
                                                                type: 'hbox'
                                                            },
                                                            labelWidth: 130,
                                                            fieldLabel: 'X-ray verification',
                                                            items: [
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'financial_ability',
                                                                    boxLabel: 'Yes',
                                                                    inputValue: 'Y',
                                                                    width: 60,
                                                                },
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'financial_ability',
                                                                    boxLabel: 'No ',
                                                                    inputValue: 'N ',
                                                                    width: 50,
                                                                }
                                                            ]
                                                        },

                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldset',
                                                    margin: '3px',
                                                    flex:1,
                                                    layout: {
                                                        type: 'vbox',
                                                    },
                                                    width: 500,
                                                    height: 130,
                                                    title: 'IVAD Port Specific',
                                                    items:[
                                                        {
                                                            xtype: 'radiogroup',
                                                            layout: {
                                                                align: 'stretch',
                                                                type: 'hbox'
                                                            },
                                                            labelWidth: 130,
                                                            fieldLabel: 'Reservoir',
                                                            xlabelAlign: 'top',
                                                            items: [
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'reservoir',
                                                                    boxLabel: 'Single',
                                                                    inputValue: 'S',
                                                                    width: 60,
                                                                },
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'reservoir',
                                                                    boxLabel: 'Double ',
                                                                    inputValue: 'D ',
                                                                    width: 70,
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: 'Huber gauge/length',
                                                            isHeader: false,
                                                            labelWidth: 133,
                                                            name: 'huber_gauge_length',
                                                            width: 263,
                                                        },
                                                        {
                                                            xtype: 'radiogroup',
                                                            layout: {
                                                                align: 'stretch',
                                                                type: 'hbox'
                                                            },
                                                            labelWidth: 130,
                                                            fieldLabel: 'Accessed',
                                                            items: [
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'accessed',
                                                                    boxLabel: 'No',
                                                                    inputValue: 'N',
                                                                    width: 60,
                                                                },
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'accessed',
                                                                    boxLabel: 'Yes,',
                                                                    inputValue: 'Y,',
                                                                    width: 60,
                                                                },
                                                                {
                                                                    xtype: 'datefield',
                                                                    name: 'accessed_date',
                                                                    isHeader: false,
                                                                    fieldLabel: 'date ',
                                                                    labelWidth: 35,
                                                                    align: "right",
                                                                    width: 160
                                                                }
                                                            ]
                                                        },
                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldset',
                                                    margin: '3px',
                                                    layout: {
                                                        type: 'vbox',
                                                    },
                                                    width: 500,
                                                    title: 'Epidural/Intrathecal access',
                                                    items:[
                                                        {
                                                            xtype: 'fieldcontainer',
                                                            layout: 'vbox',
                                                            items:[
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'epidural_site_skin_condition',
                                                                    isHeader: false,
                                                                    fieldLabel: 'Site/skin condition',
                                                                    labelWidth: 250,
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'infusion_solution',
                                                                    isHeader: false,
                                                                    fieldLabel: 'Infusion solution (type/volume/rate)',
                                                                    labelWidth: 250,
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'dressing',
                                                                    isHeader: false,
                                                                    fieldLabel: 'Dressing',
                                                                    labelWidth: 250,
                                                                },
                                                                {
                                                                    xtype: 'textareafield',
                                                                    name: 'other_epidural_intrathecal_access',
                                                                    isHeader: false,
                                                                    fieldLabel: 'Other',
                                                                    labelWidth: 133,
                                                                    height: 50,
                                                                    cols: 36
                                                                }

                                                            ]

                                                        },

                                                    ]
                                                },

                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: 0,
                                            layout: 'vbox',
                                            margin: '5px',
                                            items:[
                                                {
                                                    xtype: 'fieldcontainer',
                                                    margin: '3 3 3 30',
                                                    layout: {
                                                        type: 'vbox',
                                                    },
                                                    items: [
                                                        {
                                                            xtype: 'checkboxfield',
                                                            margin: '3px',
                                                            boxLabel: 'Medication(s) administered:',
                                                            inputValue: '8',
                                                            name: 'infusion'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: '(name of drug)',
                                                            isHeader: false,
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'name_of_drug'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: 'Dose',
                                                            isHeader: false,
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'dose'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: 'Route',
                                                            isHeader: false,
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'route'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: 'Frequency',
                                                            isHeader: false,
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'frequency'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            isHeader: false,
                                                            fieldLabel: 'Duration of therapy',
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'therapy_duration'
                                                        },

                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldcontainer',
                                                    margin: '3 3 3 30',
                                                    layout: {
                                                        type: 'vbox',
                                                    },
                                                    items: [
                                                        {
                                                            xtype: 'checkboxfield',
                                                            margin: '3px',
                                                            boxLabel: 'Medication(s) administered:',
                                                            inputValue: '9',
                                                            name: 'infusion'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: '(name of drug)',
                                                            isHeader: false,
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'name_of_drug1'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            isHeader: false,
                                                            fieldLabel: 'Dose',
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'dose1'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: 'Route',
                                                            isHeader: false,
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'route1'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: 'Frequency',
                                                            isHeader: false,
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'frequency1'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: 'Duration of therapy',
                                                            isHeader: false,
                                                            margin: '3 0 0 30',
                                                            labelWidth: 150,
                                                            name: 'therapy_duration1'
                                                        },

                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldcontainer',
                                                    margin: '3px',
                                                    layout: {
                                                        type: 'hbox',
                                                    },
                                                    items: [
                                                        {
                                                            xtype: 'checkboxfield',
                                                            margin: '3 3 3 30',
                                                            boxLabel: 'Pump:',
                                                            inputValue: '10',
                                                            name: 'infusion'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel: '(type, specify)',
                                                            isHeader: false,
                                                            margin: '3 0 0 27',
                                                            labelWidth: 90,
                                                            name: 'pump_type'
                                                        },
                                                    ]
                                                },
                                                {
                                                    xtype: 'radiogroup',
                                                    margin: '0 0 0 40',
                                                    layout: {
                                                        align: 'stretch',
                                                        type: 'hbox'
                                                    },
                                                    width: 440,
                                                    height: 50,
                                                    fieldLabel: 'Administered by',
                                                    labelAlign: 'top',
                                                    defaults: {
                                                        width: 50
                                                    },
                                                    items: [
                                                        {
                                                            xtype: 'radiofield',
                                                            name: 'administered_by',
                                                            margin: '0 0 0 5',
                                                            boxLabel: 'Self',
                                                            inputValue: 'SF',
                                                            width: 50,
                                                        },
                                                        {
                                                            xtype: 'radiofield',
                                                            name: 'administered_by',
                                                            boxLabel: 'RN ',
                                                            inputValue: 'RN',
                                                            width: 40
                                                        },
                                                        {
                                                            xtype: 'radiofield',
                                                            name: 'administered_by',
                                                            boxLabel: 'Caregiver',
                                                            inputValue: 'CG',
                                                            width: 80,
                                                        },
                                                        {
                                                            xtype: 'radiofield',
                                                            name: 'administered_by',
                                                            boxLabel: 'Other ',
                                                            inputValue: 'OTH',
                                                            width: 55
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'administered_by_other',
                                                            width: 105
                                                        },


                                                    ]
                                                },

                                            ]
                                        }

                                    ]

                                }
                            ]
                        }
                    ]
                },


            ]

        },

    ]
})
