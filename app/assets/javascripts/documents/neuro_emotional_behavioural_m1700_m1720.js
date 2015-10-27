/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.NeuroEmotionalBehaviouralM17001720', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.neuroEmotionalBehaviouralM17001720',
    border: false,
    margin: 5,
    items: [
        {
            xtype: "panel",
            border: false,
            items: [
                {
                    xtype: 'radiogroup',
                    layout: {
                        align: 'stretch',
                        type: 'vbox'
                    },
                    fieldLabel: '(M1700) Cognitive Functioning: Patient\'s current (day of assessment) level of alertness, orientation, comprehension, concentration, and immediate memory for simple commands.',
                    cls: 'oasis_blue',
                    item_id: 'cogn_functioning1',
                    width: "98%",
                    labelAlign: 'top',
                    items: [
                        {
                            xtype: 'radiofield',
                            name: 'm1700_cog_function',
                            boxLabel: '0 - Alert/oriented, able to focus and shift attention, comprehends and recalls task directions independently.',
                            inputValue: '00'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1700_cog_function',
                            boxLabel: '1 - Requires prompting (cuing, repetition, reminders) only under stressful or unfamiliar conditions.',
                            inputValue: '01'
                        },
                        {
                            xtype: 'radiofield',
                            height: 30,
                            name: 'm1700_cog_function',
                            boxLabel: '2 - Requires assistance and some direction in specific situations (for example: on all tasks involving shifting of attention), or consistently requires low stimulus environment due to distractibility.',
                            inputValue: '02'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1700_cog_function',
                            boxLabel: '3 - Requires considerable assistance in routine situations. Is not alert and oriented or is unable to shift attention and recall directions more than half the time.',
                            inputValue: '03'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1700_cog_function',
                            boxLabel: '4 - Totally dependent due to disturbances such as constant disorientation, coma, persistent vegetative state, or delirium. ',
                            inputValue: '04'
                        }
                    ]
                }
            ]
        },
        {
            xtype: 'panel',
            border: 0,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            width: "99%",
            items: [
                {
                    xtype: "panel",
                    border: false,
                    layout: "hbox",
                    items: [
                        {
                            xtype: 'radiogroup',
                            flex: 1,
                            layout: {
                                align: 'stretch',
                                type: 'vbox'
                            },
                            fieldLabel: '(M1710) When Confused (Reported or Observed Within the Last 14 Days)',
                            cls: 'oasis_blue',
                            item_id: 'when_confused2',
                            margin: "0 5 0 0",
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1710_when_confused',
                                    boxLabel: '0 -  Never',
                                    inputValue: '00'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm1710_when_confused',
                                    boxLabel: '1 - In new or complex situations only ',
                                    inputValue: '01'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm1710_when_confused',
                                    boxLabel: '2 - On awakening or at night only',
                                    inputValue: '02'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm1710_when_confused',
                                    boxLabel: '3 - During the day and evening, but not constantly',
                                    inputValue: '03'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm1710_when_confused',
                                    boxLabel: '4 - Constantly',
                                    inputValue: '04'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm1710_when_confused',
                                    boxLabel: 'NA - Patient nonresponsive',
                                    inputValue: 'NA'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            flex: 1,
                            layout: {
                                align: 'stretch',
                                type: 'vbox'
                            },
                            fieldLabel: '(M1720) When Anxious (Reported or Observed Within the Last 14 Days)',
                            cls: 'oasis_blue',
                            item_id: 'when_anxious',
                            labelAlign: 'top',
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: 'm1720_when_anxious',
                                    boxLabel: '0 -  None of the time',
                                    inputValue: '00'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm1720_when_anxious',
                                    boxLabel: '1 - Less often than daily',
                                    inputValue: '01'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm1720_when_anxious',
                                    boxLabel: '2 - Daily, but not constantly',
                                    inputValue: '02'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm1720_when_anxious',
                                    boxLabel: '3 - All of the time',
                                    inputValue: '03'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: 'm1720_when_anxious',
                                    boxLabel: 'NA - Patient nonresponsive',
                                    inputValue: 'NA'
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m1700Cognitive = main.down('radiofield[name=m1700_cog_function]').getGroupValue();
        m1710Confused = main.down('radiofield[name=m1710_when_confused]').getGroupValue();
        m1720Anxious = main.down('radiofield[name=m1720_when_anxious]').getGroupValue();
        if(m1700Cognitive == null){
            errs.push(['M1700', "Cognitive Functioning is required."]);
        }
        if(m1710Confused == null){
            errs.push(['M1710', "When Confused (Reported or Observed Within the Last 14 Days) is required."]);
        }
        if(m1720Anxious == null){
            errs.push(['M1720', "When Anxious (Reported or Observed Within the Last 14 Days) is required."]);
        }
        return errs;
    }
})
