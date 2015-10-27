/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.genitourinary', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.genitourinary',
    border: false,
    margin: 5,
    items: [


        {
            border: false,
            header: false,
            height: 700,
            marign: 5,
            items: [
                {
                    xtype: "checkboxfield",
                    name: "genitourinary_no_problem",
                    boxLabel: "<b>No Problem</b>",
                    margin: 5,
                    inputValue: "NP"
                },{
                    header: false,
                    border: false,
                    layout: {type: "hbox"},
                    items: [
                        {
                            header: false,
                            border: false,
                            flex: 1,
                            layout: {type: "vbox", align: "stretch"},
                            margin: "0 5 5 5",
                            items: [
                                {
                                    header: false,
                                    border: false,
                                    layout: 'vbox',
                                    items: [
                                        {
                                            header: false,
                                            border: false,
                                            layout: {type: "table", columns: 2},
                                            items: [
                                                {
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Urgency",
                                                    inputValue: "1",
                                                    width: 100
                                                },{
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Frequency",
                                                    inputValue: "2",
                                                    width: 100
                                                },
                                                {
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Burning",
                                                    inputValue: "3",
                                                    width: 100
                                                },
                                                {
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Pain",
                                                    inputValue: "4"
                                                },
                                                {
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Hesitancy",
                                                    inputValue: "5"
                                                },
                                                {
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Nocturia",
                                                    inputValue: "6"
                                                },
                                                {
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Hematuria",
                                                    inputValue: "7"
                                                },
                                                {
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Oliguria",
                                                    inputValue: "8"
                                                },{
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Anuria",
                                                    inputValue: "9"
                                                },{
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Diapers",
                                                    inputValue: "11"
                                                }

                                            ]
                                        },
                                        {
                                            header: false,
                                            border: false,
                                            layout: {type: "table", columns: 2},
                                            items: [
                                                {
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Incontinence (details if applicable)",
                                                    inputValue: "10"
                                                },
                                                {
                                                    xtype: "textfield",
                                                    name: "incontinence_details",
                                                    isHeader: false
                                                },
                                            ]
                                        }, {
                                            header: false,
                                            border: false,
                                            layout: {type: "table", columns: 2},
                                            items: [
                                                {
                                                    xtype: "checkboxfield",
                                                    name: "genitourinary",
                                                    boxLabel: "Other",
                                                    inputValue: "12",
                                                    margin: "0 5 0 0"
                                                },
                                                {
                                                    xtype: "textfield",
                                                    name: "other_genitourinary",
                                                    width: 326
                                                }
                                            ]
                                        },

                                    ]
                                },
                                {
                                    header: false,
                                    border: false,
                                    items: [
                                        {
                                            xtype: "label",
                                            text: "Urinary Catheter",
                                        },
                                        {
                                            border: false,
                                            header: false,
                                            layout: {type: "table", columns: 2},
                                            items: [
                                                { xtype: "textfield",
                                                    fieldLabel: "Type",
                                                    name: "urinary_catheter_type",
                                                    labelAlign: "top",
                                                    isHeader: false,

                                                },
                                                { xtype: "datefield",
                                                    fieldLabel: "Date last changed",
                                                    name: "urinary_catheter_date",
                                                    margin: "0 0 0 5",
                                                    labelAlign: "top",
                                                    isHeader: false,
                                                }
                                            ]
                                        },
                                        {
                                            border: false,
                                            header: false,
                                            items: [
                                                {
                                                    xtype: "datefield",
                                                    fieldLabel: "Foley inserted (date)",
                                                    name: "foly_inserted_date",
                                                    margin: "5 0 5 0",
                                                    isHeader: false
                                                },{
                                                    xtype: "textfield",
                                                    fieldLabel: "French (size)",
                                                    isHeader: false,
                                                    name: "french"
                                                },{
                                                    xtype: "textfield",
                                                    fieldLabel: "Inflated balloon with(ml)",
                                                    isHeader: false,
                                                    name: "inflated_balloon_with"
                                                },{
                                                    border: false,
                                                    header: false,
                                                    layout: {type: "table", columns: 2},
                                                    items: [
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_difficulty",
                                                            boxLabel: "Without difficulty",
                                                            inputValue: "1",
                                                            margin: "0 5 0 0"
                                                        },{
                                                            xtype: "radiofield",
                                                            name: "genitourinary_difficulty",
                                                            boxLabel: "Suprapubic",
                                                            inputValue: "2"
                                                        }
                                                    ]
                                                }
                                            ]
                                        },
                                        {
                                            xtype: "radiogroup",
                                            fieldLabel: "Patient tolerated procedure well",
                                            isHeader: false,
                                            labelAlign: "top",
                                            layout: {type: "table", columns: 2},
                                            items: [
                                                {
                                                    xtype: "radiofield",
                                                    name: "tolerated_procedure_well",
                                                    boxLabel: "Yes",
                                                    inputValue: "Y",
                                                    margin: "0 5 0 0"
                                                },
                                                {
                                                    xtype: "radiofield",
                                                    name: "tolerated_procedure_well",
                                                    boxLabel: "No",
                                                    inputValue: "N"
                                                }
                                            ]
                                        },{
                                            border: false,
                                            header: false,
                                            items: [
                                                {
                                                    xtype: "label",
                                                    isHeader: false,
                                                    text: "Irrigation solution"
                                                },{
                                                    xtype: "textfield",
                                                    fieldLabel: "Type",
                                                    isHeader: false,
                                                    name: "irrigation_solution_type"
                                                },{
                                                    xtype: "textfield",
                                                    fieldLabel: "Amount(mL)",
                                                    isHeader: false,
                                                    name: "irrigation_solution_amount"
                                                },{
                                                    xtype: "textfield",
                                                    fieldLabel: "Frequency",
                                                    isHeader: false,
                                                    name: "irrigation_solution_frequency"
                                                },{
                                                    xtype: "textfield",
                                                    fieldLabel: "Returns",
                                                    isHeader: false,
                                                    name: "irrigation_solution_returns"
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        },{
                            header: false,
                            border: false,
                            flex: 1,
                            items: [
                                {
                                    header: false,
                                    border: false,
                                    layout: "hbox",
                                    margin: 5,
                                    items: [
                                        {
                                            header: false,
                                            border: false,
                                            items: [
                                                {
                                                    xtype: "radiogroup",
                                                    fieldLabel: "Color",
                                                    labelAlign: "top",
                                                    layout: {type: "table", columns: 2},
                                                    items: [
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_color",
                                                            boxLabel: "Yellow",
                                                            inputValue: "YE",
                                                            margin: "0 5 0 0"
                                                        },{
                                                            xtype: "radiofield",
                                                            name: "genitourinary_color",
                                                            boxLabel: "Straw",
                                                            inputValue: "ST"
                                                        },
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_color",
                                                            boxLabel: "Amber",
                                                            inputValue: "AM",
                                                            margin: "0 5 0 0"
                                                        },
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_color",
                                                            boxLabel: "Brown",
                                                            inputValue: "BR"
                                                        },
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_color",
                                                            boxLabel: "Gray",
                                                            inputValue: "GR",
                                                            margin: "0 5 0 0"
                                                        },
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_color",
                                                            boxLabel: "Blood-tinged",
                                                            inputValue: "BT"
                                                        },{
                                                            xtype: "radiofield",
                                                            name: "genitourinary_color",
                                                            boxLabel: "Other",
                                                            inputValue: "OTH",
                                                            margin: "0 5 0 0"
                                                        },
                                                        {
                                                            xtype: "textfield",
                                                            name: "genitourinary_color_other",
                                                            isHeader: false,
                                                            fieldLabel: "",
                                                            labelWidth: 50
                                                        }
                                                    ]
                                                }
                                            ]
                                        },{
                                            header: false,
                                            border: false,
                                            items: [
                                                {
                                                    xtype: "radiogroup",
                                                    fieldLabel: "Clarity",
                                                    labelAlign: "top",
                                                    layout: {type: "table", columns: 2},
                                                    items: [
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_clarity",
                                                            boxLabel: "Clear",
                                                            margin: "0 5 0 0",
                                                            inputValue: "CL"
                                                        },
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_clarity",
                                                            boxLabel: "Cloudy",
                                                            inputValue: "CD"
                                                        },
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_clarity",
                                                            boxLabel: "Sediment",
                                                            inputValue: "SD",
                                                            margin: "0 5 0 0"

                                                        },
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_clarity",
                                                            boxLabel: "Mucous",
                                                            inputValue: "MU"
                                                        }
                                                    ]
                                                },

                                                {
                                                    xtype: "radiogroup",
                                                    fieldLabel: "Odor",
                                                    labelAlign: "top",
                                                    layout: {type: "table", columns: 2},
                                                    items: [
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_odor",
                                                            boxLabel: "Yes",
                                                            inputValue: "Y",
                                                            margin: "0 5 0 0"
                                                        },
                                                        {
                                                            xtype: "radiofield",
                                                            name: "genitourinary_odor",
                                                            boxLabel: "No",
                                                            inputValue: "N"
                                                        }
                                                    ]
                                                },
                                            ]
                                        }
                                    ]
                                },{
                                    header: false,
                                    border: false,
                                    margin: 5,
                                    items: [
                                        {
                                            xtype: "checkboxfield",
                                            name: "urostomy",
                                            boxLabel: "Urostomy (describe skin around stoma)",
                                            isHeader: false,
                                            margin: "0 0 0 5",
                                            inputValue: "13"
                                        },
                                        {
                                            xtype: "textarea",
                                            name: "genitourinary_urostomy",
                                            isHeader: false,
                                            cols: 55,
                                            margin: "0 0 0 5"
                                        },{
                                            xtype: "radiogroup",
                                            fieldLabel: "Ostomy care managed by",
                                            labelAlign: top,
                                            layout: {type: "table", columns: 2},
                                            items: [
                                                {
                                                    xtype: "radiofield",
                                                    name: "ostomy_care_managed_by",
                                                    boxLabel: "Self",
                                                    inputValue: "SF",
                                                    margin: "0 5 0 5"
                                                },
                                                {
                                                    xtype: "radiofield",
                                                    name: "ostomy_care_managed_by",
                                                    boxLabel: "Caregiver",
                                                    inputValue: "CG"
                                                },
                                            ]
                                        },
                                        {
                                            xtype: "checkboxfield",
                                            name: "ostomy_care_managed_by",
                                            boxLabel: "Other(specify)",
                                            inputValue: "OTH",
                                            margin: "0 0 0 5"
                                        },
                                        {
                                            xtype: "textarea",
                                            labelAlign: "top",
                                            name: "other_ostomy_care_managed_by",
                                            cols: 55,
                                            margin: "0 0 0 5"
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
})
