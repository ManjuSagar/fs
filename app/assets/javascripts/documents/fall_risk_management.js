/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.FallRiskManagement', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.fallRiskManagement',
    items: [
        {
            xtype: "panel",
            border: false,
            margin: '10 5 5 60',
            layout: {
                type: "table",
                tableAttrs: {
                    border: 1
                },
                columns: 2
            },
            items: [
                {
                    height: 20,
                    width: 600,
                    border: false,
                    style: "text-align:center;",
                    colspan: 2,
                    html: "<b>MAHC 10 - FALL RISK ASSESSMENT TOOL</b>"
                },
                {

                    height: 80,
                    width: 600,
                    border: false,
                    style: "text-align:center;",
                    html: "<b>REQUIRED CORE ELEMENTS</br>Assess one point for each core element 'yes'.</br></b> " +
                        "Information may be gathered from medical record, assessment and if " +
                        "applicable, the patient/caregiver. Beyond protocols listed below, scoring " +
                        "should be based on your clinical judgment. "
                },
                {
                    html: "<b>Points</b>",
                    height: 55,
                    width: 100,
                    style: "text-align:center;",
                    border: false
                },
                {
                    html: "<b>Age 65+</b>",
                    margin: 5,
                    height: 30,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    name: "age",
                    style: "align:center;",
                    boxLabel: "1",
                    inputValue: 1
                },
                {
                    html: "<b>Diagnosis (3 or more co-existing)</b></br>Includes only documented medical diagnosis.",
                    margin: 5,
                    height: 40,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    name: "diagnosis",
                    boxLabel: "1",
                    inputValue: 1
                },
                {
                    html: "<b>Prior history of falls within 3 months</br></b>A unintentional change in position " +
                        "resulting in coming to rest on the ground or at a lower level.",
                    margin: 5,
                    height: 40,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    name: "position",
                    boxLabel: "1",
                    inputValue: 1
                },
                {
                    html: "<b>Incontinence</b></br>Inability to make it to the bathroom or commode in timely manner.</br> " +
                        "Includes frequency, urgency, and/or nocturia.",
                    margin: 5,
                    height: 60,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    boxLabel: "1",
                    inputValue: 1,
                    name: "incontinence"
                },
                {
                    html: "<b>Visual impairment</b></br>Includes but not limited to, macular degeneration, diabetic retinopathies, " +
                        "visual field loss,</br> age related changes, decline in visual acuity,accommodation, " +
                        "glare tolerance, depth perception,</br> and night vision or not wearing prescribed glasses " +
                        "or having the correct prescription.",
                    margin: 5,
                    height: 80,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    name: "visual_impairment",
                    boxLabel: "1",
                    inputValue: 1
                },
                {
                    html: "<b>Impaired functional mobility</b></br>May include patients who need help with " +
                        "IADLs or ADLs or have gait or transfer problems, </br>arthritis, pain, fear of falling, " +
                        "foot problems, impaired sensation, impaired coordination or</br> improper use of " +
                        "assistive devices.",
                    margin: 5,
                    height: 80,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    boxLabel: "1",
                    inputValue: 1,
                    name: "impaired_functional_mobility",
                },
                {
                    html: "<b>Environmental hazards</b></br>May include but not limited to, poor illumination, " +
                        "equipment tubing, inappropriate footwear,</br> pets, hard to reach items, floor " +
                        "surfaces that are uneven or cluttered, or outdoor entry and exits.",
                    margin: 5,
                    height: 60,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    name: "environmental_hazards",
                    boxLabel: "1",
                    inputValue: 1
                },
                {
                    html: "<b>Poly Pharmacy (4 or more prescriptions - any type)</b></br>All PRESCRIPTIONS " +
                        "including prescriptions for OTC meds. Drugs highlyassociated with fall risk</br> " +
                        "include but not limited to, sedatives, anti-depressants, tranquilizers, " +
                        "narcotics, antihypertensives,</br> cardiac meds,corticosteriods, anti-anxiety drugs, " +
                        "anticholinergic drugs, and hypoglycemic</br> drugs.",
                    margin: 5,
                    height: 100,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    name: "poly_pharmacy",
                    boxLabel: "1",
                    inputValue: 1
                },
                {
                    html: "<b>Pain affecting level of function</b></br>Pain often affects an " +
                        "individual's desire or ability to move or pain can be a factor in depression or </br> " +
                        "compliance with safety recommendations.",
                    margin: 5,
                    height: 60,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    boxLabel: "1",
                    inputValue: 1,
                    name: "pain_affecting_level",
                },
                {
                    html: "<b>Cognitive impairment</b></br>Could include patients with dementia, Alzheimer's " +
                        "or stroke patients or patients who are confused,</br> use poor judgment, have decreased " +
                        "comprehension, impulsivity, memory deficits. Consider</br> patient's ability to " +
                        "adhere to the plan of care.",
                    margin: 5,
                    height: 80,
                    border: false
                },
                {
                    xtype: "checkboxfield",
                    margin: '0 0 0 55',
                    name: "cognitive_impairment",
                    boxLabel: "1",
                    inputValue: 1
                },
                {
                    html: "<b>A score of 4 or more is considered at risk for falling <span style=padding-left:200px>TOTAL</b>",
                    margin: 5,
                    height: 20,
                    border: false
                },
                {
                    xtype: "numberfield",
                    margin: 5,
                    readOnly: true,
                    itemId: "fall_risk_assessment_total",
                    name: "fall_risk_assessment_total"
                },
                {
                    html: "MAHC 10 reprinted with permission from <b> Missouri Alliance for HOME CARE</b>",
                    margin: 5,
                    height: 20,
                    colspan: 2,
                    border: false
                }
            ]
        }
    ],
    afterRender: function(){
        this.callParent();
        var points = this.down("#fall_risk_assessment_total");
        var checkboxes = points.up("panel").query("checkboxfield");
        Ext.each(checkboxes, function(field){
            field.on("change", function(ele){
                if (ele.checked)
                    points.setValue(points.value + ele.inputValue);
                else
                    points.setValue(points.value - ele.inputValue);
            }, this);
        }, this);
    }
})
