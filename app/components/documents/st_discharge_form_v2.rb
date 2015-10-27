# Custom user form (predefined model and layout)
class Documents::STDischargeFormV2 < Documents::AbstractDocumentForm

  def configuration
    c= super
    c.merge(
        model: "STDischarge",
        items:[
            {
                xtype: 'container',
                height: 768,
                width: 1024,
                layout: {
                    type: 'fit'
                },
                items: [
                    {
                        xtype: 'borderlessFormPanel',
                        style: 'color:green;',
                        layout: {
                            type: 'border'
                        },
                        bodyPadding: 10,
                        manageHeight: false,
                        title: '',
                        items: [
                            {
                                xtype: 'panel',
                                region: 'north',
                                border: 0,
                                layout: {
                                    type: 'fit'
                                },
                                items: [
                                    :patient_details.component
                                ]
                            },
                            {
                                xtype: 'tabpanel',
                                region: 'center',
                                margin: '5px',
                                activeTab: 0,
                                plain: true,
                                layout: {
                                    deferredRender: false,
                                    type: 'card'
                                },
                                items: [
                                    {
                                        xtype: 'panel',
                                        height: 711,
                                        width: 990,
                                        autoScroll: true,
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'PROBLEMS/CONDITION ON  ADMISSION ',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                itemId: 'problem_accordions',
                                                autoScroll: true,
                                                layout: {
                                                    fill: false,
                                                    type: 'accordion'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        itemId: 'treat_voice_disorder',
                                                        margin: '3px',
                                                        width: 760,
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapseFirst: false,
                                                        collapsed: false,
                                                        title: 'Treat Voice Disorder',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_voice_interventions',
                                                                fieldLabel: 'Interventions',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_voice_response',
                                                                fieldLabel: 'Patient\'s Response/Outcome',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        itemId: 'treat_speech_disorder',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Treat Speech Disorder ',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_speach_interventions',
                                                                fieldLabel: 'Interventions',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_speach_response',
                                                                fieldLabel: 'Patient\'s Response/Outcome',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        itemId: 'treat_dysphagia',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapseFirst: false,
                                                        collapsed: true,
                                                        title: 'Treat Dysphagia',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_dysphagia_interventions',
                                                                fieldLabel: 'Interventions',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_dysphagia_response',
                                                                fieldLabel: 'Patient\'s Response/Outcome',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        itemId: 'treat_language_disorder',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Treat Language Disorder',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_language_interventions',
                                                                fieldLabel: 'Interventions',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_language_response',
                                                                fieldLabel: 'Patient\'s Response/Outcome',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        itemId: 'aural_rehabilitation_training',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Aural Rehabilitation Training',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'aural_rehabilitation_interventions',
                                                                fieldLabel: 'Interventions',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'aural_rehabilitation_response',
                                                                fieldLabel: 'Patient\'s Response/Outcome',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        itemId: 'treat_visual_disorder',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        collapsible: false,
                                                        title: 'Treat Visual Disorder',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_visual_interventions',
                                                                fieldLabel: 'Interventions',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_visual_response',
                                                                fieldLabel: 'Patient\'s Response/Outcome',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        itemId: 'treat_cognitive_disorder',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Treat Cognitive Disorder',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_cognitive_interventions',
                                                                fieldLabel: 'Interventions',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_cognitive_response',
                                                                fieldLabel: 'Patient\'s Response/Outcome',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        itemId: 'other_problems_panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Other',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other_interventions',
                                                                fieldLabel: 'Interventions',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other_response',
                                                                fieldLabel: 'Patient\'s Response/Outcome',
                                                                labelAlign: 'right',
                                                                labelWidth: 200,
                                                                cols: 100
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        title: 'Pain/Home Bound Status',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                height: 223,
                                                itemId: 'pain_panel',
                                                margin: '7px',
                                                bodyPadding: 3,
                                                title: 'Pain',
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        border: false,                                                        
                                                        layout: {
                                                            columns: 5,
                                                            type: 'table'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Pain Location',
                                                                margin: '0 0 3px 5px'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Intensity(0-10)',
                                                                margin: '0 0 3px 3px'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Frequency',
                                                                margin: '0 0 3px 3px'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Description',
                                                                margin: '0 0 3px 3px'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Aggravating Factors',
                                                                margin: '0 0 3px 3px'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location1',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity1',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                editable: false,
                                                                store: [
                                                                    0,
                                                                    1,
                                                                    2,
                                                                    3,
                                                                    4,
                                                                    5,
                                                                    6,
                                                                    7,
                                                                    8,
                                                                    9,
                                                                    10
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'frequency1',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description1',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors1',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location2',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity2',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                editable: false,
                                                                store: [
                                                                    0,
                                                                    1,
                                                                    2,
                                                                    3,
                                                                    4,
                                                                    5,
                                                                    6,
                                                                    7,
                                                                    8,
                                                                    9,
                                                                    10
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'frequency2',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description2',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors2',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location3',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity3',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                editable: false,
                                                                store: [
                                                                    0,
                                                                    1,
                                                                    2,
                                                                    3,
                                                                    4,
                                                                    5,
                                                                    6,
                                                                    7,
                                                                    8,
                                                                    9,
                                                                    10
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'frequency3',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description3',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors3',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location4',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity4',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                editable: false,
                                                                store: [
                                                                    0,
                                                                    1,
                                                                    2,
                                                                    3,
                                                                    4,
                                                                    5,
                                                                    6,
                                                                    7,
                                                                    8,
                                                                    9,
                                                                    10
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'frequency4',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description4',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors4',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location5',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity5',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                editable: false,
                                                                store: [
                                                                    0,
                                                                    1,
                                                                    2,
                                                                    3,
                                                                    4,
                                                                    5,
                                                                    6,
                                                                    7,
                                                                    8,
                                                                    9,
                                                                    10
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'frequency5',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description5',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                width: 149,
                                                                name: 'aggravating_factors5',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location6',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity6',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                editable: false,
                                                                store: [
                                                                    0,
                                                                    1,
                                                                    2,
                                                                    3,
                                                                    4,
                                                                    5,
                                                                    6,
                                                                    7,
                                                                    8,
                                                                    9,
                                                                    10
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'frequency6',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description6',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                rowspan: 0,
                                                                name: 'aggravating_factors6',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            }
                                                        ]
                                                    }
                                                ],
                                                tools: [
                                                    {
                                                        xtype: 'tool',
                                                        type: 'pin'
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                flex: 1,
                                                margin: '7px',
                                                itemId: 'homebound_panel',
                                                title: 'Home Bound Status',
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        layout: {
                                                            align: 'middle',
                                                            type: 'hbox'
                                                        },
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
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Poor/Limited Endurance/Strength',
                                                                        inputValue: 'Poor/Limited Endurance/Strength'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Poor Unsteady Gait',
                                                                        inputValue: 'Poor Unsteady Gait'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Requires Assist with ADL/Assistive Devices',
                                                                        inputValue: 'Requires Assist with ADL/Assistive Devices'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Unable to Negotiate Uneven Surfaces or Steps',
                                                                        inputValue: 'Unable to Negotiate Uneven Surfaces or Steps'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Non-wt bearing',
                                                                        inputValue: 'Non-wt bearing'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Requires assist with transfer',
                                                                        inputValue: 'Requires assist with transfer'
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
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Unable to leave home without assistance',
                                                                        inputValue: 'Unable to leave home without assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Bedbound',
                                                                        inputValue: 'Bedbound'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Paralysis UE/LE/both',
                                                                        inputValue: 'Paralysis UE/LE/both'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Requires assist to ambulate',
                                                                        inputValue: 'Requires assist to ambulate'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Poor coordination or balance',
                                                                        inputValue: 'Poor coordination or balance'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'home_bound_status',
                                                                        boxLabel: 'Partial wt bearing',
                                                                        inputValue: 'Partial wt bearing'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'panel',
                                                                flex: 1,
                                                                border: 0,
                                                                items: [
                                                                    {
                                                                        xtype: 'textfield',
                                                                        margin: '0 5px',
                                                                        name: 'other_home_bound_status',
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Other'
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        margin: '5px 5px',
                                                                        name: 'ambulates',
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Ambulates in ft.'
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    }
                                                ],
                                                tools: [
                                                    {
                                                        xtype: 'tool',
                                                        type: 'pin'
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        autoScroll: true,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'DC Reason/ DC Status/Skilled Care/Continuing Problems',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'vbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        border: 0,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'hbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
                                                                layout: {
                                                                    type: 'vbox'
                                                                },
                                                                title: 'DC Reason',
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        flex: 1,
                                                                        name: 'dc_reason',
                                                                        boxLabel: 'No further skilled care needed',
                                                                        checked: true,
                                                                        inputValue: 'No further skilled care needed'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        flex: 1,
                                                                        name: 'dc_reason',
                                                                        boxLabel: ' Patient/PCG Refused',
                                                                        inputValue: ' Patinet/PCG Refused'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        flex: 1,
                                                                        name: 'dc_reason',
                                                                        boxLabel: 'Patient Moved Out Of Area',
                                                                        inputValue: 'Patient Moved Out Of Area'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        flex: 1,
                                                                        name: 'dc_reason',
                                                                        boxLabel: 'Patient Admitted to Hospital',
                                                                        inputValue: 'Patinet Admitted to Hospital'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        flex: 1,
                                                                        name: 'dc_reason',
                                                                        boxLabel: 'Physician\'s request',
                                                                        inputValue: 'Physicians request'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        flex: 1,
                                                                        name: 'dc_reason',
                                                                        boxLabel: 'Patient non-compliant with POC',
                                                                        inputValue: 'Patient non-compliant with POC'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        flex: 1,
                                                                        name: 'dc_reason',
                                                                        boxLabel: 'Repeatedly not found at home',
                                                                        inputValue: 'Repeatedly not found at home'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        flex: 1,
                                                                        name: 'dc_reason',
                                                                        boxLabel: 'Transferred to another HHA',
                                                                        inputValue: 'Transferred to another HHA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        flex: 1,
                                                                        name: 'dc_reason',
                                                                        boxLabel: 'Death',
                                                                        inputValue: 'Death'
                                                                    },
                                                                    {
                                                                        xtype: 'fieldcontainer',
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'hbox'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                name: 'dc_reason',
                                                                                fieldLabel: '',
                                                                                boxLabel: 'Other &nbsp',
                                                                                inputValue: 'Other'
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'dc_other',
                                                                                fieldLabel: ''
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
                                                                layout: {
                                                                    type: 'vbox'
                                                                },
                                                                title: 'DC Status',
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
                                                                                name: 'dc_status',
                                                                                boxLabel: 'Patient discharged safely to self care',
                                                                                inputValue: 'Patient discharged safely to self care'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dc_status',
                                                                                boxLabel: 'Patient discharged safely to care of PCG',
                                                                                inputValue: 'Patient discharged safely to care of PCG'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dc_status',
                                                                                boxLabel: 'MD notified',
                                                                                inputValue: 'MD notified'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dc_status',
                                                                                boxLabel: 'Written DC instructions provided',
                                                                                inputValue: 'Written DC instructions provided'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dc_status',
                                                                                boxLabel: 'Patient/PCG verbalized understanding of DC instructions',
                                                                                inputValue: 'Patient/PCG verbalized understanding of DC instructions'
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        title: 'Skilled Care/Continuing Problems',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                name: 'skilled_care',
                                                                fieldLabel: 'Skilled Care/Comments',
                                                                labelAlign: 'top',
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                name: 'continuing_problems',
                                                                fieldLabel: 'Continuing Problems/Specific Needs/Instructions',
                                                                labelAlign: 'top',
                                                                cols: 100
                                                            }
                                                        ]
                                                    }]
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
        ]
    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var accordions = Ext.ComponentQuery.query("#problem_accordions")[0].query("panel");
      registerContentChangeEventHandlers(this, accordions);
      var panelList = ["#pain_panel", "#homebound_panel"];
      registerVisitedEventHandlers(this, panelList);
    }
  JS


end
