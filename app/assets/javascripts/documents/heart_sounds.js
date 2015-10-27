/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.heartsounds', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.heartsounds',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'fieldset',
            margin: '3px',
            width: 650,
            height: 800,
            layout: {
                type: 'vbox',
            },
            title: 'Heart Sounds',
            items:[
                {
                    xtype: 'checkboxfield',
                    name: 'heart_sounds',
                    boxLabel: '<b>No Problem</b>',
                    inputValue: 'NP',
                    margin: '3px',
                    width: 100,
                },
                {
                    xtype: 'checkboxgroup',
                    margin: '3px',
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    fieldLabel: 'Heart Sounds',
                    items: [
                        {
                            xtype: 'checkboxfield',
                            name: 'heart_sounds',
                            boxLabel: 'Regular',
                            inputValue: '1',
                            width: 150,
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'heart_sounds',
                            boxLabel: 'Irregular',
                            inputValue: '2',
                            width: 150,
                        },
                        {
                            xtype: 'checkboxfield',
                            name: 'heart_sounds',
                            boxLabel: 'Murmur',
                            inputValue: '3',
                            width: 100,
                        },

                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    layout: 'hbox',
                    items:[
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Pacemaker',
                            inputValue: '4',
                            name: 'heart_sounds',
                            margin: '3px'
                        },
                        {
                            xtype: 'fieldcontainer',
                            layout: {
                                type: 'table',
                                columns: 2,
                            },
                            items: [
                                {
                                    xtype: 'datefield',
                                    fieldLabel: 'Date',
                                    name: 'pacemaker_date',
                                    labelAlign: 'right',
                                    isHeader: false
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Type',
                                    labelWidth: 40,
                                    name: 'pacemaker_type',
                                    labelAlign: 'right',
                                    isHeader: false
                                },
                                {
                                    xtype: 'datefield',
                                    fieldLabel: 'Last date checked',
                                    name: 'pacemaker_last_date_checked',
                                    labelAlign: 'right',
                                    isHeader: false
                                },
                            ]
                        },

                    ]
                },

                {
                    xtype: 'checkboxfield',
                    boxLabel: 'Chest Pain',
                    inputValue: '5',
                    name: 'heart_sounds'
                },
                {
                    xtype: 'checkboxgroup',
                    columns: 5,
                    defaults: {
                        width: 100,
                        margin: '0 0 0 5'
                    },
                    items:[
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Anginal',
                            inputValue: '1',
                            name: 'chest_pain'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Postural',
                            inputValue: '2',
                            name: 'chest_pain'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Localized',
                            inputValue: '3',
                            name: 'chest_pain'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Substernal',
                            inputValue: '4',
                            name: 'chest_pain'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Radiating',
                            inputValue: '5',
                            name: 'chest_pain'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Dull',
                            inputValue: '6',
                            name: 'chest_pain'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Ache',
                            inputValue: '7',
                            name: 'chest_pain'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Sharp',
                            inputValue: '8',
                            name: 'chest_pain'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Vise-like',
                            inputValue: '9',
                            name: 'chest_pain'
                        }

                    ]
                },
                {
                    xtype: 'checkboxgroup',
                    fieldLabel: 'Associated With',
                    margin: '8px',
                    columns: 3,
                    defaults: {
                        width: 150,
                    },
                    items:[
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Shortness of breath',
                            inputValue: '1',
                            name: 'associated_with'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Activity',
                            inputValue: '2',
                            name: 'associated_with'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Sweats',
                            inputValue: '3',
                            name: 'associated_with'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Palpitations',
                            inputValue: '4',
                            name: 'associated_with'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Fatigue',
                            inputValue: '5',
                            name: 'associated_with'
                        },
                    ]
                },
                {
                    xtype: 'textfield',
                    fieldLabel: 'Frequency/duration',
                    name: "associated_with_frequency",
                    labelWidth: 130,
                    margin:'7 3 3 120',
                },
                {
                    xtype: 'textareafield',
                    fieldLabel: 'How relieved',
                    name: "associated_with_how_relieved",
                    labelWidth: 130,
                    margin:'7 3 3 120',
                    height: 50,
                    cols: 40
                },
                {
                    xtype: 'checkboxfield',
                    boxLabel: 'Edema',
                    inputValue: '6',
                    name: 'heart_sounds'
                },
                {
                    xtype: 'checkboxgroup',
                    columns: 3,
                    defaults: {
                        width: 150,
                        margin: '0 0 0 5'
                    },
                    items:[
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Pedal',
                            inputValue: '1',
                            name: 'edema'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Right',
                            inputValue: '1',
                            name: 'pedal'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Left',
                            inputValue: '2',
                            name: 'pedal'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Sacral',
                            inputValue: '2',
                            name: 'edema'
                        },
                        {
                            xtype: 'checkboxfield',
                            boxLabel: 'Dependent',
                            inputValue: '3',
                            name: 'edema'
                        },
                        {
                            xtype: 'textfield',
                            name: 'edema_dependent'
                        },
                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    layout: "hbox",
                    items:[
                        {
                            xtype: 'panel',
                            border: 0,
                            layout: 'vbox',
                            items:[
                                {
                                    xtype: 'radiofield',
                                    name: 'edema_pitting',
                                    margin: '0 0 0 10',
                                    boxLabel: 'Pitting',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    columns: 4,
                                    defaults: {
                                        width: 60,
                                        margin: '0 0 0 40'
                                    },
                                    items:[
                                        {
                                            xtype: 'checkboxfield',
                                            boxLabel: '+1',
                                            inputValue: '+1',
                                            name: 'pitting'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            boxLabel: '+2',
                                            inputValue: '+2',
                                            name: 'pitting'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            boxLabel: '+3',
                                            inputValue: '+3',
                                            name: 'pitting'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            boxLabel: '+4',
                                            inputValue: '+4',
                                            name: 'pitting'
                                        }

                                    ]
                                }

                            ]
                        },
                        {
                            xtype: 'radiofield',
                            name: 'edema_pitting',
                            boxLabel: 'Non-Pitting',
                            inputValue: '2'
                        }
                    ]
                },
                {
                    xtype: 'textfield',
                    name: 'edema_site',
                    fieldLabel: 'Site',
                    labelWidth: 50,
                    margin: '5 0 8 10'
                },
                {
                    xtype: 'fieldcontainer',
                    defaultType: 'checkboxfield',

                    layout: 'hbox',
                    items:[
                        {
                            boxLabel: 'Cramps',
                            inputValue: '7',
                            name: 'heart_sounds',
                            width: 100
                        },
                        {
                            boxLabel: 'Claudication',
                            inputValue: '8',
                            name: 'heart_sounds',
                            width: 100
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    border: 0,
                    layout: 'vbox',
                    items: [
                        {
                            xtype: 'checkboxfield',
                            margin: '0 0 0 3',
                            boxLabel: 'Capillary refill',
                            inputValue: '9',
                            labelWidth: 300,
                            name: 'heart_sounds'
                        },
                        {
                            xtype: 'radiogroup',
                            columns: 4,
                            defaults: {
                                width: 140,
                                margin: '0 0 0 40'
                            },
                            items:[
                                {
                                    xtype: 'radiofield',
                                    boxLabel: 'Less than 3 sec ',
                                    inputValue: '1',
                                    name: 'capillary_refill'
                                },
                                {
                                    xtype: 'radiofield',
                                    boxLabel: 'Greater than 3 sec',
                                    inputValue: '2',
                                    name: 'capillary_refill'
                                }

                            ]
                        }


                    ]
                },

                {
                    xtype: 'checkboxfield',
                    boxLabel: 'Disease Management Problems(explain)',
                    inputValue: '10',
                    name: 'heart_sounds'
                },
                {
                    xtype: 'textareafield',
                    name: 'disease_management_explain',
                    xheight: 50,
                    cols: 50
                }



            ]


        }
    ],
    afterRender: function(){
        this.callParent();
        var noProblem = this.query("[boxLabel=<b>No Problem</b>]")[0];
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
        },this)

    }
})

