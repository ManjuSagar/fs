class Documents::SuperVisoryVisitForm < Documents::AbstractDocumentForm
    def configuration
        c = super
        c.merge(
            model: "SuperVisoryVisit",
            item_id: :super_visory_visits_id,
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
                            xtype: 'form',
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
                                    region: 'center',
                                    border: 0,
                                    items: [
                                        {  
                                            border: 0,
                                            items: [
                                                :super_visory_visits.component
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: 0,
                                            width: 1020,
                                            layout: {
                                                align: 'stretch',
                                                type: 'vbox'
                                            },
                                            items: [
                                                {
                                                    xtype: 'fieldset',
                                                    title: 'Staff Information',
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
                                                                    xtype: 'label',
                                                                    width: 226,
                                                                    text: 'Item'
                                                                },
                                                                {
                                                                    xtype: 'label',
                                                                    width: 110,
                                                                    text: 'Exceeds Requirements'
                                                                },
                                                                {
                                                                    xtype: 'label',
                                                                    width: 108,
                                                                    text: 'Meets Requirements'
                                                                },
                                                                {
                                                                    xtype: 'label',
                                                                    width: 117,
                                                                    text: 'Does Not Meet Requirements'
                                                                },
                                                                {
                                                                    xtype: 'label',
                                                                    width: 154,
                                                                    text: 'Not Observed'
                                                                },
                                                                {
                                                                    xtype: 'label',
                                                                    width: 131,
                                                                    text: 'Comments'
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 42,
                                                                    width: 683,
                                                                    fieldLabel: 'Reports for work assignments as schedule',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'reports_for_work_assignments',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'reports_for_work_assignments',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'reports_for_work_assignments',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'reports_for_work_assignments',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'work_assignments_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 42,
                                                                    width: 683,
                                                                    fieldLabel: 'Identifies self by name and title to the client',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'identifies_self',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'identifies_self',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'identifies_self',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'identifies_self',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'identifies_self_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 43,
                                                                    width: 683,
                                                                    fieldLabel: 'Demonstrates courteous behaviour toward the client and behaviour ',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'courteous_behaviour',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'courteous_behaviour',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'courteous_behaviour',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'courteous_behaviour',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'courteous_behaviour_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 42,
                                                                    width: 683,
                                                                    fieldLabel: 'Demonstrates cooperative behaviour with the client and others',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'cooperative_behaviour',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'cooperative_behaviour',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'cooperative_behaviour',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'cooperative_behaviour',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'cooperative_behaviour_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 42,
                                                                    width: 683,
                                                                    fieldLabel: 'Demonstrates the positive and helpful attitude toward client and others',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'positive_attitude',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'positive_attitude',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'positive_attitude',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'positive_attitude',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'positive_attitude_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 42,
                                                                    width: 683,
                                                                    fieldLabel: 'Demonstrates competent skills and expertise',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'competent_skills',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'competent_skills',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'competent_skills',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'competent_skills',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'competent_skills_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 42,
                                                                    width: 683,
                                                                    fieldLabel: 'Demonstrates adqueate communication skills',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'adequate_skills',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'adequate_skills',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'adequate_skills',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'adequate_skills',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'adequate_skills_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    width: 683,
                                                                    fieldLabel: 'Follows client care plan',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'client_care_plan',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'client_care_plan',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'client_care_plan',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'client_care_plan',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'client_care_plan_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 42,
                                                                    width: 683,
                                                                    fieldLabel: 'Document provided home health care services and in appropriate manner',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'provided_hhc_services',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'provided_hhc_services',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'provided_hhc_services',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'provided_hhc_services',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'provided_hhc_services_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 42,
                                                                    width: 683,
                                                                    fieldLabel: 'Informs of client needs and condition as appropriate, in a timely manner',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'inform_client_needs',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'inform_client_needs',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'inform_client_needs',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'inform_client_needs',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'inform_client_needs_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 42,
                                                                    width: 683,
                                                                    fieldLabel: 'Adheres to home health care agency policies and procedures',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'adheres_to_hha',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'adheres_to_hha',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'adheres_to_hha',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'adheres_to_hha',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'adheres_to_hha_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    width: 683,
                                                                    fieldLabel: 'Utilizes proper body mechanics',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'body_mechanics',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'body_mechanics',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'body_mechanics',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'body_mechanics',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'body_mechanics_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    width: 683,
                                                                    fieldLabel: 'Utilizes good grooming habits',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'grooming_habits',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'grooming_habits',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements",
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'grooming_habits',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'grooming_habits',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'grooming_habits_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    height: 40,
                                                                    width: 683,
                                                                    fieldLabel: 'Complies with home health agency dress code ',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'complies_with_hha',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'complies_with_hha',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'complies_with_hha',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'complies_with_hha',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'complies_with_hha_comments',
                                                                    fieldLabel: ''
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'panel',
                                                            border: 0,
                                                            layout: {
                                                                align: 'middle',
                                                                type: 'hbox'
                                                            },
                                                            items: [
                                                                {
                                                                    xtype: 'radiogroup',
                                                                    width: 683,
                                                                    fieldLabel: 'Other',
                                                                    labelWidth: 240,
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'other',
                                                                            boxLabel: '',
                                                                            inputValue: "Exceeds Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'other',
                                                                            boxLabel: '',
                                                                            inputValue: "Meets Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'other',
                                                                            boxLabel: '',
                                                                            inputValue: "Does Not Meet Requirements"
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            name: 'other',
                                                                            boxLabel: '',
                                                                            inputValue: "Not Observed"
                                                                        }
                                                                    ]
                                                                },
                                                                {
                                                                    xtype: 'textfield',
                                                                    name: 'other_comments',
                                                                    fieldLabel: ''
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
                        }
                    ]
                }
            ]
        )
    end
end