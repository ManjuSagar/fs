/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.PressureUlserM1322M1324C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.pressureUlserM1322M1324C1',
    border: false,
    items: [
        {
            xtype: 'radiogroup',
            layout:{
                align: 'stretch',
                type: 'vbox'
            },
            margin: 5,
            fieldLabel: '(M1322) Current Number of Stage I Pressure Ulcers: Intact skin with non-blanchable redness'+
                'of a localized area usually over a bony prominence. The area may be painful, firm, soft, warmer, or'+
                'cooler as compared to adjacent tissue. ',
            cls: 'oasis_green',
            item_id: 'stg_1_ulcer',
            width: "95%",
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1322_nbr_prsulc_stg1',
                    boxLabel: '0',
                    inputValue: '00'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1322_nbr_prsulc_stg1',
                    boxLabel: '1',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1322_nbr_prsulc_stg1',
                    boxLabel: '2',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1322_nbr_prsulc_stg1',
                    boxLabel: '3',
                    inputValue: '03'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1322_nbr_prsulc_stg1',
                    boxLabel: '4 or more',
                    inputValue: '04'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            height: 200,
            width: 405,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            margin: 5,
            fieldLabel: '(M1324) Stage of Most Problematic Unhealed Pressure Ulcer that is Stageable: (Excludes pressure ulcer that cannot be staged due to a non-removable dressing/device, coverage of wound bed by slough and/or eschar, or suspected deep tissue injury.)',
            cls: 'oasis_pink',
            itemId: 'stg_prb_pre_ulcer',
            width: "95%",
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1324_stg_prblm_ulcer',
                    boxLabel: '1 - Stage I ',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1324_stg_prblm_ulcer',
                    boxLabel: '2 - Stage II',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1324_stg_prblm_ulcer',
                    boxLabel: '3 - Stage III',
                    inputValue: '03'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1324_stg_prblm_ulcer',
                    boxLabel: '4 - Stage IV',
                    inputValue: '04'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1324_stg_prblm_ulcer',
                    boxLabel: 'NA - Patient has no pressure ulcers or no stageable pressure ulcers',
                    inputValue: 'NA'
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        var m1322Pressure = main.down('radiofield[name=m1322_nbr_prsulc_stg1]').getGroupValue();
        var m1324ulser = main.down('radiofield[name=m1324_stg_prblm_ulcer]').getGroupValue();
        var m1308stg2 = main.down("[name=m1308_nbr_prsulc_stg2]");
        var m1308stg3 = main.down("[name=m1308_nbr_prsulc_stg3]");
        var m1308stg4 = main.down("[name=m1308_nbr_prsulc_stg4]");
        var m1308nstg = main.down("[name=m1308_nstg_cvrg]");

        if(m1322Pressure == null){
            errs.push(['M1322', "Select the Number of Stage I Pressure Ulcers."]);
        }


        if(m1324ulser == null){
            errs.push(["M1324", "Do not leave stage of Most Problematic Unhealed Pressure Ulcer empty."]);
        }else if (m1322Pressure == "00" && this.fieldIsZeroOrNull(m1308stg2) && this.fieldIsZeroOrNull(m1308stg3) && this.fieldIsZeroOrNull(m1308stg4) && m1324ulser != "NA"){
            errs.push(["M1324",  "Current Number of Unhealed (non epithelialized) Pressure Ulcers stage 2, stage 3, stage4 and Current Number of Stage I Pressure Ulcers stage is '0', then Stage of Most Problematic Unhealed (Observable) Pressure Ulcer is must be equal to NA"])
        }
        else if (m1324ulser == "01"){
            if (m1322Pressure == "00"){
                errs.push(["M1322",  "Stage of Most Problematic Unhealed (Observable) Pressure Ulcer is stage 1 then Current Number of Stage I Pressure Ulcers must be greater than 0"])
            }
        }else if(m1324ulser == "02"){
            if(this.fieldIsZeroOrNull(m1308stg2)){
                errs.push(["M1308",  "Stage of Most Problematic Unhealed (Observable) Pressure Ulcer is stage 2 then Current Number of unhealed Pressure Ulcers  stage 2 must be greater than 0"])
            }
        }else if(m1324ulser == "03"){
            if (this.fieldIsZeroOrNull(m1308stg3)){
                errs.push(["M1308",  "Stage of Most Problematic Unhealed (Observable) Pressure Ulcer is stage 3 then Current Number of unhealed Pressure Ulcers  stage 3 must be greater than 0"])
            }
        }else if(m1324ulser == "04"){
            if (this.fieldIsZeroOrNull(m1308stg4)){
                errs.push(["M1308",  "Stage of Most Problematic Unhealed (Observable) Pressure Ulcer is stage 4 then Current Number of unhealed Pressure Ulcers  stage 4 must be greater than 0"])
            }
        }

        return errs;
    },
    fieldIsZeroOrNull: function(field){
        return (field.value == null || field.value == 0);
    },
})
