/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.PatientWoundType', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.patientWoundType',
    items: [
        {
            xtype: 'panel',
            height: 615,
            itemId: "wound_description_",
            margin: '3px',
            border: 0,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            title: "Wound Description ",
            items: [
                {
                    xtype: 'panel',
                    border: 0,
                    margin: '0 3 3 0',
                    layout: {
                        align: 'middle',
                        type: 'hbox'
                    },
                    items: [
                        {
                            xtype: 'textfield',
                            name: "wound_type_",
                            margin: '5px',
                            fieldLabel: 'Wound Type:',
                            labelAlign: 'right'
                        },
                        {
                            xtype: 'numberfield',
                            name: "wound_age_",
                            fieldLabel: 'Age in Months:',
                            labelAlign: 'right',
                            maxValue: 1200,
                            minValue: 1
                        },
                        {
                            xtype: 'textfield',
                            name: "wound_location_",
                            fieldLabel: 'Wound Location:',
                            labelAlign: 'right'
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    flex: 3,
                    border: 0,
                    height: 236,
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    items: [
                        {
                            xtype: 'fieldset',
                            flex: 1,
                            margin: 3,
                            items: [
                                {
                                    xtype: 'radiogroup',
                                    fieldLabel: 'Is there eschar tissue present in the wound?',
                                    labelAlign: 'top',
                                    labelSeparator: ' ',
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            margin: '0 20px',
                                            name: "wound_tissue_present_",
                                            boxLabel: 'Yes',
                                            inputValue: 'yes'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "wound_tissue_present_",
                                            boxLabel: 'No',
                                            inputValue: 'no'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    fieldLabel: 'Has debridement been attempted in the last 10 days?',
                                    labelAlign: 'top',
                                    labelSeparator: ' ',
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            margin: '0 20px',
                                            name: "wound_debridement_attempted_",
                                            boxLabel: 'Yes',
                                            inputValue: 'yes'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "wound_debridement_attempted_",
                                            boxLabel: 'No',
                                            inputValue: 'no'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'datefield',
                                    width: 180,
                                    name: "wound_debridement_date_",
                                    fieldLabel: 'If Yes, debridement date',
                                    labelAlign: 'top'
                                },
                                {
                                    xtype: 'textfield',
                                    width: 161,
                                    name: "wound_debridement_type_",
                                    fieldLabel: 'Debridement Type',
                                    labelAlign: 'top'
                                },
                                {
                                    xtype: 'radiogroup',
                                    height: 43,
                                    fieldLabel: 'Are serial debridements required?',
                                    labelAlign: 'top',
                                    labelSeparator: ' ',
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            margin: '0 20px',
                                            name: "wound_debridement_required_",
                                            boxLabel: 'Yes',
                                            inputValue: 'yes'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "wound_debridement_required_",
                                            boxLabel: 'No',
                                            inputValue: 'no'
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            xtype: 'fieldset',
                            flex: 1,
                            margin: 3,
                            items: [
                                {
                                    xtype: 'datefield',
                                    name: "wound_measurement_date_",
                                    fieldLabel: 'Measurement date:',
                                    labelAlign: 'top'
                                },
                                {
                                    xtype: 'textfield',
                                    name: "wound_length_",
                                    fieldLabel: 'Length (cm)',
                                    labelAlign: 'top'
                                },
                                {
                                    xtype: 'textfield',
                                    name: "wound_width_",
                                    fieldLabel: 'Width (cm)',
                                    labelAlign: 'top'
                                },
                                {
                                    xtype: 'textfield',
                                    name: "wound_depth_",
                                    fieldLabel: 'Depth',
                                    labelAlign: 'top'
                                },
                                {
                                    xtype: 'textfield',
                                    name: "wound_appearance_of_wound_",
                                    fieldLabel: 'Appearance of wound bed and color:',
                                    labelAlign: 'top'
                                }
                            ]
                        },
                        {
                            xtype: 'fieldset',
                            flex: 1,
                            margin: 3,
                            title: '',
                            items: [
                                {
                                    xtype: 'textfield',
                                    name: "wound_exudate_",
                                    fieldLabel: 'Exudate (amount and color):',
                                    labelAlign: 'top'
                                },
                                {
                                    xtype: 'radiogroup',
                                    fieldLabel: 'Is the wound full thickness?',
                                    labelAlign: 'top',
                                    labelSeparator: ' ',
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            margin: '0 20px',
                                            name: "wound_thickness_",
                                            boxLabel: 'Yes',
                                            inputValue: 'yes'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "wound_thickness_",
                                            boxLabel: 'No',
                                            inputValue: 'no'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    fieldLabel: 'Is muscle, tendon or bone exposed?',
                                    labelAlign: 'top',
                                    labelSeparator: ' ',
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            margin: '0 20px',
                                            name: "wound_muscle_",
                                            boxLabel: 'Yes',
                                            inputValue: 'yes'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "wound_muscle_",
                                            boxLabel: 'No',
                                            inputValue: 'no'
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: 'fieldset',
                    flex: 1.3,
                    height: 121,
                    margin: 3,
                    layout: {
                        type: 'vbox'
                    },
                    items: [
                        {
                            xtype: 'radiogroup',
                            flex: 1,
                            width: 400,
                            fieldLabel: 'Is there undermining?',
                            labelAlign: 'top',
                            labelSeparator: ' ',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    margin: '0 20px',
                                    name: "wound_underminig_",
                                    boxLabel: 'Yes',
                                    inputValue: 'yes'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "wound_underminig_",
                                    boxLabel: 'No',
                                    inputValue: 'no'
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            flex: 0.8,
                            border: 0,
                            layout: {
                                align: 'middle',
                                type: 'hbox'
                            },
                            items: [
                                {
                                    xtype: 'textfield',
                                    name: "wound_undermining_location1_",
                                    fieldLabel: 'Location #1 (cm)',
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    name: "wound_undermining_from1_",
                                    fieldLabel: 'From',
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    name: "wound_undermining_to1_",
                                    fieldLabel: 'To',
                                    labelAlign: 'right'
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            flex: 0.8,
                            border: 0,
                            layout: {
                                align: 'middle',
                                type: 'hbox'
                            },
                            items: [
                                {
                                    xtype: 'textfield',
                                    name: "wound_undermining_location2_",
                                    fieldLabel: 'Location #2 (cm)',
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    name: "wound_undermining_from2_",
                                    fieldLabel: 'From',
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    name: "wound_undermining_to2_",
                                    fieldLabel: 'To',
                                    labelAlign: 'right'
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: 'fieldset',
                    flex: 1.3,
                    height: 125,
                    margin: 3,
                    layout: {
                        type: 'vbox'
                    },
                    items: [
                        {
                            xtype: 'radiogroup',
                            flex: 1,
                            width: 400,
                            fieldLabel: 'Is there tunneling/sinus?',
                            labelAlign: 'top',
                            labelSeparator: ' ',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    margin: '0 20px',
                                    name: "wound_tunneling_",
                                    boxLabel: 'Yes',
                                    inputValue: 'yes'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "wound_tunneling_",
                                    boxLabel: 'No',
                                    inputValue: 'no'
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            flex: 0.8,
                            border: 0,
                            layout: {
                                align: 'middle',
                                type: 'hbox'
                            },
                            items: [
                                {
                                    xtype: 'textfield',
                                    name: "wound_tunneling_location1_",
                                    fieldLabel: 'Location #1 (cm)',
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    name: "wound_tunneling_from1_",
                                    fieldLabel: 'From',
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    name: "wound_tunneling_to1_",
                                    fieldLabel: 'To',
                                    labelAlign: 'right'
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            flex: 0.8,
                            border: 0,
                            layout: {
                                align: 'middle',
                                type: 'hbox'
                            },
                            items: [
                                {
                                    xtype: 'textfield',
                                    name: "wound_tunneling_location2_",
                                    fieldLabel: 'Location #2 (cm)',
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    name: "wound_tunneling_from2_",
                                    fieldLabel: 'From',
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    name: "wound_tunneling_to2_",
                                    fieldLabel: 'To',
                                    labelAlign: 'right'
                                }
                            ]
                        }
                    ]
                }
            ],
            tools: [
                {
                    xtype: 'tool',
                    tooltip: 'close',
                    type: 'close'
                }
            ]
        }

    ]
})