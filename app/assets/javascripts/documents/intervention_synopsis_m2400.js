/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.InterventionSynopsisM2400', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.interventionSynopsisM2400',
    border: false,
    items: [
        {xtype: 'label',
            margin: "10 5",
            html: "(M2400) Intervention Synopsis: (Check only <u>one</u> box in each row.) At the time of or at any time since the previous OASIS assessment, were the"+
                "following interventions BOTH included in the physician-ordered plan of care AND implemented?",
            cls: 'oasis_blue'
        },
        {
            xtype: 'panel',
            border: false,
            margin: '10 5 5 60',
            layout: {
                type: 'table',
                tableAttrs: {
                    border:1,
                    cls: 'oasis_blue'
                },
                columns: 5
            },
            defaults:{
                bodyStyle: 'padding: 5px;background-color:#CCE6FF;'
            },
            items: [
                {
                    html: "Plan / Intervention",
                    width: 300,
                    style: "text-align:center;font-weight:bold;",
                    border:false
                },
                {
                    html: "No",
                    width: 60,
                    style: "text-align:center;font-weight:bold;",
                    border:false
                },
                {
                    html: "Yes",
                    width: 60,
                    style: "text-align:center;font-weight:bold;",
                    border:false
                },
                {
                    xtype: "label",
                    text: "Not Applicable",
                    width: 240,
                    colspan: "2",
                    padding: '0 0 0 5px'

                },
                {
                    html: "<b>a.</b> Diabetic foot care including monitoring for the presence of skin lesions on the lower extremities and patient/caregiver education on proper foot care",
                    width: 300,
                    height:65,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_dbts_ft',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_dbts_ft',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_dbts_ft',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    width: 60,
                    padding: '0 0 0 10px'
                },
                {
                    html: "Patient is not diabetic or is missing lower legs dut to congenital or acquired condition (bilateral amputee)",
                    width: 200,
                    height:60,
                    border:false
                },
                {
                    html: "<b>b.</b> Falls prevention interventions",
                    width: 300,
                    height:70,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_fall_prvnt',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_fall_prvnt',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_fall_prvnt',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    padding: '0 0 0 10px'
                },
                {
                    html: "Formal multi-factor Fall Risk Assessment indicates the patient was not at risk for falls since the last OASIS assessment",
                    width: 200,
                    height:80,
                    border:false
                },
                {
                    html: "<b>c.</b> Depression intervention(s) such as medication, referral for other treatment, or a monitoring plan for current treatment ",
                    width: 300,
                    height:85,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_dprsn',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_dprsn',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_dprsn',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    width: 60,
                    padding: '0 0 0 10px'
                },
                {
                    html: "Formal assessment indicates patient did not meet criteria for depression AND patient did not have diagnosis of depression since the last OASIS assessment",
                    width: 200,
                    height:95,
                    border:false
                },
                {
                    html: "<b>d.</b> Intervention(s) to monitor and mitigate pain",
                    width: 300,
                    height:60,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_pain_mntr',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_pain_mntr',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_pain_mntr',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    width: 60,
                    padding: '0 0 0 10px'
                },
                {
                    html: "Formal assessment did not indicate pain since the last OASIS assessment",
                    width: 200,
                    height:60,
                    border:false
                },
                {
                    html: "<b>e.</b> Intervention(s) to prevent pressure ulcers",
                    width: 300,
                    height:70,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_prsulc_prvn',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_prsulc_prvn',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_prsulc_prvn',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    width: 60,
                    padding: '0 0 0 10px'
                },
                {
                    html: "Formal assessment indicates the patient was not at risk of pressure ulcers since the last OASIS assessment",
                    width: 200,
                    height:80,
                    border:false
                },
                {
                    html: "<b>f.</b> Pressure ulcer treatment based on principles of moist wound healing",
                    width: 300,
                    height:100,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_prsulc_wet',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_prsulc_wet',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2400_intrvtn_smry_prsulc_wet',
                    inputValue: "NA",
                    boxLabel: 'NA',

                    padding: '0 0 0 10px'
                },
                {
                    html: "Dressings that support the principles of moist wound healing not indicated for this patient`s pressure ulcers"+
                        " <u>OR</u> patient has no pressure ulcers with need for moist wound healing",
                    width: 200,
                    height:150,
                    border:false
                }
            ]
        }

    ],
    onValidate: function(main){
        var errs = new Array();
        m2400IntrvtnSmryDbtsFt = main.down('radiofield[name=m2400_intrvtn_smry_dbts_ft]').getGroupValue();
        m2400IntrvtnSmryFallPrvnt = main.down('radiofield[name=m2400_intrvtn_smry_fall_prvnt]').getGroupValue();
        m2400IntrvtnSmryDprsn = main.down('radiofield[name=m2400_intrvtn_smry_dprsn]').getGroupValue();
        m2400IntrvtnSmryPainMntr = main.down('radiofield[name=m2400_intrvtn_smry_pain_mntr]').getGroupValue();
        m2400IntrvtnSmryPrsulcPrvn = main.down('radiofield[name=m2400_intrvtn_smry_prsulc_prvn]').getGroupValue();
        m2400IntrvtnSmryPrsulcWet = main.down('radiofield[name=m2400_intrvtn_smry_prsulc_wet]').getGroupValue();

        if(m2400IntrvtnSmryDbtsFt == null){
            errs.push(['M2400', "Select one option whether diabetic foot care education provided to patient/caregiver."]);
        }

        if(m2400IntrvtnSmryFallPrvnt == null){
            errs.push(['M2400', "Select one option for falls prevention interventions."]);
        }

        if(m2400IntrvtnSmryDprsn == null){
            errs.push(['M2400', "Select one option for depression intervention(s) for current treatment."]);
        }

        if(m2400IntrvtnSmryPainMntr == null){
            errs.push(['M2400', "Select one option for intervention(s) to monitor and mitigate pain."]);
        }

        if(m2400IntrvtnSmryPrsulcPrvn == null){
            errs.push(['M2400', "Select one option for interventions(s) to prevent pressure ulcers."]);
        }

        if(m2400IntrvtnSmryPrsulcWet == null){
            errs.push(['M2400', "Select one option for pressure ulcer treatment."]);
        }

        return errs;
    }
})
