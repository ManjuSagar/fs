/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.NeuroEmotionalBehaviouralM17001730C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.neuroEmotionalBehaviouralM17001730C1',
    items: [
        {
            xtype: 'panel',
            margin: 5,
            border: 0,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            items: [
                {
                    xtype: 'radiogroup',
                    layout: {
                        align: 'stretch',
                        type: 'vbox'
                    },
                    fieldLabel: '(M1700) Cognitive Functioning: Patient\'s current (day of assessment) level of alertness, orientation, comprehension, concentration, and immediate memory for simple commands.',
                    cls: 'oasis_blue',
                    itemId: 'cog_functioning',
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
                            boxLabel: '2 - Requires assistance and some direction in specific situations (for example, on all tasks involving shifting of attention), or consistently requires low stimulus environment due to distractibility.',
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
                },
                {
                    xtype: 'panel',
                    border: 0,
                    layout: {
                        align: 'stretch',
                        type: 'hbox'
                    },
                    items: [
                        {
                            xtype: 'radiogroup',
                            flex: 1,
                            width: 1024,
                            layout: {
                                align: 'stretch',
                                type: 'vbox'
                            },
                            fieldLabel: '(M1710) When Confused (Reported or Observed Within the Last 14 Days)',
                            cls: 'oasis_blue',
                            itemId: 'when_confused',
                            width: "98%",
                            margin: "0 5 5 0",
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
                            width: 1024,
                            layout: {
                                align: 'stretch',
                                type: 'vbox'
                            },
                            fieldLabel: '(M1720) When Anxious (Reported or Observed Within the Last 14 Days)',
                            cls: 'oasis_blue',
                            itemId: 'when_anxious',
                            width: "98%",
                            margin: "0 0 5 0",
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
                },
                {
                    xtype: 'radiogroup',
                    layout: {
                        align: 'stretch',
                        type: 'vbox'
                    },
                    fieldLabel: '(M1730)Depression Screening: Has the patient been screened for depression, using a standardized, validated depression screening tool?',
                    cls: 'oasis_blue',
                    itemId: 'dep_screen',
                    width: "98%",
                    labelAlign: 'top',
                    items: [
                        {
                            xtype: 'radiofield',
                            name: 'm1730_stdz_dprsn_scrng',
                            boxLabel: '0 - No',
                            inputValue: '00'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1730_stdz_dprsn_scrng',
                            boxLabel: '1 - Yes, patient was screened using the PHQ-2©* scale.',
                            inputValue: '01'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1730_stdz_dprsn_scrng',
                            boxLabel: '2 - Yes, patient was screened with a different standardized, validated assessment-and the patient meets criteria for further evaluation for depression.',
                            inputValue: '02'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1730_stdz_dprsn_scrng',
                            boxLabel: '3 - Yes, patient was screened with a different standardized, validated assessment and the patient does not meet criteria for further evaluation for depression',
                            inputValue: '03'
                        }
                    ]
                },
                {
                    xtype: 'label',
                    margin: '2px',
                    text: 'PHQ-2: Instructions for this two-question tool: Ask patient: Over the last two weeks, how often have you been bothered by any of the following problems?'
                },
                {
                    xtype: 'panel',
                    border: false,
                    layout: {
                        type: 'table',
                        tableAttrs: {
                            border:1,
                            cls: 'oasis_blue'
                        },
                        columns: 6
                    },
                    defaults:{
                        bodyStyle: 'padding: 5px; background-color: #CCE6FF;',
                    },
                    items: [
                        {
                            html: 'PHQ-2&copy;<sup>*</sup>',
                            style: 'text-align:center;font-weight:bold;',
                            height: 60,
                            border:false

                        },
                        {
                            html: 'Not at all 0 - 1 day',
                            style: 'text-align:center;font-weight:bold;',
                            width: 110,
                            height: 60,
                            border:false
                        },
                        {
                            html: 'Several days 2 - 6 days',
                            style: 'text-align:center;font-weight:bold;',
                            width: 110,
                            height: 60,
                            border:false
                        },
                        {
                            html: 'More than half of the days 7 - 11 days',
                            style: 'text-align:center;font-weight:bold;',
                            width: 110,
                            height: 60,
                            border:false
                        },
                        {
                            html: 'Nearly every day 12 - 14 days',
                            style: 'text-align:center;font-weight:bold;',
                            width: 110,
                            height: 60,
                            border:false
                        },
                        {
                            html: 'N/A Unable to respond',
                            style: 'text-align:center;font-weight:bold;',
                            width: 110,
                            height: 60,
                            border:false
                        },
                        {
                            html: 'a) Little interest or pleasure in doing things',
                            border:false
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_lack_intrst",
                            inputValue: "00",
                            boxLabel: '0',
                            padding: '0 0 0 45px'
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_lack_intrst",
                            inputValue: "01",
                            boxLabel: '1',
                            padding: '0 0 0 45px'
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_lack_intrst",
                            inputValue: "02",
                            boxLabel: '2',
                            padding: '0 0 0 45px'
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_lack_intrst",
                            inputValue: "03",
                            boxLabel: '3',
                            padding: '0 0 0 45px'
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_lack_intrst",
                            inputValue: "NA",
                            boxLabel: 'na',
                            padding: '0 0 0 45px'
                        },
                        {
                            html: 'b) Feeling down, depressed, or hopeless?',
                            border:false
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_dprsn",
                            inputValue: "00",
                            boxLabel: '0',
                            padding: '0 0 0 45px'
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_dprsn",
                            inputValue: "01",
                            boxLabel: '1',
                            padding: '0 0 0 45px'
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_dprsn",
                            inputValue: "02",
                            boxLabel: '2',
                            padding: '0 0 0 45px'
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_dprsn",
                            inputValue: "03",
                            boxLabel: '3',
                            padding: '0 0 0 45px'
                        },
                        {
                            xtype: 'radiofield',
                            name: "m1730_phq2_dprsn",
                            inputValue: "NA",
                            boxLabel: 'na',
                            padding: '0 0 0 45px'
                        },
                    ]
                },
                {
                    html: "<i><sup>* Copyright&copy; pizer Inc. All rights reserved. Reproduced with permission.</sup></i>",
                    border: false
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        var interest_value = false;
        var depression_value = false;
        m1730MainValue = main.down("[name=m1730_stdz_dprsn_scrng]").getGroupValue();
        m1700Cognitive = main.down('radiofield[name=m1700_cog_function]').getGroupValue();
        m1710Confused = main.down('radiofield[name=m1710_when_confused]').getGroupValue();
        m1720Anxious = main.down('radiofield[name=m1720_when_anxious]').getGroupValue();
        m1730Depression = main.down('radiofield[name=m1730_stdz_dprsn_scrng]').getGroupValue();
        if(m1700Cognitive == null){
            errs.push(['M1700', "Select one option from Cognitive Functioning."]);
        }
        if(m1710Confused == null){
            errs.push(['M1710', "Choose one option, when patient happened to be Confused within last 14 Days."]);
        }
        if(m1720Anxious == null){
            errs.push(['M1720', "Choose one option, when patient happened to be Anxious within last 14 Days."]);
        }
        if(m1730Depression == null){
            errs.push(['M1730', "Select how Depression Screening Assessment conducted."]);
        }

        if(m1730MainValue == '01'){
            Ext.each(this.m1730_interest_value_group, function(element, index){
                if(element.checked == true){
                    interest_value = true;
                }
            }, this);
            if(interest_value == false){
                errs.push(['M1730', "Do not leave the option Patient's 'Little interests and Pleasure' towards doing things empty, since 'Patient was screened using PHQ-2 scale' was selected in 'Depression Screening'."]);
            }

            Ext.each(this.m1730_depression_value_group, function(element, index){
                if(element.checked == true){
                    depression_value = true;
                }
            }, this);
            if(depression_value == false){
                errs.push(['M1730', "Do not leave the option patient is 'Feeling down, depressed, or hopelesss' empty, since 'Patient was screened using PHQ-2 scale' was selected in 'Depression Screening'."]);
            }
        }
        return errs;
    },
    m1730FieldsEventHandling: function(phq2_group){
        this.query("[name=m1730_stdz_dprsn_scrng]").forEach(function(s){
            s.on('change', function(el){
                if(el.getGroupValue() == "00" || el.getGroupValue() == "02" || el.getGroupValue() == "03"){
                    Ext.each(phq2_group, function(element, index){
                        element.disable().setValue(false);
                    }, this);
                }else{
                    Ext.each(phq2_group, function(element, index){
                        element.enable();
                    }, this);
                }
            }, this);
        }, this);
    },
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query("#super_main")[0];
        this.m1730_interest_value_group = this.mainScope.query('radiofield[name=m1730_phq2_lack_intrst]');
        this.m1730_depression_value_group = this.mainScope.query('radiofield[name=m1730_phq2_dprsn]');
        this.m1730FieldsEventHandling(this.m1730_interest_value_group.concat(this.m1730_depression_value_group));
    }
})
