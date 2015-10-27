# Custom user form (predefined model and layout)
class Documents::MSWEvaluationForm < Documents::AbstractDocumentForm

  def configuration
    c = super
    @prev_eval_document = PatientTreatment.find(c[:treatment_id]).documents.find_all_by_document_type("MSWEvaluation").last if c[:treatment_id]
    c.merge(
        model: "MSWEvaluation",
        bbar: ["->", :previous_evaluation_report.action],
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
                                                height: 354,
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
                                                        title: 'Patient Lives',
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
                                                                        name: 'patient_lives',
                                                                        boxLabel: 'Alone',
                                                                        inputValue: 'Alone'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'patient_lives',
                                                                        boxLabel: 'With Friend/Family',
                                                                        inputValue: 'With Friend/Family'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'patient_lives',
                                                                        boxLabel: 'With Dependent',
                                                                        inputValue: 'With Dependent'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'patient_lives',
                                                                        boxLabel: 'With Spouse/Partner',
                                                                        inputValue: 'With Spouse/Partner'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'patient_lives',
                                                                        boxLabel: 'With Religious Community',
                                                                        inputValue: 'With Religious Community'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'patient_lives',
                                                                        boxLabel: 'Assisted Living',
                                                                        inputValue: 'Assisted Living'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'patient_lives',
                                                                        boxLabel: 'With Partner',
                                                                        inputValue: 'With Partner'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'patient_lives',
                                                                        boxLabel: 'Has Paid Caregiver',
                                                                        inputValue: 'Has Paid Caregiver'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'patient_lives',
                                                                        boxLabel: 'Has Live-In, Paid Caregiver',
                                                                        inputValue: 'Has Live-In, Paid Caregiver'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'other_patient_lives',
                                                                fieldLabel: 'Other'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'quality_of_care',
                                                                fieldLabel: 'Quality Of Care'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'env_conditions',
                                                                fieldLabel: 'Environ. Conds.'
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
                                                        title: 'Reason(s) for Referral',
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
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Assessment for Psychosocial Coping',
                                                                        inputValue: 'Assessment for Psychosocial Coping'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Counseling re Disease Process or Management',
                                                                        inputValue: 'Counseling re Disease Process or Management'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Lives Alone, No Identified Caregiver',
                                                                        inputValue: 'Lives Alone, No Identified Caregiver'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Solo Caregiver for Minor Children/Other Dependents',
                                                                        inputValue: 'Solo Caregiver for Minor Children/Other Dependents'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Family/Caregiver Coping Support',
                                                                        inputValue: 'Family/Caregiver Coping Support'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Reported Noncompliance to Medical Plan of Care',
                                                                        inputValue: 'Reported Noncompliance to Medical Plan of Care'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Hospice Eligibility',
                                                                        inputValue: 'Hospice Eligibility'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Suspected Negligence or Abuse',
                                                                        inputValue: 'Suspected Negligence or Abuse'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Financial/Practical Resources',
                                                                        inputValue: 'Financial/Practical Resources'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'reasons_for_referral',
                                                                        boxLabel: 'Assistance with Advanced Directive / DPOA/DNR',
                                                                        inputValue: 'Assistance with Advanced Directive / DPOA/DNR'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'other_reasons_for_referral',
                                                                fieldLabel: 'Other'
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
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        margin: '3px',
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
                                                                margin: '3px',
                                                                name: 'other_emotional_status',
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
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        margin: '3px',
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
                                        title: 'Financial Assessment',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                flex: 1,
                                                border: 0,
                                                height: 571,
                                                margin: '0 0 0 3px',
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
                                                                margins: '0 3px 0 0',
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'hbox'
                                                                },
                                                                title: 'Income Sources',
                                                                items: [
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: 0,
                                                                        layout: {
                                                                            columns: 2,
                                                                            type: 'table'
                                                                        },
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
                                                                                        height: 16,
                                                                                        width: 31,
                                                                                        text: ''
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        height: 17,
                                                                                        width: 128,
                                                                                        text: '     Income Sources'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        height: 15,
                                                                                        width: 42,
                                                                                        text: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        height: 15,
                                                                                        width: 34,
                                                                                        text: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        height: 17,
                                                                                        width: 46,
                                                                                        text: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                text: 'Amount'
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Employment',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'employment',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'employment',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'employment',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'employment_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Pt Social Security',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'pt_social_security',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'pt_social_security',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'pt_social_security',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'pt_social_security_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Spouse Social Security',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'spouse_social_security',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'spouse_social_security',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'spouse_social_security',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'spouse_social_security_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Pt SSI',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'pt_ssi',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'pt_ssi',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'pt_ssi',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'pt_ssi_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Spouse SSI',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'spouse_ssi',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'spouse_ssi',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'spouse_ssi',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'spouse_ssi_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Pensions',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'pensions',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'pensions',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'pensions',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'pensions_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Other Income',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'other_income',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'other_income',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'other_income',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'other_income_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Food Stamps',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'food_stamps',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'food_stamps',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'food_stamps',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'food_stamps_amount',
                                                                                fieldLabel: ''
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
                                                                                        xtype: 'label',
                                                                                        height: 13,
                                                                                        width: 66,
                                                                                        text: ''
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        width: 78,
                                                                                        text: 'Total Income'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'total_income',
                                                                                fieldLabel: ''
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margins: '0 0 0 3px',
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'hbox'
                                                                },
                                                                title: 'Assets',
                                                                items: [
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: 0,
                                                                        layout: {
                                                                            columns: 2,
                                                                            type: 'table'
                                                                        },
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
                                                                                        height: 16,
                                                                                        width: 81,
                                                                                        text: ''
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        height: 18,
                                                                                        width: 77,
                                                                                        text: 'Assets'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        height: 15,
                                                                                        width: 42,
                                                                                        text: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        height: 15,
                                                                                        width: 34,
                                                                                        text: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        height: 17,
                                                                                        width: 46,
                                                                                        text: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                text: 'Amount'
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Savings Account',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'savings_account',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'savings_account',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'savings_account',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'savings_account_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Owns Home (value)',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'owns_home',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'owns_home',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'owns_home',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'owns_home_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Owns Other Property(value)',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'owns_other',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'owns_other',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'owns_other',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'owns_other_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'VA Aid & Assistance',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'va_assistance',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'va_assistance',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'va_assistance',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'va_assistance_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Spouse SSI',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'spouse_assets_ssi',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'spouse_assets_ssi',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'spouse_assets_ssi',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'spouse_assets_ssi_amount',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                width: 286,
                                                                                fieldLabel: 'Other Assets',
                                                                                labelAlign: 'right',
                                                                                labelWidth: 150,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'other_assets',
                                                                                        boxLabel: '',
                                                                                        checked: true,
                                                                                        inputValue: 'N/A'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'other_assets',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'No'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'other_assets',
                                                                                        boxLabel: '',
                                                                                        inputValue: 'Yes'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'other_assets_amount',
                                                                                fieldLabel: ''
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
                                                                                        xtype: 'label',
                                                                                        height: 13,
                                                                                        width: 66,
                                                                                        text: ''
                                                                                    },
                                                                                    {
                                                                                        xtype: 'label',
                                                                                        width: 78,
                                                                                        text: 'Total Assets'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'textfield',
                                                                                name: 'total_assets',
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
                                        title: 'Interventions/Goals/Identified Problems',
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
                                                        margin: '0 3px 0 0',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        title: 'Interventions',
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
                                                                    },
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
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'other_interventions',
                                                                fieldLabel: 'Other'
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        margin: '0 0 0 3px',
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
                                                                name: 'other_goals',
                                                                fieldLabel: 'Other'
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
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        title: 'Identified Problems',
                                                        items: [
                                                            {
                                                                xtype: 'panel',
                                                                flex: 1,
                                                                border: 0,
                                                                layout: {
                                                                    align: 'middle',
                                                                    type: 'hbox'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxgroup',
                                                                        flex: 1,
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs a meal prepared or delivered daily',
                                                                                inputValue: 'Patient needs a meal prepared or delivered daily'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs assistance with housekeeping/shopping',
                                                                                inputValue: 'Patient needs assistance with housekeeping/shopping'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs daily contact to check on him/her',
                                                                                inputValue: 'Patient needs daily contact to check on him/her'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs assistance with alert device (ERS, PRS)',
                                                                                inputValue: 'Patient needs assistance with alert device (ERS, PRS)'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs transportation assistance to medical care',
                                                                                inputValue: 'Patient needs transportation assistance to medical care'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs alternative living arrangements',
                                                                                inputValue: 'Patient needs alternative living arrangements'
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxgroup',
                                                                        flex: 1,
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient/family reported noncompliant to plan of care',
                                                                                inputValue: 'Patient/family reported noncompliant to plan of care'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs assistance with advanced directives',
                                                                                inputValue: 'Patient needs assistance with advanced directives'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs assistance with medical/insurance forms',
                                                                                inputValue: 'Patient needs assistance with medical/insurance forms'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs assistance with entitlement forms',
                                                                                inputValue: 'Patient needs assistance with entitlement forms'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Patient needs alternative living arrangements',
                                                                                inputValue: 'Patient needs alternative living arrangements'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'identified_problems',
                                                                                boxLabel: 'Psychosocial counseling indicated',
                                                                                inputValue: 'Psychosocial counseling indicated'
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'further_problems',
                                                                fieldLabel: 'Provide further information',
                                                                labelWidth: 180
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'Strengths/Intevention Details/Plan Of Care',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                margin: '7px',
                                                layout: {
                                                    type: 'vbox'
                                                },
                                                title: 'Identified Strength/intervention Details/Plan of Care',
                                                items: [
                                                    {
                                                        xtype: 'textareafield',
                                                        name: 'identified_strengths',
                                                        fieldLabel: 'Identified Strengths and Supports',
                                                        labelAlign: 'top',
                                                        cols: 100
                                                    },
                                                    {
                                                        xtype: 'textareafield',
                                                        name: 'intervention_details',
                                                        fieldLabel: 'Intervention Details',
                                                        labelAlign: 'top',
                                                        cols: 100
                                                    },
                                                    {
                                                        xtype: 'textareafield',
                                                        name: 'plan_of_care',
                                                        fieldLabel: 'Plan of Care',
                                                        labelAlign: 'top',
                                                        cols: 100
                                                    },
                                                    {
                                                        xtype: 'textareafield',
                                                        name: 'visit_goal_details',
                                                        fieldLabel: 'Visit Goal Details',
                                                        labelAlign: 'top',
                                                        cols: 100
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

  action :previous_evaluation_report, text: "View Last Evaluation"


  js_method :init_component, <<-JS
    function(){
      this.callParent();
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
      report_url = "/reports/pre_generated"
      report_title = "Patient : #{treatment.to_s}, Certification Period - #{certification_period}"
      {:launch_previous_evaluation_report => [report_url, report_title]}
    end
  end

end
