/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.DischargeDatesM0903M0906', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.dischargeDatesM0903M0906',
    border: false,
    items: [
        {name: 'm0903_last_home_visit',
            fieldLabel: "(M0903) Date of Last(Most Recent) Home visit",
            labelAlign: 'top',
            xtype: "datefield",
            width: "95%",
            margin: "5px"
        },
        {name: 'm0906_dc_tran_dth_dt',
            fieldLabel: "(M0906) Discharge/Transfer/Death Date: Enter the date of the discharge, transfer, or death (at home) of the patient.",
            labelAlign: 'top',
            xtype: "datefield",
            width: "95%",
            margin: "5px"
        }
    ],
    serverValidationRequiredFields: function(){
        return ["m0903_last_home_visit", "m0906_dc_tran_dth_dt"]
    },
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
        this.m0903LastHomeVisit = this.mainScope.down('datefield[name=m0903_last_home_visit]');
        this.m0906DcTranDthDt = this.mainScope.down('datefield[name=m0906_dc_tran_dth_dt]');
        this.assessmentReason = this.mainScope.down('textfield[name=m0100_assmt_reason]');

        if(this.mainScope.dcTrnasDthDateKeyField) this.m0906DcTranDthDt.setReadOnly(true);
    },
    onValidate: function(main){
        var errs = new Array();
        if (this.m0903LastHomeVisit.value == null){
            errs.push(['M0903', "Last Home visit date of patient can't be blank."]);
        }
        else{
            if (this.m0903LastHomeVisit.value > new Date()){
                errs.push(['M0903', "Last Home visit date should not exceed today."]);
            }
            if(this.infoCompletedDt.value && this.m0903LastHomeVisit.value > this.infoCompletedDt.value){
                errs.push(["M0903", "Last Home visit date must be before or on the same dates of Assessment completed date."]);
            }
            if(this.m0906DcTranDthDt.value && this.m0903LastHomeVisit.value > this.m0906DcTranDthDt.value){
                errs.push(["M0903", "Last Home visit date must be before or on the same dates of Discharge/Transfer/Death date of the patient."]);
            }
        }

        if (this.m0906DcTranDthDt.value == null){
            errs.push(['M0906', "Discharge/Transfer/Death date of the patient can't be blank."]);
        }
        else{
            if (this.m0906DcTranDthDt.value > new Date()){
                errs.push(['M0906', "Discharge/Transfer/Death date of the patient should not exceed today."]);
            }
            if(this.m0906DcTranDthDt.value < new Date("07/19/1999")){
                errs.push(['M0906', "Discharge/Transfer/Death date cannot precede 07-19-1999."]);
            }
            if(this.infoCompletedDt.value && this.m0906DcTranDthDt.value > this.infoCompletedDt.value){
                errs.push(['M0906', "Discharge/Transfer/Death date should be earlier than or equal to Assessment completed date."]);
            }
            if(this.assessmentReason.value == '09'){
                if (this.m0906DcTranDthDt.value && this.m0906DcTranDthDt.isValid()){
                    days = Math.floor(this.infoCompletedDt.value - this.m0906DcTranDthDt.value)/86400000;
                    if (days < 0 || days > 2){
                        errs.push(["M0090", "ASSESSMENT COMPLETED DATE should be in between 2 days from DISCHARGE TRANSFER DEATH DATE in Discharge Dates panel."])
                    }
                }
            }
        }

        return errs;
    }
})