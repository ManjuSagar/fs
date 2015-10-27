# Custom user form (predefined model and layout)
class Documents::PTDischargeForm < Documents::AbstractDocumentForm

  def configuration
    c = super
    c.merge(
        model: "PTDischarge",
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
                                activeTab: 1,
                                deferredRender: false,
                                plain: true,
                                items: [
                                    {
                                        xtype: 'panel',
                                        hidden: true,
                                        autoScroll: true,
                                        layout: {
                                            type: 'fit'
                                        },
                                        hideCollapseTool: false,
                                        title: 'Problems/Goals/Orders',
                                        tabConfig: {
                                            xtype: 'tab',
                                            hidden: true
                                        },
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                hidden: false,
                                                autoScroll: true,
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
                                                        hideCollapseTool: false,
                                                        title: 'ROM: Cervical',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_cervical_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_cervical_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_cervical_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_cervical_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_trunk_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_trunk_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_trunk_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_trunk_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_ue_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_ue_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_ue_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_ue_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_le_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_le_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_le_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_le_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_cervical_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_cervical_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_cervical_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_cervical_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_trunk_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_trunk_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_trunk_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_trunk_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_ue_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_ue_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_ue_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_ue_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_le_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_le_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_le_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_le_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'transfers_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'transfers_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'transfers_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'transfers_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'gait_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'gait_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'gait_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'gait_orders_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_details',
                                                                fieldLabel: 'Details at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_goals',
                                                                fieldLabel: 'Goals at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_orders',
                                                                fieldLabel: 'Orders at Eval',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_progress_goals',
                                                                fieldLabel: 'Progress Towards Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                xtype: 'panel',
                                                height: 223,
                                                itemId: 'pain_panel',
                                                margin: '7px',
                                                title: 'Pain',
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        height: 199,
                                                        margin: '5px',
                                                        layout: {
                                                            columns: 5,
                                                            type: 'table'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'label',
                                                                text: 'Pain Location'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                text: 'Intensity(0-10)'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                text: 'Frequency'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                text: 'Description'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                text: 'Aggravating Factors'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location1',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity1',
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
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description1',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors1',
                                                                fieldLabel: ''
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location2',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity2',
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description2',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors2',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location3',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity3',
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description3',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors3',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location4',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity4',
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description4',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'aggravating_factors4',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location5',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity5',
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description5',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                width: 149,
                                                                name: 'aggravating_factors5',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'pain_location6',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity6',
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'description6',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                rowspan: 0,
                                                                name: 'aggravating_factors6',
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            }
                                                        ]
                                                    }
                                                ],
                                                tools: [
                                                    {
                                                        xtype: 'tool',
                                                        type: 'pin'
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
                                        title: 'Physical & Functional Status',
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
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        itemId: 'physical_status_panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
                                                        title: 'Physical Status',
                                                        items: [
                                                            {
                                                                xtype: 'image',
                                                                height: 22,
                                                                margin: '0px 0px 0px 90px',
                                                                width: 224,
                                                                src: '/assets/physical_modified3.png'
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 295,
                                                                name: 'ambulation',
                                                                fieldLabel: 'Ambulation',
                                                                labelAlign: 'right',
                                                                labelWidth: 95,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 295,
                                                                name: 'coordination',
                                                                value: 0,
                                                                fieldLabel: 'Coordination',
                                                                labelAlign: 'right',
                                                                labelWidth: 95,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 295,
                                                                name: 'endurance',
                                                                value: 0,
                                                                fieldLabel: 'Endurance',
                                                                labelAlign: 'right',
                                                                labelWidth: 95,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 295,
                                                                name: 'gross',
                                                                value: 0,
                                                                fieldLabel: 'Gross Motor',
                                                                labelAlign: 'right',
                                                                labelWidth: 95,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 295,
                                                                name: 'strength',
                                                                value: 0,
                                                                fieldLabel: 'Strength',
                                                                labelAlign: 'right',
                                                                labelWidth: 95,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            }
                                                        ],
                                                        tools: [
                                                            {
                                                                xtype: 'tool',
                                                                type: 'pin'
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        flex: 2,
                                                        itemId: 'functional_status_panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
                                                        title: 'Functional Status',
                                                        items: [
                                                            {
                                                                xtype: 'panel',
                                                                border: 0,
                                                                height: 22,
                                                                margin: '5px 0 0 0',
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
                                                                height: 32,
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
                                                        ],
                                                        tools: [
                                                            {
                                                                xtype: 'tool',
                                                                type: 'pin'
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
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        height: 302,
                                                        itemId: 'functional_limitations_panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
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
                                                                        boxLabel: 'Legally Blind ',
                                                                        inputValue: 'Legally Blind'
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
                                                        ],
                                                        tools: [
                                                            {
                                                                xtype: 'tool',
                                                                type: 'pin'
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        height: 302,
                                                        itemId: 'equipment_panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
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
                                                                        flex: 1,
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
                                                                        flex: 1,
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Wheelchair',
                                                                        inputValue: 'Wheelchair'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        flex: 1,
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Hospital Bed',
                                                                        inputValue: 'Hospital Bed'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        flex: 1,
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Mobility Scooter ',
                                                                        inputValue: 'Mobility Scooter '
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        flex: 1,
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Comode',
                                                                        inputValue: 'Comode'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        flex: 1,
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Splint',
                                                                        inputValue: 'Splint'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        flex: 1,
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Brace',
                                                                        inputValue: 'Brace'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        flex: 1,
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Crutches',
                                                                        inputValue: 'Crutches'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        flex: 1,
                                                                        name: 'equipments',
                                                                        fieldLabel: '',
                                                                        boxLabel: 'Orthotic Device ',
                                                                        inputValue: 'Orthotic Device '
                                                                    }
                                                                ]
                                                            }
                                                        ],
                                                        tools: [
                                                            {
                                                                xtype: 'tool',
                                                                type: 'pin'
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        height: 241,
                                                        itemId: 'msc_panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
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
                                                                fieldLabel: 'Other'
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                margin: '3px',
                                                                name: 'msc_other2',
                                                                fieldLabel: 'Other'
                                                            }
                                                        ],
                                                        tools: [
                                                            {
                                                                xtype: 'tool',
                                                                type: 'pin'
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
                                        title: 'Interventions/Modalities/Education',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                layout: {
                                                    type: 'hbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        itemId: 'interventions_panel',
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
                                                        ],
                                                        tools: [
                                                            {
                                                                xtype: 'tool',
                                                                type: 'pin'
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        flex: 2,
                                                        itemId: 'modalities_panel',
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
                                                                        boxLabel: 'Pulmonary Physical Therapy',
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
                                                        ],
                                                        tools: [
                                                            {
                                                                xtype: 'tool',
                                                                type: 'pin'
                                                            }
                                                        ]
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                itemId: 'education_panel',
                                                margin: '3px',
                                                layout: {
                                                    type: 'anchor'
                                                },
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
                                                                        inputValue: 'Pre/prosthetic Training'
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
                                                                layout: {
                                                                    type: 'anchor'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'textfield',
                                                                        margin: '5px 0 0 0',
                                                                        name: 'edu_other1',
                                                                        fieldLabel: 'Other',
                                                                        labelAlign: 'right'
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        margin: '5px 0 0 0',
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
                                                        height: 25,
                                                        width: 550,
                                                        fieldLabel: 'Patient/Family /PCG',
                                                        labelWidth: 150,
                                                        items: [
                                                            {
                                                                xtype: 'radiofield',
                                                                name: 'verbalized',
                                                                boxLabel: 'Verbalized understanding',
                                                                checked: true,
                                                                inputValue: 'Verbalized understanding'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                name: 'verbalized',
                                                                boxLabel: 'Did not Verbalize understanding',
                                                                inputValue: 'Did not Verbalize understanding'
                                                            }
                                                        ]
                                                    }
                                                ],
                                                tools: [
                                                    {
                                                        xtype: 'tool',
                                                        type: 'pin'
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'DC Reason/DC Status/Notes & Comments',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                margin: '3px',
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
                                                        title: 'DC Reason',
                                                        items: [
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'No further skilled care needed',
                                                                checked: true,
                                                                inputValue: 'No further skilled care needed'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Patient/PCG Refused',
                                                                inputValue: 'Patinet/PCG Refused'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Patient Admitted to Hospital',
                                                                inputValue: 'Patinet Admitted to Hospital'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Patient Moved Out Of Area',
                                                                inputValue: 'Patient Moved Out Of Area'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Physician\'s Request',
                                                                inputValue: 'Physician\'s Request'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Patient non-compliant with POC',
                                                                inputValue: 'Patient non-compliant with POC'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Repeatedly not found at home',
                                                                inputValue: 'Repeatedly not found at home'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Transferred to another HHA',
                                                                inputValue: 'Transferred to another HHA'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Death',
                                                                inputValue: 'Death'
                                                            },
                                                            {
                                                                xtype: 'fieldcontainer',
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'hbox'
                                                                },
                                                                fieldLabel: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'dc_reason',
                                                                        fieldLabel: '',
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
                                                        layout: {
                                                            type: 'vbox'
                                                        },
                                                        title: 'DC Status',
                                                        items: [
                                                            {
                                                                xtype: 'radiogroup',
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'vbox'
                                                                },
                                                                fieldLabel: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'dc_status',
                                                                        boxLabel: 'Patient discharged safely to self care',
                                                                        checked: true,
                                                                        inputValue: 'Patient discharged safely to self care'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'dc_status',
                                                                        boxLabel: 'Patient discharged safely to care of PCG',
                                                                        inputValue: 'Patient discharged safely to care of PCG'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'dc_status',
                                                                        boxLabel: 'MD notified',
                                                                        inputValue: 'MD notified'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'dc_status',
                                                                        boxLabel: 'Written DC instructions provided',
                                                                        inputValue: 'Written DC instructions provided'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'dc_status',
                                                                        boxLabel: 'Patient/PCG Verbalized understanding of DC instructions',
                                                                        inputValue: 'Patient/PCG Verbalized understanding of DC instructions'
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                height: 300,
                                                itemId: 'notes_and_comments_panel',
                                                margin: '7px',
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'vbox'
                                                },
                                                title: 'Notes and Comments',
                                                items: [
                                                    {
                                                        xtype: 'textareafield',
                                                        margins: '5px 5px 0 0 ',
                                                        height: 58,
                                                        name: 'notes_and_comments',
                                                        fieldLabel: 'Notes and Comments',
                                                        labelAlign: 'right',
                                                        cols: 100
                                                    }],
                                                tools: [
                                                    {
                                                        xtype: 'tool',
                                                        type: 'pin'
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

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var panelList = ["#pain_panel", "#physical_status_panel", "#functional_status_panel", "#functional_limitations_panel",
                   "#equipment_panel", "#msc_panel", "#interventions_panel", "#modalities_panel", "#education_panel",
                  "#notes_and_comments_panel"];
      registerVisitedEventHandlers(this, panelList);
      }
JS

end
