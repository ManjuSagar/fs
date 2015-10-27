/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.EliminationM1600M1620', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.eliminationM1600M1620',
    border: false,
    items: [

        {
            xtype: "panel",
            layout: "hbox",
            items: [
                {
                    xtype: "panel",
                    border: false,
                    flex: 1,
                    height: 600,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1600) Has this patient been treated for a Urinary Tract Infection in the past 14 days?",
                            cls: 'oasis_blue',
                            item_id: 'urinary_tract_infection',
                            width: "98%",
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1600_uti",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - No'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1600_uti",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Yes'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1600_uti",
                                    inputValue: "NA",
                                    margin: 5,
                                    boxLabel: 'NA - Patient on prophylactic treatment'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1600_uti",
                                    inputValue: "UK",
                                    margin: 5,
                                    boxLabel: 'UK - Unknown[Omit "UK" option on DC]'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1610) Urinary Incontinence or Urinary Catheter Presence",
                            cls: 'oasis_pink',
                            item_id: 'uri_tract_inf',
                            width: "98%",
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1610_ur_incont",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - No incontinence or catheter (includes anuria or ostomy for urinary drainage)',
                                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1620]</text>'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1610_ur_incont",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Patient is incontinent'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1610_ur_incont",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - Patient requires a urinary catheter (specifically: external, indwelling, intermittent, suprapubic)',
                                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1620]</text>'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1615) When does Urinary Incontinence occur?",
                            cls: 'oasis_blue',
                            item_id: 'uri_incontinence',
                            width: "98%",
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1615_incntnt_timing",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - Timed-voiding defers incontinence'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1615_incntnt_timing",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Occasional stress incontinence'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1615_incntnt_timing",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - During the night only'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1615_incntnt_timing",
                                    inputValue: "03",
                                    margin: 5,
                                    boxLabel: '3 - During the day only'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1615_incntnt_timing",
                                    inputValue: "04",
                                    margin: 5,
                                    boxLabel: '4 - During the day and night'
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: "panel",
                    border: false,
                    flex: 1,
                    height: 400,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1620) Bowel Incontinence Frequency",
                            cls: 'oasis_pink',
                            item_id: 'bow_incontinence_fre',
                            width: "98%",
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1620_bwl_incont",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - Very rarely or never has bowel incontinence'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1620_bwl_incont",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Less than once weekly'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1620_bwl_incont",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - One to three times weekly'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1620_bwl_incont",
                                    inputValue: "03",
                                    margin: 5,
                                    boxLabel: '3 - Four to six times weekly'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1620_bwl_incont",
                                    inputValue: "04",
                                    margin: 5,
                                    boxLabel: '4 - On a daily basis'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1620_bwl_incont",
                                    inputValue: "05",
                                    margin: 5,
                                    boxLabel: '5 - More often than once daily'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1620_bwl_incont",
                                    inputValue: "NA",
                                    margin: 5,
                                    boxLabel: 'NA - Patient has ostomy for bowel elimination'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1620_bwl_incont",
                                    inputValue: "UK",
                                    margin: 5,
                                    boxLabel: 'UK - Unknown [omit "UK" option on FU, DC]'
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ],
    initComponent: function(){
        this.callParent();
        radio_group_array = this.query("[xtype=radiogroup]");
        this.m1610AndM1615FieldsEventHandling(radio_group_array);
        //this.m1620AndM1630FieldsEventHandling(radio_group_array);

    },
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
    },
    m1610AndM1615FieldsEventHandling: function(radio_group_array){
        this.query("[name=m1610_ur_incont]").forEach(function(ele){
            ele.on('change', function(el){
                if(el.getGroupValue() == "00" || el.getGroupValue() == "02"){
                    radio_group_array[2].disable();
                    radios = radio_group_array[2].query("radiofield");
                    radios.forEach(function(e){e.setValue(false);});
                }
                else{
                    radio_group_array[2].enable();
                }
            }, this);
        },this);
    },
    m1620AndM1630FieldsEventHandling: function(radio_group_array){
        this.query("[name=m1620_bwl_incont]").forEach(function(ele){
            ele.on('change', function(el){
                if(el.getGroupValue() == "NA"){
                    radio_group_array[4].query("[name=m1630_ostomy]")[0].disable().setValue(false);
                    radio_group_array[4].query("[name=m1630_ostomy]")[1].enable();
                    radio_group_array[4].query("[name=m1630_ostomy]")[2].enable();
                }
                else{
                    radio_group_array[4].query("[name=m1630_ostomy]")[0].enable().setValue("00");
                    radio_group_array[4].query("[name=m1630_ostomy]")[1].disable().setValue(false);
                    radio_group_array[4].query("[name=m1630_ostomy]")[2].disable().setValue(false);
                }
            }, this);
        },this);
    },
    onValidate: function(main){
        var errs = new Array();
        m1610Value = this.super_main.down("[name=m1610_ur_incont]").getGroupValue();
        m1615Value = this.super_main.down("[name=m1615_incntnt_timing]").getGroupValue();
        m1620Value = this.super_main.down("[name=m1620_bwl_incont]").getGroupValue();
        //m1630Value = this.super_main.down("[name=m1630_ostomy]").getGroupValue();
        m1600Urinary = this.super_main.down('radiofield[name=m1600_uti]').getGroupValue();
        m1610Catheter = this.super_main.down('radiofield[name=m1610_ur_incont]').getGroupValue();
        m1620Bowel = this.super_main.down('radiofield[name=m1620_bwl_incont]').getGroupValue();
        assessmentReason = this.super_main.down('textfield[name=m0100_assmt_reason]').value;
        //m1630Elimination = this.super_main.down('radiofield[name=m1630_ostomy]').getGroupValue();
        if(m1600Urinary == null){
            errs.push(['M1600', "Select a reason whether the patient has been treated for Urinary Tract Infection in the past 14 days."]);
        }else if(assessmentReason == "09" && m1600Urinary == 'UK'){
            errs.push(['M1600', "Selected reason should not be 'UK', since the patient has been treated for Urinary Tract Infection in the past 14 days "]);
        }
        if(m1610Catheter == null){
            errs.push(['M1610', "Select whether patient is 'Urinary Incontinence' or any 'Urinary Catheter Presence'."]);
        }
        if(m1620Bowel == null){
            errs.push(['M1620', "Select at least one frequency from Bowel Incontinence."]);
        }
        /*if(m1630Elimination == null){
         errs.push(['M1630', "Ostomy for Bowel Elimination is required."]);
         } */
        if(m1610Value == "01"){
            if(m1615Value == null){
                errs.push(['M1615', "Do not leave patient's 'Urinary Incontinence time of occurrence' field empty, since 'Patient is incontinent' has been selected in 'Urinary Incontinence' status."]);
            }
        }

        if((assessmentReason == "04" || assessmentReason == "05" || assessmentReason == "09") && (m1620Bowel == "UK")) {
            errs.push(['M1620', "For this assessment reason bowel incontinence frequency can not be 'UK'"]);
        }

        /*if(m1620Value == "NA"){
         if(m1630Value == null){
         errs.push(['M1630', 'Do not leave 'Patient's ostomy was not related to an inpatient stay(Option #2)' or 'The ostomy was related to an inpatient stay (Option #3)' empty from 'Ostomy for Bowel Elimination' since 'Bowel Incontinence Frequency' set to 'Not Applicable'.']);
         }
         }  */
        return errs;
    }
})
