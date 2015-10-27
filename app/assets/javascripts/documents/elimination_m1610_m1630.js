/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.EliminationM1610M1630', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.eliminationM1610M1630',
    border: false,
    items: [
        {
            xtype: "panel",
            border: false,
            layout: "hbox",
            items: [
                {
                    xtype: "panel",
                    border: false,
                    flex: 1,
                    height: 480,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1610) Urinary Incontinence or Urinary Catheter Presence",
                            cls: 'oasis_pink',
                            item_id: 'urin_incontinence1',
                            width: "98%",
                            labelAlign: 'top',
                            columns: 1,
                            margin: 5,
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
                            fieldLabel: "(M1620) Bowel Incontinence Frequency",
                            cls: 'oasis_pink',
                            item_id: 'bowel_incontinence1',
                            width: "98%",
                            labelAlign: 'top',
                            columns: 1,
                            margin: "5",
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
                                    boxLabel: 'UK - Unknown'
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: "panel",
                    border: false,
                    flex: 1,
                    height: 480,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1630) Ostomy for Bowel Elimination: Does this patient have an ostomy for bowel elimination that (within the last 14 days): a) was related to an inpatient facility stay, or b) necessitated a change in medical or treatment regimen?",
                            cls: 'oasis_green',
                            item_id: 'bowel_elimination',
                            width: '98%',
                            labelAlign: 'top',
                            columns: 1,
                            margin: "5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1630_ostomy",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - Patient does not have an ostomy for bowel elimination'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1630_ostomy",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Patient`s ostomy was not related to an inpatient stay and did not necessitate change in medical or treatment regimen'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1630_ostomy",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - The ostomy was related to an inpatient stay or did necessitate change in medical or treatment regimen'
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
        this.m1620AndM1630FieldsEventHandling(radio_group_array);

    },
    afterRender: function()  {
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
    },
    m1620AndM1630FieldsEventHandling: function(radio_group_array){
        this.query("[name=m1620_bwl_incont]").forEach(function(ele){
            ele.on('change', function(el){
                if(el.getGroupValue() == "NA"){
                    this.query("[name=m1630_ostomy]")[0].disable().setValue(false);
                    this.query("[name=m1630_ostomy]")[1].enable();
                    this.query("[name=m1630_ostomy]")[2].enable();
                }
                else{
                    this.query("[name=m1630_ostomy]")[0].enable().setValue("00");
                    this.query("[name=m1630_ostomy]")[1].disable().setValue(false);
                    this.query("[name=m1630_ostomy]")[2].disable().setValue(false);
                }
            }, this);
        },this);
    },
    onValidate: function(main){
        var errs = new Array();
        m1610Value = this.super_main.down("[name=m1610_ur_incont]").getGroupValue();
        m1620Value = this.super_main.down("[name=m1620_bwl_incont]").getGroupValue();
        m1630Value = this.super_main.down("[name=m1630_ostomy]").getGroupValue();
        m1610Catheter = this.super_main.down('radiofield[name=m1610_ur_incont]').getGroupValue();
        m1620Bowel = this.super_main.down('radiofield[name=m1620_bwl_incont]').getGroupValue();
        m1630Elimination = this.super_main.down('radiofield[name=m1630_ostomy]').getGroupValue();
        assessmentReason = this.super_main.down('textfield[name=m0100_assmt_reason]').value;
        if(m1610Catheter == null){
            errs.push(['M1610', "Select whether patient is 'Urinary Incontinence' or any 'Urinary Catheter Presence'."]);
        }
        if(m1620Bowel == null){
            errs.push(['M1620', "Select at least one frequency from Bowel Incontinence."]);
        }
        if(m1630Elimination == null){
            errs.push(['M1630', "Ostomy for Bowel Elimination is required."]);
        }

        if(m1620Value == "NA"){
            if(m1630Value == null){
                errs.push(['M1630', "Do not leave 'Patient's ostomy was not related to an inpatient stay(Option #2)' or 'The ostomy was related to an inpatient stay (Option #3)' empty from 'Ostomy for Bowel Elimination' since 'Bowel Incontinence Frequency' set to 'Not Applicable'."]);
            }
        }

        if((assessmentReason == "04" || assessmentReason == "05" || assessmentReason == "09") && (m1620Bowel == "UK")) {
            errs.push(['M1620', "For this assessment reason bowel incontinence frequency can not be 'UK'"]);
        }
        return errs;
    }
})
