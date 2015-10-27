# Custom user form (predefined model and layout)
class Documents::SNDischargeFormV2 < Documents::AbstractDocumentForm

  def configuration
    c = super
    c.merge(
        model: "SNDischarge",
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
                                items: [
                                    {
                                        xtype: 'panel',
                                        height: 692,
                                        title: 'Pain/PCG/Complaints/Problems/Interventions/',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                margin: '5px',
                                                layout: {
                                                    columns: 5,
                                                    type: 'table'
                                                },
                                                title: 'Pain',
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
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: 'Intensity(0-10)',
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
                                                        fieldLabel: '	 Description:',
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
                                                        fieldLabel: ''
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
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'description2',
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'aggravating_factors2',
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'pain_location3',
                                                        margin: '0 0 3px 5px',
                                                        fieldLabel: ''
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
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'description3',
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'aggravating_factors3',
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'pain_location4',
                                                        margin: '0 0 3px 5px',
                                                        fieldLabel: ''
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
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'description4',
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'aggravating_factors4',
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'pain_location5',
                                                        margin: '0 0 3px 5px',
                                                        fieldLabel: ''
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
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'description5',
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'aggravating_factors5',
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'pain_location6',
                                                        margin: '0 0 3px 5px',
                                                        fieldLabel: ''
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
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'description6',
                                                        margin: '0 0 3px 3px',
                                                        fieldLabel: ''
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'aggravating_factors6',
                                                        margin: '0 0 3px 3px',
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
                                                                        boxLabel: 'Foul Odor Drainage',
                                                                        inputValue: 'Foul Odor Drainage'
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
                                                                xtype: 'textareafield',
                                                                width: "93%",
                                                                name: 'other_integumentary',
                                                                fieldLabel: 'Other',
                                                                labelAlign: "top",
                                                                cols: 100,
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
                                                                        boxLabel: 'Impaired Vision',
                                                                        inputValue: 'Impaired Vision'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'eent',
                                                                        boxLabel: 'Legally Blind',
                                                                        inputValue: 'Legally Blind'
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
                                                                        boxLabel: 'Prone to Aspiration',
                                                                        inputValue: 'Prone to Aspiration'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'eent',
                                                                        boxLabel: 'HOH',
                                                                        inputValue: 'HOH'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                label_width: '5',
                                                                labelAlign: 'top',
                                                                margin: '5px',
                                                                name: 'other_eent',
                                                                fieldLabel: 'Other',
                                                                cols: 100,
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
                                                                        inputValue: 'SOB'
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
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                width: "93%",
                                                                labelAlign: 'top',
                                                                name: 'other_respiratory',
                                                                fieldLabel: 'Other',
                                                                cols: 100,
                                                            }
                                                        ]
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                height: 470,
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
                                                                xtype: 'textareafield',
                                                                width: "93%",
                                                                labelAlign: 'top',
                                                                name: 'other_musculoskeletal',
                                                                fieldLabel: 'Other',
                                                                cols: 100,
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
                                                                width: 328,
                                                                fieldLabel: 'Appetite',
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        floating: false,
                                                                        name: 'appetite',
                                                                        boxLabel: 'Good',
                                                                        checked: true,
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
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                width: "93%",
                                                                name: 'other_gastrointestinal',
                                                                fieldLabel: 'Other',
                                                                labelAlign: "top",
                                                                cols: 100,
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
                                                                xtype: 'textareafield',
                                                                width: "93%",
                                                                labelAlign: 'top',
                                                                margin: '3px',
                                                                name: 'mental_other1',
                                                                fieldLabel: 'Other',
                                                                cols: 100,
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        height: 600,
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
                                                height: 410,
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'hbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        height: 370,
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'table',
                                                            tableAttrs: {
                                                                border:0,
                                                            },
                                                            columns: 2,
                                                        },
                                                        title: 'Neurological',
                                                        items: [
                                                            {
                                                                xtype: 'checkboxfield',
                                                                name: 'neurological',
                                                                boxLabel: 'Aphasic',
                                                                inputValue: 'Aphasic',
                                                            },
                                                            {
                                                                xtype: 'checkboxfield',
                                                                name: 'neurological',
                                                                boxLabel: 'Grips unequal',
                                                                inputValue: 'Grips unequal'
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
                                                                boxLabel: 'Pupils unequal',
                                                                inputValue: 'Pupils unequal'
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
                                                                boxLabel: 'PERRLA',
                                                                inputValue: 'PERRLA'
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
                                                                boxLabel: 'Weakness',
                                                                inputValue: 'Weakness'
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
                                                                boxLabel: 'R',
                                                                inputValue: 'R'
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
                                                                boxLabel: 'L',
                                                                inputValue: 'L'
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                labelAlign: 'top',
                                                                margin: "5px 0 0 0",
                                                                name: 'other_neurological',
                                                                fieldLabel: 'Other',
                                                                cols: 33
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        height: 370,
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
                                                                                boxLabel: 'Pacer',
                                                                                inputValue: 'Pacer'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'cardiovascular',
                                                                                boxLabel: 'Dependent',
                                                                                inputValue: 'Dependent'
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                fieldLabel: 'Pedal pulses',
                                                                margin: '5px',
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'pedal_pulses',
                                                                        boxLabel: 'Present',
                                                                        checked: true,
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
                                                                labelWidth: 60,
                                                                margin: '5px',
                                                                fieldLabel: 'Edema',
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'edema',
                                                                        boxLabel: 'Pitting',
                                                                        inputValue: 'Pitting'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'edema',
                                                                        boxLabel: 'Non-pitting',
                                                                        inputValue: 'Non-pitting'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'edema',
                                                                        boxLabel: 'Dependent',
                                                                        inputValue: 'Dependent Edema'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'checkboxgroup',
                                                                height: 19,
                                                                margin: "0 0 0 71",
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'hbox'
                                                                },
                                                                fieldLabel: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'edema',
                                                                        boxLabel: '1+',
                                                                        inputValue: '1+'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'edema',
                                                                        boxLabel: '2+',
                                                                        inputValue: '2+'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'edema',
                                                                        boxLabel: '3+',
                                                                        inputValue: '3+'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'edema',
                                                                        boxLabel: '4+',
                                                                        inputValue: '4+'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'panel',
                                                                border: 0,
                                                                margin: '5px',
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'hbox'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxgroup',
                                                                        flex: 1,
                                                                        fieldLabel: 'Ankle',
                                                                        labelWidth: 61,
                                                                        items: [
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'ankle_location',
                                                                                boxLabel: 'L',
                                                                                inputValue: 'Left',
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'ankle_location',
                                                                                boxLabel: 'R',
                                                                                inputValue: 'Right'
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxgroup',
                                                                        flex: 1,
                                                                        fieldLabel: 'Dorsum',
                                                                        labelWidth: 67,
                                                                        items: [
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dorsum_location',
                                                                                boxLabel: 'L',
                                                                                inputValue: 'Left'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dorsum_location',
                                                                                boxLabel: 'R',
                                                                                inputValue: 'Right '
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                label_width: "5",
                                                                labelAlign: 'top',
                                                                margin: '5px',
                                                                name: 'other_cardiovascular',
                                                                fieldLabel: 'Other',
                                                                cols: 100,
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        height: 370,
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'table',
                                                            tableAttrs: {
                                                                border:0,
                                                            },
                                                            columns: 2,
                                                        },
                                                        title: 'Genitourinary',
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
                                                                boxLabel: 'Condom',
                                                                inputValue: 'Condom'
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
                                                                boxLabel: 'IFC',
                                                                inputValue: 'IFC'
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
                                                                boxLabel: 'Suprapub',
                                                                inputValue: 'Suprapub'
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
                                                                boxLabel: 'Odor',
                                                                inputValue: 'Odor'
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
                                                                boxLabel: 'Cloudy',
                                                                inputValue: 'Cloudy'
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
                                                                boxLabel: 'Hematuria',
                                                                inputValue: 'Hematuria'
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
                                                                boxLabel: 'Chills',
                                                                inputValue: 'Chills'
                                                            },
                                                            {
                                                                xtype: 'checkboxfield',
                                                                name: 'genitourinary',
                                                                boxLabel: 'Catheter',
                                                                inputValue: 'Catheter'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                text: ""
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                labelAlign: 'top',
                                                                margin: "5px 0 0 0",
                                                                name: 'other_genitourinary',
                                                                fieldLabel: 'Other',
                                                                cols: 33
                                                            }
                                                        ]
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                height: 520,
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
                                                                        boxLabel: 'Poor Foot Care',
                                                                        inputValue: 'Poor Foot Care'
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
                                                                xtype: 'textareafield',
                                                                label_width: '5',
                                                                name: 'other_endocrine',
                                                                margin: '5px',
                                                                labelAlign: 'top',
                                                                fieldLabel: 'Other',
                                                                cols: 100,
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1.15,
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
                                                                    },
                                                                    {
                                                                        xtype: 'textareafield',
                                                                        label_width: '5',
                                                                        margin: "10px",
                                                                        name: 'other_universal_precautions',
                                                                        labelAlign: 'top',
                                                                        fieldLabel: 'Other',
                                                                        cols: 100,
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1.15,
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
                                                                name: 'ambulates',
                                                                fieldLabel: 'Ambulates in ft.'
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                width: '93%',
                                                                name: 'other_home_bound_status',
                                                                fieldLabel: 'Other',
                                                                labelAlign: 'top',
                                                                cols: 100,
                                                            },
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        margin: '7px',
                                        padding: '3px',
                                        autoScroll: true,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'DC Reason/DC Status/PCG/Visit Details',
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
                                                        title: 'DC Reason',
                                                        items: [
                                                            {
                                                                xtype: 'radiofield',
                                                                anchor: '100%',
                                                                name: 'dc_reason',
                                                                fieldLabel: '',
                                                                boxLabel: 'No further skilled care needed',
                                                                checked: true,
                                                                inputValue: 'No further skilled care needed'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                anchor: '100%',
                                                                name: 'dc_reason',
                                                                fieldLabel: '',
                                                                boxLabel: 'Patient/PCG Refused',
                                                                inputValue: 'Patient/PCG Refused'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                anchor: '100%',
                                                                name: 'dc_reason',
                                                                fieldLabel: '',
                                                                boxLabel: 'Patient Moved Out Of Area',
                                                                inputValue: 'Patient Moved Out Of Area'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                anchor: '100%',
                                                                name: 'dc_reason',
                                                                fieldLabel: '',
                                                                boxLabel: 'Patient Admitted to Hospital',
                                                                inputValue: 'Patient Admitted to Hospital'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                anchor: '100%',
                                                                name: 'dc_reason',
                                                                fieldLabel: '',
                                                                boxLabel: 'Physician\'s request',
                                                                inputValue: 'Physician\'s request'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                anchor: '100%',
                                                                name: 'dc_reason',
                                                                fieldLabel: '',
                                                                boxLabel: 'Patient non-compliant with POC',
                                                                inputValue: 'Patient non-compliant with POC'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                anchor: '100%',
                                                                name: 'dc_reason',
                                                                fieldLabel: '',
                                                                boxLabel: 'Repeatedly not found at home',
                                                                inputValue: 'Repeatedly not found at home'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                anchor: '100%',
                                                                name: 'dc_reason',
                                                                fieldLabel: '',
                                                                boxLabel: 'Transferred to another HHA',
                                                                inputValue: 'Transferred to another HHA'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                anchor: '100%',
                                                                name: 'dc_reason',
                                                                fieldLabel: '',
                                                                boxLabel: 'Death',
                                                                inputValue: 'Death'
                                                            },
                                                            {
                                                                xtype: 'fieldcontainer',
                                                                layout: {
                                                                    align: 'middle',
                                                                    type: 'hbox'
                                                                },
                                                                fieldLabel: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'dc_reason',
                                                                        fieldLabel: '',
                                                                        labelPad: 0,
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
                                                                checked: true,
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
                                            },
                                        ] + medication_review_form
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
