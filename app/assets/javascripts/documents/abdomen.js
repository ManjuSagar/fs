/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.Abdomen', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.abdomen',
    border: false,
    items: [
        {
            xtype: "checkboxfield",
            name: "abdomen_no_problem",
            boxLabel: "<b>No Problem</b>",
            margin: 5,
            inputValue: "NP"
        },
        {
            border: false,
            header: false,
            margin: "0 5 0 5",
            layout: {type: "hbox"},
            items: [
                {
                    xtype: "checkboxfield",
                    name: "abdomen",
                    boxLabel: "Tenderness",
                    inputValue: "1",
                    margin: "0 5 0 0"
                },
                {
                    xtype: "checkboxfield",
                    name: "abdomen",
                    boxLabel: "Pain",
                    inputValue: "2",
                    margin: "0 5 0 0"
                },
                {
                    xtype: "checkboxfield",
                    name: "abdomen",
                    boxLabel: "Distention",
                    inputValue: "3",
                    margin: "0 5 0 0"
                },
                {
                    xtype: "checkboxfield",
                    name: "abdomen",
                    boxLabel: "Hard",
                    inputValue: "4",
                    margin: "0 5 0 0"
                },
                {
                    xtype: "checkboxfield",
                    name: "abdomen",
                    boxLabel: "Soft",
                    inputValue: "5",
                    margin: "0 5 0 0"
                },
                {
                    xtype: "checkboxfield",
                    name: "abdomen",
                    boxLabel: "Ascites",
                    inputValue: "6",
                    margin: "0 5 0 0"
                }
            ]
        },
        {
            border: false,
            header: false,
            layout: {type: "table", columns: 2},
            margin: "0 5 0 5",
            items: [
                {
                    xtype: "checkboxfield",
                    name: "abdomen",
                    boxLabel: "Abdominal",
                    inputValue: "7"
                },
                {
                    xtype: "textfield",
                    name: "girth",
                    isHeader: false,
                    margin: "0 0 0 5",
                    labelWidth: 50,
                    fieldLabel: "Girth (cm)"
                }
            ]
        },
        {
            border: false,
            header: false,
            margin: "0 5 0 5",
            layout: {type: "table", columns: 2},
            items: [
                {
                    xtype: "checkboxfield",
                    name: "abdomen",
                    boxLabel: "Other",
                    inputValue: "8",
                    width: 142
                },
                {
                    xtype: "textfield",
                    name: "abdomen_other",
                    fieldLabel: "",
                    width: 250

                }
            ]
        },
        {
            border: false,
            header: false,
            layout: {type: "hbox"},
            margin: "0 5 0 5",
            items: [
                {
                    xtype: "checkboxfield",
                    name: "abdomen",
                    boxLabel: "Bowel sounds",
                    inputValue: "9"
                },
            ]
        },
        {
            border: false,
            header: false,
            layout: {type: "table", columns: 4},
            items: [
                {
                    xtype: "radiofield",
                    name: "bowel_sounds",
                    boxLabel: "Active",
                    inputValue: "1",
                    margin: "0 5 0 10"
                },
                {
                    xtype: "radiofield",
                    name: "bowel_sounds",
                    boxLabel: "Absent",
                    inputValue: "2",
                    margin: "0 5 0 5"
                },
                {
                    xtype: "radiofield",
                    name: "bowel_sounds",
                    boxLabel: "Hypo",
                    inputValue: "3",
                    margin: "0 5 0 0"
                },
                {
                    xtype: "radiofield",
                    name: "bowel_sounds",
                    boxLabel: "Hyperactive",
                    inputValue: "4",
                    margin: "0 5 0 0",
                },
            ]

        },
        {
            xtype: "textfield",
            name: "bowel_sounds_x_quadrants",
            isHeader: false,
            fieldLabel: "Quadrants",
            margin: "0 5 0 10",
            labelWidth: 134

        },
        {
            border: false,
            header: false,
            margin: 5,
            layout: {type: "table", columns: 2},
            items: [
                {
                    xtype: "checkboxfield",
                    name: "bowel_sounds_other",
                    boxLabel: "Other",
                    inputValue: "5",
                    width: 142
                },
                {
                    xtype: "textfield",
                    name: "bowel_sounds_other_text",
                    fieldLabel: "",
                    width: 250
                }
            ]
        }
    ]
})
