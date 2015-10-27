/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.PatientPrimaryWoundType', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.patientPrimaryWoundType',
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
                            height: 900,
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
    ]
})
