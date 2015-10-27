/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.poc', {
    extend: 'Ext.tab.Panel',
    alias: 'widget.poc',
    border: 0,
    items: [
        {
            autoScroll: true,
            title: 'Care Coordination And Plan',
            border: 0,
            layout: {
                type: 'table',
                columns: 1,
                tableAttrs: {
                    style: {
                        width: '96%',
                        height:'100%'
                    }
                }
            },
            border: 0,
            width: 500,
            margin: 5,
            items:[

                {
                    xtype: 'fieldset',
                    layout: {
                        type: 'vbox',
                    },

                    xflex: 1,
                    title: 'Care Coordination',
                    items:[
                        {
                            xtype: 'checkboxgroup',
                            layout: {
                                align: 'stretch',
                                type: 'hbox'
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'care_coordination',
                                    boxLabel: 'Physician',
                                    inputValue: '1',
                                    width: 80,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'care_coordination',
                                    boxLabel: "SN",
                                    inputValue: "2",
                                    width: 65,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'care_coordination',
                                    boxLabel: "PT",
                                    inputValue: "3",
                                    width: 65,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'care_coordination',
                                    boxLabel: "OT",
                                    inputValue: "4",
                                    width: 65,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'care_coordination',
                                    boxLabel: "ST",
                                    inputValue: "5",
                                    width: 65,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'care_coordination',
                                    boxLabel: "MSW",
                                    inputValue: "6",
                                    width: 80,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'care_coordination',
                                    boxLabel: "CHHA",
                                    inputValue: "7",
                                    width: 70,
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'care_coordination',
                                    boxLabel: "Other(specify)",
                                    inputValue: "8",
                                    width: 120,
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'other_care_coordination',
                                },
                            ]
                        },
                        {
                            xtype: 'label',
                            text: 'Was a referral made to MSW for assistance with community resources/assistance with a living will /counseling needs (depression /suicidal ideation) and/or unsafe environment?',
                            width: 400,
                            margin: '3px'
                        },
                        {
                            xtype: 'radiogroup',
                            layout: {
                                align: 'stretch',
                                type: 'hbox'
                            },
                            items: [
                                {
                                    xtype: 'datefield',
                                    name: 'care_coord_referral_date',
                                    fieldLabel: 'Date',
                                    labelWidth: 35,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'referral',
                                    boxLabel: 'Yes',
                                    inputValue: 'Y',
                                    margin: '0 0 0 7',
                                    width: 63,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'referral',
                                    boxLabel: 'No',
                                    inputValue: 'N',
                                    width: 65,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'referral',
                                    boxLabel: 'Refused',
                                    inputValue: 'R',
                                    width: 80,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'referral',
                                    boxLabel: 'N/A',
                                    inputValue: 'NA',
                                    width: 72,
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'referral_comment',
                                    fieldLabel: 'Comment',
                                    labelWidth: 114
                                },
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            layout: {
                                align: 'stretch',
                                type: 'hbox'
                            },
                            fieldLabel: 'Verbal Order obtained',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'verbal_order',
                                    boxLabel: 'Yes ',
                                    inputValue: 'Y ',
                                    width: 50,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'verbal_order',
                                    boxLabel: 'No',
                                    inputValue: 'N',
                                    margin: '0 0 0 20',
                                    width: 60,
                                },
                                {
                                    xtype: 'datefield',
                                    name: 'verbal_order_date',
                                    fieldLabel: 'specify date',
                                    labelWidth: 100,
                                },
                            ]
                        }
                    ]
                },
                {
                    xtype: 'fieldset',
                    title: 'Care Plan',
                    items:[
                        {
                            xtype: 'checkboxfield',
                            name: 'care_plan',
                            boxLabel: 'Reviewed with patient involvement',
                            inputValue: '1',

                        }

                    ]
                },
            ]
        },
        {
            autoScroll: true,
            border: 0,
            title: "Goals",
            layout: 'vbox',
            items:[

                {
                    xtype: 'checkboxgroup',
                    margin: '5px',
                    layout: {
                        type: 'vbox'
                    },
                    defaults: {
                        margin: '0 0 0 20',
                    },
                    fieldLabel: 'DISCHARGE PLANS',
                    labelAlign: 'top',
                    items: [
                        {
                            xtype: 'checkboxfield',
                            name: 'discharge_plans',
                            boxLabel: 'Return to an independent level of care(self-care)',
                            inputValue: '1',
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'discharge_plans',
                            boxLabel: "Able to remain in residence with assistance of primary caregiver/ support from community agencies",
                            inputValue: '2',
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'discharge_plans',
                            boxLabel: "When patient knowledgeable about when to notify physician",
                            inputValue: "3",
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'discharge_plans',
                            boxLabel: "Able to understand medication regime and care related to diagnoses",
                            inputValue: "4",
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'discharge_plans',
                            boxLabel: "Medical condition stabilizes",
                            inputValue: "5",
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'discharge_plans',
                            boxLabel: "When maximum functional potential reached",
                            inputValue: "6",
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'discharge_plans',
                            boxLabel: "Discharge at the end of episode if the patient is hospitalized",
                            inputValue: "7",
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'discharge_plans',
                            boxLabel: "Other",
                            inputValue: "8",
                        },
                        {
                            xtype: 'textarea',
                            cols: 80,
                            name: 'other_discharge_plans',
                        },
                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    layout: 'hbox',
                    items:[
                        {
                            xtype: 'radiogroup',
                            fieldLabel: 'DISCUSSED WITH PATIENT',
                            margin: '5px',
                            layout: {
                                align: 'stretch',
                                type: 'hbox'
                            },
                            labelWidth: 200,
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'goals_discussed_with_patient',
                                    boxLabel: 'Yes',
                                    inputValue: 'Y',
                                    width: 60,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'goals_discussed_with_patient',
                                    boxLabel: 'No',
                                    inputValue: 'N',
                                    width: 60,
                                },
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            fieldLabel: 'REHAB POTENTIAL',
                            margin: '5px',
                            layout: {
                                align: 'stretch',
                                type: 'hbox'
                            },
                            labelWidth: 150,
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'rehab_potential',
                                    boxLabel: 'Poor',
                                    inputValue: 'P',
                                    width: 60,

                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'rehab_potential',
                                    boxLabel: 'Fair',
                                    inputValue: 'F',
                                    width: 60,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'rehab_potential',
                                    boxLabel: 'Good',
                                    inputValue: 'G',
                                    width: 60,
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'discussion',
                                    boxLabel: 'Excellent',
                                    inputValue: 'E',
                                    width: 100,
                                }
                            ]
                        }

                    ]
                }





            ]
        }
    ]
})
