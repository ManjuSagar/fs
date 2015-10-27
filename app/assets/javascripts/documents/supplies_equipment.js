/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.SuppliesEquipment', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.suppliesEquipment',
    items:[
        {
            xtype: 'checkboxgroup',
            margin: '5px',
            columns: 4,
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: 'Bathbench',
                    inputValue: '1',
                    width: 200
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: "Cane",
                    inputValue: "2",
                    width: 200
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: 'Commode',
                    inputValue: '3',
                    width: 200
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: 'Eggcrate',
                    inputValue: '4',
                    width: 200
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: "Hospital bed",
                    inputValue: "5"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: 'Hoyer lift',
                    inputValue: '6'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: "Enteral feeding pump",
                    inputValue: "7"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    inputValue: '8',
                    boxLabel: 'Nebulizer'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: "Oxygen concentrator",
                    inputValue: "9"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: 'Suction machine',
                    inputValue: '10'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: "Ventilator",
                    inputValue: "11"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: 'Walker',
                    inputValue: '12'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: "Wheelchair",
                    inputValue: "13"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: 'Tens unit',
                    inputValue: '14'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: "Special mattress overlay",
                    inputValue: "15"
                },
                {
                    xtype: 'textfield',
                    name: 'special_mattress_overlay'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'supplies_equipment',
                    boxLabel: 'Pressure relieving device',
                    inputValue: '16'
                },
                {
                    xtype: 'textfield',
                    name: 'pressure_relieving_device'
                }
            ]
        },
        {
            xtype: 'checkboxfield',
            name: 'supplies_equipment',
            boxLabel: 'Other',
            inputValue: '17',
            margin: '0 0 0 10'
        },
        {
            xtype: 'textareafield',
            name: 'other_supplies_equipment',
            margin: '0 0 0 10',
            cols:30
        }
    ]
})
