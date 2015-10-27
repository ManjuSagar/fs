/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.RespiratoryCardacM1400M1410', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.respiratoryCardacM1400M1410',
    border: false,
    margin: 5,
    items: [

        {
            xtype: 'radiogroup',
            width: 757,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1400) When is the patient dyspneic or noticeably Short of Breath?',
            cls: 'oasis_pink',
            itemId: 'shrt_of_breath',
            width: "58%",
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '0 - Patient is not short of breath ',
                    inputValue: '00'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '1 - When walking more than 20 feet, climbing stairs',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '2 - With moderate exertion (for example, while dressing, using commode or bedpan, walking distances less than 20 feet) ',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '3 - With minimal exertion (for example, while eating, talking, or performing other ADLs) or with agitation',
                    inputValue: '03'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '4 - At rest (during day or night)',
                    inputValue: '04'
                }
            ]
        },
        {
            xtype: 'checkboxgroup',
            width: 757,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1410) Respiratory Treatments utilized at home: (Mark all that apply.)',
            labelAlign: 'top',
            items: [
                {
                    xtype: 'checkboxfield',
                    name: 'm1410_resptx_oxygen',
                    boxLabel: '1 - Oxygen (intermittent or continuous)',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1410_resptx_ventilator',
                    boxLabel: '2 - Ventilator (continually or at night)',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1410_resptx_airpress',
                    boxLabel: '3 - Continuous / Bi-level positive airway pressure ',
                    inputValue: '1'
                },
                {
                    xtype: 'checkboxfield',
                    name: 'm1410_resptx_none',
                    boxLabel: '4 - None of the above ',
                    inputValue: '1'
                }
            ]
        }

    ],
    onValidate: function(main){
        var errs = new Array();
        m1400Dyspneic = main.down('radiofield[name=m1400_when_dyspneic]').getGroupValue();
        if(m1400Dyspneic == null){
            errs.push(['M1400', "Select the reason when patient feel noticeably Short of Breath."]);
        }
        if(this.m1410Oxygen.value == false && this.m1410Ventilator.value == false && this.m1410AirPress.value == false && this.m1410None.value == false){
            errs.push(['M1410', "Select at least one mode of treatment from 'Respiratory Treatments utilized at home'."])
        }
        return errs;
    },
    selectOtherValues: function(){
        Ext.each(this.fields, function(element){
            this.down("[name="+element+"]").on('change',function(el){
                if(el.value){
                    this.m1410None.setValue(false);
                }
            }, this);
        }, this);
    },
    selectNoneOfAbove: function(){
        this.noneOfAbove.on('change',function(el){
            if(el.value){
                Ext.each(this.fields, function(element){
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
            }
        }, this);
    },
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        this.noneOfAbove = this.super_main.down('checkbox[name=m1410_resptx_none]');
        this.fields = ["m1410_resptx_oxygen", "m1410_resptx_ventilator", "m1410_resptx_airpress"];
        this.m1410Oxygen = this.super_main.down("[name=m1410_resptx_oxygen]");
        this.m1410Ventilator = this.super_main.down("[name=m1410_resptx_ventilator]");
        this.m1410AirPress = this.super_main.down("[name=m1410_resptx_airpress]");
        this.m1410None = this.super_main.down("[name=m1410_resptx_none]");
        this.selectNoneOfAbove();
        this.selectOtherValues();
    }
})
