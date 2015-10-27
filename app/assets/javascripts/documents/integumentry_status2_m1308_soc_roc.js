/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.IntegumentryStatus2M1308SocRoc', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.integumentryStatus2M1308SocRoc',
    border: false,
    margin: 5,
    items: [

        {
            xtype: "label",
            margin: 5,
            text: '(M1308) Current Number of Unhealed (non epithelialized) Pressure Ulcers at Each Stage:',
            html: '<i>(Enter "0" if none; excludes Stage I pressure ulcers )</i>',
            cls: 'oasis_pink',
            itemId: 'ne_pres_ulcr'
        },
        {
            html: '<i>(Enter "0" if none; excludes Stage I pressure ulcers )</i>',
            margin: "0 0 0 50",
            border: 0
        },
        {
            xtype: "panel",
            border: false,
            margin: '10 5 5 60',
            layout: {
                type: "table",
                tableAttrs: {
                    border:1,
                    cls: 'oasis_pink'
                },
                columns: 2
            },
            defaults:{
                bodyStyle: 'padding: 5px; background-color: #FFDBDB;'
            },
            items: [
                {
                    html: "" ,
                    height: 55,
                    width: 300,
                    border:false
                },
                {
                    html: "<b>COLUMN 1</b></br>Complete at</br> <b>SOC/ROC/FU & D/C</b>",
                    height: 55,
                    width: 200,
                    style: "text-align:center;",
                    border:false
                },{
                    html: "Stage Description - unhealed pressure ulcers",
                    height: 65,
                    border:false
                },
                {
                    html: "<u>Number Currently Present</u>",
                    height: 65,
                    style: "text-align:center;",
                    border:false
                },
                {
                    html: "<b>a</b>. <b>Stage II:</b> Partial thickness loss of dermis presenting as a shallow open ulcer with red  pink wound bed, without slough. May also present as an intact or open/ruptured serum-filled blister.",
                    width: 300,
                    border:false
                },
                {
                    xtype: "numberfield",
                    margin: 5,
                    labelWidth: 400,
                    minValue:0,
                    name: "m1308_nbr_prsulc_stg2",
                    itemId: 'loss_of_dermis'
                },{
                    html: "<b>b</b>. <b>Stage III:</b> Full thickness tissue loss. Subcutaneous fat may be visible but bone,tendon, or muscles are not exposed. Slough may be present but does not obscure thedepth of tissue loss. May include undermining and tunneling.",
                    width: 300,
                    border:false
                },
                {
                    xtype: "numberfield",
                    margin: 5,
                    labelWidth: 400,
                    minValue:0,
                    name: "m1308_nbr_prsulc_stg3",
                    itemId: 'tissue_loss'
                },{
                    html: "<b>c</b>. <b>Stage IV:</b> Full thickness tissue loss with visible bone, tendon, or muscle. Slough or eschar may be present on some parts of the wound bed. Often includes undermining and tunneling.",
                    width: 300,
                    border:false
                },
                {
                    xtype: "numberfield",
                    margin: 5,
                    labelWidth: 400,
                    minValue:0,
                    name: "m1308_nbr_prsulc_stg4",
                    itemId: 'tissue_loss_with_vis_bone'
                },{
                    html: "<b>d.1</b> Unstageable: Known or likely but unstageable due to non-removable dressing or device.",
                    width: 300,
                    border:false
                },
                {
                    xtype: "numberfield",
                    margin: 5,
                    labelWidth: 400,
                    minValue:0,
                    name: "m1308_nstg_drsg",
                    itemId: 'unstageable_nstg_drsg'
                },
                {
                    html: "<b>d.2</b> Unstageable: Known or likely but unstageable due to coverage of wound bed by slough and/or eschar.",
                    width: 300,
                    border:false
                },
                {
                    xtype: "numberfield",
                    margin: 5,
                    labelWidth: 400,
                    minValue:0,
                    name: "m1308_nstg_cvrg",
                    itemId: 'unstageable_nstg_cvrg'
                },{
                    html: "<b>d.3</b> Unstageable: Suspected deep tissue injury in evolution.",
                    width: 300,
                    border:false
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
    ],
    field1308SocRocValidation: function(field){
        return (field && ((field.value == 0) || field.value == null))
    },
    onValidate: function(main){
        var errs = new Array();
        var m1306Unhold = main.down('radiofield[name=m1306_unhld_stg2_prsr_ulcr]').getGroupValue();
        var m1308Numberfields = main.down("#integumentarystatus2_m1308").query("[xtype=numberfield]");
        var m1308NbrPrsulcStg2 = main.down("[name=m1308_nbr_prsulc_stg2]").value;
        var m1308NbrPrsulcStg3 = main.down("[name=m1308_nbr_prsulc_stg3]").value;
        var m1308NbrPrsulcStg4 = main.down("[name=m1308_nbr_prsulc_stg4]").value;
        var m1308NstgDrsg = main.down("[name=m1308_nstg_drsg]").value;
        var m1308NstgCvrg = main.down("[name=m1308_nstg_cvrg]").value;
        var m1308NstgDeepTisue = main.down("[name=m1308_nstg_deep_tisue]").value;
        var m1308NbrStg2AtSocRoc = main.down('[name=m1308_nbr_stg2_at_soc_roc]');
        var m1308NbrStg3AtSocRoc = main.down('[name=m1308_nbr_stg3_at_soc_roc]');
        var m1308NbrStg4AtSocRoc = main.down('[name=m1308_nbr_stg4_at_soc_roc]');
        var m1308NstgDrsgSocRoc = main.down('[name=m1308_nstg_drsg_soc_roc]');
        var m1308NstgCvrgSocRoc = main.down('[name=m1308_nstg_cvrg_soc_roc]');
        var m1308NstgDeepTisueSocRoc = main.down('[name=m1308_nstg_deep_tisue_soc_roc]');
        var assessmentReason = main.down('textfield[name=m0100_assmt_reason]');

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
            if ((m1308NbrStg2AtSocRoc) && (m1308NbrStg2AtSocRoc.value != null && m1308NbrPrsulcStg2 < m1308NbrStg2AtSocRoc.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'a', Column 1 must be grater than column 2"]);
            }
            if ((m1308NbrStg3AtSocRoc) && (m1308NbrStg3AtSocRoc.value != null && m1308NbrPrsulcStg3 < m1308NbrStg3AtSocRoc.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'b', Column 1 must be grater than column 2"]);
            }

            if((m1308NbrStg4AtSocRoc) && (m1308NbrStg4AtSocRoc.value != null && m1308NbrPrsulcStg4 < m1308NbrStg4AtSocRoc.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'c', Column 1 must be grater than column 2"]);
            }
            if ((m1308NstgDrsgSocRoc) && (m1308NstgDrsgSocRoc.value != null && m1308NstgDrsg < m1308NstgDrsgSocRoc.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'd1', Column 1 must be grater than column 2"]);
            }

            if ((m1308NstgCvrgSocRoc) && (m1308NstgCvrgSocRoc.value != null && m1308NstgCvrg < m1308NstgCvrgSocRoc.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'd2', Column 1 must be grater than column 2"]);
            }

            if ((m1308NstgDeepTisueSocRoc) && (m1308NstgDeepTisueSocRoc.value != null && m1308NstgDeepTisue < m1308NstgDeepTisueSocRoc.value)){
                errs.push(["M1308", "Stage Description - Unhealed Pressure Ulcers 'd3', Column 1 must be grater than column 2"]);
            }
        }

        return errs;
    }

})
