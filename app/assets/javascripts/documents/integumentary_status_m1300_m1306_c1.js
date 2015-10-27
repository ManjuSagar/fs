/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.IntegumentaryStatusM1300M1306C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.integumentaryStatusM1300M1306C1',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'radiogroup',
            width: 822,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1300) Pressure Ulcer Assessment: Was this patient assessed for Risk of Developing Pressure Ulcers?',
            cls: 'oasis_blue',
            itemId: 'pre_ulcr_assmnt',
            width: "60%",
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1300_prsr_ulcr_risk_asmt',
                    boxLabel: '0 - No assessment conducted',
                    inputValue: '00',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1306]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1300_prsr_ulcr_risk_asmt',
                    boxLabel: '1 - Yes, based on an evaluation of clinical factors, (for example: mobility, incontinence, nutrition, etc.) without use of standardized tool',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1300_prsr_ulcr_risk_asmt',
                    boxLabel: '2 - Yes, using a standardized, validated tool (for example: Braden Scale, Norton Scale)',
                    inputValue: '02'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1302) Does this patient have a Risk of Developing Pressure Ulcers?',
            cls: 'oasis_blue',
            itemId: 'rsk_dev_pres_ulcr',
            width: "60%",
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1302_risk_of_prsr_ulcr',
                    boxLabel: '0 - No ',
                    inputValue: '0'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1302_risk_of_prsr_ulcr',
                    boxLabel: '1- Yes',
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
            fieldLabel: '(M1306) Does this patient have at least one Unhealed Pressure Ulcer at Stage II or Higher or designated as Unstageable? (Excludes Stage I pressure ulcers and healed Stage II pressure ulcers)',
            cls: 'oasis_blue',
            itemId: 'unhealed_pre_ulcr',
            width: "60%",
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1306_unhld_stg2_prsr_ulcr',
                    boxLabel: '0 - No ',
                    inputValue: '0',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1322]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1306_unhld_stg2_prsr_ulcr',
                    boxLabel: '1 - Yes',
                    inputValue: '1'
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m1300_value = main.down("[name=m1300_prsr_ulcr_risk_asmt]").getGroupValue();
        m1302_value = main.down("[name=m1302_risk_of_prsr_ulcr]").getGroupValue();
        m1306_value = main.down("[name=m1306_unhld_stg2_prsr_ulcr]").getGroupValue();
        m1308_numberfields = main.down("#integumentarystatus2_m1308").query("[xtype=numberfield]");
        m1300Risk = main.down('radiofield[name=m1300_prsr_ulcr_risk_asmt]').getGroupValue();
        m1306Unhold = main.down('radiofield[name=m1306_unhld_stg2_prsr_ulcr]').getGroupValue();

        if(m1300Risk == null){
            errs.push(['M1300', "Select how Pressure Ulcer Assessment conducted."]);
        }
        if(m1306Unhold == null){
            errs.push(['M1306', "Please choose (Yes/No) whether the patient has one Unhealed Pressure Ulcer at stage II or treated as 'unstageable'."]);
        }
        if(m1300_value == "01" || m1300_value == "02"){
            if(m1302_value == null){
                errs.push(['M1302', "Please choose (Yes/No) whether the patient has risk of developing pressure ulcers."]);
            }
        }

        if(m1306_value == "01"){
            m1308_numberfields.every(function(tf){
                if(tf.value == null){
                    errs.push(['M1308', 'M1308_NBR_PRSULC_STG2 through M1308_NSTG_DEEP_TISUE_SOC_ROC cannot be blank.']);
                    return false;
                }
            });
        }
        return errs;
    },
    applyM1306UnhealedPressureUlcerRules: function(){
        this.super_main.down("#integumentarystatus2_m1308").query("[xtype=numberfield]").forEach(function(n){n.enable();});
        this.super_main.down("#pressure_ulcer_m1310_m1324").query("[xtype=numberfield]").forEach(function(n){n.enable();});
        this.super_main.query("[name=m1320_stus_prblm_prsr_ulcr]").forEach(function(n){n.enable();});
    },
    skipM1307ToM1320: function(){
        this.super_main.down("#integumentarystatus2_m1308").query("[xtype=numberfield]").forEach(function(n){n.disable().setValue();});
        this.super_main.down("#pressure_ulcer_m1310_m1324").query("[xtype=numberfield]").forEach(function(n){n.disable().setValue();});
        this.super_main.query("[name=m1320_stus_prblm_prsr_ulcr]").forEach(function(n){n.disable().setValue(false);});
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
    m1300PressureUlcerAssessment: function(){
        this.query("[name=m1300_prsr_ulcr_risk_asmt]")[0].on('change', function(el){
            if(el.value){
                this.query("[name=m1302_risk_of_prsr_ulcr]").forEach(function(n){ n.disable().setValue(false);});
            }else{
                this.query("[name=m1302_risk_of_prsr_ulcr]").forEach(function(n){ n.enable();});
            }
        }, this);
    },
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
    },
    initComponent: function(){
        this.callParent();
        this.m1300PressureUlcerAssessment();
        this.m1306UnhealedPressure();
    }
})
