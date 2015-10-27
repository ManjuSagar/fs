# Custom user form (predefined model and layout)
class Documents::PlanOfCareFormV2 < Documents::AbstractDocumentForm

  def configuration
    c = super
    c.merge(
        model: "PlanOfCare",
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
                        border: 0,
                        frame: false,
                        style: 'color:green;',
                        focusOnToFront: false,
                        layout: {
                            type: 'border'
                        },
                        bodyBorder: false,
                        bodyPadding: 10,
                        closable: false,
                        collapsible: false,
                        manageHeight: false,
                        title: '',
                        paramsAsHash: false,
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
                                        autoScroll: false,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'Diagnosis/Medications',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                flex: 1,
                                                border: 0,
                                                height: 713,
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
                                                                title: 'Diagnosis',
                                                                items: [
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: false,
                                                                        layout: {
                                                                            columns: 3,
                                                                            type: 'table'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'principal_icd1',
                                                                                fieldLabel: 'ICD-9-CM ',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 168,
                                                                                name: 'principal_diagnosis1',
                                                                                fieldLabel: 'Principal Diagnosis ',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date1',
                                                                                fieldLabel: 'Date',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'principal_icd2',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 168,
                                                                                name: 'principal_diagnosis2',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date2',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'principal_icd3',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 168,
                                                                                name: 'principal_diagnosis3',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date3',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'principal_icd4',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 168,
                                                                                name: 'principal_diagnosis4',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date4',
                                                                                fieldLabel: ''
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: false,
                                                                        height: 126,
                                                                        layout: {
                                                                            columns: 3,
                                                                            type: 'table'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'surgical_icd1',
                                                                                fieldLabel: 'ICD-9-CM ',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 164,
                                                                                name: 'surgical_procedure1',
                                                                                fieldLabel: 'Surgical Procedure',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'surgical_date1',
                                                                                fieldLabel: 'Date',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'surgical_icd2',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 164,
                                                                                name: 'surgical_procedure2',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'surgical_date2',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'surgical_icd3',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 164,
                                                                                name: 'surgical_procedure3',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'surgical_date3',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'surgical_icd4',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 164,
                                                                                name: 'surgical_procedure4',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'surgical_date4',
                                                                                fieldLabel: ''
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: false,
                                                                        height: 126,
                                                                        layout: {
                                                                            columns: 3,
                                                                            type: 'table'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 150,
                                                                                name: 'pertinent_icd1',
                                                                                fieldLabel: 'ICD-9-CM ',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 168,
                                                                                name: 'pertinent_diagnoses1',
                                                                                fieldLabel: 'Other Pertinent Diagnoses',
                                                                                labelAlign: 'top',
                                                                                grow: false,
                                                                                growMax: 600
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                width: 150,
                                                                                name: 'pertinent_date1',
                                                                                fieldLabel: 'Date',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'pertinent_icd2',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 168,
                                                                                name: 'pertinent_diagnoses2',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'pertinent_date2',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'pertinent_icd3',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 168,
                                                                                name: 'pertinent_diagnoses3',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'pertinent_date3',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'pertinent_icd4',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                width: 168,
                                                                                name: 'pertinent_diagnoses4',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'pertinent_date4',
                                                                                fieldLabel: ''
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
                                                        title: 'Medications',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                name: 'medications',
                                                                fieldLabel: 'Medications: Dose/Frequency/Route (N)ew (C)hanged ',
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
                                        autoScroll: false,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'DME/Safety Measures/Nutritional Req./Allergies',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                flex: 1,
                                                border: 0,
                                                height: 713,
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
                                                                title: 'DME and Supplies',
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
                                                                                name: 'dme',
                                                                                boxLabel: 'None',
                                                                                inputValue: 'None'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Cane',
                                                                                inputValue: 'Cane'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Walker',
                                                                                inputValue: 'Walker'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Wheelchair',
                                                                                inputValue: 'Wheelchair'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Hospital bed',
                                                                                inputValue: 'Hospital bed'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Mobility Scooter',
                                                                                inputValue: 'Mobility Scooter'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Comode',
                                                                                inputValue: 'Comode'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Splint',
                                                                                inputValue: 'Splint'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Brace',
                                                                                inputValue: 'Brace'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Crutches',
                                                                                inputValue: 'Crutches'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Orthotic Device '
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
                                                                title: 'Functional Limitations',
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
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Amputation',
                                                                                inputValue: 'Amputation'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Bowel/Bladder',
                                                                                inputValue: 'Bowel/Bladder'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Contracture',
                                                                                inputValue: 'Contracture'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Hearing',
                                                                                inputValue: 'Hearing'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Paralysis',
                                                                                inputValue: 'Paralysis'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Endurance',
                                                                                inputValue: 'Endurance'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Ambulation',
                                                                                inputValue: 'Ambulation'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Speech',
                                                                                inputValue: 'Speech'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Legally blind ',
                                                                                inputValue: 'Legally blind'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Dyspnea With Minimal Exertion',
                                                                                inputValue: 'Dyspnea With Minimal Exertion'
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        margin: '3px',
                                                                        name: 'other_functional_limitations',
                                                                        fieldLabel: 'Other',
                                                                        labelWidth: 40
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
                                                                title: 'Activities Permitted ',
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
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Complete Bedrest',
                                                                                inputValue: 'Complete Bedrest'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Bedrest BRP',
                                                                                inputValue: 'Bedrest BRP'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Up As Tolerated',
                                                                                inputValue: 'Up As Tolerated'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Transfer Bed/Chair',
                                                                                inputValue: 'Transfer Bed/Chair'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Exercises Prescribed',
                                                                                inputValue: 'Exercises Prescribed'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Partial Weight Bearing',
                                                                                inputValue: 'Partial Weight Bearing'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Independent At Home',
                                                                                inputValue: 'Independent At Home'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Crutches',
                                                                                inputValue: 'Crutches'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Cane',
                                                                                inputValue: 'Cane'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Dyspnea',
                                                                                inputValue: 'Dyspnea'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Wheelchair',
                                                                                inputValue: 'Wheelchair'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                flex: 1,
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Walker',
                                                                                inputValue: 'Walker'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                flex: 1,
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'No Restrictions',
                                                                                inputValue: 'No Restrictions'
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        name: 'other_activities_permitted',
                                                                        fieldLabel: 'Other',
                                                                        labelWidth: 40
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
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
                                                                                boxLabel: 'Comatose',
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
                                                                        name: 'mental_status_other1',
                                                                        fieldLabel: 'Other'
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        margin: '3px',
                                                                        name: 'mental_status_other2',
                                                                        fieldLabel: 'Other'
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
                                                                xtype: 'panel',
                                                                flex: 1,
                                                                border: 0,
                                                                margin: '2px 2px 0px 2px',
                                                                padding: '3px',
                                                                autoScroll: false,
                                                                layout: {
                                                                    type: 'vbox'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        height: 34,
                                                                        width: 649,
                                                                        layout: {
                                                                            align: 'middle',
                                                                            type: 'hbox'
                                                                        },
                                                                        fieldLabel: 'Prognosis',
                                                                        labelAlign: 'right',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.1,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Poor ',
                                                                                checked: true,
                                                                                inputValue: 'Poor'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.15,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Guarded ',
                                                                                inputValue: 'Guarded'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.1,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Fair ',
                                                                                inputValue: 'Fair'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.1,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Good ',
                                                                                inputValue: 'Good'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.15,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Excellent ',
                                                                                inputValue: 'Excellent'
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'textareafield',
                                                                        margin: '3px',
                                                                        padding: ' ',
                                                                        name: 'nutritional_req',
                                                                        fieldLabel: 'Nutritional Req.  ',
                                                                        labelAlign: 'top',
                                                                        cols: 100
                                                                    },
                                                                    {
                                                                        xtype: 'textareafield',
                                                                        height: 84,
                                                                        margin: '3px',
                                                                        name: 'allergies',
                                                                        fieldLabel: 'Allergies ',
                                                                        labelAlign: 'top',
                                                                        cols: 100
                                                                    },
                                                                    {
                                                                        xtype: 'textareafield',
                                                                        flex: 1,
                                                                        margin: '3px',
                                                                        name: 'safety_measures',
                                                                        fieldLabel: 'Safety Measures',
                                                                        labelAlign: 'top',
                                                                        cols: 100
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        margin: '3px',
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'Orders',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                margin: '7px',
                                                title: 'Orders for Discipline and Treatments (Specify Amount/Frequency/Duration)',
                                                items: [
                                                    {
                                                        xtype: 'textareafield',
                                                        margin: '3px',
                                                        name: 'orders',
                                                        fieldLabel: 'Orders ',
                                                        labelAlign: 'top',
                                                        grow: true,
                                                        growMin: 500,
                                                        cols: 120
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        margin: '3px',
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'Goals',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                margin: '7px',
                                                title: 'Goals/Rehabilitation Potential Discharge Plans',
                                                items: [
                                                    {
                                                        xtype: 'textareafield',
                                                        margin: '3px',
                                                        name: 'goals',
                                                        fieldLabel: 'Goals',
                                                        labelAlign: 'top',
                                                        grow: true,
                                                        growMin: 500,
                                                        cols: 120
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        margin: '3px',
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'Miscellaneous',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                margin: '7px',
                                                title: 'Miscellaneous',
                                                items: [
                                                    {
                                                        xtype: 'textareafield',
                                                        margin: '3px',
                                                        name: 'miscellaneous',
                                                        fieldLabel: 'Miscellaneous',
                                                        labelAlign: 'top',
                                                        grow: true,
                                                        growMin: 500,
                                                        cols: 120
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
    )
  end

end