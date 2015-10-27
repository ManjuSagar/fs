/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.Elimination', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.elimination',
    border: false,
    items: [
        {
            xtype: "checkboxfield",
            name: "elimination_no_problem",
            boxLabel: "<b>No Problem</b>",
            inputValue: "NP"
        },
        {
            header: false,
            border: false,
            layout: "hbox",
            items: [
                {
                    border: false,
                    header: false,
                    flex: 1,
                    items: [
                        {
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 3},
                            defaults: {margin: "0 5 0 0"},
                            items: [
                                {
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Flatulence",
                                    inputValue: "1"
                                },{
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Constipation",
                                    inputValue: "2"
                                },
                                {
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Impaction",
                                    inputValue: "3"
                                },{
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Diarrhea",
                                    inputValue: "4"
                                },{
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Hemorrhoids",
                                    inputValue: "6"
                                },{
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Rectal bleeding",
                                    inputValue: "7"
                                }
                            ]
                        },{
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 2},
                            items: [
                                {
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Last BM",
                                    inputValue: "5",
                                    margin: "0 5 0 0"

                                },{
                                    xtype: "textfield",
                                    isHeader: false,
                                    name: "elimination_last_bm",
                                },{
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Frequency of stools",
                                    inputValue: "8",
                                    margin: "0 5 0 0"


                                },{
                                    xtype: "textfield",
                                    name: "frequency_of_stools",
                                },{
                                    xtype: "label",
                                    text: "Bowel regime/program:",
                                    isHeader: false,
                                    margin: "0 5 0 0"


                                },{
                                    xtype: "textfield",
                                    name: "bowel_regime_program",
                                    isHeader: false,
                                }
                            ]
                        },{
                            border: false,
                            header: false,
                            layout: "hbox",
                            items: [
                                {
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Laxative/Enema use:",
                                    inputValue: "9"
                                },
                            ]
                        },{
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 3},
                            items: [{
                                xtype: "radiofield",
                                name: "laxative_enema_use",
                                margin: "0 0 0 5",
                                boxLabel: "Daily",
                                inputValue: "D"
                            },{
                                xtype: "radiofield",
                                name: "laxative_enema_use",
                                margin: "0 0 0 5",
                                boxLabel: "Weekly",
                                inputValue: "W"
                            },{
                                xtype: "radiofield",
                                name: "laxative_enema_use",
                                boxLabel: "Monthly",
                                margin: "0 0 0 5",
                                inputValue: "M"
                            },]},{
                            border: false,
                            header: false,
                            layout: {type: "table", columns: 2},
                            items: [
                                {
                                    xtype: "radiofield",
                                    name: "laxative_enema_use",
                                    boxLabel: "Other",
                                    margin: "0 5 0 5",
                                    inputValue: "O"
                                },
                                {
                                    xtype: "textfield",
                                    name: "other_laxative_enema_use",
                                    isHeader: false,
                                    width: 229
                                },

                            ]
                        },{
                            xtype: "checkboxfield",
                            name: "elimination",
                            boxLabel: "Incontinence (details if applicable)",
                            inputValue: "10"
                        },{
                            xtype: "textarea",
                            name: "elimination_incontinence",
                            margin: "0 0 0 5",
                            cols: 41,
                            fieldLabel: ""
                        },{
                            border: false,
                            header: false,
                            layout: "hbox",
                            margin: "5 0 0 0",
                            items: [
                                {
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Diapers / Other: ",
                                    inputValue: "11"
                                },{
                                    xtype: "textfield",
                                    name: "elimination_diapers",
                                    fieldLabel: "",
                                    margin: "0 0 0 5",
                                    width: 171
                                }
                            ]
                        },

                    ]
                },{
                    header: false,
                    border: false,
                    flex: 1,
                    items: [
                        {
                            border: false,
                            header: false,
                            items: [
                                {
                                    xtype: "checkboxfield",
                                    name: "elimination",
                                    boxLabel: "Ileostomy/Colostomy site (describe skin around stoma):",
                                    inputValue: "12"

                                },
                                {
                                    xtype: "textarea",
                                    name: "skin_arround_stoma",
                                    isHeader: false,
                                    labelAlign: "top",
                                    fieldLabel: "",
                                    cols: 70
                                },
                                {
                                    xtype: "label",
                                    text: "Ostomy care managed by:",
                                    isHeader: false
                                },
                                {
                                    border: false,
                                    header: false,
                                    layout: {type: "table", columns: 4},
                                    items: [
                                        {
                                            xtype: "radiofield",
                                            name: "elimination_ostomy_care_managed_by",
                                            boxLabel: "Self",
                                            inputValue: "SF",
                                            margin: "0 0 0 5"
                                        },{
                                            xtype: "radiofield",
                                            name: "elimination_ostomy_care_managed_by",
                                            boxLabel: "Caregiver",
                                            inputValue: "CG",
                                            margin: "0 0 0 5"
                                        },
                                        {
                                            xtype: "radiofield",
                                            name: "elimination_ostomy_care_managed_by",
                                            isHeader: false,
                                            boxLabel: "Other",
                                            margin: "0 0 0 5",
                                            inputValue: "OTH"
                                        },{
                                            xtype: "textfield",
                                            name: "elimination_ostomy_care_other",
                                            isHeader: false,
                                            margin: "0 0 0 5",
                                            width: 285
                                        }
                                    ]
                                }


                            ]
                        },
                    ]
                }
            ]
        }
    ]
})
