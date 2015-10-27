/**
 * Created by msuser1 on 25/12/14.
 */

Ext.define('Ext.panel.PlanOfCareM2250C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.planOfCareM2250C1',
    border: 0,
    items: [
        {
            xtype: "label",
            html: "(M2250) Plan of Care Synopsis: (Check only <u>one</u> box in each row.)  Does the physician-ordered plan of care include the following:",
            cls: 'oasis_blue',
            cls: 'oasis_blue',
            itemId: 'poc_synopsis',
            margin: "10 5"
        },
        {
            xtype: "panel",
            border: false,
            margin: '10 5 5 30',
            layout: {
                type: 'table',
                tableAttrs: {
                    border:1,
                    cls: 'oasis_blue'
                },
                columns: 5
            },
            defaults:{
                bodyStyle: 'padding:2px;background-color:#CCE6FF;'

            },
            items: [
                {
                    html: "Plan / Intervention",
                    width: 400,
                    style: "text-align:center;font-weight:bold;",
                    border:false
                },
                {
                    html: "No",
                    width: 60,
                    style: "text-align:center;font-weight:bold;",
                    border: false
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
                    width: 440,
                    colspan: "2",
                    padding: '0 0 0 5px',
                    border:false

                },
                {
                    html: "<b>a.</b> Patient-specific parameters for notifying physician of changes in vital signs or other clinical findings",
                    width: 460,
                    height:57,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_ptnt_specf',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_ptnt_specf',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_ptnt_specf',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    width: 60,
                    padding: '0 0 0 10px'
                },
                {
                    html: "Physician has chosen not to establish patient-specific parameters for this patient. Agency will use standardized clinical guidelines accessible for all care providers to reference",
                    width: 400,
                    height:57,
                    border:false
                },
                {
                    html: "<b>b.</b> Diabetic foot care including monitoring for the presence of skin lesions on the lower extremities and patient/caregiver education on proper foot care",
                    width: 460,
                    height:40,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_dbts_ft_care',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_dbts_ft_care',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_dbts_ft_care',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    padding: '0 0 0 10px'
                },
                {
                    html: "Patient is not diabetic or is missing lower legs due to congenital or acquired condition (bilateral amputee).",
                    width: 400,
                    height:40,
                    border:false

                },
                {
                    html: "<b>c.</b> Falls prevention interventions",
                    width: 460,
                    height:23,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_fall_prvnt',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_fall_prvnt',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_fall_prvnt',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    width: 60,
                    padding: '0 0 0 10px'
                },
                {
                    html: "Falls risk assessment indicates patient has no risk for falls.",
                    width: 400,
                    height:23,
                    border:false
                },
                {
                    html: "<b>d.</b> Depression intervention(s) such as medication, referral for other treatment, or a " +
                        "monitoring plan for current treatment and/or  physician notified that patient screened positive for depression",


                    width: 460,
                    height:70,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_dprsn_intrvtn',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_dprsn_intrvtn',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_dprsn_intrvtn',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    width: 60,
                    padding: '0 0 0 10px'
                },
                {
                    html: "Patient has no diagnosis of depression AND depression screening indicates patient has: 1) no symptoms of depression; or 2) "+
                          "has some symptoms of depression but does not meet criteria for further evaluation of depression screening tool used.",
                    width: 400,
                    height:80,
                    border:false
                },
                {
                    html: "<b>e.</b> Intervention(s) to monitor and mitigate pain",
                    width: 460,
                    height:23,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_pain_intrvtn',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_pain_intrvtn',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_pain_intrvtn',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    width: 60,
                    padding: '0 0 0 10px'
                },
                {
                    html: "Pain assessment indicates patient has no pain.",
                    width: 400,
                    height:23,
                    border:false
                },
                {
                    html: "<b>f.</b> Intervention(s) to prevent pressure ulcers",
                    width: 460,
                    height:45,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_prsulc_prvnt',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_prsulc_prvnt',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_prsulc_prvnt',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    padding: '0 0 0 10px'
                },
                {
                    html: "Pressure ulcer risk assessment (clinical or formal) indicates patient is not at risk of developing pressure ulcers.",
                    width: 400,
                    height:40,
                    border:false
                },
                {
                    html: "<b>g.</b> Pressure ulcer treatment based on principles of moist wound healing OR order for treatment based on moist wound healing has been requested from physician",
                    width: 460,
                    height:60,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_prsulc_trtmt',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_prsulc_trtmt',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 20px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2250_plan_smry_prsulc_trtmt',
                    inputValue: "NA",
                    boxLabel: 'NA',
                    padding: '0 0 0 10px'
                },
                {
                    html: "Patient has no pressure ulcers OR has no pressure ulcers for which moist wound healing is indicated.",
                    width: 400,
                    height:60,
                    border:false
                }

            ]

        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m2250PlanSmryPtntSpecf = main.down('radiofield[name=m2250_plan_smry_ptnt_specf]').getGroupValue();
        m2250PlanSmryDbtsFtCare = main.down('radiofield[name=m2250_plan_smry_dbts_ft_care]').getGroupValue();
        m2250PlanSmryFallPrvnt = main.down('radiofield[name=m2250_plan_smry_fall_prvnt]').getGroupValue();
        m2250PlanSmryDprsnIntrvtn = main.down('radiofield[name=m2250_plan_smry_dprsn_intrvtn]').getGroupValue();
        m2250PlanSmryPrsulcPainIntrvtn = main.down('radiofield[name=m2250_plan_smry_pain_intrvtn]').getGroupValue();
        m2250PlanSmryPrsulcPrvnt = main.down('radiofield[name=m2250_plan_smry_prsulc_prvnt]').getGroupValue();
        m2250PlanSmryPrsulcTrtmt = main.down('radiofield[name=m2250_plan_smry_prsulc_trtmt]').getGroupValue();

        if(m2250PlanSmryPtntSpecf == null){
            errs.push(['M2250', "Choose (Yes/No/NA) for Patient-specific parameters in order to notify the physician on changes in vital signs."]);
        }

        if(m2250PlanSmryDbtsFtCare == null){
            errs.push(['M2250', "Diabetic Foot care should be Yes/No/NA."]);
        }

        if(m2250PlanSmryFallPrvnt == null){
            errs.push(['M2250', "Falls prevention Interventions should be Yes/No/NA."]);
        }

        if(m2250PlanSmryDprsnIntrvtn == null){
            errs.push(['M2250', "Depression intervention(s) should be Yes/No/NA."]);
        }

        if(m2250PlanSmryPrsulcPainIntrvtn == null){
            errs.push(['M2250', "Intervention(s) to monitor and mitigate Pain should be Yes/No/NA."]);
        }

        if(m2250PlanSmryPrsulcPrvnt == null){
            errs.push(['M2250', "Intervention(s) to prevent Pressure Ulcers should be Yes/No/NA."]);
        }

        if(m2250PlanSmryPrsulcTrtmt == null){
            errs.push(['M2250', "Pressure Ulcer Treatment should be Yes/No/NA."]);
        }

        return errs;
    }
})
