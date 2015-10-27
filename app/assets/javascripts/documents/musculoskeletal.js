/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.Musculoskeletal', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.musculoskeletal',
    items: [
        {
            xtype: 'checkboxfield',
            margin: '5 0 0 5',
            name: 'musculoskeletal',
            boxLabel: '<b>No Problem</b>',
            inputValue: 'NP',
            width: 100
        },
        {xtype: 'panel',
            layout: "hbox",
            border: false,
            header: false,
            items: [
                {
                    xtype: "panel",
                    layout: 'vbox',
                    border: false,
                    header: false,
                    flex: 1,
                    items: [
                        {
                            xtype: 'fieldcontainer',
                            margin: '5 5 0 5',
                            layout: 'hbox',
                            items:[
                                {
                                    xtype: 'checkboxfield',
                                    name: 'musculoskeletal',
                                    boxLabel: 'Hemiplegia',
                                    inputValue: '1',
                                    width: 132
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'musculoskeletal',
                                    boxLabel: 'Paraplegia',
                                    inputValue: '2',
                                    margin: "0 5 0 0"
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: 'musculoskeletal',
                                    boxLabel: 'Quadriplegia',
                                    inputValue: '3'
                                },

                            ]
                        },
                        { border: false,
                            header: false,
                            layout: {type: "table", columns: 2},
                            margin: 5,
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    boxLabel: 'Fracture(location)',
                                    inputValue: '7',
                                    width: 130,
                                    name: 'musculoskeletal',
                                    isHeader: false
                                },
                                {
                                    xtype: 'textfield',
                                    margin: '0 0 0 5',
                                    isHeader: false,
                                    name: 'fracture',
                                    width: 180
                                },
                                {
                                    xtype: 'checkboxfield',
                                    boxLabel: 'Atrophy',
                                    inputValue: '9',
                                    width: 130,
                                    name: 'musculoskeletal',
                                    isHeader: false
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'antrophy',
                                    margin: '0 0 0 5',
                                    width: 180
                                },
                                {
                                    xtype: 'checkboxfield',
                                    width: 130,
                                    boxLabel: 'Paresthesia',
                                    inputValue: '11',
                                    name: 'musculoskeletal',
                                    isHeader: false
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'paresthesia',
                                    margin: '0 0 0 5',
                                    width: 180
                                }
                            ]
                        },{
                            xtype: 'fieldcontainer',
                            layout: {
                                type: 'vbox',
                            },
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    margin: 5,
                                    boxLabel: 'Contractures',
                                    inputValue: '13',
                                    name: 'musculoskeletal',
                                    isHeader: false,
                                },
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Joint',
                                    name: 'contractures_joint',
                                    margin: '0 0 0 20',
                                    isHeader: false,
                                    labelWidth: 115,
                                    width: 300
                                },

                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Location',
                                    name: 'contractures_location',
                                    margin: '3 0 0 20',
                                    isHeader: false,
                                    labelWidth: 115,
                                    width: 300
                                }
                            ]
                        },{
                            xtype: 'fieldcontainer',
                            margin: 5,
                            layout: 'vbox',
                            items:[
                                {
                                    xtype: 'checkboxfield',
                                    name: 'musculoskeletal',
                                    boxLabel: 'Other(specify)',
                                    inputValue: '15',
                                    width: 120
                                },
                                {
                                    xtype: 'textareafield',
                                    name: 'musculoskeletal_other',
                                    margin: '0 0 0 15',
                                    labelWidth: 50,
                                    cols: 39
                                }
                            ]
                        },
                    ]

                },{xtype: "panel",
                    border: false,
                    header: false,
                    flex: 1,
                    items: [
                        {
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 3},
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    margin: '0 0 0 5',
                                    width: 130,
                                    boxLabel: 'Poor conditioning',
                                    inputValue: '4',
                                    name: 'musculoskeletal',
                                    isHeader: false
                                },
                                {
                                    xtype: 'checkboxfield',
                                    width: 120,
                                    margin: '0 0 0 3',
                                    boxLabel: 'Shuffling',
                                    inputValue: '5',
                                    name: 'musculoskeletal',
                                    isHeader: false
                                },
                                {
                                    xtype: 'checkboxfield',
                                    width: 120,
                                    margin: '0 0 0 5',
                                    boxLabel: 'Wide-based gait',
                                    inputValue: '6',
                                    name: 'musculoskeletal',
                                    isHeader: false
                                }
                            ]
                        },{
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 2},
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    boxLabel: 'Swollen, painful joints(specify)',
                                    inputValue: '8',
                                    margin: '0 0 5 5',
                                    width: 200,
                                    name: 'musculoskeletal',
                                    isHeader: false
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'swollon_painful_joints',
                                    margin: '0 0 5 5',
                                    isHeader: false,
                                    width: 180

                                },
                                {
                                    xtype: 'checkboxfield',
                                    width: 200,
                                    margin: '0 0 5 5',
                                    boxLabel: 'Decreased ROM',
                                    inputValue: '10',
                                    name: 'musculoskeletal',
                                    isHeader: false
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'decreased_rom',
                                    margin: '0 0 5 5',
                                    width: 180
                                },
                                {
                                    xtype: 'checkboxfield',
                                    width: 200,
                                    margin: '0 0 0 5',
                                    boxLabel: 'Weakness',
                                    inputValue: '12',
                                    name: 'musculoskeletal',
                                    isHeader: false
                                },
                                {
                                    xtype: 'textfield',
                                    name: 'weakness',
                                    margin: '0 0 5 5',
                                    width: 180
                                }
                            ]
                        },{
                            xtype: 'fieldcontainer',
                            layout: 'vbox',
                            margin: '5px',
                            items:[
                                {
                                    xtype: 'checkboxfield',
                                    xmargin: '3px',
                                    boxLabel: 'Amputation',
                                    inputValue: '14',
                                    name: 'musculoskeletal',
                                    isHeader: false
                                },
                                {
                                    xtype: 'fieldcontainer',
                                    margin: '0 0 0 20',
                                    layout: 'hbox',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'amputation',
                                            boxLabel: 'BK',
                                            inputValue: 'BK',
                                            width: 60
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'amputation',
                                            boxLabel: "AK",
                                            inputValue: "AK",
                                            width: 60
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'amputation',
                                            boxLabel: "UE",
                                            inputValue: "UE",
                                            width: 60
                                        },
                                    ]
                                },
                                {
                                    xtype: 'fieldcontainer',
                                    margin: '0 0 0 20',
                                    layout: 'hbox',
                                    items:[
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'amputation',
                                            boxLabel: "Right",
                                            inputValue: "Right",
                                            width:60
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'amputation',
                                            boxLabel: "Left",
                                            inputValue: "Left",
                                            width: 60
                                        }

                                    ]
                                },
                                {
                                    xtype: 'textareafield',
                                    fieldLabel: '(specify)',
                                    margin: '0 0 0 20',
                                    name: 'amputation_specify',
                                    labelWidth: 50,
                                    labelAlign: 'top',
                                    cols: 47
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
