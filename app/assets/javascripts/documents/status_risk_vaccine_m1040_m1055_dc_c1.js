/**
 * Created by msuser1 on 26/12/14.
 */

Ext.define('Ext.panel.StatusRiskVaccineM1040M1055DcC1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.statusRiskVaccineM1040M1055DcC1',
    border: false,
    items: [

        {
            xtype: 'radiogroup',
            fieldLabel: "(M1041) Influenza Vaccine Data Collection Period: Does this episode of care (SOC/ROC to Transfer/Discharge)"+
                " include any dates on or between October 1 and March 31? ",
            labelAlign: 'top',
            cls: 'oasis_blue',
            item_id: 'flu_vacc',
            width: "99%",
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1041_in_inflnz_season",
                    inputValue: "0",
                    margin: 5,
                    boxLabel: '0 - No',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1051]</text>'

                },
                {
                    xtype: 'radiofield',
                    name: "m1041_in_inflnz_season",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: '1 - Yes'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1046) Influenza Vaccine Received: Did the patient receive the influenza vaccine for this year’s flu season? ",
            cls: 'oasis_blue',
            item_id: 'flu_vacc_not_rec',
            labelAlign: 'top',
            columns: 1,
            width: "99%",
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1046_inflnz_recd_crnt_season",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Yes; received from your agency during this episode of care (SOC/ROC to Transfer/Discharge)'
                },
                {
                    xtype: 'radiofield',
                    name: "m1046_inflnz_recd_crnt_season",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Yes; received from your agency during a prior episode of care (SOC/ROC to Transfer/Discharge)'
                },
                {
                    xtype: 'radiofield',
                    name: "m1046_inflnz_recd_crnt_season",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Yes; received from another health care provider (for example: physician, pharmacist)'
                },
                {
                    xtype: 'radiofield',
                    name: "m1046_inflnz_recd_crnt_season",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - No; patient offered and declined'
                },{
                    xtype: 'radiofield',
                    name: "m1046_inflnz_recd_crnt_season",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - No; patient assessed and determined to have medical contraindication(s)'
                },{
                    xtype: 'radiofield',
                    name: "m1046_inflnz_recd_crnt_season",
                    inputValue: "06",
                    margin: 5,
                    boxLabel: '6 - No; not indicated - patient does not meet age/condition guidelines for influenza vaccine'
                },{
                    xtype: 'radiofield',
                    name: "m1046_inflnz_recd_crnt_season",
                    inputValue: "07",
                    margin: 5,
                    boxLabel: '7 - No; inability to obtain vaccine due to declared shortage'
                },{
                    xtype: 'radiofield',
                    name: "m1046_inflnz_recd_crnt_season",
                    inputValue: "08",
                    margin: 5,
                    boxLabel: '8 - No; patient did not receive the vaccine due to reasons other than those listed in responses 4 – 7.'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1051) Pneumococcal Vaccine: Has the patient ever received the pneumococcal vaccination (for example,pneumovax)? ",
            cls: 'oasis_blue',
            item_id: 'pneumococcal_vacc',
            labelAlign: 'top',
            columns: 1,
            width: "99%",
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1051_pvx_rcvd_agncy",
                    inputValue: "0",
                    margin: 5,
                    boxLabel: '0 - No.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1051_pvx_rcvd_agncy",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: '1 - Yes',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1230]</text>'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1056) Reason Pneumococcal Vaccine not received: If patient has never received the pneumococcal vaccination (for example, pneumovax), state reason",
            cls: 'oasis_blue',
            item_id: 'rea_ppv_not_received',
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            width: "99%",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1056_pvx_rsn_not_rcvd_agncy",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Offered and declined'
                },
                {
                    xtype: 'radiofield',
                    name: "m1056_pvx_rsn_not_rcvd_agncy",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Assessed and determined to have medical contraindication(s)'
                },
                {
                    xtype: 'radiofield',
                    name: "m1056_pvx_rsn_not_rcvd_agncy",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Not indicated; patient does not meet age/condition guidelines for Pneumococcal Vaccine'
                },{
                    xtype: 'radiofield',
                    name: "m1056_pvx_rsn_not_rcvd_agncy",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - None of the above'
                }
            ]
        }

    ],
    afterRender: function(){
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        this.m1041InflnzSeason = this.super_main.down('radiofield[name=m1041_in_inflnz_season]').getGroupValue();
        this.m1046InflnzRecdcrntSeason = this.super_main.down('radiofield[name=m1046_inflnz_recd_crnt_season]').getGroupValue();

        this.super_main.query("[name = m1041_in_inflnz_season]").forEach(function(s){
            s.on('change', function(el){
                if(el.getGroupValue() == "0" ){
                    this.super_main.query("[name=m1046_inflnz_recd_crnt_season]").forEach(function(n){n.disable().setValue(false);},this);
                }else{
                    this.super_main.query("[name=m1046_inflnz_recd_crnt_season]").forEach(function(n){n.enable();},this);
                }
            }, this);
        }, this);

        this.super_main.query("[name =m1051_pvx_rcvd_agncy]").forEach(function(s){
            s.on('change', function(el){
                var m0100Value = this.super_main.down("[name=m0100_assmt_reason]").value;
                if(el.getGroupValue() == "1"){
                    this.super_main.query("[name=m1056_pvx_rsn_not_rcvd_agncy]").forEach(function(n){n.disable().setValue(false);},this);
                }else{
                    this.super_main.query("[name=m1056_pvx_rsn_not_rcvd_agncy]").forEach(function(n){n.enable();},this);
                }
            }, this);
        }, this);

    },
    onValidate: function(){
        var errs = new Array();
        var m1041InflnzSeason = this.super_main.down('radiofield[name=m1041_in_inflnz_season]');
        var m1046InflnzRecdcrntSeason = this.super_main.down('radiofield[name=m1046_inflnz_recd_crnt_season]');
        var m1051PpvRcvdAgncy = this.super_main.down('radiofield[name=m1051_pvx_rcvd_agncy]');
        var m1056PpvRsnNotRcvdAgncy = this.super_main.down('radiofield[name=m1056_pvx_rsn_not_rcvd_agncy]');
        var m0100Value = this.super_main.down("[name=m0100_assmt_reason]").value;
        if(m1041InflnzSeason.getGroupValue() == null){
            errs.push(['M1041', "Please choose (Yes/No) whether patient received influenza vaccine from your agency."]);
        }

        if(m1041InflnzSeason.getGroupValue() == "1"){
            if(m1046InflnzRecdcrntSeason.getGroupValue() == null){
                errs.push(['M1046', "Select the reason of not receiving the Influenza vaccine by patient."]);
            }
        }

        if(m1051PpvRcvdAgncy.getGroupValue() == null){
            errs.push(['M1051', "Please choose (Yes/No) whether patient received Pneumococcal vaccine from your agency."]);
        }

        if(m1056PpvRsnNotRcvdAgncy.getGroupValue() == null && m1051PpvRcvdAgncy.getGroupValue() == "0"){
            errs.push(['M1056', "Select the reason of not receiving the PPV vaccine by patient."]);
        }

        return errs;
    }
})
