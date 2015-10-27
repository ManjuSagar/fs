/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.IntegumentaryPocComponent', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.integumentaryPocComponent',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'panel',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            items: [
                {
                    xtype: 'panel',
                    border: 0,
                    padding: '3px',
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    items: [
                        {
                            xtype: 'fieldset',
                            flex: 0.65,
                            margin: '3px',
                            layout: {
                                type: 'vbox'
                            },
                            title: 'Integumentary',
                            itemId: 'integumentary_fieldset',
                            items: [
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            anchor: '100%',
                                            fieldLabel: '',
                                            name: 'integumentary',
                                            boxLabel: '<b>No Problem</b>',
                                            inputValue: 'NP'
                                        },
                                    ]
                                },
                                {
                                    xtype: 'label',
                                    text: "Check all applicable conditions below"

                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'integumentary',
                                    boxLabel: 'Turgor',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'radiogroup',
                                    width: 218,
                                    margin: '0 0 0 10',
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "turgor",
                                            boxLabel: 'Good',
                                            inputValue: 'G'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "turgor",
                                            boxLabel: 'Poor',
                                            inputValue: 'P'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'integumentary',
                                            boxLabel: 'Itch',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'integumentary',
                                            boxLabel: 'Rash',
                                            inputValue: '3'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'integumentary',
                                            boxLabel: 'Dry',
                                            inputValue: '4'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'integumentary',
                                            boxLabel: 'Scaling',
                                            inputValue: '5'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'integumentary',
                                            boxLabel: 'Redness',
                                            inputValue: '6'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'integumentary',
                                            boxLabel: 'Bruises',
                                            inputValue: '7'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'integumentary',
                                            boxLabel: 'Ecchymosis',
                                            inputValue: '8'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'integumentary',
                                            boxLabel: 'Pallor',
                                            inputValue: '9'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'integumentary',
                                            boxLabel: 'Jaundice',
                                            inputValue: '10'
                                        },
                                    ]
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'other_integumentary',
                                    fieldLabel: 'Other (specify)',
                                    labelWidth: 90,
                                }
                            ]
                        },{
                            xtype: 'fieldset',
                            flex: 0.9,
                            margin: '3px',
                            layout: {
                                type: 'vbox'
                            },
                            title: "WOUND CARE: (Check all that apply)",
                            items: [
                                {
                                    xtype: 'radiogroup',
                                    height: 28,
                                    width: 350,
                                    fieldLabel: 'Wound care done during this visit',
                                    labelWidth: 200,
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            floating: false,
                                            name: 'wound_care',
                                            boxLabel: 'Yes',
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'wound_care',
                                            boxLabel: 'No',
                                            inputValue: 'N'
                                        },
                                    ]
                                },
                                {
                                    xtype: "textfield",
                                    fieldLabel: "Location(s) wound site",
                                    labelWidth: 180,
                                    name: "wound_care_location",

                                },
                                {
                                    xtype: "label",
                                    text: "Soiled dressing removed by"
                                },
                                {
                                    border: false,
                                    header: false,
                                    layout: {
                                        type: 'table',
                                        columns: 2,
                                    },
                                    fieldLabel: 'Soiled dressing removed by',
                                    labelAlign: "top",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: 'soiled_dressing',
                                            boxLabel: 'Patient',
                                            inputValue: 'PA',
                                            width: 100,
                                        },{
                                            xtype: 'radiofield',
                                            name: 'soiled_dressing',
                                            boxLabel: 'RN',
                                            inputValue: 'RN'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'soiled_dressing',
                                            boxLabel: 'Caregiver(name)',
                                            inputValue: 'CG',
                                            width: 120,
                                            margin: "5 0 5 0"
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'soiled_dressing_cargiver',
                                            fieldLabel: '',
                                            width: 120,
                                            margin: "5 0 5 0"
                                        }
                                    ]
                                },{
                                    border: false,
                                    header: false,
                                    layout: {type: 'table', columns: 3},
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: 'soiled_dressing',
                                            boxLabel: 'PT',
                                            inputValue: 'PT',
                                            margin: "0 16 0 0"
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'soiled_dressing',
                                            boxLabel: 'Other',
                                            inputValue: 'OTH',
                                            margin: "0 16 0 0"
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'other_soiled_dressing',
                                            fieldLabel: '',
                                            width: 120,
                                        }
                                    ]


                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        type: 'table',
                                        tableAttrs: {
                                            border: 0,
                                        },
                                        columns: 2,
                                        width: 150,

                                    },
                                    margin: "10px 0 0 0",
                                    fieldLabel: 'Technique',
                                    labelWidth: 70,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_technique',
                                            boxLabel: 'Sterile',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_technique',
                                            boxLabel: 'Clean',
                                            inputValue: '2',
                                            margin: "2px"
                                        },

                                    ]
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        type: 'table',
                                        tableAttrs: {
                                            border: 0,
                                        },
                                        columns: 2,

                                    },
                                    margin: "10px 0 0 0",
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_cleaned',
                                            boxLabel: 'Wound cleaned with (specify)',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'wound_cleaned_with',
                                            fieldLabel: '',
                                            width: 120,
                                            margin: "0 0 0 5px"
                                        }

                                    ]
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        type: 'table',
                                        tableAttrs: {
                                            border: 0,
                                        },
                                        columns: 2,

                                    },
                                    margin: "10px 0 0 0",
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_irrigated',
                                            boxLabel: "Wound irrigated with (specify)",
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'wound_irrigated_with',
                                            fieldLabel: '',
                                            width: 120,
                                            margin: "0 0 0 5px"
                                        }

                                    ]
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        type: 'table',
                                        tableAttrs: {
                                            border: 0,
                                        },
                                        columns: 2,

                                    },
                                    margin: "10px 0 0 0",
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_packed',
                                            boxLabel: 'Wound packed with (specify)',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'wound_packed_with',
                                            fieldLabel: '',
                                            width: 120,
                                            margin: "0 0 0 5px"
                                        }

                                    ]
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        type: 'table',
                                        tableAttrs: {
                                            border: 0,
                                        },
                                        columns: 2,

                                    },
                                    margin: "10px 0 0 0",
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_dressing',
                                            boxLabel: "Wound dressing applied (specify)",
                                            inputValue: '1',
                                            labelWidth: 400,
                                            margin: "2px",

                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'wound_dressing_applied',
                                            fieldLabel: '',
                                            width: 100,
                                            margin: "0 0 0 5px"
                                        }

                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    height: 28,
                                    width: 350,
                                    fieldLabel: 'Patient tolerated procedure well',
                                    labelWidth: 200,
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            floating: false,
                                            name: 'patient_tolerate',
                                            boxLabel: 'Yes',
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'patient_tolerate',
                                            boxLabel: 'No',
                                            inputValue: 'N'
                                        },
                                    ]
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'wound_care_comments',
                                    fieldLabel: 'Comments'
                                }
                            ]
                        },{
                            xtype: 'fieldset',
                            flex: 1,
                            margin: '3px',
                            layout: {
                                type: 'vbox'
                            },
                            title: 'DIABETIC FOOT EXAM: (Check all that apply)',
                            items: [
                                {
                                    xtype: "textfield",
                                    fieldLabel: "Frequency of diabetic foot exam",
                                    labelWidth: 220,
                                    name: "foot_diabetic_exam",
                                },
                                {
                                    xtype: 'radiogroup',
                                    layout: {
                                        type: 'table',
                                        tableAttrs: {
                                            border: 0,
                                        },
                                        columns: 4,
                                    },
                                    fieldLabel: 'Done by',
                                    labelAlign: "top",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: 'done_by',
                                            boxLabel: 'Patient',
                                            inputValue: 'PA',
                                            width: 100,
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'done_by',
                                            boxLabel: 'RN ',
                                            inputValue: 'RN'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'done_by',
                                            boxLabel: 'Caregiver(name)',
                                            inputValue: 'CG',
                                            width: 120,
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'care_giver_name',
                                            fieldLabel: '',
                                            width: 120,
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'done_by',
                                            boxLabel: 'PT',
                                            inputValue: 'PT'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'done_by',
                                            boxLabel: 'Other',
                                            inputValue: 'OTH'
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'other_done_by',
                                            fieldLabel: '',
                                            width: 120,
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    width: 350,
                                    fieldLabel: 'Exam by clinician this visit',
                                    labelWidth: 200,
                                    margin: "10px 0 0 0",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: 'exam_by_clinician',
                                            boxLabel: 'Yes',
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'exam_by_clinician',
                                            boxLabel: 'No',
                                            inputValue: 'N'
                                        },
                                    ]
                                },
                                {
                                    xtype: "textfield",
                                    fieldLabel: "Integument findings",
                                    labelWidth: 220,
                                    name: "integument_findings",
                                    margin: "10px 0 0 0"
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox'
                                    },
                                    fieldLabel: 'Pedal pulses',
                                    labelWidth: 80,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'pedal_pulses',
                                            boxLabel: 'Present right/left',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'warm_pedal_pulses',
                                            boxLabel: 'Right',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'warm_pedal_pulses',
                                            boxLabel: 'Left',
                                            inputValue: '2',
                                            margin: "2px"
                                        }],

                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox'
                                    },
                                    fieldLabel: '',
                                    margin: '0, 0, 0, 85',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'pedal_pulses',
                                            boxLabel: 'Absent right/left',
                                            inputValue: '2',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'absent',
                                            boxLabel: 'Right',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'absent',
                                            boxLabel: 'Left',
                                            inputValue: '2',
                                            margin: "2px"
                                        },

                                    ]
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'diabetic_comments',
                                    fieldLabel: 'Comment'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox'
                                    },
                                    fieldLabel: 'Loss of sense of',
                                    labelWidth: 100,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'loss_of_sense',
                                            boxLabel: 'Warm right/left',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'loss_of_sense_warm',
                                            boxLabel: 'Right',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'loss_of_sense_warm',
                                            boxLabel: 'Left',
                                            inputValue: '2',
                                            margin: "2px"
                                        }]},
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox'
                                    },
                                    fieldLabel: '',
                                    margin: "0 0 0 105",
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'loss_of_sense',
                                            boxLabel: 'Cold right/left',
                                            inputValue: '2',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'loss_of_sense_cold',
                                            boxLabel: 'Right',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'loss_of_sense_cold',
                                            boxLabel: 'Left',
                                            inputValue: '2',
                                            margin: "2px"
                                        }
                                    ]
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'loss_of_sense_comments',
                                    fieldLabel: 'Comment'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox',
                                    },
                                    fieldLabel: 'Neuropathy',
                                    labelWidth: 80,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'neuropathy',
                                            boxLabel: 'Tingling right/left',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'tingling',
                                            boxLabel: 'Right',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'tingling',
                                            boxLabel: 'Left',
                                            inputValue: '2',
                                            margin: "2px"
                                        }]}, {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox',
                                    },
                                    fieldLabel: '',
                                    margin: "0 0 0 85",
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'neuropathy',
                                            boxLabel: 'Burning right/left',
                                            inputValue: '2',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'burning',
                                            boxLabel: 'Right',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'burning',
                                            boxLabel: 'Left',
                                            inputValue: '2',
                                            margin: "2px"
                                        },
                                    ]
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox'
                                    },
                                    fieldLabel: 'Leg hair',
                                    labelWidth: 80,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'leg_hair',
                                            boxLabel: 'Present right/left',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'present',
                                            boxLabel: 'Right',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'present',
                                            boxLabel: 'Left',
                                            inputValue: '2',
                                            margin: "2px"
                                        }]},
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'hbox'
                                    },
                                    fieldLabel: '',
                                    margin: "0 0 0 85",
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'leg_hair',
                                            boxLabel: 'Absent right/left',
                                            inputValue: '2',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'absent',
                                            boxLabel: 'Right',
                                            inputValue: '1',
                                            margin: "2px"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'absent',
                                            boxLabel: 'Left',
                                            inputValue: '2',
                                            margin: "2px"
                                        }
                                    ]
                                },
                                {
                                    xtype: 'label',
                                    text: "Complete LEAP Diabetic Foot Screening per organizational guideline"
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    padding: '3px',
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    items: [
                        {
                            xtype: 'fieldset',
                            flex: 0.7,
                            margin: '3px',
                            layout: {
                                type: 'vbox'
                            },
                            title: 'WOUND CARE:',
                            items: [
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },
                                    fieldLabel: '',
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: "2X2's",
                                            inputValue: "1"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: "4X4's",
                                            inputValue: "2"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: "ABD's",
                                            inputValue: "3"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Cotton tipped applicators',
                                            inputValue: '4'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Wound cleanser',
                                            inputValue: '5'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Wound gel',
                                            inputValue: '6'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Drain sponges',
                                            inputValue: '7'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Gloves',
                                            inputValue: '8'
                                        },
                                        {
                                            xtype: 'radiogroup',
                                            width: 250,
                                            height: 20,
                                            margin: '0 0 5px 10px',
                                            fieldLabel: '',
                                            items: [
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'wound_care_dme',
                                                    boxLabel: 'Sterile',
                                                    inputValue: '9'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'wound_care_dme',
                                                    boxLabel: 'Non-Sterile',
                                                    inputValue: '10'
                                                },
                                            ]
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Hydrocolloids',
                                            inputValue: '11'
                                        },
                                        {
                                            xtype: 'numberfield',
                                            name: 'kerlix_size',
                                            fieldLabel: 'Kerlix Size',
                                            labelWidth: 75,
                                            maxWidth: 250
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Nu-gauze',
                                            inputValue: '12'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Saline',
                                            inputValue: '13'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Tape',
                                            inputValue: '14'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Transparent Dressing',
                                            inputValue: '15',
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'wound_care_dme',
                                            boxLabel: 'Other',
                                            inputValue: '16'
                                        },
                                    ]
                                },
                                {
                                    xtype: 'textareafield',
                                    name: 'other_wound_care_dme',
                                    fieldLabel: '',
                                    cols: 15,
                                    width: 350,
                                },
                            ]
                        },
                        {
                            xtype: 'fieldset',
                            flex: 0.7,
                            margin: '3px',
                            layout: {
                                type: 'vbox'
                            },
                            title: 'ENDOCRINE/HEMATOLOGY',
                            itemId: 'endocrine_fieldset',
                            items: [
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'endocrine',
                                            boxLabel: "<b>No Problem</b>",
                                            inputValue: 'NP',
                                            align: 'center'
                                        }
                                    ]
                                },
                                {
                                    header: false,
                                    border: false,
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'label',
                                            text: "(Check all applicable items)"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'endocrine',
                                            boxLabel: "Diabetes:",
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'panel',
                                            layout: 'hbox',
                                            border: 0,
                                            items:[
                                                {
                                                    xtype: 'radiofield',
                                                    margin: '0 0 0 5',
                                                    name: 'diabetes',
                                                    boxLabel: "Type I Juvenile",
                                                    inputValue: '1'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'diabetes',
                                                    boxLabel: "Type II",
                                                    inputValue: '2'
                                                },

                                            ]

                                        },

                                        {
                                            xtype: 'datefield',
                                            name: 'diabetes_date',
                                            fieldLabel: "Date of onset"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'endocrine',
                                            boxLabel: "Diet/Oral Control",
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'other_diet_control',
                                            fieldLabel: 'specify',
                                            margin: '0 0 0 5',
                                            labelAlign: 'top'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'endocrine',
                                            boxLabel: "Insulin dose/ frequency (specify)",
                                            inputValue: '4'
                                        },
                                        {
                                            xtype: 'textareafield',
                                            name: 'insulin_dose_frequency',
                                            fieldLabel: ""
                                        },
                                        {
                                            xtype: 'datefield',
                                            name: 'insulin_since',
                                            fieldLabel: 'On insulin since',
                                        },
                                        {
                                            xtype: 'label',
                                            text: "Administered by:",

                                        },
                                        {
                                            xtype: 'radiogroup',
                                            width: 250,
                                            margin: '0 0 5px 10px',
                                            fieldLabel: '',
                                            columns: 3,
                                            items: [
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'endocrine_administered_by',
                                                    boxLabel: 'Self',
                                                    inputValue: 'SF'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'endocrine_administered_by',
                                                    boxLabel: 'Caregiver',
                                                    inputValue: 'CG'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'endocrine_administered_by',
                                                    boxLabel: 'Nurse',
                                                    inputValue: 'NR'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'endocrine_administered_by',
                                                    boxLabel: 'Other',
                                                    inputValue: 'OTH'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'endocrine_administered_by_other',
                                                    boxLabel: '',
                                                },
                                            ]
                                        },
                                        {
                                            xtype: 'fieldcontainer',
                                            layout: 'vbox',
                                            items:[
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'endocrine',
                                                    boxLabel: 'Hyperglycemia',
                                                    inputValue: '5'
                                                },
                                                {
                                                    border: false,
                                                    header: false,
                                                    layout: {type: 'table', columns: 3},
                                                    items:[
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'hyperglycemia',
                                                            boxLabel: 'Glycosuria',
                                                            inputValue: '1',
                                                            width: 120
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'hyperglycemia',
                                                            boxLabel: 'Polyuria',
                                                            inputValue: '2',
                                                            width: 120
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'hyperglycemia',
                                                            boxLabel: 'Polydipsia',
                                                            inputValue: '3',
                                                            width: 120
                                                        }
                                                    ]
                                                }

                                            ]
                                        },{
                                            xtype: 'fieldcontainer',
                                            layout: 'vbox',
                                            items:[
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'endocrine',
                                                    boxLabel: 'Hypoglycemia',
                                                    inputValue: '3'
                                                },
                                                {
                                                    border: false,
                                                    header: false,
                                                    layout: {type: 'table', columns: 3},
                                                    items:[
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'hypoglycemia',
                                                            boxLabel: 'Sweats',
                                                            inputValue: '1',
                                                            width: 120
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'hypoglycemia',
                                                            boxLabel: 'Polyphagia',
                                                            inputValue: '2',
                                                            width: 120
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'hypoglycemia',
                                                            boxLabel: 'Weak',
                                                            inputValue: '3',
                                                            width: 120
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'hypoglycemia',
                                                            boxLabel: 'Faint',
                                                            inputValue: '4',

                                                            width: 120
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'hypoglycemia',
                                                            boxLabel: 'Stupor',
                                                            inputValue: '5',
                                                            width: 120
                                                        },
                                                    ]
                                                }

                                            ]
                                        },
                                        {
                                            border: false,
                                            header: false,
                                            layout: {type: 'table', columns: 2},
                                            items: [
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: "A1c",
                                                    name: 'a1c',
                                                    margin: "0 5 0 0",
                                                    labelWidth: 40
                                                },
                                                {
                                                    xtype: "label",
                                                    text: "%"
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'checkboxgroup',
                                            width: 250,
                                            margin: '0 0 0 10px',
                                            fieldLabel: '',
                                            columns: 2,
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'a1c_found',
                                                    boxLabel: "Today's Visit",
                                                    inputValue: '1'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'a1c_found',
                                                    boxLabel: 'Patient Reported',
                                                    inputValue: '2'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'a1c_found',
                                                    boxLabel: 'Lab slip',
                                                    inputValue: '3'
                                                },
                                            ]
                                        },
                                        {
                                            header: false,
                                            border: false,
                                            layout: "hbox",
                                            width: 320,
                                            items: [
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: "BS",
                                                    name: 'bs_weight',
                                                    labelWidth: 20,
                                                    value: "mg/dL",
                                                    fieldStyle: "text-align: right",
                                                    flex: 1
                                                },{
                                                    xtype: 'datefield',
                                                    fieldLabel: 'Date',
                                                    name: 'bs_date',
                                                    labelWidth: 40,
                                                    flex: 1
                                                },{
                                                    xtype: 'timefield',
                                                    fieldLabel: "Time",
                                                    name: 'bs_time',
                                                    labelWidth: 40,
                                                    flex: 1
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'checkboxgroup',
                                            width: 250,
                                            margin: '0 0 5px 10px',
                                            fieldLabel: '',
                                            columns: 2,
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'bs',
                                                    boxLabel: "FBS",
                                                    inputValue: '1'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'bs',
                                                    boxLabel: 'Before Meal',
                                                    inputValue: '2'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'bs',
                                                    boxLabel: 'Postprandial',
                                                    inputValue: '3'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'bs',
                                                    boxLabel: 'Random HS',
                                                    inputValue: '4'
                                                },

                                            ]
                                        },
                                        {
                                            xtype: 'checkboxgroup',
                                            width: 250,
                                            fieldLabel: '',
                                            layout: 'hbox',
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'endocrine',
                                                    boxLabel: "Blood sugar ranges",
                                                    inputValue: "6"
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'blood_sugar_ranges'
                                                },

                                            ]
                                        },
                                        {
                                            xtype: 'radiogroup',
                                            width: 280,
                                            height:40,
                                            margin: '0 0 5px 5px',
                                            labelAlign: 'top',
                                            columns: 2,
                                            items:[
                                                {
                                                    xtype: 'radiofield',
                                                    margin: '0 0 0 5px',
                                                    name: 'blood_sugar_report',
                                                    boxLabel: 'Patient Report',
                                                    inputValue: '1'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    margin: '0 0 0 5px',
                                                    name: 'blood_sugar_report',
                                                    boxLabel: 'Caregiver Report',
                                                    inputValue: '2'
                                                },
                                            ]
                                        },

                                        {
                                            xtype: 'radiogroup',
                                            width: 280,
                                            height:80,
                                            margin: '0 0 5px 5px',
                                            fieldLabel: 'Monitored By',
                                            labelAlign: 'top',
                                            columns: 3,
                                            items: [
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'monitored_by',
                                                    boxLabel: 'Self',
                                                    inputValue: 'SF'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'monitored_by',
                                                    boxLabel: 'Caregiver',
                                                    inputValue: 'CG'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'monitored_by',
                                                    boxLabel: 'Nurse',
                                                    inputValue: 'NR'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'monitored_by',
                                                    boxLabel: 'Other',
                                                    inputValue: 'OTH'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'other_monitored_by',
                                                    boxLabel: '',
                                                    inputValue: 'other'
                                                },
                                            ]
                                        },
                                        {
                                            xtype: 'textfield',
                                            margin: '0 0 0 5',
                                            name: 'frequency_of_monitoring',
                                            fieldLabel: 'Frequency of Monitoring',
                                            labelAlign:'top'
                                        },
                                        {
                                            xtype: 'textfield',
                                            margin: '0 0 0 5',
                                            name: 'competency',
                                            fieldLabel: 'Competency with use of Glucometer',
                                            labelAlign:'top'

                                        },

                                        {
                                            xtype: 'checkboxfield',
                                            boxLabel: "Disease Management Problems (explain)",
                                            name: 'endocrine',
                                            inputValue: '9'
                                        },
                                        {
                                            xtype: 'textareafield',
                                            BoxLabel: "",
                                            name: 'disease_mgmt_text',
                                            inputValue: 'disease_mgmt'
                                        },
                                        {
                                            border: false,
                                            header: false,
                                            layout: {type: 'table', columns: 2},
                                            margin: '0 0 5px 10px',
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'endocrine',
                                                    boxLabel: "Enlarged Thyroid",
                                                    inputValue: '10',
                                                    margin: "0 5 0 0",
                                                    width: 160
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'disease_effect',
                                                    boxLabel: 'Fatigue',
                                                    inputValue: '1'
                                                }
                                            ]
                                        },{
                                            border: false,
                                            header: false,
                                            layout: {type: 'table', columns: 3},
                                            margin: '0 0 5px 10px',
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'disease_effect',
                                                    boxLabel: 'Intolerance to heat/cold',
                                                    inputValue: '2',
                                                    margin: "0 5 0 0"
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'disease_effect',
                                                    boxLabel: 'Other',
                                                    inputValue: '3',
                                                    margin: "0 5 0 0"
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'other_disease_effect',
                                                    fieldLabel: '',
                                                    cols: 20
                                                },
                                            ]

                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'endocrine',
                                            boxLabel: 'Anemia (specify if known)',
                                            inputValue: '11'
                                        },
                                        {
                                            xtype: 'textfield',
                                            name: 'other_anaemia',
                                            fieldLabel: '',
                                            inputValue: 'anaemia'
                                        },
                                        {
                                            xtype: 'panel',
                                            margin: '0 0 5px 0',
                                            border: 0,
                                            layout: 'vbox',
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'endocrine',
                                                    boxLabel: "Secondary bleed:",
                                                    inputValue: '12'
                                                },
                                                {
                                                    xtype: 'checkboxgroup',
                                                    layout: 'hbox',
                                                    width: 350,
                                                    items:[
                                                        {
                                                            xtype: 'checkboxfield',
                                                            margin: '0 0 0 10',
                                                            name: 'secondary',
                                                            boxLabel: "GI",
                                                            inputValue: '1'
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'secondary',
                                                            boxLabel: "GU",
                                                            inputValue: '2'
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'secondary',
                                                            boxLabel: "GYN",
                                                            inputValue: '3'
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'secondary',
                                                            boxLabel: "Unknown",
                                                            inputValue: '4',
                                                            width: 90
                                                        },
                                                        {
                                                            xtype: 'checkboxfield',
                                                            name: 'secondary',
                                                            boxLabel: 'Hemophilia',
                                                            inputValue: '5'
                                                        },

                                                    ]
                                                }

                                            ]
                                        },
                                        {
                                            header: false,
                                            border: false,
                                            layout: 'hbox',
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'secondary',
                                                    margin: '0 0 0 10',
                                                    boxLabel: "Other",
                                                    inputValue: '6'
                                                },{
                                                    xtype: 'textfield',
                                                    name: 'secondary_other',
                                                    margin: "0 0 5px 0"
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            xtype: 'fieldset',
                            flex: 0.4,
                            margin: '3px',
                            title: "DIABETIC",
                            items: [
                                {
                                    xtype: 'checkboxgroup',
                                    layout: {
                                        type: 'vbox'
                                    },
                                    width: 250,
                                    margin: '0 0 5px 10px',
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'diabetic_supplies',
                                            boxLabel: "Chemstrips",
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'diabetic_supplies',
                                            boxLabel: 'Syringes',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'diabetic_supplies',
                                            boxLabel: 'Other',
                                            inputValue: '3'
                                        },
                                        {
                                            xtype: 'textareafield',
                                            name: 'other_diabetic_supplies',
                                            fieldLabel: '',
                                            inputValue: 'other'
                                        },
                                    ]
                                }
                            ]
                        }
                    ]

                }
            ]
        }

    ],
    afterRender: function(){
        this.callParent();
        var noProblems = this.query("[boxLabel=<b>No Problem</b>]");
        Ext.each(noProblems, function(noProblem){
            noProblem.on("change", function(ele){
                var fieldSetId = "#" + noProblem.name + "_fieldset";
                var fieldSet = ele.up(fieldSetId);
                var fields = fieldSet.query("textfield, textarea, datefield, numberfield, radiogroup, checkboxfield, radiofield");
                Ext.each(fields, function(e){
                    if(noProblem != e && noProblem.checked == true){
                        if(e.xtype == "radiofield" || e.xtype == "checkboxfield"){
                            e.disable().setValue(false);
                        } else {
                            e.disable().setValue();
                        }
                    } else {
                        e.enable();
                    }
                }, this);
            }, this);
        }, this);
    }

})
