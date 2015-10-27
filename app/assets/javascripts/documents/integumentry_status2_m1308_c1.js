/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.IntegumentryStatus2M1308C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.integumentryStatus2M1308C1',
    border: false,
    margin: 5,
    items: [
        {
            xtype: "panel",
            border: false,
            layout: {
                align: "strech",
                type: "hbox"
            },
            items: [
                   {
                    xtype: "panel",
                    border: false,
                    margin: 5,
                    itemId: "integumentarystatus2_m1308",
                       layout: {
                        type: "vbox"
                    },
                    items: [

                        {
                            xtype: "label",
                            margin: 5,
                            text: '(M1308) Current Number of Unhealed Pressure Ulcers at Each Stage or Unstageable',
                            html: '<i>(Enter “0” if none; Excludes Stage I pressure ulcers and healed Stage II pressure ulcers) </i>',
                            cls: 'oasis_pink',
                            itemId: 'ne_pres_ulcr'
                        },
                        {
                            html: '<i>(Enter “0” if none; Excludes Stage I pressure ulcers and healed Stage II pressure ulcers) </i>',
                            margin: "0 0 0 10",
                            border: 0
                        },
                        {
                            xtype: "panel",
                            border: false,
                            margin: '10 5 5 5',
                            layout: {
                                type: "table",
                                tableAttrs: {
                                    border: 1,
                                    cls: 'oasis_pink'
                                },
                                columns: 2
                            },
                            defaults: {
                                bodyStyle: 'padding: 5px; background-color: #FFDBDB;'
                            },
                            items: [
                                {
                                    html: "Stage Description - unhealed pressure ulcers",
                                    height: 65,
                                    border: false
                                },
                                {
                                    html: "<u>Number Currently Present</u>",
                                    height: 65,
                                    style: "text-align:center;",
                                    border: false
                                },
                                {
                                    html: "<b>a</b>. <b>Stage II:</b> Partial thickness loss of dermis presenting as a shallow open ulcer with red  pink wound bed, without slough. May also present as an intact or open/ruptured serum-filled blister.",
                                    width: 300,
                                    border: false
                                },
                                {
                                    xtype: "numberfield",
                                    margin: 5,
                                    labelWidth: 400,
                                    minValue: 0,
                                    name: "m1308_nbr_prsulc_stg2",
                                    itemId: 'loss_of_dermis'
                                },
                                {
                                    html: "<b>b</b>. <b>Stage III:</b> Full thickness tissue loss. Subcutaneous fat may be visible but bone,tendon, or muscles are not exposed. Slough may be present but does not obscure thedepth of tissue loss. May include undermining and tunneling.",
                                    width: 300,
                                    border: false
                                },
                                {
                                    xtype: "numberfield",
                                    margin: 5,
                                    labelWidth: 400,
                                    minValue: 0,
                                    name: "m1308_nbr_prsulc_stg3",
                                    itemId: 'tissue_loss'
                                },
                                {
                                    html: "<b>c</b>. <b>Stage IV:</b> Full thickness tissue loss with visible bone, tendon, or muscle. Slough or eschar may be present on some parts of the wound bed. Often includes undermining and tunneling.",
                                    width: 300,
                                    border: false
                                },
                                {
                                    xtype: "numberfield",
                                    margin: 5,
                                    labelWidth: 400,
                                    minValue: 0,
                                    name: "m1308_nbr_prsulc_stg4",
                                    itemId: 'tissue_loss_with_vis_bone'
                                },
                                {
                                    html: "<b>d.1</b> Unstageable: Known or likely but unstageable due to non-removable dressing or device.",
                                    width: 300,
                                    border: false
                                },
                                {
                                    xtype: "numberfield",
                                    margin: 5,
                                    labelWidth: 400,
                                    minValue: 0,
                                    name: "m1308_nstg_drsg",
                                    itemId: 'unstageable_nstg_drsg'
                                },
                                {
                                    html: "<b>d.2</b> Unstageable: Known or likely but unstageable due to coverage of wound bed by slough and/or eschar.",
                                    width: 300,
                                    border: false
                                },
                                {
                                    xtype: "numberfield",
                                    margin: 5,
                                    labelWidth: 400,
                                    minValue: 0,
                                    name: "m1308_nstg_cvrg",
                                    itemId: 'unstageable_nstg_cvrg'
                                },
                                {
                                    html: "<b>d.3</b> Unstageable: Suspected deep tissue injury in evolution.",
                                    width: 300,
                                    border: false
                                },
                                {
                                    xtype: "numberfield",
                                    margin: 5,
                                    labelWidth: 400,
                                    minValue: 0,
                                    name: "m1308_nstg_deep_tisue",
                                    itemId: 'unstageable_nstg_deep_tisue'
                                }
                            ]
                        }
                    ]
                },

                {
                      xtype: "panel",
                      layout: {
                        type: "vbox",
                          align: "strech"
                       },
                      itemId: 'integumentarystatus2_m1309',
                      border: false,
                      margin: '20 5 5 10',
                      items: [
                          {
                          xtype: "label",
                          margin: 5,
                          text: '(M1309) Worsening in Pressure Ulcer Status since SOC/ROC: ',
                          html: '<i>(Enter “0” if none; excludes Stage I pressure ulcers and healed Stage II pressure ulcers) </i>',
                          cls: 'oasis_pink',
                          itemId: ''
                         },
                         {
                                   xtype: "label",
                                   text: "Instructions for a – c: For Stage II, III and IV pressure ulcers, report the number that are new or have increased in "+
                                         " numerical stage since the most recent SOC/ROC",
                                   cls: 'oasis_pink',
                                   margin: '0 0 0 10',
                                   width: 750,
                                   border: false
                         },
                         {
                                   xtype: "panel",
                                   layout: {
                                       type: "table",
                                       tableAttrs: {
                                           border: 1,
                                           cls: 'oasis_pink'
                                       },
                                       columns: 2
                                   },
                                   defaults: {
                                   bodyStyle: 'padding: 5px; background-color: #FFDBDB;'
                                   },
                                   margin: '10 5 5 5',
                                   items: [
                                       {
                                            html: "",
                                            width: 150,
                                            border: false
                                       },
                                       {
                                           html: "Enter Number (Enter “0” if there are no current Stage II, III or IV pressure ulcers OR if all current Stage II,"+
                                                " III or IV pressure ulcers existed at the same numerical stage at most recent SOC/ROC)",
                                           width: 400,
                                           border: false
                                       },
                                       {
                                           html: "a. Stage II",
                                           width: 150,
                                           border: false

                                       },
                                       {
                                           xtype: "numberfield",
                                           margin: 5,
                                           labelWidth: 400,
                                           minValue: 0,
                                           name: "m1309_nbr_new_wrs_prsulc_stg2",
                                           itemId: ''
                                       },
                                       {
                                           html: "b. Stage III",
                                           width: 150,
                                           border: false

                                       },
                                       {
                                           xtype: "numberfield",
                                           margin: 5,
                                           labelWidth: 400,
                                           minValue: 0,
                                           name: "m1309_nbr_new_wrs_prsulc_stg3",
                                           itemId: ''
                                       },
                                       {
                                           html: "c. Stage IV",
                                           width: 150,
                                           border: false

                                       },
                                       {
                                           xtype: "numberfield",
                                           margin: 5,
                                           labelWidth: 400,
                                           minValue: 0,
                                           name: "m1309_nbr_new_wrs_prsulc_stg4",
                                           itemId: ''
                                       }

                                   ]
                         },
                          {
                              xtype: "label",
                              text: "Instructions for d: For pressure ulcers that are unstageable due to "+
                                  "slough/eschar, report the number that are new"+
                                  " or were a Stage I or II at the most recent SOC/ROC.",
                              margin: '0 0 0 10',
                              labelWidth: 30,
                              width: 750,
                              cls: 'oasis_pink'
                          },
                          {
                              xtype: "panel",
                              layout: {
                                  type: "table",
                                  tableAttrs: {
                                      border: 1,
                                      cls: 'oasis_pink'
                                  },
                                  columns: 2
                              },
                              defaults: {
                                  bodyStyle: 'padding: 5px; background-color: #FFDBDB;'
                              },
                              margin: '10 5 5 5',
                              items: [

                                  {
                                      html: "",
                                      width: 150,
                                      border: false
                                  },
                                  {
                                      html: "Enter Number (Enter “0” if there are no unstageable pressure"+
                                           " ulcers at discharge OR if all current"+
                                           " unstageable pressure ulcers were Stage III"+
                                           " or IV or were unstageable at most recent SOC/ROC)",
                                      width: 400,
                                      border: false
                                  },
                                  {
                                      html: "a. Unstageable due to coverage of wound bed by slough or eschar",
                                      width: 150,
                                      border: false

                                  },
                                  {
                                      xtype: "numberfield",
                                      margin: 5,
                                      labelWidth: 400,
                                      minValue: 0,
                                      name: "m1309_nbr_new_wrs_prsulc_nstg",
                                      itemId: ''
                                  }

                              ]
                          }
                       ]
                 }
            ]
        }
    ],
    field1308SocRocValidation: function(field){
        return (field && ((field.value == 0) || field.value == null))
    },
    onValidate: function(main){
        var errs = new Array();
        var m1306Unhold = main.down('radiofield[name=m1306_unhld_stg2_prsr_ulcr]').getGroupValue();
        var m1308Numberfields = main.down("#integumentarystatus2_m1308").query("[xtype=numberfield]");
        var m1309Numberfields = main.down("#integumentarystatus2_m1309").query("[xtype=numberfield]");
        var m1308NbrPrsulcStg2 = main.down("[name=m1308_nbr_prsulc_stg2]").value;
        var m1308NbrPrsulcStg3 = main.down("[name=m1308_nbr_prsulc_stg3]").value;
        var m1308NbrPrsulcStg4 = main.down("[name=m1308_nbr_prsulc_stg4]").value;
        var m1308NstgDrsg = main.down("[name=m1308_nstg_drsg]").value;
        var m1308NstgCvrg = main.down("[name=m1308_nstg_cvrg]").value;
        var m1308NstgDeepTisue = main.down("[name=m1308_nstg_deep_tisue]").value;
        var assessmentReason = main.down('textfield[name=m0100_assmt_reason]');
        var m1309NbrNewWrsPrsulcStg2 = main.down('[name=m1309_nbr_new_wrs_prsulc_stg2]');
        var m1309NbrNewWrsPrsulcStg3 = main.down('[name=m1309_nbr_new_wrs_prsulc_stg3]');
        var m1309NbrNewWrsPrsulcStg4 = main.down('[name=m1309_nbr_new_wrs_prsulc_stg4]');
        var m1309NbrNewWrsPrsulcNstg = main.down('[name=m1309_nbr_new_wrs_prsulc_nstg]');

        Ext.each(m1308Numberfields, function(field, index){
            if (m1306Unhold == "1" && field.value == null){
                if(field.name == "m1308_nbr_prsulc_stg2"){
                    errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'a', Column 1, cannot be blank."]);
                } else if(field.name == "m1308_nbr_prsulc_stg3"){
                    errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'b', Column 1, cannot be blank."]);
                }else if(field.name == "m1308_nbr_prsulc_stg4"){
                    errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'c', Column 1, cannot be blank."]);
                }else if(field.name == "m1308_nstg_drsg"){
                    errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'd1', Column 1, cannot be blank."]);
                }else if(field.name == "m1308_nstg_cvrg"){
                    errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'd2', Column 1, cannot be blank."]);
                }else if(field.name == "m1308_nstg_deep_tisue"){
                    errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'd3', Column 1, cannot be blank."]);
                }
            }
        });


        if(m1306Unhold == "1"){
            if (assessmentReason.value == 1 || assessmentReason.value == 3){
                if (m1308NbrPrsulcStg2 == 0 && m1308NbrPrsulcStg3 == 0 && m1308NbrPrsulcStg4 == 0 && m1308NstgDrsg == 0 && m1308NstgCvrg == 0 &&
                    m1308NstgDeepTisue == 0 ){
                    errs.push(["M1308", "At least one item between Stage Description - unhealed pressure ulcers column 1 and column2 must be grater than 0."])
                }
            } else if(assessmentReason.value == 4 || assessmentReason.value == 5 || assessmentReason.value == 9){
                if (m1308NbrPrsulcStg2 == 0 && m1308NbrPrsulcStg3 == 0 && m1308NbrPrsulcStg4 == 0 && m1308NstgDrsg == 0 && m1308NstgCvrg == 0 &&
                    m1308NstgDeepTisue == 0 && this.field1308SocRocValidation(m1308NbrStg2AtSocRoc) && this.field1308SocRocValidation(m1308NbrStg3AtSocRoc) &&
                    this.field1308SocRocValidation(m1308NbrStg4AtSocRoc) && this.field1308SocRocValidation(m1308NstgDrsgSocRoc) &&
                    this.field1308SocRocValidation(m1308NstgCvrgSocRoc) && this.field1308SocRocValidation(m1308NstgDeepTisueSocRoc)){
                    errs.push(["M1308", "At least one item between Stage Description - unhealed pressure ulcers column 1 and column2 must be grater than 0."])
                }
            }
            if ((m1309NbrNewWrsPrsulcStg2) && (m1309NbrNewWrsPrsulcStg2.value != null && m1308NbrPrsulcStg2 < m1309NbrNewWrsPrsulcStg2.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'M1308 a', must be grater than Worsening in Pressure Ulcer 'M1309 a' "]);
            }
            if ((m1309NbrNewWrsPrsulcStg3) && (m1309NbrNewWrsPrsulcStg3.value != null && m1308NbrPrsulcStg3 < m1309NbrNewWrsPrsulcStg3.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'M1308 b', must be grater than Worsening in Pressure Ulcer 'M1309 b'"]);
            }

            if((m1309NbrNewWrsPrsulcStg4) && (m1309NbrNewWrsPrsulcStg4.value != null && m1308NbrPrsulcStg4 < m1309NbrNewWrsPrsulcStg4.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'M1308 c', must be grater than Worsening in Pressure Ulcer 'M1309 c'"]);
            }
            if ((m1309NbrNewWrsPrsulcNstg) && (m1309NbrNewWrsPrsulcNstg.value != null && m1308NstgCvrg < m1309NbrNewWrsPrsulcNstg.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'm1308 d2', must be grater than Worsening in Pressure Ulcer coverage 'M1309"]);
            }

        }

        return errs;
    }

})
