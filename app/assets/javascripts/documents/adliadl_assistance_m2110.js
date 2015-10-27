/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.AdliadlAssistanceM2110', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.adliadlAssistanceM2110',
    border: 0,
    items: [
        {
            xtype: 'radiogroup',
            fieldLabel: "(M2110) How Often does the patient receive ADL or IADL assistance from any caregiver(s) (other than home health agency staff)?",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m2110_adl_iadl_astnc_freq",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - At least daily'
                },
                {
                    xtype: 'radiofield',
                    name: "m2110_adl_iadl_astnc_freq",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Three or more times per week'
                },
                {
                    xtype: 'radiofield',
                    name: "m2110_adl_iadl_astnc_freq",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - One to two times per week'
                },
                {
                    xtype: 'radiofield',
                    name: "m2110_adl_iadl_astnc_freq",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Received, but less often than weekly'
                },
                {
                    xtype: 'radiofield',
                    name: "m2110_adl_iadl_astnc_freq",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - No assistance received'
                },
                {
                    xtype: 'radiofield',
                    name: "m2110_adl_iadl_astnc_freq",
                    inputValue: "UK",
                    margin: 5,
                    boxLabel: 'UK - Unknown'
                }
            ]}],
    onValidate: function(main){
        var errs = new Array();

        var m2110RadioGroupArray = main.down("#adl_iadl_assistance_m2110").query("[xtype=radiogroup]");
        var m0100AssmtReason = main.down("[name=m0100_assmt_reason]");
        var m2110Value = m2110RadioGroupArray[0].down("[name = m2110_adl_iadl_astnc_freq]").getGroupValue();
        if(m2110Value == null){
            errs.push(['M2110', "Select the level of Assistance receives by patient for ADL and IADL from any caregiver(s)."]);
        }
        if(m0100AssmtReason && m0100AssmtReason.value == "09" && m2110Value == 'UK'){
            errs.push(['M2110', "For this Assessment level of Assistance receives by patient for ADL and IADL from any caregiver(s) can't be UK."]);
        }

        return errs;
    }
})
