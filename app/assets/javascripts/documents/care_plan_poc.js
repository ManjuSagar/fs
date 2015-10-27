/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.CarePlanPoc', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.carePlanPoc',
    border: false,
    margin: 5,
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
                    xtype: 'fieldset',
                    flex: 1,
                    margin: '5px',
                    title: 'Intensity: (using scales below)',
                    items: [
                        {
                            xtype: 'label',
                            margin: '150 5 5 150',
                            padding: '5px',
                            shrinkWrap: 3,
                            text: 'Wong-Baker FACES Pain Rating Scale'
                        },
                        {
                            xtype: 'image',
                            border: false,
                            height: 140,
                            width: 500,
                            src: '/assets/wong1.jpg'
                        },
                        {
                            xtype: 'slider',
                            margin: '0 0 0 50',
                            width: 395,
                            fieldLabel: '',
                            name: 'pain_scale',
                            value: 0,
                            increment: 1,
                            maxValue: 10
                        },
                        {
                            xtype: 'image',
                            margin: '5px',
                            width: 470,
                            src: '/assets/copy_rights.png'
                        },
                        {
                            xtype: 'checkboxgroup',
                            width: 571,
                            fieldLabel: 'Collected using',
                            layout: {
                                type: 'checkboxgroup',
                                autoFlex: false
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'intensity_scale',
                                    boxLabel: 'FACES Scale',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 0 0 5',
                                    name: 'intensity_scale',
                                    boxLabel: '0 - 10 Scale (subjective reporting)',
                                    inputValue: '2'
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: 'fieldset',
                    flex: 1,
                    margin: '5px',
                    title: 'Patient Pain',
                    items: [
                        {
                            xtype: 'checkboxfield',
                            anchor: '100%',
                            fieldLabel: '',
                            name: 'patient_pain',
                            boxLabel: '<b>No Problem</b>',
                            inputValue: 'NP'
                        },
                        {
                            xtype: 'radiogroup',
                            fieldLabel: 'Is patient experiencing pain?',
                            labelSeparator: ' ',
                            labelWidth: 180,
                            layout: {
                                type: 'hbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'patient_experiencing',
                                    boxLabel: 'Yes',
                                    inputValue: 'Y'
                                },
                                {
                                    xtype: 'radiofield',
                                    margin: '0 0 0 5px',
                                    name: 'patient_experiencing',
                                    boxLabel: 'No',
                                    inputValue: 'N'
                                }
                            ]
                        },
                        {
                            xtype: 'checkboxfield',
                            anchor: '100%',
                            fieldLabel: '',
                            name: 'patient_pain',
                            boxLabel: 'Unable to communicate',
                            inputValue: '1'
                        },
                        {
                            xtype: 'checkboxgroup',
                            fieldLabel: 'Non -  verbals demonstrated',
                            labelWidth: 180,
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'patient_pain',
                                    boxLabel: 'Diaphoresis',
                                    inputValue: '2'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'patient_pain',
                                    boxLabel: 'Grimacing',
                                    inputValue: '3'
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            border: false,
                            layout: 'column',
                            header: false,
                            title: 'My Panel',
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    width: 75,
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Moaning',
                                    inputValue: '4'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Crying',
                                    inputValue: '5'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 5',
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Guarding',
                                    inputValue: '6'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 0',
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Irritability',
                                    inputValue: '7'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 10 0 0',
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Anger',
                                    inputValue: '8'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Tense',
                                    inputValue: '9'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    width: 100,
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Restlessness',
                                    inputValue: '10'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 5',
                                    width: 140,
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Change in vital signs',
                                    inputValue: '11'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 5 0 0',
                                    width: 120,
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Self-assessment',
                                    inputValue: '12'
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
                                columns: 2
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'patient_pain',
                                    boxLabel: 'Other',
                                    inputValue: '13'
                                },
                                {
                                    xtype: 'textfield',
                                    margin: '0 0 0 5px',
                                    fieldLabel: '',
                                    name: 'other_patient_pain'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    labelWidth: 150,
                                    name: 'patient_pain',
                                    boxLabel: 'Implications',
                                    inputValue: '14'
                                },
                                {
                                    xtype: 'textareafield',
                                    height: 56,
                                    margin: '0 0 0 5px',
                                    width: 376,
                                    fieldLabel: '',
                                    name: 'implications_patient_pain'
                                }
                            ]
                        },
                        {
                            xtype: 'textareafield',
                            anchor: '100%',
                            height: 78,
                            fieldLabel: 'How does the pain interfere/impact their functional/activity level? (explain)',
                            labelAlign: 'top',
                            name: 'pain_interfere'
                        }
                    ]
                }
            ]
        },
        {
            xtype: 'panel',
            flex: 1,
            border: false,
            height: 396,
            shrinkWrapDock: 3,
            header: false,
            title: 'My Panel',
            items: [
                {
                    xtype: 'tabpanel',
                    deferredRender: false,
                    plain: true,
                    items: [
                        {
                            xtype: 'panel',
                            title: 'Pain Assessment',
                            items: [
                                {
                                    xtype: 'fieldset',
                                    margin: '5px',
                                    title: 'Pain Assessment',
                                    layout: {
                                        type: 'vbox',
                                        align: 'stretch'
                                    },
                                    items: [
                                        {
                                            xtype: 'panel',
                                            border: false,
                                            height: 36,
                                            layout: 'column',
                                            header: false,
                                            title: 'My Panel',
                                            items: [
                                                {
                                                    xtype: 'label',
                                                    height: 13,
                                                    margin: '0 0 0 20px',
                                                    shrinkWrap: 3,
                                                    width: 34
                                                },
                                                {
                                                    xtype: 'label',
                                                    height: 16,
                                                    width: 148,
                                                    text: 'Location'
                                                },
                                                {
                                                    xtype: 'label',
                                                    height: 16,
                                                    width: 140,
                                                    text: 'Onset'
                                                },
                                                {
                                                    xtype: 'label',
                                                    height: 16,
                                                    width: 61,
                                                    text: 'Intensity (0-10)'
                                                },
                                                {
                                                    xtype: 'label',
                                                    height: 16,
                                                    width: 75,
                                                    text: 'Worst Pain Gets (0-10)'
                                                },
                                                {
                                                    xtype: 'label',
                                                    height: 16,
                                                    width: 75,
                                                    text: 'Best Pain Gets (0-10)'
                                                },
                                                {
                                                    xtype: 'label',
                                                    height: 16,
                                                    width: 132,
                                                    text: 'Description'
                                                },
                                                {
                                                    xtype: 'label',
                                                    height: 16,
                                                    width: 149,
                                                    text: 'Aggravating Factors'
                                                },
                                                {
                                                    xtype: 'label',
                                                    height: 16,
                                                    width: 75,
                                                    text: 'Relieving Factors'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: false,
                                            layout: 'table',
                                            header: false,
                                            title: 'My Panel',
                                            items: [
                                                {
                                                    xtype: 'textfield',
                                                    width: 42,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    value: 1,
                                                    readOnly: true,
                                                    emptyText: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    labelWidth: 50,
                                                    name: 'pain_location1'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_onset1'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_intensity1',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_worst1',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_best1',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 126,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_description1'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_aggravating_factors1'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_relieving_factors1'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: false,
                                            layout: 'table',
                                            header: false,
                                            title: 'My Panel',
                                            items: [
                                                {
                                                    xtype: 'textfield',
                                                    width: 42,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    value: 2,
                                                    readOnly: true,
                                                    emptyText: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    labelWidth: 50,
                                                    name: 'pain_location2'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_onset2'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_intensity2',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_worst2',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_best2',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 126,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_description2'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_aggravating_factors2'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_relieving_factors2'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: false,
                                            layout: 'table',
                                            header: false,
                                            title: 'My Panel',
                                            items: [
                                                {
                                                    xtype: 'textfield',
                                                    width: 42,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    value: 3,
                                                    readOnly: true,
                                                    emptyText: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    labelWidth: 50,
                                                    name: 'pain_location3'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_onset3'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_intensity3',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_worst3',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_best3',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 126,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_description3'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_aggravating_factors3'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_relieving_factors3'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: false,
                                            layout: 'table',
                                            header: false,
                                            title: 'My Panel',
                                            items: [
                                                {
                                                    xtype: 'textfield',
                                                    width: 42,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    value: 4,
                                                    readOnly: true,
                                                    emptyText: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    labelWidth: 50,
                                                    name: 'pain_location4'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_onset4'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_intensity4',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_worst4',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_best4',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 126,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_description4'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_aggravating_factors4'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_relieving_factors4'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: false,
                                            layout: 'table',
                                            header: false,
                                            title: 'My Panel',
                                            items: [
                                                {
                                                    xtype: 'textfield',
                                                    width: 42,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    value: 5,
                                                    readOnly: true,
                                                    emptyText: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    labelWidth: 50,
                                                    name: 'pain_location5'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_onset5'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_intensity5',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_worst5',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_best5',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 126,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_description5'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_aggravating_factors5'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_relieving_factors5'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'panel',
                                            border: false,
                                            layout: 'table',
                                            header: false,
                                            title: 'My Panel',
                                            items: [
                                                {
                                                    xtype: 'textfield',
                                                    width: 42,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    value: 6,
                                                    readOnly: true,
                                                    emptyText: ''
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    labelWidth: 50,
                                                    name: 'pain_location6'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_onset6'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_intensity6',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_worst6',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 74,
                                                    labelAlign: 'right',
                                                    name: 'pain_best6',
                                                    value: '/10',
                                                    fieldStyle: 'text-align: right'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    width: 126,
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_description6'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_aggravating_factors6'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    labelAlign: 'top',
                                                    name: 'pain_relieving_factors6'
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            title: 'Frequency',
                            items: [
                                {
                                    xtype: 'fieldset',
                                    margin: '5px',
                                    title: 'Frequency',
                                    items: [
                                        {
                                            xtype: 'checkboxgroup',
                                            fieldLabel: 'Frequency',
                                            columns: 'auto',
                                            layout: {
                                                type: 'checkboxgroup',
                                                autoFlex: false
                                            },
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'pain_frequency',
                                                    boxLabel: 'Occassionally',
                                                    inputValue: '1'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    margin: '0 5 0 5',
                                                    name: 'pain_frequency',
                                                    boxLabel: 'Continuous',
                                                    inputValue: '2'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'pain_frequency',
                                                    boxLabel: 'Intermittent',
                                                    inputValue: '3'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'checkboxgroup',
                                            width: 738,
                                            fieldLabel: 'What makes pain better?',
                                            labelWidth: 180,
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'pain_better',
                                                    boxLabel: 'Movement',
                                                    inputValue: '1'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'pain_better',
                                                    boxLabel: 'Ambulation',
                                                    inputValue: '2'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'pain_better',
                                                    boxLabel: 'Immobility',
                                                    inputValue: '3'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'pain_better',
                                                    boxLabel: 'Other',
                                                    inputValue: '4'
                                                },
                                                {
                                                    xtype: 'textfield',
                                                    fieldLabel: '',
                                                    name: 'pain_better_other'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'textfield',
                                            width: 605,
                                            fieldLabel: 'Is there a pattern to the pain? (explain)',
                                            labelWidth: 230,
                                            name: 'pain_pattern'
                                        },
                                        {
                                            xtype: 'checkboxgroup',
                                            fieldLabel: 'How often is breakthrough medication needed?',
                                            labelWidth: 280,
                                            layout: {
                                                type: 'checkboxgroup',
                                                autoFlex: false
                                            },
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'medication_needed',
                                                    boxLabel: 'Never',
                                                    inputValue: '1'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    margin: '0 5 0 5',
                                                    name: 'medication_needed',
                                                    boxLabel: 'Less than daily',
                                                    inputValue: '2'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'medication_needed',
                                                    boxLabel: '2-3 times/day',
                                                    inputValue: '3'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    margin: '0 5 0 5',
                                                    name: 'medication_needed',
                                                    boxLabel: 'More than 3 times/day',
                                                    inputValue: '4'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'checkboxgroup',
                                            width: 472,
                                            fieldLabel: 'Does the pain radiate?',
                                            labelWidth: 150,
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'pain_radiate',
                                                    boxLabel: 'Occasionally',
                                                    inputValue: '1'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'pain_radiate',
                                                    boxLabel: 'Continuously',
                                                    inputValue: '2'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'pain_radiate',
                                                    boxLabel: 'Intermittent',
                                                    inputValue: '3'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'radiogroup',
                                            width: 417,
                                            fieldLabel: 'Current pain control medications adequate',
                                            labelWidth: 280,
                                            items: [
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'medication_adequate',
                                                    boxLabel: 'Yes',
                                                    inputValue: 'Y'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'medication_adequate',
                                                    boxLabel: 'No',
                                                    inputValue: 'N'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'textfield',
                                            width: 603,
                                            fieldLabel: 'Comment',
                                            name: 'comment'
                                        },
                                        {
                                            xtype: 'radiogroup',
                                            width: 307,
                                            fieldLabel: 'Implications Care Plan',
                                            labelWidth: 180,
                                            items: [
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'implications_care_plan',
                                                    boxLabel: 'Yes',
                                                    inputValue: 'Y'
                                                },
                                                {
                                                    xtype: 'radiofield',
                                                    name: 'implications_care_plan',
                                                    boxLabel: 'No',
                                                    inputValue: 'N'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'checkboxgroup',
                                            width: 399,
                                            fieldLabel: 'Has the physician been notified by the',
                                            labelWidth: 235,
                                            items: [
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'notified_by',
                                                    boxLabel: 'Patient',
                                                    inputValue: '1'
                                                },
                                                {
                                                    xtype: 'checkboxfield',
                                                    name: 'notified_by',
                                                    boxLabel: 'Staff',
                                                    inputValue: '2'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'textfield',
                                            anchor: '100%',
                                            fieldLabel: 'What was the outcome?',
                                            labelWidth: 150,
                                            name: 'outcome'
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ],
    afterRender: function(){
        this.callParent();
        var fieldSet = this.query('[title=Patient Pain]')[0];
        var noProblem = fieldSet.query("[boxLabel=<b>No Problem</b>]")[0];
        noProblem.on("change", function(ele){
            var fields = fieldSet.query("textfield, textareafield, datefield, numberfield, checkboxgroup, radiogroup, checkboxfield, radiofield");
            Ext.each(fields, function(e){
                if(noProblem != e && noProblem.checked == true){
                    if(e.xtype == "radiofield" || e.xtype == "checkboxfield"){
                        e.disable().setValue(false);
                    } else {
                        e.disable().setValue();
                    }
                } else {
                    e.enable();
                }
            }, this);
        },this)
    }
})
