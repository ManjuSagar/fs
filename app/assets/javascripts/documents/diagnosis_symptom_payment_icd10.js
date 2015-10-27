/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.diagnosissymptompaymenticd10', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.diagnosissymptompaymenticd10',
    border: false,
    margin: 5,
    items: [

        {
            xtype: "displayfield",
            margin: 5,
            value: "<b>(M1021/1023/1025) Diagnoses, Symptom Control and Optional Diagnoses:</b> List each diagnosis for which the <br/>"+
            "patient is receiving home care in Column 1, and enter its ICD-10-CM code at the level of highest specificity in Column<br/>"+
            "2 (diagnosis codes only - no surgical or procedure codes allowed). Diagnoses are listed in the order that best reflects<br/>"+
            "the seriousness of each condition and supports the disciplines and services provided. Rate the degree of symptom</br>" +
            "control for each condition in Column 2. ICD-10-CM sequencing requirements must be followed if multiple coding is </br>"+
            "indicated for any diagnoses. If a Z-code is reported in Column 2 in place of a diagnosis that is no longer active (a </br>"+
            "resolved condition), then optional item M1025 (Optional Diagnoses - Columns 3 and 4) may be completed. Diagnoses </br>"+
            "reported in M1025 will not impact payment.<br/><br/>"+

            "<b>Code each row according to the following directions for each column.</b> Review the OASIS Guidance Manual for </br>"+
            "additional directions on how to complete M1021, M1023 and M1025. <br /><br />"+
            "Column 1:&nbsp;&nbsp;&nbsp;&nbsp;Enter the description of the diagnosis. Sequencing of diagnoses should reflect the seriousness of <br/>"+
            "<div style='margin-left: 75px'>each condition and support the disciplines and services provided.</div><br/>"+

            "Column 2:&nbsp;&nbsp;&nbsp;&nbsp;Enter the ICD-10-CM code for the condition described in Column 1 - no surgical or procedure codes<br>"+
            "<div style='margin-left: 75px'>allowed. Codes must be entered at the level of highest specificity and ICD-10-CM coding rules and</div>"+
            "<div style='margin-left: 75px'>sequencing requirements must be followed. Note that external cause codes (ICD-10-CM codes beginning</div>"+
            "<div style='margin-left: 75px'>with V, W, X, or Y) may not be reported in M1021 (Primary Diagnosis) but may be reported in M1023</div>"+
            "<div style='margin-left: 75px'>(Secondary Diagnoses). Also note that when a Z-code is reported in Column 2, the code for the</div>"+
            "<div style='margin-left: 75px'>underlying condition can often be entered in Column 2, as long as it is an active on-going condition</div>"+
            "<div style='margin-left: 75px'>impacting home health care.</div><br />"+
            "<div style='margin-left: 75px'>Rate the degree of symptom control for the condition listed in Column 1. Choose one value that </div>"+
            "<div style='margin-left: 75px'>represents the degree of symptom control appropriate for each diagnosis using the following scale:</div>"+
            "<div style='margin-left: 100px'>0 - Asymptomatic, no treatment needed at this time</div>"+
            "<div style='margin-left: 100px'>1 - Symptoms well controlled with current therapy</div>"+
            "<div style='margin-left: 100px'>2 - Symptoms controlled with difficulty, affecting daily functioning: patient needs ongoing monitoring</div>"+
            "<div style='margin-left: 100px'>3 - Symptoms poorly controlled; patient needs frequent adjustment in treatment and dose monitoring</div>"+
            "<div style='margin-left: 100px'>4 - Symptoms poorly controlled; history of re-hospitalizations</div><br/>"+
            "<div style='margin-left: 75px'>Note that the rating for symptom control in Column 2 should not be used to determine the sequencing</div>"+
            "<div style='margin-left: 75px'>of the diagnoses listed in Column 1. These are separate items and sequencing may not coincide.</div><br/><br/><br/>"+
            "Column 3:&nbsp;&nbsp;&nbsp;&nbsp;(OPTIONAL) There is no requirement that HHAs enter a diagnosis code in M1025 (Columns 3 and 4).<br/>"+
            "<div style='margin-left: 75px'>Diagnoses reported in M1025 will not impact payment.</div><br/>"+
            "<div style='margin-left: 75px'>Agencies may choose to report an underlying condition in M1025 (Columns 3 and 4) when:</div>"+
            "<div style='margin-left: 75px'><ul><li>&nbsp;&nbsp;a Z-code is reported in Column 2 AND</li>"+
            "<li>&nbsp;&nbsp;the underlying condition for the Z-code in Column 2 is a resolved condition . An example of a<br/>"+
            "&nbsp;&nbsp;resolved condition is uterine cancer that is no longer being treated following a hysterectomy.</li>"+
            "</ul></div>"+
            "Column 4:&nbsp;&nbsp;&nbsp;&nbsp;(OPTIONAL) If a Z-code is reported in M1021/M1023 (Column 2) and the agency chooses to report a <br/>"+
            "<div style='margin-left: 75px'>resolved underlying condition that requires multiple diagnosis codes under ICD-10-CM coding </div>"+
            "<div style='margin-left: 75px'>guidelines, enter the diagnosis descriptions and the ICD-10-CM codes in the same row in Columns 3</div>"+
            "<div style='margin-left: 75px'>and 4. For example, if the resolved condition is a manifestation code, record the diagnosis description</div>"+
            "<div style='margin-left: 75px'>and ICD-10-CM code for the underlying condition in Column 3 of that row and the diagnosis description</div>"+
            "<div style='margin-left: 75px'>and ICD-10-CM code for the manifestation in Column 4 of that row. Otherwise, leave Column 4 blank</div>"+
            "<div style='margin-left: 75px'>in that row.</div>"
        }

    ]
})
