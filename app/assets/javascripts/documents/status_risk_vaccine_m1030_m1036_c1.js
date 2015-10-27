/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.StatusRiskVaccineM1030M1036C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.statusRiskVaccineM1030M1036C1',
    border: false,
    margin: 5,
    items: [

        {
            layout: "table",
            columns: 2,
            autoScroll: true,
            border: false,
            items: [
                {
                    columns: 1,
                    height: 540,
                    border: false,
                    items: [
                        {
                            xtype: 'checkboxgroup',
                            fieldLabel: "(M1030) Therapies the patient receives at home: (Mark all that apply.)",
                            cls: 'oasis_green',
                            itemId: 'home_therapy',
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1030_thh_iv_infusion",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '1 - Intravenous or infusion therapy (excludes TPN)'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1030_thh_par_nutrition",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '2 - Parenteral nutrition (TPN or lipids)'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1030_thh_ent_nutrition",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '3 - Enteral nutrition (nasogastric, gastrostomy, jejunostomy, or any other artificial entry into the alimentary canal)'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1030_thh_none_above",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '4 - None of the above'
                                },
                            ]
                        },
                        {
                            xtype: 'checkboxgroup',
                            fieldLabel: "(M1033) Risk for Hospitalization: Which of the following signs or symptoms characterize this patient as at risk for hospitalization? (Mark all that apply.)",
                            labelAlign: 'top',
                            itemId: 'm1033_risk_hospitalization',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_hstry_falls",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '1 - History of falls (2 or more falls - or any fall with an injury - in the past 12 months)'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_weight_loss",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '2 - Unintentional weight loss of a total of 10 pounds or more in the past 12 months'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_mltpl_hospztn",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '3 - Multiple hospitalizations (2 or more) in the past 6 months'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_mltpl_ed_visit",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '4 - Multiple emergency department visits (2 or more) in the past 6 months'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_mntl_bhv_dcln",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '5 - Decline in mental, emotional, or behavioral status in the past 3 months'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_compliance",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '6 - Reported or observed history of difficulty complying with any medical instructions (for example, medications, diet, exercise) in the past 3 months'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_5plus_mdctn",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '7 - Currently taking 5 or more medications'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_crnt_exhstn",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '8 - Currently reports exhaustion'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_othr_risk",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '9 - Other risk(s) not listed in 1 - 8'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1033_hosp_risk_none_above",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '10 - None of the above'
                                },
                            ]
                        }
                    ]
                },{
                    columns: 1,
                    height: 540,
                    border: false,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1034) Overall Status: Which description best fits the patient`s overall status? (Check one )",
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1034_ptnt_ovral_stus",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - The patient is stable with no heightened risk(s) for serious complications and death (beyond those typical of the patient`s age).'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1034_ptnt_ovral_stus",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - The patient is temporarily facing high health risk(s) but is likely to return to being stable without heightened risk(s) for serious complications and death (beyond those typical of the patient`s age).'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1034_ptnt_ovral_stus",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - The patient is likely to remain in fragile health and have ongoing high risk(s) of serious complications and death.'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1034_ptnt_ovral_stus",
                                    inputValue: "03",
                                    margin: 5,
                                    boxLabel: '3 - The patient has serious progressive conditions that could lead to death within a year.'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1034_ptnt_ovral_stus",
                                    inputValue: "UK",
                                    margin: 5,
                                    boxLabel: 'UK - The patient`s situation is unknown or unclear.'
                                }
                            ]
                        },
                        {
                            xtype: 'checkboxgroup',
                            fieldLabel: "(M1036) Risk Factors, either present or past, likely to affect current health status and/or outcome: (Mark all that apply.)",
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1036_rsk_smoking",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '1 - Smoking'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1036_rsk_obesity",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '2 - Obesity'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1036_rsk_alcoholism",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '3 - Alcohol dependency'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1036_rsk_drugs",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '4 - Drug dependency'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1036_rsk_none",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '5 - None of the above'
                                },
                                {
                                    xtype: 'checkboxfield',
                                    name: "m1036_rsk_unknown",
                                    margin: 5,
                                    inputValue: "1",
                                    boxLabel: 'UK - Unknown'
                                }
                            ]
                        }
                    ]
                }

            ]
        }
    ],

    onValidate: function(){
        var errs = new Array();
        m1034OvralStus = this.mainScope.down('radiofield[name=m1034_ptnt_ovral_stus]').getGroupValue();
        if(this.m1030Infusion.value == false && this.m1030ParNutrition.value == false
            && this.m1030EntNutrition.value == false && this.m1030NoneOfAbove.value == false){
            errs.push(['M1030', 'Select at least one Therapy that patient receives at home.'])
        }

        if(this.m1033HospRiskHstryFalls.value == false && this.m1033HospRiskWeightLoss.value == false
            && this.m1033HospRiskMltplHospztn.value == false && this.m1033HospRiskMltplEdVisit.value == false
            &&this.m1033HospRiskRcntDcln.value == false && this.m1033HospRiskReptdHstry.value == false
            && this.m1033HospRisk5plusMdctn.value == false && this.m1033HospRiskReportsExhaustion.value == false
            && this.m1033HospRiskOther.value == false && this.m1033HospRiskNoneAbove.value == false){
            errs.push(['M1033', 'Select at least one item from Risk for Hospitalization.'])
        }

        if(m1034OvralStus == null){
            errs.push(['M1034', "Choose one option which describes the patient's overall status."]);
        }

        if(this.m1036Smoking.value == false && this.m1036Obesity.value == false && this.m1036Alcoholism.value == false && this.m1036Drugs.value == false && this.m1036NoneOfAbove.value == false && this.m1036Unknown.value == false){
            errs.push(['M1036', "Select at least one Risk Factor which affect current health status."])
        }

        return errs;
    },
    selectUnknownM1036: function(){
        this.m1036Unknown.on('change', function(el){
            if(el.value){
                Ext.each(this.m1036fields, function(element){
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
                this.m1036NoneOfAbove.setValue(false);
            }
        }, this);
    },
    selectOtherValuesM1036: function(){
        Ext.each(this.m1036fields, function(element){
            this.down("[name="+element+"]").on('change', function(el){
                if(el.value){
                    this.m1036NoneOfAbove.setValue(false);
                    this.m1036Unknown.setValue(false);
                }
            }, this);
        }, this);
    },
    selectNoneOfAboveM1036: function(){
        this.m1036NoneOfAbove.on('change', function(el){
            if(el.value){
                Ext.each(this.m1036fields, function(element){
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
                this.m1036Unknown.setValue(false);
            }
        }, this);
    },

    selectOtherValuesM1030: function(){
        Ext.each(this.m1030fields, function(element){
            this.down("[name="+element+"]").on('change', function(el){
                if(el.value){
                    this.m1030NoneOfAbove.setValue(false);
                }
            }, this);
        }, this);
    },
    selectNoneOfAboveM1030: function(){
        this.m1030NoneOfAbove.on('change', function(el){
            if(el.value){
                Ext.each(this.m1030fields, function(element){
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
            }
        }, this);
    },
    selectNoneOfAboveM1033: function(){
        this.m1033HospRiskNoneAbove.on('change', function(el){

            if(el.value){
                Ext.each(this.m1033fields, function(element){
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
            }
        }, this);
    },

    selectOtherValuesM1033: function(){
        Ext.each(this.m1033fields, function(element){
            this.down("[name="+element+"]").on('change', function(el){
                if(el.value){
                    this.m1033HospRiskNoneAbove.setValue(false);
                }
            }, this);
        }, this);
    },
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];

        this.m1030Infusion = this.mainScope.down("[name=m1030_thh_iv_infusion]");
        this.m1030ParNutrition = this.mainScope.down("[name=m1030_thh_par_nutrition]");
        this.m1030EntNutrition = this.mainScope.down("[name=m1030_thh_ent_nutrition]");

        this.m1030NoneOfAbove = this.mainScope.down('[name=m1030_thh_none_above]');
        this.m1033HospRiskHstryFalls = this.mainScope.down('[name = m1033_hosp_risk_hstry_falls]');
        this.m1033HospRiskWeightLoss = this.mainScope.down('[name = m1033_hosp_risk_weight_loss]');
        this.m1033HospRiskMltplHospztn = this.mainScope.down('[name = m1033_hosp_risk_mltpl_hospztn]');
        this.m1033HospRiskMltplEdVisit = this.mainScope.down('[name = m1033_hosp_risk_mltpl_ed_visit]');
        this.m1033HospRiskRcntDcln = this.mainScope.down('[name = m1033_hosp_risk_mntl_bhv_dcln]');
        this.m1033HospRiskReptdHstry = this.mainScope.down('[name = m1033_hosp_risk_compliance]');
        this.m1033HospRisk5plusMdctn = this.mainScope.down('[name = m1033_hosp_risk_5plus_mdctn]');
        this.m1033HospRiskReportsExhaustion = this.mainScope.down('[name = m1033_hosp_risk_crnt_exhstn]');
        this.m1033HospRiskOther = this.mainScope.down('[name = m1033_hosp_risk_othr_risk]');
        this.m1033HospRiskNoneAbove = this.mainScope.down('[name = m1033_hosp_risk_none_above]');
        this.m1030fields = ["m1030_thh_iv_infusion", "m1030_thh_par_nutrition", "m1030_thh_ent_nutrition"];
        this.m1033fields = ["m1033_hosp_risk_hstry_falls", "m1033_hosp_risk_weight_loss", "m1033_hosp_risk_mltpl_hospztn",
            "m1033_hosp_risk_mltpl_ed_visit", "m1033_hosp_risk_mntl_bhv_dcln", "m1033_hosp_risk_compliance",
            "m1033_hosp_risk_5plus_mdctn", "m1033_hosp_risk_crnt_exhstn", "m1033_hosp_risk_othr_risk"];

        this.selectNoneOfAboveM1030();
        this.selectOtherValuesM1030();
        this.selectNoneOfAboveM1033();
        this.selectOtherValuesM1033();

        this.m1036NoneOfAbove = this.mainScope.down('[name=m1036_rsk_none]');
        this.m1036Unknown = this.mainScope.down('[name=m1036_rsk_unknown]');
        this.m1036fields = ["m1036_rsk_smoking", "m1036_rsk_obesity", "m1036_rsk_alcoholism", "m1036_rsk_drugs"];
        this.m1036Smoking = this.mainScope.down("[name=m1036_rsk_smoking]");
        this.m1036Obesity = this.mainScope.down("[name=m1036_rsk_obesity]");
        this.m1036Alcoholism = this.mainScope.down("[name=m1036_rsk_alcoholism]");
        this.m1036Drugs = this.mainScope.down("[name=m1036_rsk_drugs]");

        this.selectNoneOfAboveM1036();
        this.selectOtherValuesM1036();
        this.selectUnknownM1036();
    }

})
