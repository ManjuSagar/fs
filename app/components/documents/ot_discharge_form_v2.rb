# Custom user form (predefined model and layout)
class Documents::OTDischargeFormV2 < Documents::AbstractDocumentForm

  def configuration
    c = super
    c.merge(
        model: "OTDischarge",
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
                                        title: 'Problems/Goals/Orders',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                hidden: true,
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
                                                        collapsed: true,
                                                        title: 'ROM:RUE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_rue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_rue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_rue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_rue_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                        title: 'ROM:LUE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_lue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_lue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_lue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'rom_lue_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                        title: 'Strength:RUE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_rue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_rue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_rue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_rue_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                        title: 'Strength:LUE(0-5)',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_lue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_lue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_lue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'strength_lue_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                        title: 'Coordination:RUE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'coordination_rue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'coordination_rue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'coordination_rue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'coordination_rue_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                        title: 'Coordination:LUE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'coordination_lue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'coordination_lue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'coordination_lue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'coordination_lue_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                        title: 'Sensation:RUE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'sensation_rue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'sensation_rue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'sensation_rue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'sensation_rue_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                        title: 'Sensation:LUE',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'sensation_lue_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'sensation_lue_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'sensation_lue_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'sensation_lue_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                        title: 'Vision/perception',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'vision_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'vision_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'vision_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'vision_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                        title: 'Balance:sit/stand',
                                                        items: [
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'balance_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'endurance_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other1_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other2_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                                name: 'other3_details',
                                                                fieldLabel: 'Details',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other3_goals',
                                                                fieldLabel: 'Goals',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other3_orders',
                                                                fieldLabel: 'Orders',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                cols: 100
                                                            },
                                                            {
                                                                xtype: 'textareafield',
                                                                margin: '5px 0 0 3px',
                                                                name: 'other3_interventions',
                                                                fieldLabel: 'Interventions/Teachings',
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
                                                height: 230,
                                                itemId: 'pain_panel',
                                                margin: '7px',
                                                layout: {
                                                    type: 'anchor'
                                                },
                                                title: 'Pain',
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        height: 199,
                                                        margin: '5px 0 0 5px',
                                                        layout: {
                                                            columns: 5,
                                                            type: 'table'
                                                        },
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
                                                                fieldLabel: 'Intensity (0-10)',
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
                                                                fieldLabel: 'Description',
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
                                                                fieldLabel: '',
                                                                labelAlign: 'top'
                                                            },
                                                            {
                                                                xtype: 'combobox',
                                                                name: 'intensity2',
                                                                margin: '0 0 3px 3px',
                                                                fieldLabel: '',
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
                                        title: 'UE/Functional Status & Limitations/Equipment/Home Bound Status',
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
                                                        itemId: 'ue_function_panel',
                                                        margin: '3px',
                                                        layout: {
                                                            type: 'anchor'
                                                        },
                                                        title: 'UE Function',
                                                        items: [
                                                            {
                                                                xtype: 'image',
                                                                height: 22,
                                                                margin: '0px 0px 0px 145px',
                                                                width: 224,
                                                                src: '/assets/physical_modified3.png'
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 350,
                                                                name: 'grasp',
                                                                fieldLabel: 'Grasp and Pinch',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 350,
                                                                name: 'fine_motor',
                                                                fieldLabel: 'Fine Motor Coordination',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 350,
                                                                name: 'gross_motor',
                                                                fieldLabel: 'Gross Motor Coordination',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 350,
                                                                name: 'sharp',
                                                                fieldLabel: 'Sharp/Dull Sensation',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 350,
                                                                name: 'proprioception',
                                                                fieldLabel: 'Proprioception',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
                                                                decimalPrecision: 2,
                                                                increment: 14.28,
                                                                useTips: false
                                                            },
                                                            {
                                                                xtype: 'slider',
                                                                width: 350,
                                                                name: 'stereognosis',
                                                                fieldLabel: 'Stereognosis',
                                                                labelAlign: 'right',
                                                                labelWidth: 150,
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
                                                        title: 'Functional Status:ADL',
                                                        items: [
                                                            {
                                                                xtype: 'panel',
                                                                border: 0,
                                                                height: 22,
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
                                                                fieldLabel: 'Feeding',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'Feeding',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'Feeding',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'Feeding',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'Feeding',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'Feeding',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'Feeding',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'Feeding',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'Feeding',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Grooming/Hygiene',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'grooming',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'grooming',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'grooming',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'grooming',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'grooming',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'grooming',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'grooming',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'grooming',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'UB Dressing',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'ub_dressing',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'ub_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'ub_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'ub_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'ub_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'ub_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'ub_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'ub_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'LB Dressing',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'lb_dressing',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'lb_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'lb_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'lb_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'lb_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'lb_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'lb_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'lb_dressing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Bathing',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Toileting',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toileting',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toileting',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toileting',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toileting',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toileting',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toileting',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toileting',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toileting',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Toilet Transfer',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet_transfer',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'toilet_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Bathing Transfer',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing_transfer',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'bathing_transfer',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Meal Preparation',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'meal_preparation',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'meal_preparation',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'meal_preparation',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'meal_preparation',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'meal_preparation',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'meal_preparation',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'meal_preparation',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'meal_preparation',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'radiogroup',
                                                                width: 502,
                                                                fieldLabel: 'Household Chores',
                                                                labelAlign: 'right',
                                                                labelWidth: 180,
                                                                items: [
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'household_chores',
                                                                        boxLabel: '',
                                                                        checked: true,
                                                                        inputValue: 'Independent'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'household_chores',
                                                                        boxLabel: '',
                                                                        inputValue: 'Supervised'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'household_chores',
                                                                        boxLabel: '',
                                                                        inputValue: 'SBA'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'household_chores',
                                                                        boxLabel: '',
                                                                        inputValue: 'Minimum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'household_chores',
                                                                        boxLabel: '',
                                                                        inputValue: 'Moderate Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'household_chores',
                                                                        boxLabel: '',
                                                                        inputValue: 'Maximum Assistance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'household_chores',
                                                                        boxLabel: '',
                                                                        inputValue: 'Dep'
                                                                    },
                                                                    {
                                                                        xtype: 'radiofield',
                                                                        name: 'household_chores',
                                                                        boxLabel: '',
                                                                        inputValue: 'Untested'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'panel',
                                                                border: false,
                                                                height: 28,
                                                                layout: {
                                                                    align: 'middle',
                                                                    type: 'hbox'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'textfield',
                                                                        width: 185,
                                                                        name: 'other_caption',
                                                                        fieldLabel: ''
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        height: 23,
                                                                        width: 316,
                                                                        fieldLabel: '',
                                                                        hideEmptyLabel: false,
                                                                        hideLabel: true,
                                                                        labelAlign: 'right',
                                                                        labelWidth: 180,
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                name: 'other',
                                                                                boxLabel: '',
                                                                                checked: true,
                                                                                inputValue: 'Independent'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                name: 'other',
                                                                                boxLabel: '',
                                                                                inputValue: 'Supervised'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                name: 'other',
                                                                                boxLabel: '',
                                                                                inputValue: 'SBA'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                name: 'other',
                                                                                boxLabel: '',
                                                                                inputValue: 'Minimum Assistance'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                name: 'other',
                                                                                boxLabel: '',
                                                                                inputValue: 'Moderate Assistance'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                name: 'other',
                                                                                boxLabel: '',
                                                                                inputValue: 'Maximum Assistance'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                name: 'other',
                                                                                boxLabel: '',
                                                                                inputValue: 'Dep'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                name: 'other',
                                                                                boxLabel: '',
                                                                                inputValue: 'Untested'
                                                                            }
                                                                        ]
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
                                                                        boxLabel: 'Hospital Bed',
                                                                        inputValue: 'Hospital Bed'
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
                                                        flex: 0.75,
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
                                                        flex: 1.25,
                                                        itemId: 'homebound_panel',
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
                                        title: 'Misc/Interventions/Education',
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
                                                        flex: 5,
                                                        itemId: 'interventions_panel',
                                                        margin: '3px',
                                                        width: 543,
                                                        layout: {
                                                            align: 'middle',
                                                            type: 'hbox'
                                                        },
                                                        title: 'Interventions/Teachings',
                                                        items: [
                                                            {
                                                                xtype: 'checkboxgroup',
                                                                width: 189,
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
                                                                        boxLabel: 'Therapeutic Exercises ',
                                                                        inputValue: 'Therapeutic Exercises '
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Transfer Training ',
                                                                        inputValue: 'Transfer Training '
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'ADL Training',
                                                                        inputValue: 'ADL Training'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Ambulation',
                                                                        inputValue: 'Ambulation'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Establish Home Program',
                                                                        inputValue: 'ambulation'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Bed Mobility ',
                                                                        inputValue: 'Bed Mobility '
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Hot Packs/Hydrotherapy',
                                                                        inputValue: 'Hot Packs/Hydrotheraphy'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Ultrasound',
                                                                        inputValue: 'Bed mobility '
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'checkboxgroup',
                                                                #height: 210,
                                                                width: 205,
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
                                                                        name: 'interventions',
                                                                        boxLabel: 'Prosthetic Training',
                                                                        inputValue: 'Prosthetic Training'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Fabrication of Orthotic Device',
                                                                        inputValue: 'Fabrication of Orthotic Device'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Muscle re-education ',
                                                                        inputValue: 'Muscle re-education '
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Management & Eval of POC',
                                                                        inputValue: 'Management & Eval of POC'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Soft Tissue Mobility ',
                                                                        inputValue: 'Soft Tissue Mobility '
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Join Mobility',
                                                                        inputValue: 'Join Mobility'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'interventions',
                                                                        boxLabel: 'Balance Activities ',
                                                                        inputValue: 'Balance Activities '
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                name: 'other_interventions',
                                                                fieldLabel: 'Other',
                                                                labelAlign: 'right'
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
                                                                        boxLabel: 'Equipment Training	',
                                                                        inputValue: 'Equipment Training	'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'education',
                                                                        boxLabel: 'Gait Training',
                                                                        inputValue: 'Gait Training'
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
                                                                        boxLabel: 'ROM Exercises',
                                                                        inputValue: 'ROM Exercises'
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
                                                                        boxLabel: 'Strengthening Exercises',
                                                                        inputValue: 'Strengthening Exercises'
                                                                    },
                                                                    {
                                                                        xtype: 'checkboxfield',
                                                                        name: 'education',
                                                                        boxLabel: 'Energy Conservation',
                                                                        inputValue: 'Energy Conservation'
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
                                                                        boxLabel: 'Transfer Training',
                                                                        inputValue: 'Transfer Training'
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'panel',
                                                                flex: 1,
                                                                border: 0
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
                                                        margin: '0 0 3px 10px',
                                                        items: [
                                                            {
                                                                xtype: 'radiofield',
                                                                name: 'verbalized',
                                                                boxLabel: 'Verbalized understanding',
                                                                checked: true,
                                                                inputValue: 'Verbalized understanding '
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                name: 'verbalized',
                                                                boxLabel: 'Did not verbalize understanding',
                                                                inputValue: 'Did not verbalize understanding '
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
                                                                inputValue: ' Patinet/PCG Refused'
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
                                                                boxLabel: 'Patient Admitted to Hospital',
                                                                inputValue: 'Patinet Admitted to Hospital'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Physician\'s Request',
                                                                inputValue: 'Physicians Request'
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                flex: 1,
                                                                name: 'dc_reason',
                                                                boxLabel: 'Patient Non-Compliant with POC',
                                                                inputValue: 'Patient Non-Compliant with POC'
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
                                                xtype: 'panel',
                                                height: 230,
                                                itemId: 'notes_and_comments_panel',
                                                margin: '7px',
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'vbox'
                                                },
                                                title: 'Notes & Comments',
                                                items: [
                                                    {
                                                        xtype: 'textareafield',
                                                        margins: '5px 5px 0 0',
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
      var panelList = ["#pain_panel", "#ue_function_panel", "#functional_status_panel", "#functional_limitations_panel",
                   "#equipment_panel", "#msc_panel", "#interventions_panel", "#education_panel", "#notes_and_comments_panel"];
      registerVisitedEventHandlers(this, panelList);
    }
  JS


end
