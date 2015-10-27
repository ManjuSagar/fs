/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.ClinicalRecordItemsM0110', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.clinicalRecordItemsM0110',
    border: false,
    items: [
        {
            xtype: "panel",
            border: false,
            layout: "hbox",
            items: [
                {

                    xtype: "panel",
                    border: false,
                    margin: 5,
                    height: 400,
                    flex: 1,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: '(M0110) Episode Timing: Is the Medicare home health payment episode for which this assessment will define a case mix group an "early" episode or a "later" episode in the patient`s current sequence of adjacent Medicare home health payment episodes?',
                            labelAlign: 'top',
                            columns: 1,
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m0110_episode_timing",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Early'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m0110_episode_timing",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - Later'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m0110_episode_timing",
                                    inputValue: "UK",
                                    margin: 5,
                                    boxLabel: 'UK - Unknown'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m0110_episode_timing",
                                    inputValue: "NA",
                                    margin: 5,
                                    boxLabel: 'NA - Not Applicable: No Medicare case mix group to be defined by this assessment'
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ],
    serverValidationRequiredFields: function(){
        return ["m0090_info_completed_dt"]
    },
    serverValidationRequiredFieldsSuffix: function(){
        return [""]
    },
    onValidate: function(main){
        var errs = new Array();
        m0110Episode = main.down('radiofield[name=m0110_episode_timing]').getGroupValue();
        if (m0110Episode == null){
            errs.push(['M0110', "Select the episode timing."]);
        }
        return errs;
    }
})
