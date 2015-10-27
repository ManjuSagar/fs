/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.IntegumentaryStatusM1306', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.integumentaryStatusM1306',
    border: false,
    items: [
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1306) Does this patient have at least one Unhealed Pressure Ulcer at Stage II or Higher or designated as "unstageable"? (Excludes Stage I pressure ulcers and healed Stage II pressure ulcers)',
            cls: 'oasis_blue',
            itemId: 'one_uh_prs_ulcr',
            width: "60%",
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
        }
    ],
    initComponent: function(){
        this.callParent();
        this.m1306UnhealedPressure();
    },
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
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
        numberFields = ['m1308_nbr_prsulc_stg2', 'm1308_nbr_prsulc_stg3', 'm1308_nbr_prsulc_stg4', 'm1308_nstg_drsg',
            'm1308_nstg_cvrg', 'm1308_nstg_deep_tisue']
        Ext.each(numberFields, function(el){
            this.super_main.down('numberfield[name='+el+']').disable().setValue();
        }, this);

    },
    applyM1306UnhealedPressureUlcerRules: function(){
        numberFields = ['m1308_nbr_prsulc_stg2', 'm1308_nbr_prsulc_stg3', 'm1308_nbr_prsulc_stg4', 'm1308_nstg_drsg',
            'm1308_nstg_cvrg', 'm1308_nstg_deep_tisue']
        Ext.each(numberFields, function(el){
            this.super_main.down('numberfield[name='+el+']').enable();
        }, this);

    },
    onValidate: function(main){
        var errs = new Array();
        m1306Unhold = this.super_main.down("[name=m1306_unhld_stg2_prsr_ulcr]").getGroupValue();
        if(m1306Unhold == null){
            errs.push(['M1306', "Does this patient have at least one Unhealed Pressure Ulcer at Stage II is required."]);
        }
        return errs;
    }
})
