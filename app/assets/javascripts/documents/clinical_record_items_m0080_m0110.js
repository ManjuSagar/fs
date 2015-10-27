/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.ClinicalRecordItemsM0080M0110', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.clinicalRecordItemsM0080M0110',
    border: false,
    margin: 5,
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
                            width: 430,
                            hidden: true,
                            readOnly: false
                        },
                        {
                            xtype: "datefield",
                            fieldLabel: "(M0102) Date of Physician-ordered Start of Care (Resumption of Care): If the physician indicated a specific start of care (resumption of care) date when the patient was referred for home health services, record the date specified",
                            cls: 'oasis_blue',
                            itemId: 'date_of_phy_soc',
                            afterLabelTpl: ' <text class="oasis_yellow">[Go to M0110, if date entered]</text>',
                            name: "m0102_physn_ordrd_socroc_dt",
                            labelAlign: 'top',
                            margin: 0,
                            width: '100%'
                        },
                        {
                            xtype: "checkbox",
                            fieldLabel: " ",
                            labelSeparator: " ",
                            cls: 'oasis_blue',
                            afterLabelTextTpl: "<b>(M0102) Date of Physician-ordered Start of Care (Resumption of Care): NA</b>",
                            labelAlign: 'top',
                            inputValue: '1',
                            name: "m0102_physn_ordrd_socroc_dt_na",
                            boxLabel: "NA - No specific SOC date ordered by physician",
                            width: '100%'
                        }
                    ]
                },
                {
                    xtype: "panel",
                    border: false,
                    margin: 5,
                    height: 400,
                    flex: 1,
                    items: [
                        {
                            xtype: "datefield",
                            fieldLabel: "(M0104) Date of Referral: Indicate the date that the written or verbal referral for initiation or resumption of care was received by the HHA",
                            cls: 'oasis_blue',
                            itemId: 'date_of_ref',
                            name: "m0104_physn_rfrl_dt",
                            labelAlign: 'top',
                            width: '100%'
                        },
                        {
                            xtype: 'radiogroup',
                            fieldLabel: '(M0110) Episode Timing: Is the Medicare home health payment episode for which  this assessment will define a case mix group an "early" episode or a "later" episode in the patient`s current sequence of adjacent Medicare home health payment episodes?',
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
    onInfoCompletedDate: function(){
        if(this.infoCompletedDt.value != null && this.infoCompletedDt.isValid() == true){
            this.physicianSocRocDt.enable();
            this.physicianSocRocDtNa.enable();
            this.physicianReferralDt.enable();
        } else {
            this.physicianSocRocDt.disable().setValue();
            this.physicianSocRocDtNa.disable().setValue(false);
            this.physicianReferralDt.disable().setValue();
        }
    },
    onValidate: function(main){
        var errs = new Array();
        m0080Assessor = this.mainScope.down('radiofield[name=m0080_assessor_discipline]').getGroupValue();
        m0110Episode = this.mainScope.down('radiofield[name=m0110_episode_timing]').getGroupValue();
        m1005Value = this.mainScope.down('[name=m1005_inp_discharge_dt]').value;
        if (m0080Assessor == null){
            errs.push(['M0080', "Select the discipline of the person completing the assessment."]);
        }
        if (this.infoCompletedDt.value == null){
            errs.push(['M0090', "Enter the date this assessment was completed."]);
        }
        else{
            if (this.infoCompletedDt.value !=null && this.infoCompletedDt.isValid() == false){
                errs.push(['M0090', "The assessment completed date should be in the 'mm/dd/yyyy' format."]);
            } else {
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

                if(this.physicianSocRocDt.value != null){
                    if(this.physicianSocRocDt.value > new Date()){
                        errs.push(["M0102", "The date of the physician-ordered SOC/ROC date cannot be after the current date."]);
                    }
                    if(this.startCareDate.value != null && this.physicianSocRocDt.value >  this.startCareDate.value){
                        errs.push(["M0102", "The date of the physician-ordered SOC/ROC date cannot be after the start of care date."]);
                    }
                    if(this.rocDate.value != null && this.physicianSocRocDt.value > this.rocDate.value){
                        errs.push(["M0102", "The date of the physician-ordered SOC/ROC date cannot be after the resumption of care date."]);
                    }
                    if(this.infoCompletedDt.value != null && this.physicianSocRocDt.value > this.infoCompletedDt.value){
                        errs.push(["M0102", "The date of the physician-ordered SOC/ROC date cannot be after the assessment completed date."]);
                    }
                    if(m1005Value != null && this.physicianSocRocDt.value < m1005Value){
                        errs.push(["M0102", "The date of the physician-ordered SOC/ROC date cannot be before the inpatient discharge date."]);
                    }
                } else if(this.physicianSocRocDt.value == null && this.physicianSocRocDtNa.value == false) {
                    errs.push(["M0102", "Enter the date of the physician-ordered start of care or resumption of care, OR select 'NA'."])
                }
                if (this.physicianReferralDt.value !=null && this.physicianReferralDt.isValid()){
                    if(this.physicianReferralDt.value > new Date()){
                        errs.push(["M0104", "Physician Date Of Referral must be less than or equal to the current date"]);
                    }
                    if(this.startCareDate.value != null && this.physicianReferralDt.value > this.startCareDate.value && this.assessmentReason.value == "01"){
                        errs.push(["M0104", "Physician Date Of Referral must be less than or equal to the Start of Care Date(M0030)"]);
                    }
                    if(this.rocDate.value != null && this.physicianReferralDt.value > this.rocDate.value && this.assessmentReason.value == "03"){
                        errs.push(["M0104", "Physician Date Of Referral must be earlier than or equal to Resumption of Care Date(M0032)"]);
                    }
                    if(this.infoCompletedDt.value != null && this.physicianSocRocDt.value > this.infoCompletedDt.value){
                        errs.push(["M0104", "Physician Date Of Referral must be earlier than or equal to Date Assessment Completed(M0090)"]);
                    }
                } else if(this.physicianSocRocDt.value == null && this.physicianSocRocDtNa.value == true){
                    errs.push(["M0104", "Enter the referral date."]);
                }
            }
        }
        if (this.assessmentReason.value == null){
            errs.push(["M0100", "Select the reason for this assessment."]);
        }
        if (m0110Episode == null){
            errs.push(['M0110', "Select the episode timing."]);
        }
        return errs;
    },
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
        this.startCareDate = this.mainScope.down('datefield[name=m0030_start_care_dt]');
        this.assessmentReason = this.mainScope.down('textfield[name=m0100_assmt_reason]');
        this.physicianSocRocDt = this.mainScope.down('datefield[name=m0102_physn_ordrd_socroc_dt]');
        this.physicianSocRocDtNa = this.mainScope.down('[name=m0102_physn_ordrd_socroc_dt_na]');
        this.physicianReferralDt = this.mainScope.down('[name=m0104_physn_rfrl_dt]');
        this.rocDate = this.mainScope.down("datefield[name=m0032_roc_dt]");
        this.m0906DcTranDthDt = this.mainScope.down('datefield[name=m0906_dc_tran_dth_dt]');       

        if(this.mainScope.infoCompletedDateKeyField) this.infoCompletedDt.setReadOnly(true);
    },
    initComponent: function(){
        this.callParent();
        var physicianSocRocDt = this.down('datefield[name=m0102_physn_ordrd_socroc_dt]');
        var physicianSocRocDtNa = this.down('[name=m0102_physn_ordrd_socroc_dt_na]');
        var physicianReferralDt = this.down('datefield[name=m0104_physn_rfrl_dt]');
        var infoCompletedDt = this.down('[name=m0090_info_completed_dt]');

        physicianSocRocDt.on('select', function(el){
            if(physicianSocRocDt.value != null && physicianSocRocDt.isValid()){
                if(el.value){
                    physicianSocRocDtNa.setValue(false);
                    physicianReferralDt.setValue(null).disable();
                }
            }
        },this);

        physicianSocRocDtNa.on('change', function(el){
            if(el.value) {
                physicianSocRocDt.setValue(null);
                physicianReferralDt.setValue(null).enable();
            }
        }, this) ;

        if(infoCompletedDt.value == null){
            physicianSocRocDt.disable();
            physicianSocRocDtNa.disable();
            physicianReferralDt.disable();
        }

        infoCompletedDt.on('change', function(el){
            if(el.value) {
                this.onInfoCompletedDate();
            }
        }, this);
    }
})