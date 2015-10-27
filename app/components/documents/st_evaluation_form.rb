# Custom user form (predefined model and layout)
class Documents::STEvaluationForm < Documents::AbstractDocumentForm

  def configuration
    c = super
    @prev_eval_document = PatientTreatment.find(c[:treatment_id]).documents.find_all_by_document_type("STEvaluation").last if c[:treatment_id]
    c.merge(
        model: "STEvaluation",
        item_id: "evaluation",
        show_last_evaluation_action: true,
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
                                deferredRender: false,
                                plain: true,
                                items: [
                                    {
                                        xtype: 'panel',
                                        autoScroll: true,
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'PROBLEMS/CONDITION ON  ADMISSION ',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                autoScroll: true,
                                                layout: {
                                                    fill: false,
                                                    type: 'accordion'
                                                },
                                                itemId: 'problem_accordions',
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapseFirst: false,
                                                        collapsed: false,
                                                        title: 'Eval only with instructions',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'eval_only_with_instruction_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapseFirst: false,
                                                        collapsed: true,
                                                        title: 'Treat Voice Disorder',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_voice_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Treat Speech Disorder ',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_speach_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
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
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_dysphagia_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Treat Language Disorder',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_language_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Aural Rehabilitation Training',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'aural_rehabilitation_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
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
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_visual_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Treat Cognitive Disorder',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'treat_cognitive_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Other',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
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
                                                xtype: 'fieldset',
                                                height: 223,
                                                margin: '7px',
                                                title: 'Pain',
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        height: 199,
                                                        layout: {
                                                            columns: 5,
                                                            type: 'table'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location1',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: 'Pain Location',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity1',
                                                                fieldLabel: 'Intensity(0-10)',
                                                                margin: '0 0 3px 3px',
                                                                labelAlign: 'top',
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
                                                                fieldLabel: 'Frequency',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description1',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: 'Description',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors1',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: 'Aggravating Factors',
                                                                labelAlign: 'top'
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
                                                ]
                                            },
                                            {
                                                xtype: 'fieldset',
                                                margin: '7px',
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
                                                ]
                                            },
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        autoScroll: true,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'Speech Voice Function/Cognitive Skills/Narrative Response',
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
                                                        flex: 1,
                                                        margin: '3px',
                                                        title: 'Speech Voice Function',
                                                        items: [
                                                            {
                                                                xtype: 'image',
                                                                anchor: '',
                                                                height: 30,
                                                                margin: '0px 0px 0px 150px',
                                                                width: 200,
                                                                src: '/images/speech_score.png'
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'speech_intelligilibility',
                                                                value: 1,
                                                                fieldLabel: 'Speech Intelligilibility  ',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'voice_quality',
                                                                value: 0,
                                                                fieldLabel: 'Voice Quality',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'laryngectomized',
                                                                value: 0,
                                                                fieldLabel: 'Laryngectomized',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'swallowing',
                                                                value: 0,
                                                                fieldLabel: 'Swallowing',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'non_verbal_comm',
                                                                value: 0,
                                                                fieldLabel: 'Non Verbal Comm',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'verbal_expression',
                                                                value: 0,
                                                                fieldLabel: 'Verbal Expression',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'graphic_formulation',
                                                                value: 0,
                                                                fieldLabel: 'Graphic Formulation',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'auditory_comp',
                                                                value: 0,
                                                                fieldLabel: 'Auditory Comp',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'visual_comp',
                                                                value: 0,
                                                                fieldLabel: 'Visual Comp',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'reading_comp',
                                                                value: 0,
                                                                fieldLabel: 'Reading Comp',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'arithmetic_proc',
                                                                value: 0,
                                                                fieldLabel: 'Arithmetic Proc',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        margin: '3px',
                                                        title: 'Cognitive Skills',
                                                        items: [
                                                            {
                                                                xtype: 'image',
                                                                anchor: '',
                                                                height: 30,
                                                                margin: '0px 0px 0px 150px',
                                                                width: 200,
                                                                src: '/images/speech_score.png'
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'attention_span',
                                                                value: 0,
                                                                fieldLabel: 'Attention Span',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'memory',
                                                                value: 0,
                                                                fieldLabel: 'Memory',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'thought_organization',
                                                                value: 0,
                                                                fieldLabel: 'Thought Organization',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'problem_solving',
                                                                value: 0,
                                                                fieldLabel: 'Problem Solving',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'orientation',
                                                                value: 0,
                                                                fieldLabel: 'Orientation',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'sequencing',
                                                                value: 0,
                                                                fieldLabel: 'Sequencing',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 327,
                                                                name: 'scheduling',
                                                                value: 1.3,
                                                                fieldLabel: 'Scheduling',
                                                                labelWidth: 150,
                                                                preventMark: false,
                                                                decimalPrecision: 1,
                                                                increment: 20,
                                                                vertical: false
                                                            }
                                                        ]
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'vbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        margin: '7px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        title: 'Narrative/interventions with patient/PCG response',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                name: 'narrative_response',
                                                                fieldLabel: '',
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

      var action = this.actions.previousEvaluationReport;
      if (action) {
        this.checkPrevEvalAvailability({}, function(result){
          action.setDisabled((result == 'q'));
        },this);
      }
    }
  JS


  endpoint :check_prev_eval_availability do |params|
    {set_result: (@prev_eval_document.present? ? 'p' : 'q')}
  end

  js_method :launch_previous_evaluation_report, <<-JS
    function(report_options) {
      var reportUrl = report_options[0];
      reportUrl = window.location.protocol + "//" + window.location.host + reportUrl;
      var reportTitle = report_options[1];
      if (Ext.isGecko) {
        window.location = reportUrl;
      } else {
        Ext.create('Ext.window.Window', {
            width : 800,
            height: 600,
            layout : 'fit',
            title : reportTitle,
            items : [{
                xtype : "component",
                id: 'myIframe1',
                autoEl : {
                    tag : "iframe",
                    href : ""
                }
            }]
        }).show();

        Ext.getDom('myIframe1').src = reportUrl;
      }
    }
  JS

  js_method :on_previous_evaluation_report, <<-JS
    function() {
      this.viewPreviousEvaluationReport();
    }
  JS

  endpoint :view_previous_evaluation_report do |params|
    if @prev_eval_document
      treatment = @prev_eval_document.treatment
      session[:pre_generated_file_name] = @prev_eval_document.combined_reports
      certification_period = @prev_eval_document.treatment_episode
      report_title = "Patient : #{treatment.to_s}, Certification Period - #{certification_period}"
      report_url = "/reports/pre_generated"
      {:launch_previous_evaluation_report => [report_url, report_title]}
    end

  end

end