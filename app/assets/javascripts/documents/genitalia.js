/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.Genitalia', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.genitalia',
    border: false,
    items: [
        {
            xtype: "checkboxfield",
            name: "genitalia_no_problem",
            boxLabel: "<b>No Problem</b>",
            inputValue: "NP"
        },
        {
            border: false,
            header: false,
            items: [
                {
                    border: false,
                    header: false,
                    layout: {type: "table", columns: 2},
                    items: [
                        {
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Discharge",
                            inputValue: "1",
                            width: 170

                        },{
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Drainage",
                            inputValue: "2"
                        }
                    ]
                },{
                    xtype: "textfield",
                    isHeader: false,
                    labelWidth: 60,
                    name: "discharge_drainage",
                    fieldLabel: "Describe"
                },{
                    border: false,
                    header: false,
                    layout: {type: "table", columns: 2},
                    items: [
                        {
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Lesions",
                            inputValue: "3",
                            width: 170
                        },{
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Blisters",
                            inputValue: "4"
                        },{
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Masses",
                            inputValue: "5"
                        },{
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Cysts",
                            inputValue: "6"
                        },{
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Inflammation",
                            inputValue: "7"
                        },{
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Surgical alteration",
                            inputValue: "8"
                        }]},
                { border: false,
                    header: false,
                    layout: {type: "table", columns: 4},
                    items: [{
                        xtype: "checkboxfield",
                        name: "genitalia",
                        boxLabel: "Prostate problem:",
                        inputValue: "9",
                        width: 170
                    },{
                        xtype: "checkboxfield",
                        name: "prostate_problem",
                        isHeader: false,
                        boxLabel: "BPH",
                        inputValue: "BPH",
                        margin: '0 5 0 0'
                    },{
                        xtype: "checkboxfield",
                        name: "prostate_problem",
                        isHeader: false,
                        boxLabel: "TURP",
                        inputValue: "TURP",
                        margin: '0 10 0 0'
                    },{
                        xtype: "datefield",
                        name: "bph_turp_date",
                        isHeader: false,
                        fieldLabel: "Date",
                        labelWidth: 32,
                    }]
                },{ border: false,
                    header: false,
                    layout: {type: "table", columns: 2},
                    items: [{
                        xtype: "checkboxfield",
                        name: "genitalia",
                        boxLabel: "Self-testicular exam",
                        inputValue: "10",
                        width: 242
                    },{
                        xtype: "textfield",
                        name: "self_testicular_exam_freq",
                        isHeader: false,
                        fieldLabel: "Frequency",
                        labelWidth: 70
                    }
                    ]
                },{
                    border: false,
                    header: false,
                    layout: {type: "table", columns: 3},
                    items: [
                        {
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Menopause",
                            inputValue: "11",
                            width: 170
                        },{
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Hysterectomy",
                            inputValue: "12",
                            margin: "0 8 0 0"
                        },{
                            xtype: "datefield",
                            name: "hysterectomy_date",
                            isHeader: false,
                            labelWidth: 30,
                            fieldLabel: "Date"
                        }
                    ]
                },{
                    border: false,
                    header: false,
                    layout: {type: "table", columns: 2},
                    items: [
                        {
                            xtype: "datefield",
                            name: "hysterectomy_last_date",
                            isHeader: false,
                            labelWidth: 70,
                            fieldLabel: "Date last PAP",
                            margin: "0 37 0 0"
                        },{
                            xtype: "textfield",
                            name: "hysterectomy_results",
                            isHeader: false,
                            labelWidth: 50,
                            fieldLabel: "Results"
                        }
                    ]
                },{
                    border: false,
                    header: false,
                    layout: {type: "table", columns: 2},
                    items: [
                        {
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Breast self-exam",
                            inputValue: "13",
                            width: 242
                        },{
                            xtype: "textfield",
                            name: "breast_self_exam_freq",
                            isHeader: false,
                            fieldLabel: "Frequency",
                            labelWidth: 70
                        }]},{
                    border: false,
                    header: false,
                    layout: {type: "table", columns: 3},
                    items: [

                        {
                            xtype: "checkboxfield",
                            name: "genitalia",
                            boxLabel: "Discharge (Left/Right)",
                            inputValue: "14",
                            width: 170
                        },
                        {
                            xtype: "checkboxfield",
                            name: "genitalia_discharge",
                            boxLabel: 'Left',
                            inputValue: "2",
                            margin: '0 5 0 0 '
                        },{
                            xtype: "checkboxfield",
                            name: "genitalia_discharge",
                            boxLabel: "Right",
                            inputValue: "1",
                            margin: '0 5 0 0',
                        }]},{
                    border: false,
                    header: false,
                    layout: {type: "table", columns: 4},
                    items: [{
                        xtype: "checkboxfield",
                        name: "genitalia",
                        boxLabel: "Mastectomy (Left/Right)",
                        inputValue: "15",
                        margin: '0 5 0 0'
                    },{
                        xtype: "checkboxfield",
                        name: "mastectomy",
                        boxLabel: "Left",
                        inputValue: "2",
                        margin: '0 5 0 0'
                    },{
                        xtype: "checkboxfield",
                        name: "mastectomy",
                        boxLabel: "Right",
                        inputValue: "1",
                        margin: '0 10 0 0'
                    },{
                        xtype: "datefield",
                        isHeader: false,
                        name: "mastectomy_date",
                        fieldLabel: "Date",
                        labelWidth: 33
                    }
                    ]
                },{
                    xtype: "checkboxfield",
                    name: "genitalia",
                    boxLabel: "Other",
                    inputValue: "16"
                },{
                    xtype: "textarea",
                    isHeader: false,
                    name: "genitalia_other",
                    labelAlign: "top",
                    fieldLabel: "Other(specify)",
                    cols: 90
                }
            ]
        }
    ]
})
