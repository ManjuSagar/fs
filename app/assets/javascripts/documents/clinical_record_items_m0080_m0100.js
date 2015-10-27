/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.ClinicalRecordItemsM0080M0100', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.clinicalRecordItemsM0080M0100',
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
                    height: 400,
                    margin: 5,
                    flex: 1,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M0080) Discipline of Person Completing Assessment",
                            labelAlign: 'top',
                            columns: 1,
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m0080_assessor_discipline",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - RN'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m0080_assessor_discipline",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - PT'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m0080_assessor_discipline",
                                    inputValue: "03",
                                    margin: 5,
                                    boxLabel: '3 - SLP/ST'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m0080_assessor_discipline",
                                    inputValue: "04",
                                    margin: 5,
                                    boxLabel: '4 - OT'
                                }
                            ]
                        },
                        {
                            xtype: "datefield",
                            fieldLabel: "(M0090) Date Assessment Completed",
                            name: "m0090_info_completed_dt",
                            labelAlign: 'top',
                            width: '100%'
                        },
                        {
                            xtype: 'combo',
                            fieldLabel: "(M0100) This Assessment is Currently Being Completed for the Following Reason",
                            labelAlign: 'top',
                            name: "m0100_assmt_reason",
                            store: [["01", "Start of Care - further visits planned"],
                                ["03", "Resumption of Care(after inpatient stay)"],
                                ["04", "Recertification (follow-up) reassessment"],
                                ["05", "Other follow-up"],
                                ["06", "Transferred to an inpatient facility - patient not discharged from agency"],
                                ["07", "Transferred to an inpatient facility - patient discharged from agency"],
                                ["08", "Death at home"],
                                ["09", "Discharge from agency"]],
                            width: 500,
                            hidden: true
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
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
        this.startCareDate = this.mainScope.down('datefield[name=m0030_start_care_dt]');
        this.assessmentReason = this.mainScope.down('textfield[name=m0100_assmt_reason]');

        if(this.mainScope.infoCompletedDateKeyField) this.infoCompletedDt.setReadOnly(true);

    },

    onValidate: function(main){
        var errs = new Array();
        m0080Assessor = main.down('radiofield[name=m0080_assessor_discipline]').getGroupValue();
        if (m0080Assessor == null){
            errs.push(['M0080', "Select the discipline of the person completing the assessment."]);
        }
        if (this.infoCompletedDt.value == null){
            errs.push(['M0090', "Enter the date this assessment was completed."]);
        }
        else{
            if (this.infoCompletedDt.value !=null && this.infoCompletedDt.isValid() == false){
                errs.push(['M0090', "The assessment completed date should be in the 'mm/dd/yyyy' format."]);
            }else{
                if (this.infoCompletedDt.value >= new Date()){
                    errs.push(["M0090", "The assessment completed date cannot be after the current date."]);
                }
                if(this.infoCompletedDt.value < new Date("01/01/2010")){
                    errs.push(["M0090", "The assessment completed date cannot be before 01/01/2010."])
                }
                if(this.assessmentReason.value == 1) {
                    days = Math.floor(this.infoCompletedDt.value - this.startCareDate.value)/86400000;
                    if (this.mainScope.nonKeyFieldCorrection == false){
                        if (!(days >= 0 && days <= 5)){
                            errs.push(["M0090", "The assessment completed date cannot be before the start of care date or more than 5 days after the start of care date."])
                        }
                    } else if (this.mainScope.nonKeyFieldCorrection) {
                        if (days < 0){
                            errs.push(["M0090", "The assessment completed date cannot be before the start of care date."])
                        }
                    }
                }

                if(this.assessmentReason.value == 3) {
                    days = Math.floor(this.infoCompletedDt.value - this.rocDate.value)/86400000;
                    if (this.mainScope.nonKeyFieldCorrection == false){
                        if (!(days >= 0 && days <= 2)){
                            errs.push(["M0090", "The assessment completed date cannot be before the resumption of care date or more than 2 days after the resumption of care date."])
                        }
                    } else if (this.mainScope.nonKeyFieldCorrection) {
                        if (days < 0){
                            errs.push(["M0090", "The assessment completed date cannot be before the resumption of care date."])
                        }
                    }
                }

                if(this.assessmentReason.value == 9) {
                    if ( this.m0906DcTranDthDt!= null && this.m0906DcTranDthDt.value !=null && this.m0906DcTranDthDt.isValid() == true){
                        days = Math.floor(this.infoCompletedDt.value - this.m0906DcTranDthDt.value)/86400000;
                        if (this.mainScope.nonKeyFieldCorrection == false){
                            if (!(days >= 0 && days <= 2)){
                                errs.push(["M0090", "The assessment completed date should not be more than 2 days after the discharge/transfer/death date."])
                            }
                        } else if (this.mainScope.nonKeyFieldCorrection) {
                            if (days < 0){
                                errs.push(["M0090", "The assessment completed date cannot be before the discharge/transfer/death date."])
                            }
                        }
                    }
                }
            }
        }
        if (this.assessmentReason.value == null){
            errs.push(["M0100", "Select the reason for this assessment."]);
        }
        return errs;
    },


})
