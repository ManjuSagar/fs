/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.AdlIadls4M1900M1910', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.adlIadls4M1900M1910',
    items: [
        {
            xtype: "panel",
            layout: "vbox",
            border: false,
            margin: '5 5 10 5',
            items: [
                {
                    xtype: "panel",
                    layout: "vbox",
                    border: false,
                    margin: 5,
                    items: [
                        {
                            xtype: "label",
                            margin: 5,
                            html:  "(M1900) Prior Functioning ADL/IADL: Indicate the patient's usual ability with everyday activities prior to " +
                                "this current illness, exacerbation, or injury. Check only <u>one</u> box in each row."
                        },
                        {
                            xtype: "panel",
                            border: false,
                            margin: '20 50 20 20',
                            layout: {
                                type: 'table',
                                tableAttrs: {
                                    border:1
                                },
                                columns: 4
                            },
                            defaults:{
                                bodyStyle: 'padding:5px',
                            },
                            items: [
                                {
                                    html: 'Functional Area',
                                    style: 'text-align:center;font-weight:bold;',
                                    height: 38,
                                    width: 270,
                                    border:false
                                },
                                {
                                    html: 'Independent',
                                    style: 'text-align:center;font-weight:bold;',
                                    width: 110,
                                    height: 38,
                                    border:false
                                },
                                {
                                    html: 'Needed Some Help',
                                    style: 'text-align:center;font-weight:bold;',
                                    width: 110,
                                    height: 43,
                                    border:false
                                },
                                {
                                    html: 'Dependent',
                                    style: 'text-align:center;font-weight:bold;',
                                    width: 110,
                                    height: 38,
                                    border:false
                                },
                                {
                                    html: 'a. Self-care (specifically: grooming, dressing, bathing and toileting hygiene)',
                                    width: 270,
                                    border:false

                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_self",
                                    inputValue: "00",
                                    boxLabel: '0',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_self",
                                    inputValue: "01",
                                    boxLabel: '1',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_self",
                                    inputValue: "02",
                                    boxLabel: '2',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    html: 'b. Ambulation',
                                    width: 270,
                                    border:false

                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_ambltn",
                                    inputValue: "00",
                                    boxLabel: '0',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_ambltn",
                                    inputValue: "01",
                                    boxLabel: '1',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_ambltn",
                                    inputValue: "02",
                                    boxLabel: '2',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    html: 'c. Transfer',
                                    width: 270,
                                    border:false
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_trnsfr",
                                    inputValue: "00",
                                    boxLabel: '0',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_trnsfr",
                                    inputValue: "01",
                                    boxLabel: '1',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_trnsfr",
                                    inputValue: "02",
                                    boxLabel: '2',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    html: 'd. Household tasks (specifically: light meal preparation, laundry, shopping and phone use)',
                                    width: 270,
                                    border:false
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_hsehold",
                                    inputValue: "00",
                                    boxLabel: '0',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_hsehold",
                                    inputValue: "01",
                                    boxLabel: '1',
                                    padding: '0 0 0 45px'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1900_prior_adliadl_hsehold",
                                    inputValue: "02",
                                    boxLabel: '2',
                                    padding: '0 0 0 45px'
                                }
                            ]

                        }
                    ]
                },
                {
                    xtype: "panel",
                    border: false,
                    width: "93%",
                    height: 300,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1910) Has this patient had a multi-factor Fall Risk Assessment (such as falls " +
                                "history, use of multiple medications, mental impairment, toileting frequency, " +
                                "general mobility/transferring impairment, environmental hazards)?",
                            cls: 'oasis_blue',
                            item_id: 'mult_fac_fall',
                            width: "98%",
                            margin: '10 0 0 5',
                            labelAlign: 'top',
                            columns: 1,
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1910_mlt_fctr_fall_risk_asmt",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - No multi-factor falls risk assessment conducted'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1910_mlt_fctr_fall_risk_asmt",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Yes, and it does not indicate a risk for falls'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1910_mlt_fctr_fall_risk_asmt",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - Yes, and it indicates a risk for falls'
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        var adliadl_self = false;
        var adliadl_ambltn = false;
        var adliadl_trnsfr = false;
        var adliadl_hsehold = false;

        m1910Value = main.down("#adl_iadls4_m1900_m1910").query("[xtype=radiogroup]")[0];

        Ext.each(this.adliadl_self_group, function(element, index){
            if(element.checked == true){
                adliadl_self = true;
            }
        }, this);
        if(adliadl_self == false){
            errs.push(['M1900', "a. Select the patient's ability of Self-Care."]);
        }


        Ext.each(this.adliadl_ambltn_group, function(element, index){
            if(element.checked == true){
                adliadl_ambltn = true;
            }
        }, this);
        if(adliadl_ambltn == false){
            errs.push(['M1900', "b. Select the patient's ability of Ambulation."]);
        }


        Ext.each(this.adliadl_trnsfr_group, function(element, index){
            if(element.checked == true){
                adliadl_trnsfr = true;
            }
        }, this);
        if(adliadl_trnsfr == false){
            errs.push(['M1900', "c. Select the patient's ability of self Transfer."]);
        }


        Ext.each(this.adliadl_hsehold_group, function(element, index){
            if(element.checked == true){
                adliadl_hsehold = true;
            }
        }, this);
        if(adliadl_hsehold == false){
            errs.push(['M1900', "d. Select the patient's ability to do Household tasks."]);
        }

        if(m1910Value.down("[name = m1910_mlt_fctr_fall_risk_asmt]").getGroupValue() == null){
            errs.push(['M1910', "Choose (Yes/No) whether the patient had a Multi-factor Fall Assessment."]);
        }

        return errs;
    },
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        this.adliadl_self_group = this.super_main.query('radiofield[name=m1900_prior_adliadl_self]');
        this.adliadl_ambltn_group = this.super_main.query('radiofield[name=m1900_prior_adliadl_ambltn]');
        this.adliadl_trnsfr_group = this.super_main.query('radiofield[name=m1900_prior_adliadl_trnsfr]');
        this.adliadl_hsehold_group = this.super_main.query('radiofield[name=m1900_prior_adliadl_hsehold]');
    }
})
