/*
 * File: app/view/TopContainer.js
 *
 * This file was generated by Sencha Architect version 3.0.4.
 * http://www.sencha.com/products/architect/
 *
 * This file requires use of the Ext JS 4.2.x library, under independent license.
 * License of Sencha Architect does not include license for Ext JS 4.2.x. For more
 * details see http://www.sencha.com/license or contact license@sencha.com.
 *
 * This file will be auto-generated each and everytime you save your project.
 *
 * Do NOT hand edit this file.
 */

Ext.define('MyApp.view.TopContainer', {
    extend: 'Ext.panel.Panel',

    requires: [
        'Ext.Img',
        'Ext.grid.Panel',
        'Ext.grid.View',
        'Ext.grid.column.Column',
        'Ext.tab.Panel',
        'Ext.tab.Tab',
        'Ext.tree.Panel',
        'Ext.tree.View',
        'Ext.form.field.Text'
    ],

    height: 693,
    width: 686,
    autoScroll: true,
    layout: 'anchor',

    initComponent: function() {
        var me = this;

        Ext.applyIf(me, {
            items: [
                {
                    xtype: 'panel',
                    height: 87,
                    width: 210
                },
                {
                    xtype: 'image',
                    height: 60,
                    margin: '5  0 10 0',
                    width: 193,
                    src: 'FN.png'
                },
                {
                    xtype: 'gridpanel',
                    height: 162,
                    margin: '10 0 0 10',
                    width: 674,
                    autoScroll: true,
                    store: 'MyArrayStore',
                    verticalScroller: {
                        numFromEdge: 10,
                        trailingBufferZone: 20,
                        leadingBufferZone: 20
                    },
                    columns: [
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'PatientName',
                            text: 'PatientName'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'Date',
                            text: 'Date'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'Discipline',
                            text: 'Discipline'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'StaffingSymbol',
                            text: 'StaffingSymbol'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'ReferralSymbol',
                            text: 'ReferralSymbol'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'SOC',
                            text: 'SOC'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'POC',
                            text: 'POC'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'RAP',
                            text: 'RAP'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'Docs',
                            text: 'Docs'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'Orders',
                            text: 'Orders'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'DC/RC',
                            text: 'DC/RC'
                        },
                        {
                            xtype: 'gridcolumn',
                            dataIndex: 'FC',
                            text: 'FC'
                        }
                    ]
                },
                {
                    xtype: 'tabpanel',
                    activeTab: 0,
                    items: [
                        {
                            xtype: 'panel',
                            title: 'Tab 1'
                        },
                        {
                            xtype: 'panel',
                            title: 'Tab 2'
                        },
                        {
                            xtype: 'panel',
                            title: 'Tab 3'
                        }
                    ]
                },
                {
                    xtype: 'treepanel',
                    title: 'My Tree Panel',
                    viewConfig: {

                    }
                },
                {
                    xtype: 'textfield',
                    anchor: '100%',
                    fieldLabel: 'Label'
                },
                {
                    xtype: 'textfield',
                    anchor: '100%',
                    fieldLabel: 'Label'
                },
                {
                    xtype: 'button',
                    disabled: true,
                    text: 'MyButton'
                }
            ]
        });

        me.callParent(arguments);
    }

});