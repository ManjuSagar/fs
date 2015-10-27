/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.NeuroEmotionalBehavioural2M1740M1750', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.neuroEmotionalBehavioural2M1740M1750',
    items: [
        {
            xtype: 'checkboxgroup',
            fieldLabel: "(M1740) Cognitive, behavioral, and psychiatric symptoms that are demonstrated at least once " +
                "a week (Reported or Observed): (Mark all that apply.)",
            cls: 'oasis_blue',
            itemId: 'cog_beh_psyc1',
            width: "98%",
            labelAlign: 'top',
            columns: 1,
            margin: "5px",
            items: [
                {
                    xtype: 'checkboxfield',
                    name: "m1740_bd_mem_deficit",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: "1 - Memory deficit: failure to recognize familiar persons/places, inability to recall " +
                        "events of past 24 hours, significant memory loss so that supervision is required"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1740_bd_imp_decisn",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: "2 - Impaired decision-making: failure to perform usual ADLs or IADLs, inability to " +
                        "appropriately stop activities, jeopardizes safety through actions"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1740_bd_verbal",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: '3 - Verbal disruption: yelling, threatening, excessive profanity, sexual references, etc'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1740_bd_physical",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: "4 - Physical aggression: aggressive or combative to self and others (for example, hits self, throws"+
                    " objects, punches, dangerous maneuvers with wheelchair or other objects)"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1740_bd_soc_inappro",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: '5 - Disruptive, infantile, or socially inappropriate behavior (excludes verbal actions)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1740_bd_delusions",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: '6 - Delusional, hallucinatory, or paranoid behavior'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1740_bd_none",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: '7 - None of the above behaviors demonstrated'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1745) Frequency of Disruptive Behavior Symptoms (Reported or Observed) Any physical, verbal, " +
                "or other disruptive/dangerous symptoms that are injurious to self or others or jeopardize personal safety",
            cls: 'oasis_blue',
            item_id: 'fre_disrupt_beh_sysD',
            width: "98%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1745_beh_prob_freq",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Never'
                },
                {
                    xtype: 'radiofield',
                    name: "m1745_beh_prob_freq",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Less than once a month'
                },
                {
                    xtype: 'radiofield',
                    name: "m1745_beh_prob_freq",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Once a month'
                },
                {
                    xtype: 'radiofield',
                    name: "m1745_beh_prob_freq",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Several times each month'
                },
                {
                    xtype: 'radiofield',
                    name: "m1745_beh_prob_freq",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Several times a week'
                },
                {
                    xtype: 'radiofield',
                    name: "m1745_beh_prob_freq",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - At least daily'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1750) Is this patient receiving Psychiatric Nursing Services at home provided by a qualified psychiatric nurse?",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1750_rec_psych_nurs",
                    inputValue: "0",
                    margin: 5,
                    boxLabel: '0 - No'
                },
                {
                    xtype: 'radiofield',
                    name: "m1750_rec_psych_nurs",
                    inputValue: "1",
                    margin: 5,
                    boxLabel: '1 - Yes'
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m1745Behavior = main.down('radiofield[name=m1745_beh_prob_freq]').getGroupValue();
        m1750Psychiatric = main.down('radiofield[name=m1750_rec_psych_nurs]').getGroupValue();
        if(this.m1740Deficit.value == false && this.m1740Decsin.value == false && this.m1740Verbal.value == false && this.m1740Physical.value == false && this.m1740Inappro.value == false && this.m1740Delusions.value == false && this.m1740None.value == false){
            errs.push(['M1740', "Select at least one Cognitive, behavioral, and psychiatric symptoms demonstrated once in a week."])
        }
        if(m1745Behavior == null){
            errs.push(['M1745', "Select the patient's Frequency of Disruptive Behavior symptoms."]);
        }
        if(m1750Psychiatric == null){
            errs.push(['M1750', "Choose (Yes/No) whether the patient receiving Psychiatric Nursing Services at home."]);
        }
        return errs;
    },
    selectOtherValues: function(){
        Ext.each(this.fields, function(element){
            this.down("[name="+element+"]").on('change', function(el){
                if(el.value){
                    this.m1740None.setValue(false);
                }
            },this);
        }, this);
    },
    selectNoneOfAbove: function(){
        this.noneOfAbove.on('change', function(el){
            if(el.value){
                Ext.each(this.fields, function(element){
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
            }
        }, this);
    },
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.noneOfAbove = this.mainScope.down('checkbox[name=m1740_bd_none]');
        this.fields = ["m1740_bd_mem_deficit", "m1740_bd_imp_decisn", "m1740_bd_verbal", "m1740_bd_physical", "m1740_bd_soc_inappro", "m1740_bd_delusions"]
        this.m1740Deficit = this.mainScope.down("[name=m1740_bd_mem_deficit]");
        this.m1740Decsin = this.mainScope.down("[name=m1740_bd_imp_decisn]");
        this.m1740Verbal = this.mainScope.down("[name=m1740_bd_verbal]");
        this.m1740Physical = this.mainScope.down("[name=m1740_bd_physical]");
        this.m1740Inappro = this.mainScope.down("[name=m1740_bd_soc_inappro]");
        this.m1740Delusions = this.mainScope.down("[name=m1740_bd_delusions]");
        this.m1740None = this.mainScope.down("[name=m1740_bd_none]");
        this.selectNoneOfAbove();
        this.selectOtherValues();
    }
})
