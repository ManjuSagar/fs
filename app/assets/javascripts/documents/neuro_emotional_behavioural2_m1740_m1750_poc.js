/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.NeuroEmotionalBehaviouralM1740M1750Poc', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.neuroEmotionalBehaviouralM1740M1750Poc',
    items: [
        {
            xtype: 'fieldset',
            margin: 5,
            checkboxName: 'mental_status',
            title: 'Mental Status',
            items: [
                {
                    border: false,
                    header: false,
                    layout: {type: "table", columns: 9},
                    defaults: {margin: "5 5 5 0"},
                    items: [
                        {
                            xtype: 'checkboxfield',
                            name: 'mental_status',
                            boxLabel: '1 - Oriented',
                            inputValue: '1',
                            width: 125
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'mental_status',
                            boxLabel: '2 - Comatose',
                            inputValue: '2'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'mental_status',
                            boxLabel: '3 - Forgetful',
                            inputValue: '3'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'mental_status',
                            boxLabel: '4 - Depressed',
                            inputValue: '4'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'mental_status',
                            boxLabel: '5 - Disoriented',
                            inputValue: '5'
                        },
                        {
                            xtype: 'checkboxfield',
                            margin: '0 5 0 5',
                            name: 'mental_status',
                            boxLabel: '6 - Lethargic',
                            inputValue: '6'
                        },
                        {
                            xtype: 'checkboxfield',
                            margin: '0 5 0 5',
                            fieldLabel: '',
                            name: 'mental_status',
                            boxLabel: '7 - Agitated',
                            inputValue: '7'
                        },
                        {
                            xtype: 'checkboxfield',
                            margin: '0 5 0 5',
                            fieldLabel: '',
                            name: 'mental_status',
                            boxLabel: '8 - Other',
                            inputValue: '8'
                        },
                        {
                            xtype: 'textfield',
                            fieldLabel: '',
                            name: 'other_mental_status',
                            width: 250
                        }
                    ]
                },
            ]
        },
        {
            xtype: 'fieldset',
            height: 580,
            margin: '5px',
            checkboxName: 'mental_status',
            title: 'Psychosocial',
            layout: {type: "hbox"},
            items: [
                {xtype: 'panel',
                    border: false,
                    header: false,
                    layout: {type: 'vbox'},
                    flex: 1,
                    items: [
                        {
                            xtype: 'textfield',
                            fieldLabel: 'Primary Language',
                            labelWidth: 120,
                            name: 'psychosocial_primary_language'
                        },
                        {
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 3},
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'psychosocial',
                                    boxLabel: 'Language barrier',
                                    inputValue: '1',
                                    width: 125,
                                    margin: "0 5 0 0"
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'psychosocial',
                                    boxLabel: 'Needs interpreter',
                                    inputValue: '2',
                                    margin: "0 5 0 0"
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: '',
                                    name: 'psychosocial_interpreter'
                                }
                            ]
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'psychosocial',
                            boxLabel: 'Learning barrier',
                            inputValue: '3'
                        },
                        {
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 4},
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'learning_barrier',
                                    boxLabel: 'Mental',
                                    inputValue: '1',
                                    margin: "0 5 0 10",
                                    width: 116,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'learning_barrier',
                                    boxLabel: 'Psychosocial',
                                    inputValue: '2',
                                    margin: "0 5 0 0"
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'learning_barrier',
                                    boxLabel: 'Physical',
                                    inputValue: '3',
                                    margin: "0 5 0 0"
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'learning_barrier',
                                    boxLabel: 'Functional',
                                    inputValue: '4',
                                    margin: "0 5 0 0"
                                }
                            ]
                        },
                        {
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 2},
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 0',
                                    name: 'psychosocial',
                                    boxLabel: 'Unable to read',
                                    inputValue: '4',
                                    width: 125
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'psychosocial',
                                    boxLabel: 'Unable to write',
                                    inputValue: '5'
                                },
                            ]
                        },
                        {
                            xtype: 'textfield',
                            fieldLabel: 'Educational level',
                            labelWidth: 105,
                            name: 'psychosocial_education_level'
                        },
                        {
                            xtype: 'checkboxfield',
                            margin: '0 5 0 0',
                            name: 'psychosocial',
                            boxLabel: 'Spiritual / Cultural implications that impact care.',
                            inputValue: '6'
                        },
                        {
                            xtype: 'textareafield',
                            height: 47,
                            width: 419,
                            fieldLabel: 'Explain',
                            labelWidth: 110,
                            name: 'spiritual_cultural_explain'
                        },
                        {
                            xtype: 'textareafield',
                            height: 47,
                            width: 419,
                            fieldLabel: 'Spiritual resource',
                            labelWidth: 110,
                            name: 'spiritual_resource'
                        },
                        {
                            xtype: 'textfield',
                            fieldLabel: 'Phone No.',
                            name: 'psychosocial_phone_number',
                            labelWidth: 110,
                        },
                        {
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 3},
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'psychosocial',
                                    boxLabel: 'Sleep/Rest',
                                    inputValue: '7',
                                    width: 125,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'sleep_rest',
                                    boxLabel: 'Adequate',
                                    inputValue: '1',
                                    margin: "0 23 0 0"
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'sleep_rest',
                                    boxLabel: 'Inadequate',
                                    inputValue: '2'
                                }
                            ]
                        },
                        {
                            xtype: 'textareafield',
                            height: 47,
                            width: 419,
                            fieldLabel: 'Explain',
                            labelAlign: 'right',
                            labelWidth: 110,
                            name: 'sleep_rest_explain'
                        },
                        {
                            xtype: 'panel',
                            border: false,
                            header: false,
                            layout: {
                                type: 'hbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'psychosocial',
                                    boxLabel: 'Inappropriate responses to caregivers/clinician',
                                    inputValue: '8'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 2 0 2',
                                    fieldLabel: '',
                                    name: 'inappropriate_responses',
                                    boxLabel: 'Caregivers',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'inappropriate_responses',
                                    boxLabel: 'Clinician',
                                    inputValue: '2'
                                }
                            ]
                        },
                        {
                            xtype: 'checkboxfield',
                            anchor: '100%',
                            fieldLabel: '',
                            name: 'psychosocial',
                            boxLabel: 'Inappropriate follow-through in past',
                            inputValue: '9'
                        },
                        {
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 3},
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'psychosocial',
                                    boxLabel: 'Angry',
                                    inputValue: '10',
                                    width: 125
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'psychosocial',
                                    boxLabel: 'Flat affect',
                                    inputValue: '11',
                                    margin: "0 23 0 0"
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'psychosocial',
                                    boxLabel: 'Discouraged',
                                    inputValue: '12',
                                    margin: "0 5 0 0"
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'psychosocial',
                                    boxLabel: 'Disorganized',
                                    inputValue: '15',
                                    width: 125
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'psychosocial',
                                    boxLabel: 'Withdrawn',
                                    inputValue: '13',
                                    margin: "0 5 0 0"
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'psychosocial',
                                    boxLabel: 'Difficulty coping',
                                    inputValue: '14'
                                }
                            ]
                        },
                    ]
                },{ xtype: "panel",
                    border: false,
                    header: false,
                    layout: {type: "vbox"},
                    flex: 0.8,
                    items: [
                        {
                            xtype: 'panel',
                            border: false,
                            header: false,
                            title: 'My Panel',
                            layout: {
                                type: 'hbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5px 0 0',
                                    fieldLabel: '',
                                    name: 'psychosocial',
                                    boxLabel: 'Depressed: Recent/Long term',
                                    inputValue: '16',
                                    margin: "0 15 0 0"
                                },
                                {
                                    xtype: 'radiogroup',
                                    width: 223,
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: 'depressed',
                                            boxLabel: 'Recent',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'depressed',
                                            boxLabel: 'Long term',
                                            inputValue: '2'
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            xtype: 'textfield',
                            width: 258,
                            fieldLabel: 'Treatment',
                            labelWidth: 65,
                            name: 'psychosocial_treatment'
                        },
                        {
                            xtype: 'checkboxfield',
                            fieldLabel: '',
                            name: 'psychosocial',
                            boxLabel: 'Inability to cope with altered health status as evidenced by:',
                            inputValue: '17'
                        },
                        {
                            xtype: 'panel',
                            border: false,
                            header: false,
                            title: 'My Panel',
                            layout: {
                                type: 'table',
                                columns: 2
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'inability_to_cope',
                                    boxLabel: 'Lack of motivation',
                                    inputValue: '1',
                                    margin: "0 5 0 10"
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'inability_to_cope',
                                    boxLabel: 'Unrealistic expectations',
                                    inputValue: '2'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'inability_to_cope',
                                    boxLabel: 'Inability to recognize problems',
                                    inputValue: '3',
                                    margin: "0 5 0 10"
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'inability_to_cope',
                                    boxLabel: 'Denial of problems',
                                    inputValue: '4'
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            border: false,
                            header: false,
                            title: 'My Panel',
                            layout: {
                                type: 'hbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'psychosocial',
                                    boxLabel: 'Evidence of abuse / neglect / exploitation:',
                                    inputValue: '18'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 5',
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Abuse',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 0',
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Neglect',
                                    inputValue: '2'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Exploitation',
                                    inputValue: '3'
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            border: false,
                            header: false,
                            title: 'My Panel',
                            layout: {
                                type: 'table',
                                columns: 4
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Potential',
                                    inputValue: '4',
                                    margin: "0 0 0 10",
                                    width: 110
                                },
                                {
                                    xtype: 'checkboxfield',
                                    width: 100,
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Actual',
                                    inputValue: '5'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 0',
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Verbal',
                                    inputValue: '6',
                                    width: 108
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Emotional',
                                    inputValue: '7',
                                    margin: '0 5 0 0'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 10',
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Physical',
                                    inputValue: '8'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 0',
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Financial',
                                    inputValue: '9'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 0',
                                    fieldLabel: '',
                                    name: 'evidence',
                                    boxLabel: 'Intervention',
                                    inputValue: '10'
                                }
                            ]
                        },
                        {
                            xtype: 'textareafield',
                            height: 49,
                            width: 419,
                            fieldLabel: 'Describe',
                            labelWidth: 70,
                            name: 'psychosocial_describe'
                        },
                        {
                            xtype: 'textareafield',
                            height: 49,
                            width: 419,
                            fieldLabel: 'Comments',
                            labelWidth: 70,
                            name: 'psychosocial_comments'
                        }
                    ]

                }
            ]
        }
    ]
})
