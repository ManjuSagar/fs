/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.StatusRiskVaccineM1030', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.statusRiskVaccineM1030',
    border: false,
    items: [
        {
            layout: "table",
            columns: 2,
            auto_scroll: true,
            border: false,
            items: [
                {
                    columns: 1,
                    height: 400,
                    border: false,
                    items: [
                        {
                            xtype: 'checkboxgroup',
                            fieldLabel: "(M1030) Therapies the patient receives at home: (Mark all that apply.)",
                            cls: 'oasis_green',
                            item_id: 'home_therapy1',
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
                    ]
                },

            ]
        }
    ],
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
    selectOtherValuesM1030: function(){
        Ext.each(this.m1030fields, function(element){
            this.down("[name="+element+"]").on('change', function(el){
                if(el.value){
                    this.m1030NoneOfAbove.setValue(false);
                }
            }, this);
        }, this);
    },
    onValidate: function(main){
        var errs = new Array();
        if(this.m1030Infusion.value == false && this.m1030ParNutrition.value == false
            && this.m1030EntNutrition.value == false && this.m1030NoneOfAbove.value == false){
            errs.push(['M1030', 'Select at least one Therapy that patient receives at home'])
        }

        return errs;
    }
})
