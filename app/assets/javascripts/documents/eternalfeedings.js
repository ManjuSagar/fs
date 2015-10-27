/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.eternalfeedings', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.eternalfeedings',
    border: false,
    margin: 5,
    items: [

        {
            xtype: "checkboxfield",
            name: "enteral_feedings_no_problem",
            boxLabel: "<b>No Problem</b>",
            inputValue: "NP"
        },{
            header: false,
            border: false,
            layout: "hbox",
            items: [
                {
                    border: false,
                    header: false,
                    layout: {type: 'vbox'},
                    items: [
                        {
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 2},
                            items: [
                                {
                                    xtype: "checkboxfield",
                                    name: "enteral_feedings",
                                    boxLabel: "Nasogastric",
                                    inputValue: "1",
                                    margin: "0 8 0 0"
                                },{
                                    xtype: "checkboxfield",
                                    name: "enteral_feedings",
                                    boxLabel: "Gastrostomy",
                                    inputValue: "2"
                                }
                            ]},{
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 3},
                            items: [{
                                xtype: "checkboxfield",
                                name: "enteral_feedings",
                                boxLabel: "Jejunostomy",
                                inputValue: "3",
                                margin: "0 5 0 0"
                            },{
                                xtype: "checkboxfield",
                                name: "enteral_feedings",
                                boxLabel: "Other(specify):",
                                inputValue: "4",
                                margin: "0 5 0 0"
                            },{
                                xtype: "textfield",
                                name: "enteral_feedings_other",
                            }
                            ]
                        },{
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 2},
                            items: [
                                {
                                    xtype: "checkboxfield",
                                    name: "enteral_feedings",
                                    boxLabel: "Pump",
                                    width: 130,
                                    inputValue: "5"
                                },{
                                    xtype: "textfield",
                                    fieldLabel: "Type/specify",
                                    name: "enteral_feedings_pump",
                                    isHeader: false,
                                    labelWidth: 75
                                }
                            ]
                        },{
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 2},
                            items: [
                                {
                                    xtype: "radiofield",
                                    name: "enteral_feedings_pump_type",
                                    boxLabel: "Bolus",
                                    inputValue: "B",
                                    margin: "0 5 0 0"
                                },{
                                    xtype: "radiofield",
                                    name: "enteral_feedings_pump_type",
                                    boxLabel: "Continuous",
                                    inputValue: "C"
                                }
                            ]
                        },{
                            xtype: "textfield",
                            name: "feedings_type_rate",
                            isHeader: false,
                            fieldLabel: "Feedings: Type (amt/rate)"
                        },{
                            xtype: "textfield",
                            name: "flush_protocol",
                            isHeader: false,
                            fieldLabel: "Flush Protocol: (amt/rate)"
                        },{
                            xtype: "label",
                            text: "Performed by:",
                            isHeader: false
                        },{
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 2},
                            items: [
                                {
                                    xtype: "radiofield",
                                    name: "enteral_feeding_performed_by",
                                    boxLabel: "Self",
                                    inputValue: "SF",
                                    margin: "0 5 0 0"
                                },
                                {
                                    xtype: "radiofield",
                                    name: "enteral_feeding_performed_by",
                                    boxLabel: "RN",
                                    inputValue: "RN"
                                }]
                        },{border: false,
                            header: false,
                            layout: {type: "table", columns: 3},
                            items: [
                                {
                                    xtype: "radiofield",
                                    name: "enteral_feeding_performed_by",
                                    boxLabel: "Caregiver",
                                    inputValue: "CG",
                                    margin: "0 15 0 0"
                                },
                                {
                                    xtype: "radiofield",
                                    name: "enteral_feeding_performed_by",
                                    boxLabel: "Other:",
                                    inputValue: "OTH",
                                    margin: "0 5 0 0"
                                },
                                {
                                    xtype: "textfield",
                                    name: "enteral_feeding_performed_by_other",
                                }
                            ]
                        }
                    ]
                },{
                    header: false,
                    border: false,
                    items: [
                        {
                            xtype: "textarea",
                            fieldLabel: "Dressing /Site care (specify)",
                            isHeader: false,
                            name: "dressing_site_care",
                            labelAlign: "top",
                            margin: '0 0 0 20',
                            cols: 80
                        },{
                            xtype: "textarea",
                            fieldLabel: "Interventions /Instructions / Comments",
                            isHeader: false,
                            labelAlign: "top",
                            margin: '0 0 0 20',
                            name: "enteral_feedings_interventions",
                            cols: 80
                        }
                    ]
                }
            ]
        }
    ]

})
