/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.UrinaryDMESupplies', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.urinaryDMESupplies',
    border: 0,
    items: [
        {
            xtype: "label",
            text: "Urinary/Ostomy"
        },{
            header: false,
            border: false,
            items: [
                {
                    xtype: "checkboxfield",
                    name: "urinary_ostomy_supplies",
                    boxLabel: "Underpads",
                    inputValue: "1"
                },{
                    xtype: "checkboxfield",
                    name: "urinary_ostomy_supplies",
                    boxLabel: "External catheters",
                    inputValue: "2"
                },{
                    xtype: "checkboxfield",
                    name: "urinary_ostomy_supplies",
                    boxLabel: "Urinary bag/pouch",
                    inputValue: "3"
                },{
                    xtype: "checkboxfield",
                    name: "urinary_ostomy_supplies",
                    boxLabel: "Ostomy pouch(brand, size)",
                    inputValue: "4"
                },{
                    xtype: "textfield",
                    name: "ostomy_pouch_size",
                    fieldLabel: "",
                },{
                    xtype: "checkboxfield",
                    name: "urinary_ostomy_supplies",
                    boxLabel: "Ostomy wafer(brand, size)",
                    inputValue: "5"
                },{
                    xtype: "textfield",
                    name: "ostomy_wafer_size",
                    fieldLabel: "",
                },{
                    xtype: "checkboxfield",
                    name: "urinary_ostomy_supplies",
                    boxLabel: "Stoma adhesive tape",
                    inputValue: "6"
                },{
                    xtype: "checkboxfield",
                    name: "urinary_ostomy_supplies",
                    boxLabel: "Skin protectant",
                    inputValue: "7"
                },
                {
                    xtype: "checkboxfield",
                    name: "urinary_ostomy_supplies",
                    boxLabel: "Other",
                    isHeader: false,
                    inputValue: "8"
                },{
                    xtype: "textarea",
                    name: "other_urinary_ostomy_supplies",
                    isHeader: false,
                    labelAlign: "top",
                    cols: 50,
                    rows: 6
                }
            ]
        }
    ]
})
