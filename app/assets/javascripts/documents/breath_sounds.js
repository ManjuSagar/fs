/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.BreathSounds', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.breathSounds',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'fieldset',
            margin: '3px',
            width: 500,
            height: 800,
            layout: {
                type: 'vbox'
            },

            flex: 1,
            title: 'Breath Sounds',
            items:[
                {
                    xtype: 'label',
                    text: '(Clear, crackles/rales, wheezes/rhonchi, diminished, absent)'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'breath_sounds',
                    boxLabel: '<b>No Problem</b>',
                    inputValue: "NP",
                    width: 100
                },
                {
                    xtype: 'panel',
                    layout: 'hbox',
                    border: 0,
                    items:[
                        {
                            xtype: 'panel',
                            border: 0,
                            defaults:{
                                xtype: 'textfield',
                                labelWidth: 40
                            },
                            margin: '3px',
                            layout: 'vbox',
                            items: [
                                {
                                    xtype: 'label',
                                    text: 'Anterior:'
                                },
                                {
                                    fieldLabel: 'Right',
                                    name: 'anterior_right',
                                    isHeader: false

                                }, {
                                    fieldLabel: 'Left',
                                    name: 'anterior_left',
                                    isHeader: false
                                }]
                        },
                        {
                            xtype: 'panel',
                            border: 0,
                            margin: '3px',
                            defaults:{
                                xtype: 'textfield',
                                labelWidth: 80
                            },
                            layout: 'vbox',
                            items: [
                                {
                                    xtype: 'label',
                                    text: 'Posterior:'
                                },
                                {
                                    fieldLabel: 'Right Upper',
                                    name: 'posterior_right_upper',
                                    isHeader: false
                                }, {
                                    fieldLabel: 'Right Lower',
                                    name: 'posterior_right_lower',
                                    isHeader: false
                                },
                                {
                                    fieldLabel: 'Left Upper',
                                    name: 'posterior_left_upper',
                                    isHeader: false
                                }, {
                                    fieldLabel: 'Left Lower',
                                    name: 'posterior_left_lower',
                                    isHeader: false
                                }
                            ]
                        }

                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    layout: 'hbox',
                    items: [
                        {
                            xtype: 'textfield',
                            fieldLabel: 'O2 @ (LPM via cannula, mask, trach)',
                            labelAlign: 'top',
                            name: 'oxygen_lpm',
                            isHeader: false
                        },
                        {
                            xtype: 'textfield',
                            fieldLabel: 'O2 saturation(%)',
                            name: 'oxygen_saturation',
                            labelAlign: 'top',
                            padding: '0 0 0 10',
                            labelWidth: 150,
                            isHeader: false
                        },

                    ]
                },

                {
                    xtype: 'textfield',
                    fieldLabel: 'Trach size/type',
                    name: "trach_size",
                    labelWidth: 150,
                    margin: '5px'
                },
                {
                    xtype: 'radiogroup',
                    margin: '0 0 0 20',
                    fieldLabel: 'Who manages?',
                    layout:
                    {
                        type: 'hbox',
                        align: 'stretch'
                    },
                    items:[
                        {
                            xtype: 'radiofield',
                            name: 'who_manages',
                            boxLabel: 'Self',
                            inputValue: 'SF'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'who_manages',
                            boxLabel: 'RN',
                            inputValue: 'RN'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'who_manages',
                            boxLabel: 'Caregiver',
                            inputValue: 'CG'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'who_manages',
                            boxLabel: 'Family',
                            inputValue: 'FY'
                        },
                    ]
                },
                {
                    xtype: 'textareafield',
                    name: 'who_manages_text',
                    margin: '0 0 0 20',
                    fieldLabel: '',
                    height: 50,
                    cols: 60
                },
                {
                    xtype: 'radiogroup',
                    margin: '5px',
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    label_width: 180,
                    fieldLabel: 'Intermittent treatments (C&DB, medicated inhalation treatments, etc.,)',
                    labelAlign: 'top',
                    items: [
                        {
                            xtype: 'radiofield',
                            name: 'intermittent_treatments',
                            boxLabel: 'No',
                            inputValue: 'N',
                            width: 60
                        },
                        {
                            xtype: 'radiofield',
                            name: 'intermittent_treatments',
                            boxLabel: 'Yes, ',
                            inputValue: 'Y',
                            width: 60
                        },
                        {
                            xtype: 'textareafield',
                            name: 'intermittent_treatments_explain',
                            fieldLabel: 'explain',
                            labelWidth: 50,
                            height: 50,
                            cols: 30
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    layout: 'vbox',
                    border: 0,
                    items:[
                        {
                            xtype: 'fieldcontainer',
                            layout: 'hbox',
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    margin: '5px',
                                    boxLabel: 'Cough',
                                    inputValue: '1',
                                    name: 'breath_sounds'
                                },
                                {
                                    xtype: 'radiogroup',
                                    margin: '5px',
                                    layout: {
                                        align: 'stretch',
                                        type: 'vbox'
                                    },

                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: 'cough',
                                            boxLabel: 'No',
                                            inputValue: 'N',
                                            width: 60
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: 'cough',
                                            boxLabel: 'Yes:',
                                            inputValue: 'Y',
                                            width: 60
                                        },
                                    ]
                                },

                            ]
                        },

                        {
                            xtype: 'radiogroup',
                            width: 250,
                            margin: '0 0 0 80',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'productive',
                                    boxLabel: 'Productive',
                                    inputValue: 'PR'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'productive',
                                    boxLabel: 'Non-Productive',
                                    inputValue: 'NPR'
                                },
                            ]
                        },

                        {
                            xtype: 'textareafield',
                            fieldLabel: 'Describe:',
                            name: "productive_describe",
                            labelWidth: 50,
                            margin: '0 0 0 90',
                            height: 50,
                            cols: 30
                        },
                    ]

                },
                {
                    xtype: 'fieldcontainer',
                    layout: 'hbox',
                    items: [
                        {
                            xtype: 'checkboxfield',
                            margin: '5px',
                            boxLabel: 'Dyspnea',
                            inputValue: '2',
                            name: 'breath_sounds'
                        },
                        {
                            xtype: 'checkboxgroup',
                            margin: '5px',
                            layout: {
                                align: 'stretch',
                                type: 'hbox'
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'dyspnea',
                                    boxLabel: 'Rest',
                                    inputValue: '1',
                                    width: 60
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'dyspnea',
                                    boxLabel: "During ADL's",
                                    inputValue: "2",
                                    width: 100
                                },
                            ]
                        },
                    ]
                },
                {
                    xtype: 'textareafield',
                    fieldLabel: 'Comments',
                    name: "dyspnea_comments",
                    margin: '0 0 0 60',
                    labelWidth: 70,
                    height: 50,
                    cols: 30
                },
                {
                    xtype: 'radiogroup',
                    margin: '5px',
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    label_width: 180,
                    fieldLabel: 'Positioning necessary for improved breathing',
                    labelAlign: 'top',
                    items: [
                        {
                            xtype: 'radiofield',
                            name: 'positioning',
                            boxLabel: 'No',
                            inputValue: 'N',
                            width: 60
                        },
                        {
                            xtype: 'radiofield',
                            name: 'positioning',
                            boxLabel: 'Yes, ',
                            inputValue: 'Y',
                            width: 60
                        },
                        {
                            xtype: 'textareafield',
                            fieldLabel: 'Describe:',
                            labelWidth: 50,
                            name: 'positioning_describe',
                            margin: '0 0 0 20',
                            height: 50,
                            cols: 30
                        }
                    ]
                }
            ]

        }
    ],
    afterRender: function(){
        this.callParent();
        var noProblem = this.down("[boxLabel=<b>No Problem</b>]");
        noProblem.on("change", function(ele){
            var fields = this.query("textfield, textareafield, datefield, numberfield, checkboxgroup, radiogroup, checkboxfield, radiofield");
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
        }, this)

    }

})
