class Documents::SNEvalForm < Documents::AbstractDocumentForm

  def configuration
    c = super
    c.merge(
        model: "SNEvaluation",
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
                            items: [
                                {
                                    xtype: 'panel',
                                    height: 692,
                                    title: 'Pain/PCG/Complaints/Problems/Interventions/',
                                    items: [
                                        {
                                            xtype: 'fieldset',
                                            margin: '5px',
                                            itemId: 'problem_accordions',
                                            layout: {
                                                columns: 5,
                                                type: 'table'
                                            },
                                            title: 'Pain',
                                            items: [
                                                {
                                                    xtype: 'textfield',
                                                    name: 'pain_location1',
                                                    fieldLabel: 'Pain Location',
                                                    labelAlign: 'top'
                                                },
                                                {
                                                    xtype: 'combobox',
                                                    name: 'intensity1',
                                                    fieldLabel: 'Intensity(0-10)',
                                                    labelAlign: 'top',
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
                                                    fieldLabel: 'Frequency',
                                                    labelAlign: 'top'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'description1',
                                                    fieldLabel: '	 Description:',
                                                    labelAlign: 'top'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'aggravating_factors1',
                                                    fieldLabel: 'Aggravating factors',
                                                    labelAlign: 'top'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'pain_location2',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'combobox',
                                                    name: 'intensity2',
                                                    fieldLabel: '',
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
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'description2',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'aggravating_factors2',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'pain_location3',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'combobox',
                                                    name: 'intensity3',
                                                    fieldLabel: '',
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
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'description3',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'aggravating_factors3',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'pain_location4',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'combobox',
                                                    name: 'intensity4',
                                                    fieldLabel: '',
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
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'description4',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'aggravating_factors4',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'pain_location5',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'combobox',
                                                    name: 'intensity5',
                                                    fieldLabel: '',
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
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'description5',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'aggravating_factors5',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'pain_location6',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'combobox',
                                                    name: 'intensity6',
                                                    fieldLabel: '',
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
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'description6',
                                                    fieldLabel: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    name: 'aggravating_factors6',
                                                    fieldLabel: ''
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'fieldset',
                                            margin: '5px',
                                            layout: {
                                                align: 'stretch',
                                                type: 'vbox'
                                            },
                                            title: 'Complaints/Problems/Interventions',
                                            items: [
                                                {
                                                    xtype: 'panel',
                                                    border: 0,
                                                    width: 958,
                                                    autoScroll: false,
                                                    layout: {
                                                        type: 'vbox'
                                                    },
                                                    items: [
                                                        {
                                                            xtype: 'textareafield',
                                                            margin: '',
                                                            name: 'patient_complaints',
                                                            fieldLabel: 'Patient Complaints',
                                                            labelAlign: 'top',
                                                            cols: 100
                                                        },
                                                        {
                                                            xtype: 'textareafield',
                                                            margin: '5px 0 0 0',
                                                            name: 'problems_findings',
                                                            fieldLabel: 'Problems/Significant Findings',
                                                            labelAlign: 'top',
                                                            cols: 100
                                                        },
                                                        {
                                                            xtype: 'textareafield',
                                                            margin: '5px 0 0 0',
                                                            name: 'skilled_interventions',
                                                            fieldLabel: 'Skilled Interventions: (Specific Instructions/ Procedures/ Techniques) ',
                                                            labelAlign: 'top',
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
                                    height: 591,
                                    margin: '3px',
                                    autoScroll: true,
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },
                                    title: 'Integumentary/EENT/Respiratory',
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
                                                    layout: {
                                                        type: 'vbox'
                                                    },
                                                    title: 'Integumentary',
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
                                                                    name: 'integumentary',
                                                                    boxLabel: 'Wound',
                                                                    inputValue: 'Wound'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'integumentary',
                                                                    boxLabel: 'Decub',
                                                                    inputValue: 'Decub'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'integumentary',
                                                                    boxLabel: 'Infected',
                                                                    inputValue: 'Infected'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'integumentary',
                                                                    boxLabel: 'Foul odor drainage',
                                                                    inputValue: 'Foul odor drainage'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'integumentary',
                                                                    boxLabel: 'Rashes',
                                                                    inputValue: 'Rashes'
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'combobox',
                                                            name: 'integumentary_stage',
                                                            fieldLabel: 'Stage',
                                                            store: [
                                                                1,
                                                                2,
                                                                3,
                                                                4
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'integumentary_sizes',
                                                            fieldLabel: 'Sizes'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'integumentary_tubes',
                                                            fieldLabel: 'Tubes'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'integumentary_shunt',
                                                            fieldLabel: 'Shunt'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'other_integumentary',
                                                            fieldLabel: 'Other'
                                                        }
                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldset',
                                                    flex: 1,
                                                    margin: '3px',
                                                    title: 'EENT',
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
                                                                    name: 'eent',
                                                                    boxLabel: 'Legally blind',
                                                                    inputValue: 'Legally blind'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'eent',
                                                                    boxLabel: 'Epistaxis',
                                                                    inputValue: 'Epistaxis'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'eent',
                                                                    boxLabel: 'Dysphagia',
                                                                    inputValue: 'Dysphagia'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'eent',
                                                                    boxLabel: 'Deaf',
                                                                    inputValue: 'Deaf'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'eent',
                                                                    boxLabel: 'Prone to aspiration',
                                                                    inputValue: 'Prone to aspiration'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'eent',
                                                                    boxLabel: 'HOH',
                                                                    inputValue: 'HOH'
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
                                                    title: 'Respiratory',
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
                                                                    name: 'respiratory',
                                                                    boxLabel: 'SOB',
                                                                    inputValue: 'sob'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'respiratory',
                                                                    boxLabel: 'Rest',
                                                                    inputValue: 'Rest'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'respiratory',
                                                                    boxLabel: 'Exertion',
                                                                    inputValue: 'Exertion'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'respiratory',
                                                                    boxLabel: 'Cough',
                                                                    inputValue: 'Cough'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'respiratory',
                                                                    boxLabel: 'Productive',
                                                                    inputValue: 'Productive'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'respiratory',
                                                                    boxLabel: 'Non-productive',
                                                                    inputValue: 'Productive'
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'respiratory_sputum_color',
                                                            fieldLabel: 'Sputum Color'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'respiratory_amount',
                                                            fieldLabel: 'Amount'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'respiratory_lung_sound',
                                                            fieldLabel: 'Lung Sound'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'respiratory_clear_bilaterally',
                                                            fieldLabel: 'Clear bilaterally'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'respiratory_o2',
                                                            fieldLabel: 'O2'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'respiratory_lpm',
                                                            fieldLabel: 'LPM'
                                                        }
                                                    ]
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: 0,
                                            height: 337,
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
                                                    title: 'Musculoskeletal',
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
                                                                    name: 'musculoskeletal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Stiff Joints',
                                                                    inputValue: 'Stiff Joints'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'musculoskeletal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Weakness',
                                                                    inputValue: 'Weakness'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'musculoskeletal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Limited ROM',
                                                                    inputValue: 'Limited ROM'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'musculoskeletal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Contractures',
                                                                    inputValue: 'Contractures'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'musculoskeletal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Foot Drop',
                                                                    inputValue: 'Foot Drop'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'musculoskeletal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Unsteady Balance',
                                                                    inputValue: 'Unsteady Balance'
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'other_musculoskeletal',
                                                            fieldLabel: 'Other'
                                                        }
                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldset',
                                                    flex: 1,
                                                    margin: '3px',
                                                    autoScroll: false,
                                                    layout: {
                                                        type: 'vbox'
                                                    },
                                                    title: 'Gastrointestinal',
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
                                                                    name: 'gastrointestinal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Nausea',
                                                                    inputValue: 'Nausea'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'gastrointestinal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Vomiting',
                                                                    inputValue: 'Vomiting'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'gastrointestinal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Diarrhea',
                                                                    inputValue: 'Diarrhea'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'gastrointestinal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Constipation',
                                                                    inputValue: 'Constipation'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'gastrointestinal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Impaction',
                                                                    inputValue: 'Impaction'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'gastrointestinal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Abd. Dist.',
                                                                    inputValue: 'Abd. Dist.'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'gastrointestinal',
                                                                    fieldLabel: '',
                                                                    boxLabel: 'Incontinent',
                                                                    inputValue: 'Incontinent'
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'radiogroup',
                                                            height: 28,
                                                            width: 267,
                                                            fieldLabel: 'Appetite',
                                                            items: [
                                                                {
                                                                    xtype: 'radiofield',
                                                                    floating: false,
                                                                    name: 'appetite',
                                                                    boxLabel: 'Good',
                                                                    inputValue: 'Good'
                                                                },
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'appetite',
                                                                    boxLabel: 'Fair',
                                                                    inputValue: 'Fair'
                                                                },
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'appetite',
                                                                    boxLabel: 'Poor',
                                                                    inputValue: 'Poor'
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'last_bm',
                                                            fieldLabel: 'Last BM'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'diet',
                                                            fieldLabel: 'Diet'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'tube_feeding',
                                                            fieldLabel: 'Tube Feeding'
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
                                                    title: 'Mental',
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
                                                                    name: 'mental',
                                                                    boxLabel: 'Anxious at times',
                                                                    inputValue: 'Anxious at times'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'mental',
                                                                    boxLabel: 'Restless',
                                                                    inputValue: 'Restless'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'mental',
                                                                    boxLabel: 'Forgetful',
                                                                    inputValue: 'Forgetful'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'mental',
                                                                    boxLabel: 'Confused at times',
                                                                    inputValue: 'Confused at times'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'mental',
                                                                    boxLabel: 'Disoriented',
                                                                    inputValue: 'Disoriented'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'mental',
                                                                    boxLabel: 'Depressed',
                                                                    inputValue: 'Depressed'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'mental',
                                                                    boxLabel: 'Agitated',
                                                                    inputValue: 'Agitated'
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            margin: '3px',
                                                            name: 'mental_other1',
                                                            fieldLabel: 'Other'
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                },
                                {
                                    xtype: 'panel',
                                    height: 577,
                                    margin: '7px',
                                    padding: '3px',
                                    autoScroll: true,
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },
                                    title: 'Home Bound Status/Neurological/Cardiovascular',
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
                                                    xtype: 'fieldset',
                                                    flex: 1,
                                                    margin: '3px',
                                                    layout: {
                                                        align: 'stretch',
                                                        type: 'hbox'
                                                    },
                                                    title: 'Neurological',
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
                                                                    name: 'neurological',
                                                                    boxLabel: 'Aphasic',
                                                                    inputValue: 'Aphasic'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'Slurred speech',
                                                                    inputValue: 'Slurred speech'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'Seizures',
                                                                    inputValue: 'Seizures'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'Headache',
                                                                    inputValue: 'Headache'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'Tremors',
                                                                    inputValue: 'Tremors'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'Vertigo',
                                                                    inputValue: 'Vertigo'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'Grips unequal',
                                                                    inputValue: 'Grips unequal'
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
                                                                    name: 'neurological',
                                                                    boxLabel: 'Grips unequal',
                                                                    inputValue: 'Grips unequal'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'Pupils unequal',
                                                                    inputValue: 'Pupils unequal'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'PERRLA',
                                                                    inputValue: 'PERRLA'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'Weakness',
                                                                    inputValue: 'Weakness'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'R',
                                                                    inputValue: 'R'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'neurological',
                                                                    boxLabel: 'L',
                                                                    inputValue: 'L'
                                                                }
                                                            ]
                                                        }
                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldset',
                                                    flex: 1,
                                                    margin: '3px',
                                                    title: 'Cardiovascular',
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
                                                                            name: 'cardiovascular',
                                                                            boxLabel: 'Chest Pain',
                                                                            inputValue: 'Chest Pain'
                                                                        },
                                                                        {
                                                                            xtype: 'checkboxfield',
                                                                            name: 'cardiovascular',
                                                                            boxLabel: 'Palpitations',
                                                                            inputValue: 'Palpitations'
                                                                        },
                                                                        {
                                                                            xtype: 'checkboxfield',
                                                                            name: 'cardiovascular',
                                                                            boxLabel: 'Dizziness',
                                                                            inputValue: 'Dizziness'
                                                                        },
                                                                        {
                                                                            xtype: 'checkboxfield',
                                                                            name: 'cardiovascular',
                                                                            boxLabel: 'Dependent',
                                                                            inputValue: 'Dependent'
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
                                                                            name: 'cardiovascular',
                                                                            boxLabel: '1+',
                                                                            inputValue: '1+'
                                                                        },
                                                                        {
                                                                            xtype: 'checkboxfield',
                                                                            name: 'cardiovascular',
                                                                            boxLabel: '2+',
                                                                            inputValue: '2+'
                                                                        },
                                                                        {
                                                                            xtype: 'checkboxfield',
                                                                            name: 'cardiovascular',
                                                                            boxLabel: '3+',
                                                                            inputValue: '3+'
                                                                        },
                                                                        {
                                                                            xtype: 'checkboxfield',
                                                                            name: 'cardiovascular',
                                                                            boxLabel: '4+',
                                                                            inputValue: '4+'
                                                                        }
                                                                    ]
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'radiogroup',
                                                            fieldLabel: 'Pedal pulses',
                                                            items: [
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'pedal_pulses',
                                                                    boxLabel: 'Present',
                                                                    inputValue: 'Present'
                                                                },
                                                                {
                                                                    xtype: 'radiofield',
                                                                    name: 'pedal_pulses',
                                                                    boxLabel: 'Absent',
                                                                    inputValue: 'Absent'
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'checkboxgroup',
                                                            height: 19,
                                                            fieldLabel: 'Location',
                                                            items: [
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'cardiovascular',
                                                                    boxLabel: 'Ankles R/L',
                                                                    inputValue: 'Ankles R/L'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'cardiovascular',
                                                                    boxLabel: 'Dorsum R/L',
                                                                    inputValue: 'Dorsum R/L'
                                                                }
                                                            ]
                                                        }
                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldset',
                                                    flex: 1,
                                                    height: 233,
                                                    margin: '3px',
                                                    layout: {
                                                        align: 'stretch',
                                                        type: 'hbox'
                                                    },
                                                    title: 'Genitourinary',
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
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Incontinent',
                                                                    inputValue: 'Incontinent'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Frequency',
                                                                    inputValue: 'Frequency'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Urgency',
                                                                    inputValue: 'Urgency'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Pain',
                                                                    inputValue: 'Pain'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Nocturia',
                                                                    inputValue: 'Nocturia'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Burning',
                                                                    inputValue: 'Burning'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Retention',
                                                                    inputValue: 'Retention'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Catheter',
                                                                    inputValue: 'Catheter'
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
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Condom',
                                                                    inputValue: 'Condom'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'IFC',
                                                                    inputValue: 'IFC'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Suprapub',
                                                                    inputValue: 'Suprapub'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Odor',
                                                                    inputValue: 'Odor'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Cloudy',
                                                                    inputValue: 'Cloudy'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Hematuria',
                                                                    inputValue: 'Hematuria'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'genitourinary',
                                                                    boxLabel: 'Chills',
                                                                    inputValue: 'Chills'
                                                                }
                                                            ]
                                                        }
                                                    ]
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: 0,
                                            height: 388,
                                            layout: {
                                                align: 'stretch',
                                                type: 'hbox'
                                            },
                                            items: [
                                                {
                                                    xtype: 'fieldset',
                                                    flex: 1,
                                                    margin: '3px',
                                                    title: 'Endocrine',
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
                                                                    boxLabel: 'Weak',
                                                                    inputValue: 'Weak'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'endocrine',
                                                                    boxLabel: 'Diaphoretic',
                                                                    inputValue: 'Diaphoretic'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'endocrine',
                                                                    boxLabel: 'Polyuria',
                                                                    inputValue: 'Polyuria'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'endocrine',
                                                                    boxLabel: 'Blurred vision',
                                                                    inputValue: 'Blurred vision'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'endocrine',
                                                                    boxLabel: 'Poor foot care',
                                                                    inputValue: 'Poor foot care'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'endocrine',
                                                                    boxLabel: 'Tremors',
                                                                    inputValue: 'Tremors'
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            anchor: '100%',
                                                            name: 'other_endocrine',
                                                            fieldLabel: 'Other'
                                                        }
                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldset',
                                                    flex: 1,
                                                    margin: '3px',
                                                    title: 'Universal Precautions Utilized',
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
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Medical Waste Disposal',
                                                                    inputValue: 'Medical Waste Disposal'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Gloves',
                                                                    inputValue: 'Gloves'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Mask',
                                                                    inputValue: 'Mask'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Hand-Washing',
                                                                    inputValue: 'Hand-Washing'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Goggles',
                                                                    inputValue: 'Goggles'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Apron',
                                                                    inputValue: 'Apron'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Sharps Disposal',
                                                                    inputValue: 'Sharps Disposal'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Red Bagging',
                                                                    inputValue: 'Red Bagging'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Double Bagging',
                                                                    inputValue: 'Double Bagging'
                                                                },
                                                                {
                                                                    xtype: 'checkboxfield',
                                                                    name: 'universal_precautions',
                                                                    boxLabel: 'Infection Control',
                                                                    inputValue: 'Infection Control'
                                                                }
                                                            ]
                                                        }
                                                    ]
                                                },
                                                {
                                                    xtype: 'fieldset',
                                                    flex: 1.3,
                                                    margin: '3px',
                                                    layout: {
                                                        type: 'vbox'
                                                    },
                                                    title: 'Home Bound Status',
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
                                                                    flex: 1,
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
                                                            name: 'other_home_bound_status',
                                                            fieldLabel: 'Other'
                                                        },
                                                        {
                                                            xtype: 'textfield',
                                                            name: 'ambulates',
                                                            fieldLabel: 'Ambulates in ft.'
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                },
                                {
                                    xtype: 'panel',
                                    height: 577,
                                    margin: '7px',
                                    padding: '3px',
                                    autoScroll: true,
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },
                                    title: 'PCG/Visit Details',
                                    items: [
                                        {
                                            xtype: 'fieldset',
                                            margin: '5px',
                                            layout: {
                                                align: 'stretch',
                                                type: 'hbox'
                                            },
                                            title: 'PCG',
                                            items: [
                                                {
                                                    xtype: 'radiogroup',
                                                    width: 608,
                                                    fieldLabel: 'Patient/Family/PCG',
                                                    labelWidth: 150,
                                                    items: [
                                                        {
                                                            xtype: 'radiofield',
                                                            name: 'pcg',
                                                            boxLabel: 'Verbalized understanding',
                                                            inputValue: 'Verbalized understanding'
                                                        },
                                                        {
                                                            xtype: 'radiofield',
                                                            name: 'pcg',
                                                            boxLabel: 'Did not verbalize understanding',
                                                            inputValue: 'Did not verbalize understanding'
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
    document_id = Document.where(["document_type = ?", "SNEvaluation"]).last.id
    #report_url = "#{request.protocol}#{request.host_with_port}/reports/#{document_id}.pdf"
    report_url = "/reports/#{document_id}.pdf"
    report_title = "Patient : James, Certification Period - [10/21/2012 - 11/20/2012]"
    {:launch_previous_evaluation_report => [report_url, report_title]}
  end

end
