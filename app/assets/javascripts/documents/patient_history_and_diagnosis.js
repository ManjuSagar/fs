/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.PatientHistoryAndDiagnosis', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.patientHistoryAndDiagnosis',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'panel',
            border: 0,
            layout: 'hbox',
            margin: '5px',
            items:[
                {
                    xtype: 'panel',
                    border: 0,
                    margin: '5px',
                    layout: {
                        type: 'vbox',
                    },
                    items: [
                        {
                            xtype: 'label',
                            text: "PHYSICIAN:"
                        },
                        {
                            xtype: "datefield",
                            margin: '10 0 0 20',
                            fieldLabel: "Date last contacted",
                            name: "date_last_contacted",
                            labelWidth: 150,
                            isHeader: false
                        },
                        {
                            xtype: "datefield",
                            margin: '10 0 0 20',
                            labelWidth: 150,
                            name: "date_last_visited",
                            fieldLabel: "Date last visited",
                            isHeader: false
                        },
                    ]
                },
                {
                    xtype: 'textareafield',
                    margin: '3 3 3 5',
                    padding: ' ',
                    fieldLabel: 'PRIMARY REASON FOR HOME HEALTH ',
                    name: "primary_reason_for_home_health",
                    labelAlign: 'top',
                    cols: 50,
                    isHeader: false
                },

            ]
        },

        {
            xtype: 'checkboxgroup',
            fieldLabel: 'HOMEBOUND REASON',
            labelWidth: 160,
            labelAlign: 'top',
            height: 150,
            columns: 2,
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'homebound_reason',
                    boxLabel: 'Needs assistance for all activities',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'homebound_reason',
                    boxLabel: 'Residual weakness',
                    inputValue: '2'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'homebound_reason',
                    boxLabel: 'Requires assistance to ambulate',
                    inputValue: '3'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'homebound_reason',
                    boxLabel: 'Confusion, unable to go out of home alone',
                    inputValue: '4',
                    width: 280
                },
                {
                    xtype: 'checkboxfield',
                    name: 'homebound_reason',
                    boxLabel: 'Unable to safely leave home unassisted',
                    inputValue: '5',
                    width: 280
                },
                {
                    xtype: 'checkboxfield',
                    name: 'homebound_reason',
                    boxLabel: 'Severe SOB, SOB upon exertion',
                    inputValue: '6'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'homebound_reason',
                    boxLabel: 'Dependent upon adaptive device(s)',
                    inputValue: '7'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'homebound_reason',
                    boxLabel: 'Medical restrictions',
                    inputValue: '8'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'homebound_reason',
                    boxLabel: 'Other(specify)',
                    inputValue: '9'
                },
                {
                    xtype: 'textfield',
                    xmargin: '25 5 5 5',
                    name: 'homebound_reason_other',
                },
            ]
        },
        {
            xtype: 'panel',
            margin: '3px',
            layout: {
                type: 'vbox',
            },
            border: 0,
            items: [
                {
                    xtype: 'label',
                    text: 'PERTINENT HISTORY AND/OR PREVIOUS OUTCOMES: (note: dates of onset, exacerbation when known)'
                },
                {
                    xtype: 'label',
                    text: '(Reference M1000, M1005, M1010 and M1012)'
                },
                {

                    xtype: 'checkboxgroup',
                    columns: 5,
                    fieldLabel: '',
                    width: 800,
                    items: [
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Hypertension',
                            inputValue: '1',
                            width: 120,
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Cardiac',
                            inputValue: '2',
                            width: 150,
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Diabetes',
                            inputValue: '3',
                            width: 120,
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Cancer',
                            inputValue: '4',
                            width: 150,
                        },
                        {
                            xtype: 'textfield',
                            name: 'cancer_site',
                            fieldLabel: "Site",
                            isHeader: false,
                            labelWidth: 20,
                            width: 170,
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Respiratory',
                            inputValue: '5'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Osteoporosis',
                            inputValue: '6'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Fractures',
                            inputValue: '7'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Surgeries',
                            inputValue: '8'
                        },
                        {
                            xtype: 'textfield',
                            name: 'surgeries_type',
                            margin: '3 0 0 25'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Infection',
                            inputValue: '9'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Immunosuppressed',
                            inputValue: '10'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'pertinent_history_and_outcomes',
                            boxLabel: 'Open Wound',
                            inputValue: '11'
                        },

                    ]
                },
                {
                    xtype: 'checkboxfield',
                    margin: '0 0 0 3px',
                    name: 'pertinent_history_and_outcomes',
                    boxLabel: 'Other',
                    inputValue: '12'
                },
                {
                    xtype: 'textareafield',
                    margin: '0 0 0 3px',
                    name: 'pertinent_history_and_outcomes_other',
                    fieldLabel: '',
                    cols: 50
                },
            ]
        },
        {
            xtype: 'panel',
            border: 0,
            margin: '5px',
            layout: {
                type: 'vbox',
            },
            items:[
                {
                    xtype: 'label',
                    text: 'IMMUNIZATIONS'
                },
                {
                    xtype: 'checkboxgroup',
                    margin: '0 0 0 40',
                    layout: 'vbox',
                    labelWidth: 300,
                    fieldLabel: 'Check if current: Within the past 12 months',
                    isHeader: false,
                    items: [
                        {
                            xtype: 'checkboxfield',
                            name: 'influenza',
                            boxLabel: 'Influenza',
                            inputValue: '1'
                        }
                    ]
                },
                {
                    xtype: 'checkboxgroup',
                    margin: '0 0 0 40',
                    layout: 'hbox',
                    labelWidth: 250,
                    fieldLabel: 'According to immunization guidelines',
                    isHeader: false,
                    items: [
                        {
                            xtype: 'checkboxfield',
                            name: 'immunization_guidelines',
                            boxLabel: 'Pneumonia',
                            inputValue: '1',
                            width: 100,
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'immunization_guidelines',
                            boxLabel: 'Tetanus',
                            inputValue: '2',
                            width: 100,
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'immunization_guidelines',
                            boxLabel: 'Other',
                            inputValue: '3',
                            width: 100,
                        },
                        {
                            xtype: 'textfield',
                            name: 'immunization_guidelines',
                            fieldLabel: '',
                            xwidth: 150,
                        },
                    ]
                },
                {
                    xtype: 'textfield',
                    margin: '5 0 0 40',
                    name: 'needs',
                    fieldLabel: 'Needs',
                    labelWidth: 40,
                    isHeader: false
                }

            ]
        },
        {
            xtype: 'panel',
            border: 0,
            margin: '5px',
            layout: {
                type: 'hbox',
            },
            items: [
                {
                    xtype: 'panel',
                    border: 0,
                    margin: '5px',
                    layout: {
                        type: 'vbox',
                    },
                    items: [
                        {
                            xtype: 'radiogroup',
                            xmargin: '5px',
                            layout: {
                                align: 'stretch',
                                type: 'hbox'
                            },
                            width: 400,
                            height: 20,
                            labelWidth: 180,
                            fieldLabel: 'PRIOR HOSPITALIZATIONS',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'hospitalizations',
                                    boxLabel: 'No',
                                    inputValue: '1',
                                    width: 60,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'hospitalizations',
                                    boxLabel: 'Yes',
                                    inputValue: '2',
                                    width: 60,
                                },
                            ]
                        },
                        {
                            xtype: 'textfield',
                            margin: '5px',
                            name: 'number_of_times',
                            fieldLabel: 'Number of times',
                            labelWidth: 150,
                            isHeader: false

                        }

                    ]
                },
                {
                    xtype: 'textareafield',
                    name: 'reasons',
                    fieldLabel: 'Reason(s)/Date(s)',
                    labelAlign: 'top',
                    margin: "3px",
                    isHeader: false,
                    cols: 50
                },

            ]

        },
        {
            xtype: 'radiogroup',
            fieldLabel: 'PROGNOSIS',
            labelWidth: 160,
            labelAlign: 'top',
            width: 500,
            layout: {
                type: 'hbox'
            },
            defaults:{
                width: 100
            },
            items: [
                {
                    xtype: 'radiofield',
                    name: 'prognosis',
                    boxLabel: '1-Poor',
                    inputValue: '1'
                },
                {
                    xtype: 'radiofield',
                    name: 'prognosis',
                    boxLabel: '2-Guarded',
                    inputValue: '2'
                },
                {
                    xtype: 'radiofield',
                    name: 'prognosis',
                    boxLabel: '3-Fair',
                    inputValue: '3'
                },
                {
                    xtype: 'radiofield',
                    name: 'prognosis',
                    boxLabel: '4-Good',
                    inputValue: '4'
                },
                {
                    xtype: 'radiofield',
                    name: 'prognosis',
                    boxLabel: '5-Excellent',
                    inputValue: '5'
                }
            ]
        },
   ]

})
