/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.Miscellaneous', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.miscellaneous',
    border: 0,
    items: [
        {
            xtype: "label",
            text: "Miscellaneous"
        },
        {
            xtype: "checkboxfield",
            boxLabel: "Enema supplies",
            name: "miscellaneous",
            inputValue: "1"
        },{
            xtype: "checkboxfield",
            boxLabel: "Feeding tube",
            name: "miscellaneous",
            inputValue: "2"
        },{
            xtype: "textfield",
            name: "feeding_tube_type",
            fieldLabel: "Type",
            isHeader: false,
            labelWidth: 50
        },{
            xtype: "textfield",
            name: "feeding_tube_size",
            fieldLabel: "Size",
            isHeader: false,
            labelWidth: 50
        },{
            xtype: "checkboxfield",
            boxLabel: "Suture removal kit",
            name: "miscellaneous",
            inputValue: "3"
        },{
            xtype: "checkboxfield",
            boxLabel: "Staple removal kit",
            name: "miscellaneous",
            inputValue: "4"
        },{
            xtype: "checkboxfield",
            boxLabel: "Steri strips",
            name: "miscellaneous",
            inputValue: "5"
        },
        {
            xtype: "checkboxfield",
            name: "miscellaneous",
            boxLabel: "Other",
            isHeader: false,
            inputValue: "6"
        },{
            xtype: "textarea",
            name: "other_miscellaneous",
            isHeader: false,
            cols: 40,
            rows: 6
        }
    ]
})
