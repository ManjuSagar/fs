# Custom user form (predefined model and layout)
class Documents::MSWDischargeFormV2 < Documents::AbstractDocumentForm

  def configuration
    c = super
    c.merge(
        model: "MSWDischarge",
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
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'Living Situation/Psychosocial Assessment/Home Bound Status',
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
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        itemId: 'living_situation',
                                                        margin: '',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
                                                        title: 'Living Situation',
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
                                                                        name: 'living_situation_follow_up',
                                                                        boxLabel: 'Unchanged from Last Visit',
                                                                        inputValue: 'Unchanged from Last Visit'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'living_situation_follow_up',
                                                                        boxLabel: 'Update to Primary Caregiver',
                                                                        inputValue: 'Update to Primary Caregiver'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'living_situation_follow_up',
                                                                        boxLabel: 'Changes to Environmental Conditions',
                                                                        inputValue: 'Changes to Environmental Conditions'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: ' 0 3px 3px 3px',
                                                                name: 'changed_living_situations',
                                                                fieldLabel: 'Changed'
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
                                                        itemId: 'follow_up_plan',
                                                        margin: '0 0 0 3px',
                                                        width: 489,
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        title: 'Follow Up Plan',
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
                                                                        name: 'follow_up_plan',
                                                                        boxLabel: 'Follow-up Visit',
                                                                        inputValue: 'Follow-up Visit'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'follow_up_plan',
                                                                        boxLabel: 'Confer with Team',
                                                                        inputValue: 'Confer with Team'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'follow_up_plan',
                                                                        boxLabel: 'Provide External Referral',
                                                                        inputValue: 'Provide External Referral'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'follow_up_plan',
                                                                        boxLabel: 'Discharge SW Services',
                                                                        inputValue: 'Discharge SW Services'
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
                                                border: 0,
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'hbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        itemId: 'emotional_status',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
                                                        title: 'Emotional Status ',
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
                                                                        name: 'emotional_status',
                                                                        boxLabel: 'Stable',
                                                                        inputValue: 'Stable'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'emotional_status',
                                                                        boxLabel: 'Tearful',
                                                                        inputValue: 'Tearful'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'emotional_status',
                                                                        boxLabel: 'Stressed',
                                                                        inputValue: 'Stressed'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'emotional_status',
                                                                        boxLabel: 'Angry',
                                                                        inputValue: 'Angry'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'emotional_status',
                                                                        boxLabel: 'Sad',
                                                                        inputValue: 'Sad'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'emotional_status',
                                                                        boxLabel: 'Withdrawn',
                                                                        inputValue: 'Withdrawn'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'emotional_status',
                                                                        boxLabel: 'Fearful',
                                                                        inputValue: 'Fearful'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'emotional_status',
                                                                        boxLabel: 'Anxious',
                                                                        inputValue: 'Anxious'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'emotional_status',
                                                                        boxLabel: 'Flat Affect',
                                                                        inputValue: 'Flat Affect'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '0 3px 5px 3px',
                                                                name: 'other_emotional_status',
                                                                fieldLabel: 'Other',
                                                                labelWidth: 40
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
                                                        itemId: 'mental_status',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
                                                        title: 'Mental Status',
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
                                                                        name: 'mental_status',
                                                                        boxLabel: 'Oriented',
                                                                        inputValue: 'Oriented'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'mental_status',
                                                                        boxLabel: 'Confused',
                                                                        inputValue: 'Comatose'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'mental_status',
                                                                        boxLabel: 'Forgetful',
                                                                        inputValue: 'Forgetful'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'mental_status',
                                                                        boxLabel: 'Depressed',
                                                                        inputValue: 'Depressed'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'mental_status',
                                                                        boxLabel: 'Disoriented',
                                                                        inputValue: 'Disoriented'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'mental_status',
                                                                        boxLabel: 'Lethargic',
                                                                        inputValue: 'Lethargic'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'mental_status',
                                                                        boxLabel: 'Agitated',
                                                                        inputValue: 'Agitated'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '3px',
                                                                name: 'other1_mental_status',
                                                                fieldLabel: 'Other'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '3px',
                                                                name: 'other2_mental_status',
                                                                fieldLabel: 'Other'
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
                                                        margin: '3px',
                                                        itemId: 'homebound_panel',
                                                        title: 'Home Bound Status',
                                                        items: [
                                                            {
                                                                xtype: 'checkboxgroup',
                                                                layout: {
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
                                                                    },
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
                                                                xtype: 'textfield',
                                                                margin: '0 5px',
                                                                name: 'other_home_bound_status',
                                                                fieldLabel: 'Other'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '5px 5px',
                                                                name: 'ambulates',
                                                                fieldLabel: 'Ambulates in ft.'
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
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        padding: '3px',
                                        autoScroll: true,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'Interventions/Goals',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                margin: '3px',
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'hbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        itemId: 'interventions',
                                                        margin: '0 3px 3px 0',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
                                                        title: 'Interventions',
                                                        items: [
                                                            {
                                                                xtype: 'panel',
                                                                border: 0,
                                                                layout: {
                                                                    align: 'stretch',
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
                                                                                name: 'interventions',
                                                                                boxLabel: 'Psychosocial Assessment',
                                                                                inputValue: 'Psychosocial Assessment'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'interventions',
                                                                                boxLabel: 'Community Res. Planning/Outreach',
                                                                                inputValue: 'Community Res. Planning/Outreach'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'interventions',
                                                                                boxLabel: 'Counsel re Disease Management',
                                                                                inputValue: 'Counsel re Disease Management'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'interventions',
                                                                                boxLabel: 'Community Res. Planning/Outreach',
                                                                                inputValue: 'Community Res. Planning/Outreach'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'interventions',
                                                                                boxLabel: 'Counseling re Family Coping',
                                                                                inputValue: 'Counseling re Family Coping'
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
                                                                                name: 'interventions',
                                                                                boxLabel: 'Stabilize Current Placement',
                                                                                inputValue: 'Stabilize Current Placement'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'interventions',
                                                                                boxLabel: 'Crisis Intervention',
                                                                                inputValue: 'Crisis Intervention'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'interventions',
                                                                                boxLabel: 'Determine/Locate Alt Placement',
                                                                                inputValue: 'Determine/Locate Alt Placement'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'interventions',
                                                                                boxLabel: 'Long-range Planning/Decision Making',
                                                                                inputValue: 'Long-range Planning/Decision Making'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'interventions',
                                                                                boxLabel: 'Financial Counseling and/or Referrals',
                                                                                inputValue: 'Financial Counseling and/or Referrals'
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '0 0 5px 3px',
                                                                padding: '',
                                                                name: 'other_interventions',
                                                                fieldLabel: 'Other'
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
                                                        itemId: 'goals',
                                                        margin: '0 0 3px 3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        title: 'Goals',
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
                                                                        name: 'goals',
                                                                        boxLabel: 'Adequate Support System',
                                                                        inputValue: 'Adequate Support System'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'goals',
                                                                        boxLabel: 'Improved Client/Family Coping',
                                                                        inputValue: 'Improved Client/Family Coping'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'goals',
                                                                        boxLabel: 'Normal Grieving Process',
                                                                        inputValue: 'Normal Grieving Process'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'goals',
                                                                        boxLabel: 'Appropriate Goals set by Client/Family',
                                                                        inputValue: 'Appropriate Goals set by Client/Family'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'goals',
                                                                        boxLabel: 'Appropriate Community Res. Referrals',
                                                                        inputValue: 'Appropriate Community Res. Referrals'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'goals',
                                                                        boxLabel: 'Stable Placement Setting',
                                                                        inputValue: 'Stable Placement Setting'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'goals',
                                                                        boxLabel: 'Mobilization of Financial Resources',
                                                                        inputValue: 'Mobilization of Financial Resources'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '0 0 5px 3px',
                                                                name: 'other_goals',
                                                                fieldLabel: 'Other'
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
                                                flex: 1,
                                                itemId: 'strength_intervention_details',
                                                margin: '0 3px 0 3px',
                                                layout: {
                                                    type: 'vbox'
                                                },
                                                title: 'intervention Details/Visit Goal Details /progress Towards Goals',
                                                items: [
                                                    {
                                                        xtype: 'textareafield',
                                                        margin: '0 0 0 5px',
                                                        name: 'intervention_details',
                                                        fieldLabel: 'Intervention Details',
                                                        labelAlign: 'top',
                                                        cols: 100
                                                    },
                                                    {
                                                        xtype: 'textareafield',
                                                        margin: '3px 0 0 5px',
                                                        name: 'visit_goal_details',
                                                        fieldLabel: 'Visit Goal Details',
                                                        labelAlign: 'top',
                                                        cols: 100
                                                    },
                                                    {
                                                        xtype: 'textareafield',
                                                        margin: '3px 0 0 5px',
                                                        name: 'progress_towards_goals',
                                                        fieldLabel: 'Progress Towards Goals',
                                                        labelAlign: 'top',
                                                        cols: 100
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
                                        xtype: 'form',
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'DC Reason/DC Status',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                margin: '3px',
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
                                                                boxLabel: 'Patient/PCG Refused',
                                                                inputValue: 'Patient/PCG Refused'
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
                                                                inputValue: 'Patient Admitted to Hospital'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Physician\'s request',
                                                                inputValue: 'Physician\'s request'
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
                                                                flex: 1,
                                                                margins: '0',
                                                                width: 400,
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'hbox'
                                                                },
                                                                fieldLabel: '',
                                                                labelPad: 0,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'dc_reason',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Other&nbsp;',
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
                                                                        checked: true,
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
                                                                        inputValue: 'Physician\'s request'
                                                                    }
                                                                ]
                                                            }
                                                        ]
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
    )
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var panelList = ["#living_situation", "#homebound_panel", "#follow_up_plan", "#emotional_status", "#mental_status",
                   "#interventions", "#goals", "#strength_intervention_details"];
      registerVisitedEventHandlers(this, panelList);

    }
  JS


end
