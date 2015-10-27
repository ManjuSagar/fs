/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.NeuroEmotionalBehaviouralM1700M1730Poc', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.neuroEmotionalBehaviouralM1700M1730Poc',
    items: [
        {
            xtype: 'fieldset',
            margin: '5px',
            title: 'Neuro/Emotional/Behavioural',
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'checkboxfield',
                    fieldLabel: '',
                    name: 'neuro_emotional_behaviour',
                    boxLabel: '<b>No Problem</b>',
                    inputValue: 'NP'
                },
                {
                    xtype: 'panel',
                    border: false,
                    width: 150,
                    header: false,
                    title: 'My Panel',
                    layout: {
                        type: 'vbox',
                        align: 'stretch'
                    },
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
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'neuro_emotional_behaviour',
                                    boxLabel: 'Headache:',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Location',
                                    labelAlign: 'right',
                                    labelWidth: 60,
                                    name: 'headache_location'
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Frequency',
                                    labelAlign: 'right',
                                    labelWidth: 70,
                                    name: 'headache_frequency'
                                }
                            ]
                        },
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
                                    xtype: 'checkboxfield',
                                    margin: '0 5px 0 0',
                                    fieldLabel: '',
                                    name: 'neuro_emotional_behaviour',
                                    boxLabel: 'PERRLA',
                                    inputValue: '2'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'neuro_emotional_behaviour',
                                    boxLabel: 'Unequal pupils: R / L',
                                    inputValue: '3'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    height: 23,
                                    width: 135,
                                    fieldLabel: '',
                                    layout: {
                                        type: 'hbox',
                                        align: 'stretch'
                                    },
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            flex: 0.6,
                                            name: 'un_equal_pupils',
                                            boxLabel: 'Right',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            flex: 0.6,
                                            name: 'un_equal_pupils',
                                            boxLabel: 'Left',
                                            inputValue: '2'
                                        }
                                    ]
                                }
                            ]
                        },
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
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'neuro_emotional_behaviour',
                                    boxLabel: 'Aphasia: Receptive / Expressive',
                                    inputValue: '4'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    width: 204,
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'aphasia',
                                            boxLabel: 'Receptive',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'aphasia',
                                            boxLabel: 'Expressive',
                                            inputValue: '2'
                                        }
                                    ]
                                }
                            ]
                        },
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
                                    xtype: 'checkboxfield',
                                    margin: '0 5px 0 0',
                                    fieldLabel: '',
                                    name: 'neuro_emotional_behaviour',
                                    boxLabel: 'Motor change: Fine / Gross',
                                    inputValue: '5'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    width: 126,
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'motor_change',
                                            boxLabel: 'Fine',
                                            inputValue: 'F'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'motor_change',
                                            boxLabel: 'Gross',
                                            inputValue: 'G'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Site',
                                    labelAlign: 'right',
                                    name: "motor_change_site",
                                    labelWidth: 60
                                }
                            ]
                        },
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
                                    xtype: 'checkboxfield',
                                    margin: '0 5px 0 0',
                                    fieldLabel: '',
                                    name: 'neuro_emotional_behaviour',
                                    boxLabel: 'Dominant side: R / L',
                                    inputValue: '6'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    height: 23,
                                    width: 135,
                                    fieldLabel: '',
                                    layout: {
                                        type: 'hbox',
                                        align: 'stretch'
                                    },
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            flex: 0.6,
                                            name: 'dominant_side',
                                            boxLabel: 'Right',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            flex: 0.6,
                                            name: 'dominant_side',
                                            boxLabel: 'Left',
                                            inputValue: '2'
                                        }
                                    ]
                                }
                            ]
                        },
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
                                    xtype: 'checkboxfield',
                                    margin: '0 5px 0 0',
                                    fieldLabel: '',
                                    name: 'neuro_emotional_behaviour',
                                    boxLabel: 'Weakness: UE / LE',
                                    inputValue: '7'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    width: 105,
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'weakness_ue_le',
                                            boxLabel: 'UE',
                                            inputValue: 'UE'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'weakness_ue_le',
                                            boxLabel: 'LE',
                                            inputValue: 'LE'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Location',
                                    labelAlign: 'right',
                                    labelWidth: 60,
                                    name: 'weakness_location'
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            border: false,
                            width: 604,
                            header: false,
                            title: 'My Panel',
                            layout: {
                                type: 'hbox',
                                align: 'stretch',
                                padding: '5 0 5 0'
                            },
                            items: [
                                {
                                    xtype: 'checkboxgroup',
                                    width: 450,
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            width: 250,
                                            labelWidth: 250,
                                            name: 'neuro_emotional_behaviour',
                                            boxLabel: 'Tremors: Fine / Gross / Paralysis',
                                            inputValue: "8",
                                            margin: '0 0 0 -5'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'tremors',
                                            boxLabel: 'Fine',
                                            inputValue: 'F'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'tremors',
                                            boxLabel: 'Gross',
                                            inputValue: 'G'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'tremors',
                                            boxLabel: 'Paralysis',
                                            inputValue: 'P'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Site',
                                    labelAlign: 'right',
                                    labelWidth: 40,
                                    name: 'termors_site'
                                }
                            ]
                        },
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
                                    xtype: 'checkboxfield',
                                    margin: '0 5px 0 0',
                                    fieldLabel: '',
                                    name: 'neuro_emotional_behaviour',
                                    boxLabel: 'Stuporous/Hallucinations: Visual/ Auditory',
                                    inputValue: '9'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    width: 160,
                                    fieldLabel: '',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'stuporous',
                                            boxLabel: 'Visual',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'stuporous',
                                            boxLabel: 'Auditory',
                                            inputValue: '2'
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            border: false,
                            header: false,
                            title: 'My Panel',
                            items: [
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Hand grips: Equal / Unequal (specify)',
                                    labelWidth: 220,
                                    name: 'hand_grips_equal_or_unequal'
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Strong / Weak (specify)',
                                    labelAlign: 'right',
                                    labelWidth: 220,
                                    name: 'hand_grips_strong_or_weak'
                                },
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
                                            xtype: 'checkboxfield',
                                            fieldLabel: '',
                                            name: 'neuro_emotional_behaviour',
                                            boxLabel: 'Psychotropic drug use (specify)',
                                            inputValue: '10'
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel: '',
                                            labelAlign: 'right',
                                            name: 'psychotropic_drug'
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
                    border: false,
                    margin: '5px',
                    width: 150,
                    header: false,
                    title: 'My Panel',
                    items: [
                        {
                            xtype: 'textfield',
                            fieldLabel: 'Dose / Frequency',
                            labelWidth: 110,
                            name: 'dose_frequency'
                        },
                        {
                            header: false,
                            border: false,
                            layout: "hbox",
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    boxLabel: 'Other (specify)',
                                    name: 'neuro_emotional_behaviour',
                                    inputValue: '11'
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: '',
                                    name: 'neuro_emotional_behaviour_other'
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
        var noProblem = this.query("[boxLabel=<b>No Problem</b>]")[0];
        noProblem.on("change", function(ele){
            var fields = this.query("textfield, textareafield, datefield, numberfield, checkboxfield, radiofield, checkboxgroup, radiogroup, label");
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
