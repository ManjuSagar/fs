/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.diagnosissymptompayment', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.diagnosissymptompayment',
    border: false,
    margin: 5,
    items: [

        {
            xtype: "displayfield",
            margin: 5,
            value: "<b>(M1020/1022/1024)Diagnoses, Symptom Control, and Payment Diagnoses:</b> List each diagnosis for which the patient <br/>" +
                "is receiving home care (Column 1) and enter its ICD-9-CM code at the level of highest specificity (no surgical/<br/>" +
                "procedure codes)  (Column 2). Diagnoses are listed in the order that best reflect the seriousness of each condition  </br>"+
                "and support the disciplines and services provided. Rate the degree of symptom control for each condition (condition2). </br>" +
                "Choose one value that represents the degree of symptom control appropriate<br/>"+
                "for each diagnosis: V codes (for M1020 or M1022) or E codes (for M1022 only) may be used. ICD-9-CM sequencing<br/>"+
                "requirements must be followed if multiple coding is indicated for any diagnoses. If a V code is reported in place<br/>"+
                "of a case mix diagnosis, then optional item M1024 Payment Diagnoses (Columns 3 and 4) may be completed. A case mix<br/>"+
                "diagnosis is a diagnosis that determines the Medicare PPS case mix group. Do not assign symptom control ratings for<br/>"+
                "V or E codes.<br/><br />"+
                "<b>Code each row according to the following directions for each column:</b><br /><br />"+
                "Column 1: Enter the description of the diagnosis.<br/><br /><br />"+
                "Column 2: Enter the ICD-9-CM code for the diagnosis described in Column 1; Rate the degree of the symptom control for<br/>"+
                  "<div style='margin-left: 10px'>the condition listed in Column 1 using the following scale:</div>"+
                "<div style='margin-left: 10px'>&nbsp;&nbsp;0 - Asymptomatic, no treatment needed at this time</div>"+
                "<div style='margin-left: 10px'>&nbsp;&nbsp;1 - Symptoms well controlled with current therapy</div>"+
                "<div style='margin-left: 10px'>&nbsp;&nbsp;2 - Symptoms controlled with difficulty, affecting daily functioning: patient needs ongoing monitoring</div>"+
                "<div style='margin-left: 10px'>&nbsp;&nbsp;3 - Symptoms poorly controlled; patient needs frequent adjustment in treatment and dose monitoring</div>"+
                "<div style='margin-left: 10px'>&nbsp;&nbsp;4 - Symptoms poorly controlled; history of re-hospitalizations</div><br/><br/>"+
                "Note that in Column 2 the severity rating for symptom control of each diagnosis should not be used to determine the sequencing<br/>"+
                "of the diagnoses listed in Column 1. These are separate items and sequencing may not coincide. Sequencing of diagnoses should<br/>"+
                "reflect the seriousness of each condition and support the disciplines and services provided.<br/><br/>"+

                "Column 3: (OPTIONAL) If a V code is assigned to any row in Column 2, in place of a case mix diagnosis, it may be necessary<br/>"+
                  "<div style='margin-left: 10px'>to complete optional item M1024 Payment Diagnoses (Columns 3 and 4). See OASIS manual and Coding Guidance.</div><br/>"+
                "Column 4: (OPTIONAL) If a V code in Column 2 is reported in place of a case mix diagnosis that requires multiple diagnosis<br/>"+
                  "<div style='margin-left: 10px'>codes under ICD-9-CM coding guidelines, enter the diagnosis descriptions and the -ICD-9-CM codes in the same row in</div>"+
                  "<div style='margin-left: 10px'>Columns 3 and 4. For example, if the case mix diagnosis is a manifestation code, record the diagnosis description and ICD-9-CM</div>"+
                  "<div style='margin-left: 10px'>code for the underlying condition in Column 3 of that row and the diagnosis description and ICD-9-CM code for the</div>"+
                  "  <div style='margin-left: 10px'>manifestation in Column 4 of that row. Otherwise, leave Column 4 blank in that row.</div>"
        }

    ]
})
