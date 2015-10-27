/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.StatusRiskVaccineM1040M1055', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.statusRiskVaccineM1040M1055',
    border: false,
    items: [

        {
            xtype: 'radiogroup',
            fieldLabel: "(M1040) Influenza Vaccine: Did the patient receive the influenza vaccine from your agency for this year`s influenza season (October 1 through March 31) during this episode of care?",
            labelAlign: 'top',
            cls: 'oasis_blue',
            item_id: 'flu_vacc',
            width: "99%",
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1040_inflnz_rcvd_agncy",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - No.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1040_inflnz_rcvd_agncy",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Yes',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1050]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: "m1040_inflnz_rcvd_agncy",
                    inputValue: "NA",
                    margin: 5,
                    boxLabel: 'NA - Does not apply because entire episode of care (SOC/ROC to Transfer/Discharge) is outside this influenza season.',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1050]</text>'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1045) Reason Influenza Vaccine not received: If the patient did not receive the influenza vaccine from your agency during this episode of care, state reason",
            cls: 'oasis_blue',
            item_id: 'flu_vacc_not_rec',
            labelAlign: 'top',
            columns: 1,
            width: "99%",
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1045_inflnz_rsn_not_rcvd",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Received from another health care provider (e.g., physician)'
                },
                {
                    xtype: 'radiofield',
                    name: "m1045_inflnz_rsn_not_rcvd",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Received from your agency previously during this year`s flu season'
                },
                {
                    xtype: 'radiofield',
                    name: "m1045_inflnz_rsn_not_rcvd",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Offered and declined'
                },
                {
                    xtype: 'radiofield',
                    name: "m1045_inflnz_rsn_not_rcvd",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Assessed and determined to have medical contraindication(s)'
                },{
                    xtype: 'radiofield',
                    name: "m1045_inflnz_rsn_not_rcvd",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - Not indicated; patient does not meet age/condition guidelines for influenza vaccine'
                },{
                    xtype: 'radiofield',
                    name: "m1045_inflnz_rsn_not_rcvd",
                    inputValue: "06",
                    margin: 5,
                    boxLabel: '6 - Inability to obtain vaccine due to declared shortage'
                },{
                    xtype: 'radiofield',
                    name: "m1045_inflnz_rsn_not_rcvd",
                    inputValue: "07",
                    margin: 5,
                    boxLabel: '7 - None of the above'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1050) Pneumococcal Vaccine: Did the patient receive pneumococcal polysaccharide vaccine (PPV) from your agency during this episode of care (SOC/ROC to Transfer/Discharge)?",
            cls: 'oasis_blue',
            item_id: 'pneumococcal_vacc',
            labelAlign: 'top',
            columns: 1,
            width: "99%",
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1050_ppv_rcvd_agncy",
                    inputValue: "0",
                    margin: 5,
                    boxLabel: '0 - No.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1050_ppv_rcvd_agncy",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: '1 - Yes',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1500]</text>'                  },
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1055) Reason PPV not received: If patient did not receive the pneumococcal polysaccharide vaccine (PPV) from your agency during this episode of care (SOC/ROC to Transfer/Discharge), state reason",
            cls: 'oasis_blue',
            item_id: 'rea_ppv_not_received',
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            width: "99%",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1055_ppv_rsn_not_rcvd_agncy",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Patient has received PPV in the past'
                },
                {
                    xtype: 'radiofield',
                    name: "m1055_ppv_rsn_not_rcvd_agncy",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Offered and declined'
                },
                {
                    xtype: 'radiofield',
                    name: "m1055_ppv_rsn_not_rcvd_agncy",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Assessed and determined to have medical contraindication(s)'
                },
                {
                    xtype: 'radiofield',
                    name: "m1055_ppv_rsn_not_rcvd_agncy",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Not indicated; patient does not meet age/condition guidelines for PPV'
                },{
                    xtype: 'radiofield',
                    name: "m1055_ppv_rsn_not_rcvd_agncy",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - None of the above'
                }
            ]
        }

    ],
    afterRender: function(){
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        this.m1040InflnzRcvdAgncy = this.super_main.down('radiofield[name=m1040_inflnz_rcvd_agncy]').getGroupValue();
        this.m1045InflnzRsnNotRcvd = this.super_main.down('radiofield[name=m1045_inflnz_rsn_not_rcvd]').getGroupValue();

        this.super_main.query("[name = m1040_inflnz_rcvd_agncy]").forEach(function(s){
            s.on('change', function(el){
                if(el.getGroupValue() == "01" || el.getGroupValue() == "NA" ){
                    this.super_main.query("[name=m1045_inflnz_rsn_not_rcvd]").forEach(function(n){n.disable().setValue(false);},this);
                }else{
                    this.super_main.query("[name=m1045_inflnz_rsn_not_rcvd]").forEach(function(n){n.enable();},this);
                }
            }, this);
        }, this);

        this.super_main.query("[name =m1050_ppv_rcvd_agncy]").forEach(function(s){
            s.on('change', function(el){
                var m0100Value = this.super_main.down("[name=m0100_assmt_reason]").value;
                if(el.getGroupValue() == "1"){
                    this.super_main.query("[name=m1055_ppv_rsn_not_rcvd_agncy]").forEach(function(n){n.disable().setValue(false);},this);
                }else{
                    this.super_main.query("[name=m1055_ppv_rsn_not_rcvd_agncy]").forEach(function(n){n.enable();},this);
                }
            }, this);
        }, this);

    },
    onValidate: function(){
        var errs = new Array();
        var m1040InflnzRcvdAgncy = this.super_main.down('radiofield[name=m1040_inflnz_rcvd_agncy]');
        var m1045InflnzRsnNotRcvd = this.super_main.down('radiofield[name=m1045_inflnz_rsn_not_rcvd]');
        var m1050PpvRcvdAgncy = this.super_main.down('radiofield[name=m1050_ppv_rcvd_agncy]');
        var m1055PpvRsnNotRcvdAgncy = this.super_main.down('radiofield[name=m1055_ppv_rsn_not_rcvd_agncy]');
        var m0100Value = this.super_main.down("[name=m0100_assmt_reason]").value;
        if(m1040InflnzRcvdAgncy.getGroupValue() == null){
            errs.push(['M1040', "Please choose (Yes/No/NA) whether patient received influenza vaccine from your agency."]);
        }

        if(m1040InflnzRcvdAgncy.getGroupValue() == "00"){
            if(m1045InflnzRsnNotRcvd.getGroupValue() == null){
                errs.push(['M1045', "Select the reason of not receiving the Influenza vaccine by patient."]);
            }
        }

        if(m1050PpvRcvdAgncy.getGroupValue() == null){
            errs.push(['M1050', "Please choose (Yes/No/NA) whether patient received Pneumococcal vaccine from your agency."]);
        }

        if(m1055PpvRsnNotRcvdAgncy.getGroupValue() == null && m1050PpvRcvdAgncy.getGroupValue() == "0"){
            errs.push(['M1055', "Select the reason of not receiving the PPV vaccine by patient."]);
        }

        return errs;
    }
})
