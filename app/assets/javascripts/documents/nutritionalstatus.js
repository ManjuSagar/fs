/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.nutritionalstatus', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.nutritionalstatus',
    border: false,
    margin: 5,
    items: [
        {
            border: false,
            header: false,
            items: [
                {
                    xtype: "checkboxfield",
                    name: "nutritional_status_no_problem",
                    boxLabel: "<b>No Problem</b>",
                    inputValue: "NP",
                    margin: 5,
                },
                {
                    border: false,
                    header: false,
                    layout: "hbox",
                    items: [
                        {
                            border: false,
                            header: false,
                            margin: "0 5 5 5",
                            items: [
                                {
                                    border: false,
                                    header: false,
                                    layout: {type: "table", columns: 3},
                                    items: [
                                        {
                                            xtype: "checkboxfield",
                                            name: "nutritional_status",
                                            boxLabel: "NAS",
                                            inputValue: "1",
                                            margin: "0 5 0 0"
                                        },{
                                            xtype: "checkboxfield",
                                            name: "nutritional_status",
                                            boxLabel: "NPO",
                                            inputValue: "2",
                                            margin: "0 5 0 0"
                                        },{
                                            xtype: "checkboxfield",
                                            name: "nutritional_status",
                                            boxLabel: "Controlled Carbohydrate",
                                            inputValue: "3"
                                        },

                                    ]
                                },{
                                    border: false,
                                    header: false,
                                    layout: {type: "table", columns: 2},
                                    items: [
                                        {
                                            xtype: "checkboxfield",
                                            name: "nutritional_status",
                                            boxLabel: "Other",
                                            inputValue: "4",
                                            margin: "0 5 0 0"
                                        },{
                                            xtype: "textfield",
                                            name: "nutritional_status_other",
                                            width: 210
                                        }
                                    ]
                                },{
                                    xtype: "textarea",
                                    name: "nutritional_requirements_diet",
                                    labelAlign: "top",
                                    isHeader: false,
                                    fieldLabel: "Nutritional requirements (diet)",
                                    cols: 80
                                },{ border: false,
                                    header: false,
                                    layout: {type: "table", columns: 4},
                                    items: [
                                        {
                                            xtype: "checkboxfield",
                                            name: "nutritional_status",
                                            boxLabel: "Increase fluids (amount):",
                                            inputValue: "5",
                                            margin: "0 5 0 0"
                                        },
                                        {
                                            xtype: "textfield",
                                            name: "nutritional_fluids_amt",
                                            isHeader: false,
                                            margin: "0 5 0 0",
                                            width: 125

                                        },{
                                            xtype: "checkboxfield",
                                            name: "nutritional_status",
                                            boxLabel: "Restrict fluids (amount):",
                                            inputValue: "6",
                                            margin: "0 5 0 0"

                                        },{
                                            xtype: "textfield",
                                            name: "restrict_fluids_amt",
                                            isHeader: false,
                                            width: 125
                                        },
                                    ]},{
                                    xtype: "radiogroup",
                                    fieldLabel: "Appetite",
                                    labelAlign: "top",
                                    layout: {type: "table", columns: 4},
                                    items: [
                                        {
                                            xtype: "radiofield",
                                            name: "nutritional_appetite",
                                            boxLabel: "Good",
                                            inputValue: "G",
                                            margin: "0 5 0 0"
                                        },{
                                            xtype: "radiofield",
                                            name: "nutritional_appetite",
                                            boxLabel: "Fair",
                                            inputValue: "F",
                                            margin: "0 5 0 0",
                                        },{
                                            xtype: "radiofield",
                                            name: "nutritional_appetite",
                                            boxLabel: "Poor",
                                            inputValue: "P",
                                            margin: "0 5 0 0",

                                        },{
                                            xtype: "radiofield",
                                            name: "nutritional_appetite",
                                            boxLabel: "Anorexic",
                                            inputValue: "A",
                                            margin: "0 5 0 0"
                                        }
                                    ]
                                },{
                                    border: false, header: false,
                                    items: [
                                        {
                                            xtype: "checkboxfield",
                                            boxLabel: "Nausea/Vomiting",
                                            name: 'appetite',
                                            inputValue: '1'
                                        },
                                        {
                                            border: false, header: false,
                                            layout: {type: "table", columns: 2},
                                            items: [
                                                {
                                                    xtype: "textfield",
                                                    fieldLabel: "Frequency",
                                                    isHeader: false,
                                                    name: "vomiting_frequency",
                                                    labelWidth: 70,
                                                    margin: "0 5 0 5",
                                                },{
                                                    xtype: "textfield",
                                                    isHeader: false,
                                                    name: "vomiting_amount",
                                                    fieldLabel: "Amount",
                                                    labelWidth: 70,

                                                }
                                            ]
                                        }
                                    ]
                                },{
                                    xtype: "checkboxfield",
                                    name: "appetite",
                                    boxLabel: "Heartburn(food intolerance)",
                                    inputValue: '2'

                                },{
                                    xtype: "checkboxfield",
                                    name: "appetite",
                                    boxLabel: "Other",
                                    inputValue: '3'

                                },{
                                    xtype: "textarea",
                                    cols: 80,
                                    isHeader: false,
                                    name: "appetite_other"
                                }
                            ]
                        },{
                            xtype: 'panel',
                            layout: 'vbox',
                            border: false,
                            header: false,
                            margin: 5,
                            items: [{
                                border: false,
                                header: false,
                                margin: 5,
                                layout: {type: "hbox"},
                                items: [{
                                    xtype: "label",
                                    html: '<b>Directions:</b> Check each area with "yes" to assessment, then total score will determine additional risk.',
                                    isHeader: false,
                                    width: 400,
                                },{
                                    xtype: "label",
                                    text: "YES"
                                },
                                ]

                            },{

                                border: false,
                                header: false,
                                defaults: {labelWidth: 400},
                                margin: 5,
                                layout: {type: "vbox", align: "stretch"},
                                items: [
                                    {
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Has an illness or condition that changed the kind and/or amount of food eaten",
                                        boxLabel: "2",
                                        inputValue: 1
                                    },{
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Eats fewer than 2 meals per day",
                                        boxLabel: "3",
                                        inputValue: 2
                                    },{
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Eats few fruits, vegetables or milk products",
                                        boxLabel: "2",
                                        inputValue: 3
                                    },{
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Has 3 or more drinks of beer, liquor or wine almost every day",
                                        boxLabel: "2",
                                        inputValue: 4
                                    },{
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Has tooth or mouth problems that make it hard to eat",
                                        boxLabel: "2",
                                        inputValue: 5
                                    },{
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Does not always have enough money to buy the food needed",
                                        boxLabel: "4",
                                        inputValue: 6
                                    },{
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Eats alone most of the time",
                                        boxLabel: "1",
                                        inputValue: 7
                                    },{
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Takes 3 or more different prescribed or over-the-counter drugs a day",
                                        boxLabel: "1",
                                        inputValue: 8
                                    },{
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Without wanting to, has lost or gained 10 pounds in the last 6 months",
                                        boxLabel: "2",
                                        inputValue: 9
                                    },{
                                        xtype: "checkboxfield",
                                        name: "heart_burn",
                                        fieldLabel: "Not always physically able to shop, cook and/or feed self",
                                        boxLabel: "2",
                                        inputValue: 10
                                    },
                                ]
                            },{
                                xtype: "numberfield",
                                itemId: "total_points",
                                name: "nutritional_status_total",
                                fieldLabel: "<b>TOTAL<b/>",
                                margin: "0 0 0 335",
                                labelWidth: 50,
                                readOnly: true,
                                width: 120
                            }
                            ]
                        }
                    ]

                },
                {
                    border: false,
                    header: false,
                    items: [
                        {
                            xtype: "label",
                            margin: 5,
                            text: "Reprinted with permission by the Nutrition Screening Initiative, a project of  the American Academy of Family Physicians, the American Dietetic Association and the National Council on the Aging, Inc., and funded in part by a grant from Ros Products Division, Abbott Laboratories Inc."
                        },
                        {
                            xtype: "fieldset",
                            title: "INTERPRETATION",
                            margin: 5,
                            items: [
                                {
                                    html: "<b>0-2 Good.</b> As appropriate reassess and/or provide information based on situation. <br/><b>3-5 Moderate risk.</b> Educate, refer, monitor and reevaluate based on patient situation and organiza <br/><b>6 or more High risk.</b> Coordinate with physician, dietitian, social service professional or nurse about how to improve nutritional health. Reassess nutritional status and educate based on plan of care.",
                                    border:false
                                },
                                {
                                    xtype: "textarea",
                                    isHeader: false,
                                    fieldLabel: "Describe at risk intervention and plan",
                                    labelAlign: "top",
                                    cols: 80,
                                    name: "risk_intervention_and_plan"
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
        var points = this.down("#total_points");
        var checkboxes = points.up("panel").query("checkboxfield");
        Ext.each(checkboxes, function(field){
            field.on("change", function(ele){
                if (ele.checked)
                    points.setValue(points.value + parseInt(ele.boxLabel));
                else
                    points.setValue(points.value - parseInt(ele.boxLabel));
            }, this);
        }, this);
    }

})
