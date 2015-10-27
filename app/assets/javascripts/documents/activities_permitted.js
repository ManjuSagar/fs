/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.ActivitiesPermitted', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.activitiesPermitted',
    items:[
        {
            xtype: 'checkboxgroup',
            margin: '5px',
            columns: 4,
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: '1-Complete bedrest',
                    inputValue: "1",
                    width: 200
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    width: 250,
                    boxLabel: "2-Bedrest/BRP",
                    inputValue: "2"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    width: 200,
                    boxLabel: '3-Up as tolerated',
                    inputValue: '3'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: "4-Transfer bed/chair",
                    inputValue: "4",
                    width: 200
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: '5-Exercises prescribed',
                    inputValue: '5'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: "6-Partial weight bearing",
                    inputValue: "6"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: '7-Independent in home',
                    inputValue: '7'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: "8-Crutches",
                    inputValue: "8"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: '9-Cane',
                    inputValue: '9'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: "A-Wheelchair",
                    inputValue: "10"
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: 'B-Walker',
                    inputValue: '11'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'activities_permitted',
                    boxLabel: "C-No restrictions",
                    inputValue: "12"
                }
            ]
        },
        {
            xtype: 'checkboxfield',
            margin: '0 0 0 10',
            name: 'activities_permitted',
            boxLabel: 'D-Other(specify)',
            inputValue: '13'
        },
        {
            xtype: 'textareafield',
            margin: '0 0 0 10',
            name: 'other_activities_permitted',
            cols:40
        }
    ],

})
