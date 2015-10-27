/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.TherapyNeedm2200', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.therapyNeedm2200',
    border: 0,
    items: [
        {
            xtype: 'panel',
            border: 0,
            height: 200,
            items: [
                {
                    xtype: 'textfield',
                    fieldLabel: "(M2200) Therapy Need: In the home health plan of care for the Medicare payment episode for which this assessment will define a case mix group, what is the indicated need for therapy visits (total of reasonable and necessary physical, occupational, and speech-language pathology visits combined)? (Enter zero [ '000' ] if no therapy visits indicated.)",
                    cls: 'oasis_green',
                    itemId: 'therapy_need',
                    afterLabelTpl: '<br> (__ __ __) Number of therapy visits indicated (total of physical, occupational and speech-language pathology combined)',
                    name: 'm2200_ther_need_nbr',
                    labelAlign: 'top',
                    margin: '0 0 0 5px',
                    width: '46%'
                },
                {
                    xtype: 'checkbox',
                    fieldLabel: " ",
                    labelSeparator: " ",
                    cls: 'oasis_green',
                    labelAlign: 'top',
                    margin: '0 0 0 5px',
                    inputValue: '1',
                    name: 'm2200_ther_need_na',
                    boxLabel: 'NA - Not Applicable: No case mix group defined by this assessment',
                    width: "46%"
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        var m2200TherNeedNumValue = main.down("[name=m2200_ther_need_nbr]").value;
        var m2200TherNeedNaValue = main.down("[name=m2200_ther_need_na]").value;
        if((m2200TherNeedNumValue == undefined || m2200TherNeedNumValue.trim() == '') && m2200TherNeedNaValue == false){
            errs.push(['M2200', "Enter Therapy Need visit count or select 'NOT Applicable'."]);
        }
        if (m2200TherNeedNumValue && m2200TherNeedNumValue.trim() != ''){
          if(/^-?[\d.]+(?:e-?\d+)?$/.test(m2200TherNeedNumValue) == false) {
            errs.push(['M2200', "Therapy Need should be a number."]);
          }
        }
        return errs;
    },
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        num = this.super_main.down("[name=m2200_ther_need_nbr]");
        na = this.super_main.down("[name=m2200_ther_need_na]");

        num.on('change', function(){
            if((num.value.trim() != "") && na.value){
                na.setValue(false);
            }
        }, this);

        na.on('change', function(){
            if(na.value && na.initialTrue != '1'){
                Ext.MessageBox.confirm("Confirmation", "Beware the HIPPS Code cannot be generated, since 'Not Applicable' is selected.", function(btn){
                    if(btn == "yes"){
                        num.setValue();
                    }else{
                        na.setValue(false);
                    }
                }, this);
            }
            na.initialTrue = false;
        }, this);
    }
})
