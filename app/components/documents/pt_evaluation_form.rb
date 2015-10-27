# Custom user form (predefined model and layout)
class Documents::PTEvaluationForm < Documents::AbstractDocumentForm

  def configuration
    c = super
    @prev_eval_document = PatientTreatment.find(c[:treatment_id]).documents.find_all_by_document_type('PTEvaluation').last if c[:treatment_id]
    c.merge(
        model: "PTEvaluation",
        show_last_evaluation_action: true,
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
                        border: false,
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
                                        autoScroll: true,
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'Problems/Goals/Orders',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                autoScroll: true,
                                                itemId: 'problem_accordions',
                                                layout: {
                                                    fill: false,
                                                    type: 'accordion'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        width: 760,
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapseFirst: false,
                                                        collapsed: false,
                                                        title: 'ROM: Cervical',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_cervical_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_cervical_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_cervical_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        width: 760,
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapseFirst: false,
                                                        collapsed: true,
                                                        title: 'ROM:Trunk',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_trunk_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_trunk_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_trunk_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'ROM:UE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_ue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_ue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_ue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapseFirst: false,
                                                        collapsed: true,
                                                        title: 'ROM:LE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_le_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_le_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_le_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Strength:Cervical',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_cervical_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_cervical_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_cervical_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Strength:Trunk',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_trunk_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_trunk_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_trunk_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        collapsible: false,
                                                        title: 'Strength:UE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_ue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_ue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_ue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Strength:LE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_le_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_le_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_le_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Balance',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Transfers',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'transfers_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'transfers_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'transfers_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Gait',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'gait_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'gait_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'gait_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Endurance',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Other',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        collapsed: true,
                                                        title: 'Other',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'details',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'goals',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                filter: 'orders',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                enableKeyEvents: true,
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
                                        height: 692,
                                        title: 'Pain',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                height: 230,
                                                margin: '7px',
                                                title: 'Pain',
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        height: 199,
                                                        layout: {
                                                            columns: 5,
                                                            type: 'table'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Pain Location',
                                                                margin: '0 0 3px 5px'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Intensity(0-10)',
                                                                margin: '0 0 3px 3px'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Frequency',
                                                                margin: '0 0 3px 3px'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Description',
                                                                margin: '0 0 3px 3px'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 15,
                                                                width: 91,
                                                                text: 'Aggravating Factors',
                                                                margin: '0 0 3px 3px'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location1',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity1',
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
                                                                name: 'frequency1',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description1',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors1',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location2',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description2',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors2',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location3',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description3',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors3',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location4',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description4',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors4',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location5',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description5',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                width: 149,
                                                                name: 'aggravating_factors5',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location6',
                                                                margin: '0 0 3px 5px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description6',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                rowspan: 0,
                                                                name: 'aggravating_factors6',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        autoScroll: true,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'Physical & Functional Status/Home Bound Status',
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
                                                        title: 'Physical Status',
                                                        items: [
                                                            {
                                                                xtype: 'image',
                                                                anchor: '',
                                                                height: 22,
                                                                margin: '0px 0px 0px 90px',
                                                                width: 224,
                                                                src: '/assets/physical_modified3.png'
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                formBind: false,
                                                                draggable: false,
                                                                width: 295,
                                                                name: 'ambulation',
                                                                value: 0,
                                                                fieldLabel: 'Ambulation',
                                                                labelWidth: 95,
                                                                preventMark: false,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                vertical: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                floating: false,
                                                                hidden: false,
                                                                styleHtmlContent: false,
                                                                width: 295,
                                                                name: 'coordination',
                                                                fieldLabel: 'Coordination',
                                                                labelWidth: 95,
                                                                decimalPrecision: 2,
                                                                increment: 14.28
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 295,
                                                                name: 'endurance',
                                                                fieldLabel: 'Endurance',
                                                                labelWidth: 95,
                                                                decimalPrecision: 2,
                                                                increment: 14.28
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 295,
                                                                name: 'gross',
                                                                value: 0,
                                                                fieldLabel: 'Gross Motor',
                                                                labelWidth: 95,
                                                                decimalPrecision: 2,
                                                                increment: 14.28
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 295,
                                                                name: 'strength',
                                                                value: 0,
                                                                fieldLabel: 'Strength',
                                                                labelWidth: 95,
                                                                decimalPrecision: 2,
                                                                increment: 14.28
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 2,
                                                        margin: '3px',
                                                        title: 'Functional Status',
                                                        items: [
                                                            {
                                                                xtype: 'panel',
                                                                border: 0,
                                                                height: 24,
                                                                layout: {
                                                                    type: 'column'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        height: 18,
                                                                        width: 186,
                                                                        text: ''
                                                                    },
                                                                    {
                                                                        xtype: 'label',
                                                                        height: 17,
                                                                        width: 36,
                                                                        text: 'Ind              '
                                                                    },
                                                                    {
                                                                        xtype: 'label',
                                                                        height: 27,
                                                                        width: 43,
                                                                        text: 'Sup'
                                                                    },
                                                                    {
                                                                        xtype: 'label',
                                                                        height: 18,
                                                                        width: 37,
                                                                        text: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'label',
                                                                        height: 19,
                                                                        width: 37,
                                                                        text: 'MinA'
                                                                    },
                                                                    {
                                                                        xtype: 'label',
                                                                        height: 23,
                                                                        width: 41,
                                                                        text: 'ModA'
                                                                    },
                                                                    {
                                                                        xtype: 'label',
                                                                        height: 22,
                                                                        width: 41,
                                                                        text: 'MaxA'
                                                                    },
                                                                    {
                                                                        xtype: 'label',
                                                                        height: 28,
                                                                        width: 38,
                                                                        text: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'label',
                                                                        height: 10,
                                                                        width: 35,
                                                                        text: 'Un'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 501,
                                                                fieldLabel: 'Bed Mobility: Roll/Scoot',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'roll',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'roll',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'roll',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'roll',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'roll',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'roll',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'roll',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'roll',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Bed Mobility: Supine-Sit',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'supine_sit',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'supine_sit',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'supine_sit',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'supine_sit',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'supine_sit',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'supine_sit',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'supine_sit',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'supine_sit',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Bed Mobility: Sit-Supine',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_supine',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_supine',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_supine',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_supine',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_supine',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_supine',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_supine',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_supine',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Transfer:Toilet',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Transfer: Sit-Stand',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_stand',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_stand',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_stand',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_stand',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_stand',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_stand',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_stand',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'sit_stand',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Transfer:Car',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'car',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'car',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'car',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'car',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'car',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'car',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'car',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'car',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Transfer:Shower',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'shower',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'shower',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'shower',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'shower',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'shower',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'shower',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'shower',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'shower',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'panel',
                                                                border: 0,
                                                                height: 37,
                                                                width: 637,
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'vbox'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        margin: '0 0 0 7px',
                                                                        text: 'Ind-Independent Sup-Supervised MinA-Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'label',
                                                                        margin: '0 0 0 7px',
                                                                        text: 'ModA-Moderate Assistance MaxA-Maximum Assistance Un-Untested '
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
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'hbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        height: 302,
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
                                                                        boxLabel: 'Dyspnea',
                                                                        inputValue: 'Dyspnea'
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
                                                        height: 302,
                                                        margin: '3px',
                                                        title: 'Equipment in the Patient\'s Home',
                                                        items: [
                                                            {
                                                                xtype: 'checkboxgroup',
                                                                height: 226,
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'vbox'
                                                                },
                                                                fieldLabel: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'None',
                                                                        inputValue: 'None'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Cane',
                                                                        inputValue: 'Cane'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Walker',
                                                                        inputValue: 'Walker'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Wheelchair',
                                                                        inputValue: 'Wheelchair'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Hospital bed',
                                                                        inputValue: 'Hospital bed'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Mobility Scooter ',
                                                                        inputValue: 'Mobility Scooter '
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Comode',
                                                                        inputValue: 'Comode'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Splint',
                                                                        inputValue: 'Splint'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Brace',
                                                                        inputValue: 'Brace'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Crutches',
                                                                        inputValue: 'Crutches'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Orthotic Device ',
                                                                        inputValue: 'Orthotic Device'
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 0.75,
                                                        height: 21,
                                                        margin: '3px',
                                                        title: 'Mental/Social/Cognition',
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
                                                                        name: 'msc',
                                                                        boxLabel: 'Oriented',
                                                                        inputValue: 'Oriented'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'msc',
                                                                        boxLabel: 'Comatose',
                                                                        inputValue: 'Comatose'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'msc',
                                                                        boxLabel: 'Forgetful',
                                                                        inputValue: 'Forgetful'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'msc',
                                                                        boxLabel: 'Depressed',
                                                                        inputValue: 'Depressed'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'msc',
                                                                        boxLabel: 'Disoriented',
                                                                        inputValue: 'Disoriented'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'msc',
                                                                        boxLabel: 'Lethargic',
                                                                        inputValue: 'Lethargic'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'msc',
                                                                        boxLabel: 'Agitated',
                                                                        inputValue: 'Agitated'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '3px',
                                                                name: 'msc_other1',
                                                                labelWidth: 40,
                                                                fieldLabel: 'Other'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '3px',
                                                                name: 'msc_other2',
                                                                labelWidth: 40,
                                                                fieldLabel: 'Other'
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1.25,
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
                                                                labelWidth: 100,
                                                                fieldLabel: 'Other'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '5px 5px',
                                                                name: 'ambulates',
                                                                labelWidth: 100,
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
                                        height: 644,
                                        margin: '7px',
                                        padding: '3px',
                                        autoScroll: true,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'Misc/Interventions/Modalities/Education',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                layout: {
                                                    type: 'hbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 2,
                                                        margin: '3px',
                                                        title: 'Misc. Findings',
                                                        items: [
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'misc_msc',
                                                                fieldLabel: 'Prior Level of Function',
                                                                labelAlign: 'right',
                                                                labelWidth: 150
                                                            },
                                                            {
                                                                xtype: 'checkboxgroup',
                                                                width: 400,
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'vbox'
                                                                },
                                                                fieldLabel: 'POC Established With ',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'poc',
                                                                        boxLabel: 'Patient',
                                                                        inputValue: 'Patient'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'poc',
                                                                        boxLabel: 'Family',
                                                                        inputValue: 'Family'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'poc',
                                                                        boxLabel: 'PCG',
                                                                        inputValue: 'PCG'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                height: 22,
                                                                margin: '0 0 0 7px',
                                                                width: 321,
                                                                fieldLabel: 'Rehab Potential',
                                                                labelAlign: 'right',
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'rehab',
                                                                        boxLabel: 'P',
                                                                        checked: true,
                                                                        inputValue: 'Poor'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'rehab',
                                                                        boxLabel: 'F',
                                                                        inputValue: 'Foor'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'rehab',
                                                                        boxLabel: 'G',
                                                                        inputValue: 'Good'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'rehab',
                                                                        boxLabel: 'E',
                                                                        inputValue: 'Excellent'
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 1,
                                                        margin: '3px',
                                                        title: 'Interventions',
                                                        items: [
                                                            {
                                                                xtype: 'checkboxgroup',
                                                                width: 396,
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'vbox'
                                                                },
                                                                fieldLabel: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Evaluation',
                                                                        inputValue: 'Evaluation'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Therapeutic Exercises',
                                                                        inputValue: 'Therapeutic Exercises'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Muscle re-education',
                                                                        inputValue: 'Muscle re-education'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Joint Mobility',
                                                                        inputValue: 'Joint Mobility'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Soft Tissue Mobility',
                                                                        inputValue: 'Soft Tissue Mobility'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Bed Mobility',
                                                                        inputValue: 'Bed Mobility'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Balance Activities',
                                                                        inputValue: 'Balance Activities'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Transfer Training',
                                                                        inputValue: 'Transfer Training'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Gait Training',
                                                                        inputValue: 'Gait Training'
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'fieldset',
                                                        flex: 2,
                                                        margin: '3px',
                                                        title: 'Modalities',
                                                        items: [
                                                            {
                                                                xtype: 'checkboxgroup',
                                                                width: 400,
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'vbox'
                                                                },
                                                                fieldLabel: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'modalities',
                                                                        boxLabel: 'Electrotherapy',
                                                                        inputValue: 'Electrotherapy'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'modalities',
                                                                        boxLabel: 'Ultrasound',
                                                                        inputValue: 'Ultrasound'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'modalities',
                                                                        boxLabel: 'Pulmonary Physical Therapy ',
                                                                        inputValue: 'Pulmonary Physical Therapy'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '3px',
                                                                name: 'modalities_other1',
                                                                fieldLabel: 'Other'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '3px',
                                                                name: 'modalities_other2',
                                                                fieldLabel: 'Other'
                                                            }
                                                        ]
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'fieldset',
                                                margin: '3px',
                                                title: 'Education',
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        border: 0,
                                                        layout: {
                                                            align: 'middle',
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
                                                                        name: 'education',
                                                                        boxLabel: 'Safety Measures',
                                                                        inputValue: 'Safety Measures'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'education',
                                                                        boxLabel: 'Pre/Prosthetic Training',
                                                                        inputValue: 'Pre/Prosthetic Training'
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
                                                                        name: 'education',
                                                                        boxLabel: 'Equipment Training',
                                                                        inputValue: 'Equipment Training'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'education',
                                                                        boxLabel: 'Family Training',
                                                                        inputValue: 'Family Training'
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
                                                                        name: 'education',
                                                                        boxLabel: 'Orthotic Training',
                                                                        inputValue: 'Orthotic Training'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'education',
                                                                        boxLabel: 'Home Exercise Program',
                                                                        inputValue: 'Home Exercise Program'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'panel',
                                                                flex: 1,
                                                                border: 0,
                                                                items: [
                                                                    {
                                                                        xtype: 'textfield',
                                                                        name: 'edu_other1',
                                                                        fieldLabel: 'Other',
                                                                        labelAlign: 'right'
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        name: 'edu_other2',
                                                                        fieldLabel: 'Other',
                                                                        labelAlign: 'right'
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'checkboxgroup',
                                                        width: 550,
                                                        fieldLabel: 'Education Presented to',
                                                        labelAlign: 'right',
                                                        labelWidth: 150,
                                                        vertical: false,
                                                        items: [
                                                            {
                                                                xtype: 'checkboxfield',
                                                                name: 'edu_presented',
                                                                boxLabel: 'Patient',
                                                                inputValue: 'Patient'
                                                            },
                                                            {
                                                                xtype: 'checkboxfield',
                                                                name: 'edu_presented',
                                                                boxLabel: 'Family',
                                                                inputValue: 'Family'
                                                            },
                                                            {
                                                                xtype: 'checkboxfield',
                                                                name: 'edu_presented',
                                                                boxLabel: 'PCG',
                                                                inputValue: 'PCG'
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'radiogroup',
                                                        height: 35,
                                                        width: 750,
                                                        fieldLabel: 'Patient/Family /PCG',
                                                        labelWidth: 160,
                                                        items: [
                                                            {
                                                                xtype: 'radiofield',
                                                                name: 'verbalized',
                                                                boxLabel: 'Verbalized Understanding',
                                                                checked: true,
                                                                inputValue: 'Verbalized Understanding '
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                name: 'verbalized',
                                                                boxLabel: 'did not verbalize understanding',
                                                                inputValue: 'Did not Verbalize Understanding '
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
                                        title: 'Notes & Comments',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                height: 300,
                                                margin: '7px',
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'vbox'
                                                },
                                                title: 'Notes and Comments',
                                                items: [
                                                    {
                                                        xtype: 'textareafield',
                                                        height: 58,
                                                        name: 'notes_and_comments',
                                                        fieldLabel: 'Notes and Comments',
                                                        labelAlign: 'right',
                                                        allowBlank: false,
                                                        enableKeyEvents: true,
                                                        cols: 100
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    :tat.component(
                                        :name => :tinetti_assessment_tool,
                                        :title => "Tinetti Assessment Tool (Optional)",
                                        :class_name => "Documents::Components::TinettiAssessmentToolForm"
                                    )
                                ]
                            }
                        ]
                    }
                ]
            }
        ]
    )
  end

  js_method :init_component, <<-JS
    function(){
      var formScope = this;
      this.callParent();
      var accordions = Ext.ComponentQuery.query("#problem_accordions")[0].query("panel");
      registerContentChangeEventHandlers(this, accordions);

     var action = this.actions.previousEvaluationReport;
      if (action) {
        this.checkPrevEvalAvailability({}, function(result){
          action.setDisabled((result == 'q'));
        },this);
      }

      Ext.ComponentQuery.query("tab[text=Tinetti Assessment Tool (Optional)]")[0].addCls('tat-tab-color');

      //TAT events
      var button = Ext.ComponentQuery.query('#calculate_score')[0];
      button.on('click', function(){
        assignTotalScore();
      });

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
