class Documents::SNEvaluationForm < Documents::AbstractDocumentForm

    def configuration
        c = super
        @prev_eval_document = PatientTreatment.find(c[:treatment_id]).documents.find_all_by_document_type('SNEvaluation').last if c[:treatment_id]
        @record_id = c[:record_id] if c[:record_id]
        @document = SNEvaluation.find(@record_id) if @record_id
        c.merge(
            model: "SNEvaluation",
            show_last_evaluation_action: true,
            wound_panel_next_seq: wound_panel_next_seq,
            item_id: "evaluation",
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
                                itemId: 'topTab',
                                tab_change_event_registered: false,
                                items: [
                                    {
                                        xtype: 'panel',
                                        height: 692,
                                        title: 'Pain/PCG/Complaints/Problems/Interventions',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                height: 223,
                                                margin: '7px',
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
                                                        margin: '0 0 3px 5px',
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
                                                        fieldLabel: 'Frequency',
                                                        margin: '0 0 3px 3px',
                                                        labelAlign: 'top'
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'description1',
                                                        fieldLabel: '	 Description:',
                                                        margin: '0 0 3px 3px',
                                                        labelAlign: 'top'
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'aggravating_factors1',
                                                        fieldLabel: 'Aggravating Factors',
                                                        margin: '0 0 3px 3px',
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
                                        height: 800,
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
                                                                fieldLabel: 'Clear Bilaterally'
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
                                                                        inputValue: 'Good',
                                                                        checked: true
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
                                                            },
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
                                                                width: 200,
                                                                inputValue: 'Aphasic',
                                                            },
                                                            {
                                                                xtype: 'checkboxfield',
                                                                name: 'neurological',
                                                                boxLabel: 'Grips unequal',
                                                                width: 200,
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
                                                                labelWidth: 38,
                                                                margin: '6px',
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
                                    },
                                    {
                                        xtype: 'panel',
                                        autoScroll: true,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        itemId: 'woundTab',
                                        title: 'Wound',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                itemId: 'wound',
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'vbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        height: 601,
                                                        border: 0,
                                                        margin: '3px',
                                                        autoScroll: true,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'vbox'
                                                        },
                                                        title: 'Patient Primary Wound Type',
                                                        items: [
                                                            {
                                                                xtype: 'panel',
                                                                flex: 1,
                                                                border: 0,
                                                                width: 967,
                                                                autoScroll: true,
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'hbox'
                                                                },
                                                                manageHeight: false,
                                                                items: [
                                                                    {
                                                                        xtype: 'panel',
                                                                        flex: 1,
                                                                        border: 0,
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'fieldset',
                                                                                flex: 1.7,
                                                                                margin: 3,
                                                                                title: 'PRESSURE ULCER',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: '',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'pressure_ulcer_stage',
                                                                                                labelClsExtra: 'heading',
                                                                                                boxLabel: 'Stage l',
                                                                                                inputValue: '1'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'pressure_ulcer_stage',
                                                                                                labelClsExtra: 'heading',
                                                                                                boxLabel: 'Stage ll',
                                                                                                inputValue: '2'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'pressure_ulcer_stage',
                                                                                                labelClsExtra: 'heading',
                                                                                                boxLabel: 'Stage lll',
                                                                                                inputValue: '3'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'pressure_ulcer_stage',
                                                                                                labelClsExtra: 'heading',
                                                                                                boxLabel: 'Stage lV',
                                                                                                inputValue: '4'
                                                                                            }
                                                                                        ]
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: '1. Is the patient being turned/positioned?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'patient_turned',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'patient_turned',
                                                                                                boxLabel: 'No',
                                                                                                inputValue: 'no'
                                                                                            }
                                                                                        ]
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: '2. Has a group of 2 or 3 surface been used for ulcer located on the posterior trunk or pelvis?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'pelvis_surface',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'pelvis_surface',
                                                                                                boxLabel: 'No',
                                                                                                inputValue: 'no'
                                                                                            }
                                                                                        ]
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: '3. Are moisture and/or incontinence being managed?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'moisture',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'moisture',
                                                                                                boxLabel: 'No',
                                                                                                inputValue: 'no'
                                                                                            }
                                                                                        ]
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: '4. Is pressure ulcer greater than 30 days?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'pressure_gt_30_days',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'pressure_gt_30_days',
                                                                                                boxLabel: 'No',
                                                                                                inputValue: 'no'
                                                                                            }
                                                                                        ]
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'fieldset',
                                                                                flex: 0.5,
                                                                                margin: 3,
                                                                                title: 'ARTERIAL ULCER/ARTERIAL INSUFFICIENCY',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: '1. Is pressure over the wound being relieved?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'arterial_ulcer',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'arterial_ulcer',
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
                                                                                height: 164,
                                                                                title: 'Please Complete if Applicable',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: '1. Is wound a direct result of an accident?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'wound_accident',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'wound_accident',
                                                                                                boxLabel: 'No',
                                                                                                inputValue: 'no'
                                                                                            }
                                                                                        ]
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        text: 'If Yes, complete the following:'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'datefield',
                                                                                        name: 'date_of_accident',
                                                                                        fieldLabel: 'Date of accident',
                                                                                        labelAlign: 'top'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: 'Accident Type',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'accident_type',
                                                                                                boxLabel: 'Auto',
                                                                                                inputValue: 'auto'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'accident_type',
                                                                                                boxLabel: 'Employment',
                                                                                                inputValue: 'employment'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'accident_type',
                                                                                                boxLabel: 'Trauma',
                                                                                                inputValue: 'trauma'
                                                                                            }
                                                                                        ]
                                                                                    }
                                                                                ]
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'panel',
                                                                        flex: 1,
                                                                        border: 0,
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'fieldset',
                                                                                flex: 1,
                                                                                margin: '0 3px 0 3px',
                                                                                title: 'DIABETIC ULCER/NEUROPATHIC ULCER',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        height: 49,
                                                                                        fieldLabel: '1. Has a reduction of pressure on the foot ulcer been accomplished with appropriate modalities?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'diabetic_ulcer',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'diabetic_ulcer',
                                                                                                boxLabel: 'No',
                                                                                                inputValue: 'no'
                                                                                            }
                                                                                        ]
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'fieldset',
                                                                                flex: 1.5,
                                                                                margin: '0 3px 0 3px',
                                                                                title: 'VENOUS STASIS ULCER/VENOUS INSUFFICIENCY',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        height: 51,
                                                                                        fieldLabel: '1. Are compression bandages and/or garments being consistently applied?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'bandages_applied',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'bandages_applied',
                                                                                                boxLabel: 'No',
                                                                                                inputValue: 'no'
                                                                                            }
                                                                                        ]
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: '2. Is elevation/ambulation being encouraged?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'ambulation_encouraged',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'ambulation_encouraged',
                                                                                                boxLabel: 'No',
                                                                                                inputValue: 'no'
                                                                                            }
                                                                                        ]
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'fieldset',
                                                                                flex: 2,
                                                                                height: 196,
                                                                                margin: '0 3px 3px 3px',
                                                                                title: 'SURGICAL',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiogroup',
                                                                                        fieldLabel: '1. Wound surgically created and not represented by descriptions above?',
                                                                                        labelAlign: 'top',
                                                                                        labelSeparator: ' ',
                                                                                        items: [
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                margin: '0 20px',
                                                                                                name: 'surgically_created',
                                                                                                boxLabel: 'Yes',
                                                                                                inputValue: 'yes'
                                                                                            },
                                                                                            {
                                                                                                xtype: 'radiofield',
                                                                                                name: 'surgically_created',
                                                                                                boxLabel: 'No',
                                                                                                inputValue: 'no'
                                                                                            }
                                                                                        ]
                                                                                    },
                                                                                    {
                                                                                        xtype: 'textfield',
                                                                                        anchor: '100%',
                                                                                        name: 'surgical_procedure',
                                                                                        fieldLabel: '2. Description of surgical procedure:',
                                                                                        labelAlign: 'top'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'datefield',
                                                                                        anchor: '100%',
                                                                                        name: 'surgical_procedure_date',
                                                                                        fieldLabel: '3. Date of surgical procedure involving wound:',
                                                                                        labelAlign: 'top'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'fieldset',
                                                                                flex: 1,
                                                                                margin: 3,
                                                                                title: 'OTHER WOUND TYPE (describe)',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'textareafield',
                                                                                        anchor: '100%',
                                                                                        height: 56,
                                                                                        name: 'other_wound_type',
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
                                                ] + wound_types(@record_id)
                                            },
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                height: 22,
                                                items: [
                                                    {
                                                        xtype: 'numberfield',
                                                        hidden: true,
                                                        itemId: 'total_wound_panels',
                                                        name: 'total_wound_panels',
                                                        value: 0,
                                                        fieldLabel: '',
                                                        minValue: 0
                                                    },
                                                    {
                                                        xtype: 'button',
                                                        itemId: 'add_wound_button',
                                                        text: 'Click to Add Wound Description'
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

    def wound_panel_next_seq
      (wound_panel_indices.sort.last || 0) + 1
    end

    def wound_panel_indices
      if @document
        (1..20).to_a.inject([]) do |result, i|
          if(@document.data.has_key?("wound_type_" + i.to_s))
            result << i
          end
            result
        end
      else
          []
      end
    end

    def wound_types(record_id)
      wound_type_arr = [wound_type_panel("")]
        if record_id
          wound_panel_indices.each {|i|
            wound_type_arr << wound_type_panel(i)
          }
        end
        wound_type_arr
    end

  def wound_type_panel(wound_number)
    {
        xtype: 'panel',
        height: 615,
        itemId: "wound_description_#{wound_number}",
        margin: '3px',
        border: 0,
        layout: {
            align: 'stretch',
            type: 'vbox'
        },
        title: "Wound Description #{wound_number}",
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
                        name: "wound_type_#{wound_number}",
                        margin: '5px',
                        fieldLabel: 'Wound Type:',
                        labelAlign: 'right'
                    },
                    {
                        xtype: 'numberfield',
                        name: "wound_age_#{wound_number}",
                        fieldLabel: 'Age in Months:',
                        labelAlign: 'right',
                        maxValue: 1200,
                        minValue: 1
                    },
                    {
                        xtype: 'textfield',
                        name: "wound_location_#{wound_number}",
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
                                        name: "wound_tissue_present_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_tissue_present_#{wound_number}",
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
                                        name: "wound_debridement_attempted_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_debridement_attempted_#{wound_number}",
                                        boxLabel: 'No',
                                        inputValue: 'no'
                                    }
                                ]
                            },
                            {
                                xtype: 'datefield',
                                width: 180,
                                name: "wound_debridement_date_#{wound_number}",
                                fieldLabel: 'If Yes, debridement date',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                width: 161,
                                name: "wound_debridement_type_#{wound_number}",
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
                                        name: "wound_debridement_required_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_debridement_required_#{wound_number}",
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
                                name: "wound_measurement_date_#{wound_number}",
                                fieldLabel: 'Measurement date:',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                name: "wound_length_#{wound_number}",
                                fieldLabel: 'Length (cm)',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                name: "wound_width_#{wound_number}",
                                fieldLabel: 'Width (cm)',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                name: "wound_depth_#{wound_number}",
                                fieldLabel: 'Depth',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                name: "wound_appearance_of_wound_#{wound_number}",
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
                                name: "wound_exudate_#{wound_number}",
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
                                        name: "wound_thickness_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_thickness_#{wound_number}",
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
                                        name: "wound_muscle_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_muscle_#{wound_number}",
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
                                name: "wound_underminig_#{wound_number}",
                                boxLabel: 'Yes',
                                inputValue: 'yes'
                            },
                            {
                                xtype: 'radiofield',
                                name: "wound_underminig_#{wound_number}",
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
                                name: "wound_undermining_location1_#{wound_number}",
                                fieldLabel: 'Location #1 (cm)',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_undermining_from1_#{wound_number}",
                                fieldLabel: 'From',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_undermining_to1_#{wound_number}",
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
                                name: "wound_undermining_location2_#{wound_number}",
                                fieldLabel: 'Location #2 (cm)',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_undermining_from2_#{wound_number}",
                                fieldLabel: 'From',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_undermining_to2_#{wound_number}",
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
                                name: "wound_tunneling_#{wound_number}",
                                boxLabel: 'Yes',
                                inputValue: 'yes'
                            },
                            {
                                xtype: 'radiofield',
                                name: "wound_tunneling_#{wound_number}",
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
                                name: "wound_tunneling_location1_#{wound_number}",
                                fieldLabel: 'Location #1 (cm)',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_tunneling_from1_#{wound_number}",
                                fieldLabel: 'From',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_tunneling_to1_#{wound_number}",
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
                                name: "wound_tunneling_location2_#{wound_number}",
                                fieldLabel: 'Location #2 (cm)',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_tunneling_from2_#{wound_number}",
                                fieldLabel: 'From',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_tunneling_to2_#{wound_number}",
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
  end


  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var form = this;
      var woundDescriptionPanel = Ext.ComponentQuery.query('#wound_description_')[0];
      Ext.ComponentQuery.query("tab[text=Wound]")[0].addCls('tat-tab-color');
      var woundPanel = Ext.ComponentQuery.query('#wound')[0];
      woundDescriptionPanel.hide();
      var button = Ext.ComponentQuery.query('#add_wound_button')[0];
      var nextSeqNumber = this.woundPanelNextSeq;
      button.on('click', function(){
        createWoundPanel(woundPanel, woundDescriptionPanel, nextSeqNumber);
        nextSeqNumber = nextSeqNumber + 1;
        var tools = Ext.ComponentQuery.query("tool[tooltip=close]");
        Ext.each(tools, function(tool, index){
          tool.on('click', function(){
            this.up('panel').destroy();
          });
        });
      });
      var recordId = this.record.id;
      var getComp = this;
      var mainTab = Ext.ComponentQuery.query('#topTab')[0];
      mainTab.on('tabchange', function(tab, newCard, oldCard) {
        if (newCard.itemId == 'woundTab') {
          if(tab.tabChangeEventRegistered == false)
          {
            var tools = Ext.ComponentQuery.query("tool[tooltip=close]");
            Ext.each(tools, function(tool, index){
              tool.on('click', function(){
                var woundPanelItemId =  this.up('panel').getItemId();
                var splitWoundPanelItemId = woundPanelItemId.split("wound_description_");
                var panelNo = parseInt(splitWoundPanelItemId[1]);
                getComp.deleteWoundPanelData({record_id: recordId, panel_no: panelNo},function(result){
                  if(result)
                  {
                    this.up('panel').destroy();
                  }
                },this);
                });
              });
                tab.tabChangeEventRegistered = true;
          }
        }
      });

      var action = this.actions.previousEvaluationReport;
      if (action) {
        this.checkPrevEvalAvailability({}, function(result){
          action.setDisabled((result == 'q'));
        },this);
      }
    }
  JS


  def netzke_attributes
    netzke_attrs_in_natural_order
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

  endpoint :check_prev_eval_availability do |params|
    {set_result: (@prev_eval_document.present? ? 'p' : 'q')}
  end

  js_method :on_previous_evaluation_report, <<-JS
    function() {
      this.viewPreviousEvaluationReport();
    }
  JS

  endpoint :view_previous_evaluation_report do |params|
    if @prev_eval_document
      treatment = @prev_eval_document.treatment
      certification_period = @prev_eval_document.treatment_episode
      session[:pre_generated_file_name] = @prev_eval_document.combined_reports
      report_url = "/reports/pre_generated"
      report_title = "Patient : #{treatment.to_s}, Certification Period - #{certification_period}"
      {:launch_previous_evaluation_report => [report_url, report_title]}
    end
  end

  endpoint :delete_wound_panel_data do |params|
        doc = SNEvaluation.find(params[:record_id])
        panel_to_delete = params[:panel_no]
        panel_no = panel_to_delete.to_s
        doc_fields_to_delete = ["wound_type_" + panel_no, "wound_age_" + panel_no, "wound_location_" + panel_no,
          "wound_tissue_present_" + panel_no, "wound_debridement_attempted_" + panel_no, "wound_debridement_date_" + panel_no,
          "wound_debridement_type_" + panel_no, "wound_debridement_required_" + panel_no, "wound_measurement_date_" + panel_no,
          "wound_length_" + panel_no, "wound_width_" + panel_no, "wound_depth_" + panel_no, "wound_appearance_of_wound_" + panel_no,
          "wound_exudate_" + panel_no, "wound_thickness_" + panel_no, "wound_muscle_" + panel_no,
          "wound_underminig_" + panel_no, "wound_undermining_location1_" + panel_no, "wound_undermining_from1_" + panel_no,
          "wound_undermining_to1_" + panel_no, "wound_undermining_location2_" + panel_no,
          "wound_undermining_from2_" + panel_no, "wound_undermining_to2_" + panel_no, "wound_tunneling_" + panel_no,
          "wound_tunneling_location1_" + panel_no, "wound_tunneling_from1_" + panel_no, "wound_tunneling_to1_" + panel_no,
          "wound_tunneling_location2_" + panel_no, "wound_tunneling_from2_" + panel_no, "wound_tunneling_to2_" + panel_no]
        doc_fields_to_delete.each do |field|
            doc.data.delete(field)
        end
        doc.save!
        {set_result: true }
  end

end