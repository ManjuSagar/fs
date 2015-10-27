/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.StatusRiskVaccineM1030M1036', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.statusRiskVaccineM1030M1036',
    border: false,
    margin: 5,
    items: [

        {
            layout: "table",
            columns: 2,
            auto_scroll: true,
            border: false,
            items: [
                {
                    columns: 1,
                    height: 450,
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
        fieldLabel: "(M1032) Risk for Hospitalization: Which of the following signs or symptoms characterize this patient as at risk for hospitalization? (Mark all that apply.)",
    labelAlign: 'top',
        columns: 1,
    margin: "10 5",
    items: [
    {
        xtype: 'checkboxfield',
        name: "m1032_hosp_risk_rcnt_dcln",
        inputValue: "1",
        margin: 5,
        boxLabel: '1 - Recent decline in mental, emotional, or behavioral status'
    },
    {
        xtype: 'checkboxfield',
        name: "m1032_hosp_risk_mltpl_hospztn",
        inputValue: "1",
        margin: 5,
        boxLabel: '2 - Multiple hospitalizations (2 or more) in the past 12 months'
    },
    {
        xtype: 'checkboxfield',
        name: "m1032_hosp_risk_hstry_falls",
        inputValue: "1",
        margin: 5,
        boxLabel: '3 - History of falls (2 or more falls - or any fall with an injury - in the past year)'
    },
{
    xtype: 'checkboxfield',
        name: "m1032_hosp_risk_5plus_mdctn",
    inputValue: "1",
    margin: 5,
    boxLabel: '4 - Taking five or more medications'
},
{
    xtype: 'checkboxfield',
        name: "m1032_hosp_risk_frailty",
    inputValue: "1",
    margin: 5,
    boxLabel: '5 - Frailty indicators, e.g., weight loss, self-reported exhaustion'
},
{
    xtype: 'checkboxfield',
        name: "m1032_hosp_risk_othr",
    inputValue: "1",
    margin: 5,
    boxLabel: '6 - Other'
},
{
    xtype: 'checkboxfield',
        name: "m1032_hosp_risk_none_above",
    inputValue: "1",
    margin: 5,
    boxLabel: '7 - None of the above'
},
]
}
]
},{
    columns: 1,
        height: 450,
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
        errs.push(['M1030', 'Select at least one Therapy that patient receives at home'])
    }

    if(this.m1032Dcln.value == false && this.m1032Hosptztn.value == false && this.m1032Falls.value == false && this.m1032Mdctn.value == false && this.m1032Frailty.value == false && this.m1032Othr.value == false && this.m1032NoneOfAbove.value == false){
        errs.push(['M1032', 'Select at least one item from Risk for Hospitalization'])
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
selectOtherValuesM1032:
    function(){
        Ext.each(this.m1032fields, function(element){
            this.down("[name="+element+"]").on('change', function(el){
                if(el.value){
                    this.m1032NoneOfAbove.setValue(false);
                }
            }, this);
        }, this);
    },
selectNoneOfAboveM1032: function(){
    this.m1032NoneOfAbove.on('change', function(el){
        if(el.value){
            Ext.each(this.m1032fields, function(element){
                this.down("checkbox[name="+element+"]").setValue(false);
            }, this);
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
afterRender: function(){
    this.callParent();
    this.mainScope = Ext.ComponentQuery.query('#super_main')[0];

    this.m1030Infusion = this.mainScope.down("[name=m1030_thh_iv_infusion]");
    this.m1030ParNutrition = this.mainScope.down("[name=m1030_thh_par_nutrition]");
    this.m1030EntNutrition = this.mainScope.down("[name=m1030_thh_ent_nutrition]");

    this.m1030NoneOfAbove = this.mainScope.down('[name=m1030_thh_none_above]');
    this.m1030fields = ["m1030_thh_iv_infusion", "m1030_thh_par_nutrition", "m1030_thh_ent_nutrition"];

    this.selectNoneOfAboveM1030();
    this.selectOtherValuesM1030();

    this.m1032NoneOfAbove = this.mainScope.down('[name=m1032_hosp_risk_none_above]');
    this.m1032fields = ["m1032_hosp_risk_rcnt_dcln", "m1032_hosp_risk_mltpl_hospztn", "m1032_hosp_risk_hstry_falls",
        "m1032_hosp_risk_5plus_mdctn", "m1032_hosp_risk_frailty", "m1032_hosp_risk_othr"];

    this.m1032Dcln = this.mainScope.down("[name=m1032_hosp_risk_rcnt_dcln]");
    this.m1032Hosptztn = this.mainScope.down("[name=m1032_hosp_risk_mltpl_hospztn]");
    this.m1032Falls = this.mainScope.down("[name=m1032_hosp_risk_hstry_falls]");
    this.m1032Mdctn = this.mainScope.down("[name=m1032_hosp_risk_5plus_mdctn]");
    this.m1032Frailty = this.mainScope.down("[name=m1032_hosp_risk_frailty]");
    this.m1032Othr = this.mainScope.down("[name=m1032_hosp_risk_othr]");

    this.selectNoneOfAboveM1032();
    this.selectOtherValuesM1032();

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
