/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.MedicationsM2030', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.medicationsM2030',
    border: false,
    items: [
        {
            xtype: 'radiogroup',
            fieldLabel: "(M2030) Management of Injectable Medications: Patient's current ability to prepare and take all prescribed"+
                "injectable medications reliably and safely, including administration of correct dosage at the appropriate"+
                "times/intervals. Excludes IV medications.",
            cls: 'oasis_green',
            item_id: 'inj_medications1',
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Able to independently take the correct medication(s) and proper dosage(s) at the correct times.'
                },
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Able to take injectable medication(s) at the correct times if:'+
                        " (a) individual syringes are prepared in advance by another person; OR"+
                        '(b) another person develops a drug diary or chart.'
                },
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Able to take medication(s) at the correct times if given reminders by another person based on the frequency of the injection'
                },
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Unable to take injectable medication unless administered by another person.'
                },
                {
                    xtype: 'radiofield',
                    name: "m2030_crnt_mgmt_injctn_mdctn",
                    inputValue: "NA",
                    margin: 5,
                    boxLabel: 'NA - No injectable medications prescribed.'
                }
            ]
        },
    ],
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        this.assessmentReason = this.super_main.down('textfield[name=m0100_assmt_reason]');
    },
    onValidate: function(){
        var errs = new Array();
        var m2030Value = this.super_main.down("[name=m2030_crnt_mgmt_injctn_mdctn]").getGroupValue();
        if(this.assessmentReason.value == 4 || 5 || 6){
            if(m2030Value == null){
                errs.push(['M2030', "Management of injectable medications by patient field cannot be blank."])
            }
        }
        return errs;
    }
})
