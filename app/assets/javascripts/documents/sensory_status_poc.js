/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.SensoryStatusPoc', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.sensoryStatusPoc',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'panel',
            flex: 1,
            border: false,
            header: false,
            title: 'My Panel',
            layout: {
                type: 'hbox',
                align: 'stretch'
            },
            items: [
                {
                    xtype: 'panel',
                    flex: 1,
                    border: false,
                    margin: '5 3 5 5',
                    header: false,
                    title: 'My Panel',
                    itemId: "eyes_panel",
                    layout: {
                        type: 'vbox',
                        align: 'stretch'
                    },
                    items: [
                        {
                            xtype: 'label',
                            margin: '5 0 0 0',
                            text: 'EYES'
                        },
                        {
                            xtype: 'checkboxfield',
                            margin: '5px',
                            fieldLabel: '',
                            name: 'eyes',
                            boxLabel: "<b>No Problem</b>",
                            inputValue: 'NP'
                        },
                        {
                            xtype: 'checkboxgroup',
                            padding: '',
                            fieldLabel: '',
                            columns: 3,
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes',
                                    boxLabel: 'Glasses',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes',
                                    boxLabel: 'Glaucoma',
                                    inputValue: '2'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes',
                                    boxLabel: 'Jaundice',
                                    inputValue: '3'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes',
                                    boxLabel: 'Contacts: R / L',
                                    inputValue: '4'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes_contacts',
                                    boxLabel: 'Right',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes_contacts',
                                    boxLabel: 'Left',
                                    inputValue: '2'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes',
                                    boxLabel: 'Blurred vision',
                                    inputValue: '5'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes',
                                    boxLabel: 'Ptosis',
                                    inputValue: '6'
                                }
                            ]
                        },
                        {
                            xtype: 'checkboxgroup',
                            fieldLabel: '',
                            columns: 3,
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    padding: '0 5 0 0',
                                    width: 120,
                                    name: 'eyes',
                                    boxLabel: 'Prosthesis: R / L',
                                    inputValue: '7'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes_prosthesis',
                                    boxLabel: 'Right',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes_prosthesis',
                                    boxLabel: 'Left',
                                    inputValue: '2'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes',
                                    boxLabel: 'Blind R / L',
                                    inputValue: '8'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes_blind',
                                    boxLabel: 'Right',
                                    inputValue: '1'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes_blind',
                                    boxLabel: 'Left',
                                    inputValue: '2'
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            border: false,
                            margin: '0 0 0 5',
                            header: false,
                            title: 'My Panel',
                            layout: {
                                type: 'table',
                                columns: 2
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: 'eyes',
                                    boxLabel: 'Other',
                                    inputValue: '9'
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: '',
                                    name: 'eyes_other'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    fieldLabel: '',
                                    name: 'eyes',
                                    boxLabel: 'Infections',
                                    inputValue: '10'
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: '',
                                    name: 'infections_text'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    padding: '0 5 0 0',
                                    fieldLabel: '',
                                    name: 'eyes',
                                    boxLabel: 'Cataract surgery: Site',
                                    inputValue: '11'
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: '',
                                    name: "cataract_surgery_site"
                                },
                                {
                                    xtype: 'datefield',
                                    width: 150,
                                    fieldLabel: 'Date',
                                    labelWidth: 30,
                                    name: 'cataract_surgery_date'
                                }
                            ]
                        },
                        {
                            xtype: 'label',
                            text: 'How does the impaired vision interfere/impact their function/safety?(explain)'
                        },
                        {
                            xtype: 'textareafield',
                            margin: '5px',
                            fieldLabel: '',
                            name: 'impaired_vision'
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    flex: 1,
                    border: false,
                    margin: '5px 3px 5px 3px',
                    header: false,
                    title: 'My Panel',
                    layout: {
                        type: 'vbox',
                        align: 'stretch'
                    },
                    items: [
                        {
                            xtype: 'panel',
                            flex: 1,
                            border: false,
                            margin: '5px',
                            header: false,
                            title: 'My Panel',
                            itemId: "nose_panel",
                            layout: {
                                type: 'vbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'label',
                                    text: 'NOSE'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '5px',
                                    fieldLabel: '',
                                    name: 'nose',
                                    boxLabel: "<b>No Problem</b>",
                                    inputValue: "NP"
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    padding: '',
                                    fieldLabel: '',
                                    layout: {
                                        type: 'table',
                                        columns: 2
                                    },
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'nose',
                                            boxLabel: 'Congestion',
                                            inputValue: '1',
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'nose',
                                            boxLabel: 'Epistaxis',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'nose',
                                            boxLabel: 'Loss of smell',
                                            inputValue: '3'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'nose',
                                            boxLabel: 'Sinus problem',
                                            inputValue: '4'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'nose',
                                            boxLabel: 'Other(specify)',
                                            inputValue: '5'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'textareafield',
                                    fieldLabel: '',
                                    name: 'nose_other',
                                    cols: 15
                                }
                            ]
                        },
                        {
                            xtype: 'panel',
                            flex: 1,
                            border: false,
                            margin: '5px',
                            header: false,
                            title: 'My Panel',
                            itemId: "throat_panel",
                            layout: {
                                type: 'vbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'label',
                                    text: 'THROAT'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '5px',
                                    fieldLabel: '',
                                    name: 'throat',
                                    boxLabel: "<b>No Problem</b>",
                                    inputValue: "NP"
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    border: false,
                                    padding: '',
                                    fieldLabel: '',
                                    layout: {
                                        type: 'table',
                                        columns: 2
                                    },
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'throat',
                                            boxLabel: 'Dysphagia',
                                            inputValue: "1"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'throat',
                                            boxLabel: 'Hoarseness',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'throat',
                                            boxLabel: 'Lesions',
                                            inputValue: '3',
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'throat',
                                            boxLabel: 'Sore throat',
                                            inputValue: '4'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'throat',
                                            boxLabel: 'Other(specify)',
                                            inputValue: '5'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'textareafield',
                                    fieldLabel: '',
                                    name: "other_throat"
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    flex: 1,
                    border: false,
                    margin: '5px 0 0 0',
                    width: 336,
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
                            margin: '5 5 0 5',
                            header: false,
                            title: 'My Panel',
                            itemId: "mouth_panel",
                            layout: {
                                type: 'vbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'label',
                                    text: 'MOUTH'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '5px',
                                    fieldLabel: '',
                                    name: 'mouth',
                                    boxLabel: "<b>No Problem</b>",
                                    inputValue: 'NP'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    padding: '',
                                    fieldLabel: '',
                                    columns: 4,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'mouth',
                                            boxLabel: 'Dentures:',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'dentures',
                                            boxLabel: 'Upper',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'dentures',
                                            boxLabel: 'Lower',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'dentures',
                                            boxLabel: 'Partial',
                                            inputValue: '3'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'mouth',
                                            boxLabel: 'Masses',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'mouth',
                                            boxLabel: 'Tumors',
                                            inputValue: '3'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'mouth',
                                            boxLabel: 'Gingivitis',
                                            inputValue: '4'
                                        }
                                    ]
                                },{
                                    xtype: 'checkboxgroup',
                                    margin: '0 5 0 5',
                                    width: 336,
                                    fieldLabel: '',
                                    columns: 2,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'mouth',
                                            boxLabel: 'Ulcerations',
                                            inputValue: '5'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'mouth',
                                            boxLabel: 'Toothache',
                                            inputValue: '6'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            width: 150,
                                            name: 'mouth',
                                            boxLabel: 'Other(specify)',
                                            inputValue: '7'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'textareafield',
                                    margin: '0 5 0 5',
                                    fieldLabel: '',
                                    name: 'mouth_other'
                                }
                            ]
                        },

                        {
                            xtype: 'panel',
                            flex: 1,
                            border: false,
                            margin: '5px',
                            header: false,
                            title: 'My Panel',
                            itemId: "ears_panel",
                            layout: {
                                type: 'vbox',
                                align: 'stretch'
                            },
                            items: [
                                {
                                    xtype: 'label',
                                    text: 'EARS'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    margin: '5px',
                                    fieldLabel: '',
                                    name: 'ears',
                                    boxLabel: "<b>No Problem</b>",
                                    inputValue: 'NP'
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    padding: '',
                                    fieldLabel: '',
                                    columns: 3,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'ears',
                                            boxLabel: 'HOH: R / L',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'hoh',
                                            boxLabel: 'Right',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'hoh',
                                            boxLabel: 'Left',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'ears',
                                            boxLabel: 'Deaf: R / L',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'deaf',
                                            boxLabel: 'Right',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'deaf',
                                            boxLabel: 'Left',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            width: 150,
                                            name: 'ears',
                                            boxLabel: 'Hearing aid: R / L',
                                            inputValue: '3'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'hearing_aid',
                                            boxLabel: 'Right',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'hearing_aid',
                                            boxLabel: 'Left',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'ears',
                                            boxLabel: 'Tinnitus: R / L',
                                            inputValue: '4'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'tinnitus',
                                            boxLabel: 'Right',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'tinnitus',
                                            boxLabel: 'Left',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'ears',
                                            boxLabel: 'Vertigo',
                                            inputValue: '5'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'checkboxfield',
                                    flex: 1,
                                    margin: '0 5 0 5',
                                    name: 'ears',
                                    boxLabel: 'Other(specify)',
                                    inputValue: '6'
                                },
                                {
                                    xtype: 'textareafield',
                                    margin: '0 5 0 5',
                                    fieldLabel: '',
                                    name: "ears_other"
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
        var noProblems = this.query("[boxLabel=<b>No Problem</b>]");
        Ext.each(noProblems, function(noProblem){
            noProblem.on("change", function(ele){
                var panel = ele.up("#" + noProblem.name + "_panel");
                var fields = panel.query("textfield, textarea, datefield, numberfield, checkboxgroup, radiogroup, checkboxfield, radiofield");
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
            }, this);
        }, this);
    }
})
