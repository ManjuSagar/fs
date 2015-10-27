/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.IntegumentaryStatusM1306M1307C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.integumentaryStatusM1306M1307C1',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1306) Does this patient have at least one Unhealed Pressure Ulcer at Stage II or Higher or designated as Unstageable? (Excludes Stage I pressure ulcers and healed Stage II pressure ulcers)',
            cls: 'oasis_blue',
            item_id: 'one_unhealed_prsr_ulcer1',
            width: "98%",
            margin: '2px',
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1306_unhld_stg2_prsr_ulcr',
                    boxLabel: '0 - No ',
                    itemId: 'm1306_no',
                    inputValue: '0',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1322]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1306_unhld_stg2_prsr_ulcr',
                    boxLabel: '1 - Yes',
                    itemId: 'm1306_yes',
                    inputValue: '1'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1307) The Oldest Stage II Pressure Ulcer that is present at discharge: (Excludes healed Stage II Pressure ulcers)',
            cls: 'oasis_blue',
            item_id: 'non_epi_stg_2',
            width: "98%",
            margin: '2px',
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1307_oldst_stg2_at_dschrg',
                    boxLabel: '1 - Was present at the most recent SOC/ROC assessment',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1307_oldst_stg2_at_dschrg',
                    boxLabel: '2 - Developed since the most recent SOC/ROC assessment: record date pressure ulcer first identified',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1307_oldst_stg2_at_dschrg',
                    boxLabel: 'NA -No Stage II pressure ulcers are present at discharge',
                    inputValue: 'NA'
                }
            ]
        },{
            xtype: "panel",
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            margin: '2px',
            cls: 'oasis_blue',
            items: [
                {
                    xtype: "datefield",
                    fieldLabel: "(M1307) Date pressure ulcer first identified",
                    cls: 'oasis_blue',
                    labelWidth: "95%",
                    name: "m1307_oldst_stg2_onst_dt",
                    labelAlign: 'top'
                }
            ]
        }
    ],
    initComponent: function(){
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        this.m1306UnhealedPressure();
    },
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        var m1307RadioButtons = this.query("[name=m1307_oldst_stg2_at_dschrg]");
        Ext.each(m1307RadioButtons, function(m1307RadioButton, index){
            m1307RadioButton.on("change", function(ele){
                var m1307RadioGroupValue = this.down("radiofield[name=m1307_oldst_stg2_at_dschrg]").getGroupValue();
                if(m1307RadioGroupValue == '02'){
                    this.down("[name=m1307_oldst_stg2_onst_dt]").setDisabled(false);
                } else {
                    this.down("[name=m1307_oldst_stg2_onst_dt]").setDisabled(true).setValue();
                }
            }, this);
        }, this);
    },
    m1306UnhealedPressure: function(){
        this.query("[name=m1306_unhld_stg2_prsr_ulcr]")[0].on('change', function(el){
            if(el.value){
                this.skipM1307ToM1320();
            }
        }, this);

        this.query("[name=m1306_unhld_stg2_prsr_ulcr]")[1].on('change', function(el){
            if(el.value){
                this.applyM1306UnhealedPressureUlcerRules();
            }
        }, this);
    },
    skipM1307ToM1320: function(){
        var numberFields = ['m1308_nbr_prsulc_stg2', 'm1308_nbr_prsulc_stg3', 'm1308_nbr_prsulc_stg4', 'm1308_nstg_drsg',
            'm1308_nstg_cvrg', 'm1308_nstg_deep_tisue', 'm1309_nbr_new_wrs_prsulc_stg2', 'm1309_nbr_new_wrs_prsulc_stg3',
            'm1309_nbr_new_wrs_prsulc_stg4', 'm1309_nbr_new_wrs_prsulc_nstg']
        Ext.each(numberFields, function(el){
            this.super_main.down('numberfield[name='+el+']').disable().setValue();
        }, this);

        var m1307Fields = this.super_main.query("[name=m1307_oldst_stg2_at_dschrg]");

        Ext.each(m1307Fields, function(field, index){
            field.disable().setValue(false);
        }, this);

        this.super_main.down("[name=m1307_oldst_stg2_onst_dt]").setDisabled(true).setValue();

        var m1320Fields = this.super_main.query("[name=m1320_stus_prblm_prsr_ulcr]");
        Ext.each(m1320Fields, function(field, index){
            field.disable().setValue(false);
        }, this);
    },
    applyM1306UnhealedPressureUlcerRules: function(){
        var numberFields = ['m1308_nbr_prsulc_stg2', 'm1308_nbr_prsulc_stg3', 'm1308_nbr_prsulc_stg4', 'm1308_nstg_drsg',
            'm1308_nstg_cvrg', 'm1308_nstg_deep_tisue', 'm1309_nbr_new_wrs_prsulc_stg2', 'm1309_nbr_new_wrs_prsulc_stg3',
            'm1309_nbr_new_wrs_prsulc_stg4', 'm1309_nbr_new_wrs_prsulc_nstg']

        Ext.each(numberFields, function(el){
            this.super_main.down('numberfield[name='+el+']').enable();
        }, this);

        var m1307Fields = this.super_main.query("[name=m1307_oldst_stg2_at_dschrg]");

        Ext.each(m1307Fields, function(field, index){
            field.enable();
        }, this);

        this.super_main.down("[name=m1307_oldst_stg2_onst_dt]").setDisabled(false);

        var m1320Fields = this.super_main.query("[name=m1320_stus_prblm_prsr_ulcr]");

        Ext.each(m1320Fields, function(field, index){
            field.enable();
        }, this);
    },
    onValidate: function(main){
        var errs = new Array();
        var m1306Unhold = this.super_main.down('radiofield[name=m1306_unhld_stg2_prsr_ulcr]').getGroupValue();
        if(m1306Unhold == null){
            errs.push(['M1306', "Does this patient have at least one Unhealed Pressure Ulcer at Stage II is required."]);
        }
        var m1307hold = this.super_main.down('radiofield[name=m1307_oldst_stg2_at_dschrg]').getGroupValue();
        var m1307holdDt = this.super_main.down('[name=m1307_oldst_stg2_onst_dt]');
        if(m1307hold == null && m1306Unhold == "1"){
            errs.push(['M1307', "The Oldest Non-epithelialized Stage II Pressure Ulcer that is present at discharge."]);
        }
        if(m1307hold == '02' && m1307holdDt.value == null){
            errs.push(['M1307', "Date pressure ulcer first identified can't be blank."]);
        }else{
            if(m1307hold == '02' && m1307holdDt.value !=null){
                if (m1307holdDt.isValid() == false){
                    errs.push(['M1307', "Date pressure ulcer first identified must be enter proper date."]);
                }
                if (m1307holdDt.isValid() && m1307holdDt.value > new Date()){
                    errs.push(['M0032', "Date pressure ulcer first identified must be less than or equal to current date."]);
                }

            }
        }

        return errs;
    }
})
