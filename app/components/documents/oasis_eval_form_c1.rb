class Documents::OasisEvalFormC1 < Documents::AbstractOasisEvalForm

  def get_form_panels
    [
        { xtype: "generalPatientInformationM0010M0140"},
        { xtype: "paymentSourceM0150" },
        { xtype: "clinicalRecordItemsM0080M0110" },
        { xtype: "inPatientDischargeM1000M1005C1"  },
        { xtype: "diagnosisAndProcedureCodesM1010M1012C1" },
        { xtype: "diagnosisAndProcedureCodesM1011"},
        { xtype: "diagnosesRegimenChangeM1016M1018" },
        { xtype: "diagnosesRegimenChangeM1017M1018" },
        { xtype: "patientHistoryAndDiagnosis", poc_page: true },
        { xtype: "diagnosissymptompayment" },
        { xtype: "diagnosissymptompaymenticd10"},
        { xtype: "primaryPaymentM1020M1024" },
        { xtype: "primaryPaymentM1022M1024" },
        { xtype: "primaryPaymentM1021M1025" },
        { xtype: "primaryPaymentM1023M1025" },
        { xtype: "statusRiskVaccineM1030M1036C1" },
        { xtype: "livingarrangmentm1100" },
        { xtype: "livingArrangementsPoc", poc_page: true },
        { xtype: "sensoryStatusM1200M1230" },
        { xtype: "sensoryStatusPoc", poc_page: true },
        { xtype: "painCarePlanM1240M1242" },
        { xtype: "carePlanPoc", poc_page: true },
        { xtype: "integumentaryStatusM1300M1306C1" },
        { xtype: "integumentaryPocComponent", poc_page: true },
        { xtype: "integumentryStatus2M1308SocRocC1", itemId: "integumentarystatus2_m1308"},
        { xtype: "pressureUlserM1310M1324C1", itemId: "pressure_ulcer_m1310_m1324" },
        :wound_care_plan_poc.component({class_name: "Documents::Oasis::WoundCarePlanPoc",
                                        poc_page: true, header: false, border: false,
                                        auto_scroll: true, name: "panel_21", record_id: config[:record_id]}),
        { xtype: "stasisUlcerWoundM1330M1350C1", layout: "hbox" },
        { xtype: "respiratoryCardacM1400M1410" },
        :cardiopulmonary_poc.component({class_name: "Documents::Oasis::Cardiopulmonary",
                                        poc_page: true, header: false, border: false,
                                        auto_scroll: true, name: "panel_24" }),
        { xtype: "eliminationM1600M1630", layout: "hbox" },
        :elimination_poc.component({class_name: "Documents::Oasis::EliminationPoc",
                                    poc_page: true, header: false, border: false,
                                    auto_scroll: true, name: "panel_26" }),
        { xtype: "neuroEmotionalBehaviouralM17001730" },
        { xtype: "neuroEmotionalBehaviouralM1700M1730Poc", poc_page: true },
        { xtype: "neuroEmotionalBehavioural2M1740M1750" },
        { xtype: "neuroEmotionalBehaviouralM1740M1750Poc", poc_page: true },
        { xtype: "adlIadls1M1800M1830C1" },
        { xtype: "adlIadls2M1840M1870", itemId: "adl_iadls2_m1840_m1870" },
        { xtype: "adlIadls3M1880M1890", itemId: "adl_iadls3_m1880_m1890" },
        { xtype: "adlIadls4M1900M1910C1", itemId: "adl_iadls4_m1900_m1910" },
        :adl4_poc.component({class_name: "Documents::Oasis::AdliadLs4PocDocument",
                             poc_page: true, header: false, border: false,
                             auto_scroll: true, name: "panel_35" }),
        { xtype: "medicationsM2000M2030" },
        :medication_poc.component({class_name: "Documents::Oasis::MedicationPocDocument",
                                  poc_page: true, header: false, border: false,

                                   auto_scroll: true, name: "panel_37" }),
        { xtype: "medications2M2040C1"},
        { xtype: "typesSourcesOfAssistanceM2102C1"},
        { xtype: "typesSourcesOfAssistance", poc_page: true },
        { xtype: "adliadlAssistanceM2110", itemId: "adl_iadl_assistance_m2110"},
        { xtype: "therapyNeedm2200"},
        { xtype: "planOfCareM2250C1"},
        { xtype: "poc", poc_page: true}
    ]
  end

  def get_combo_box_values
    [["General Patient Information (M0010 - M0140)"],
     ["Payment Source (M0150)"],
     ["Clinical Record Items (M0080 - M0110)"],
     ["In Patient Discharge (M1000 - M1005)"],
     ["Diagnosis Codes (M1010)"],
     ["Diagnosis Codes (M1011)"],
     ["Diagnoses Regimen Change (M1016 - M1018)"],
     ["Diagnoses Regimen change (M1017 - M1018)"],
     ["Patient History and Diagnosis Clinical", "poc_page"],
     ["Diagnoses Symptom Payment"],
     ["Diagnoses Symptom Payment ICD10"],
     ["Primary Other Payment 1 (M1020 - M1024)"],
     ["Primary Other Payment 2 (M1022 - M1024)"],
     ["Primary Other Payment 1 (M1021 - M1025)"],
     ["Primary Other Payment 2 (M1023 - M1025)"],
     ["Status Risk Vaccine (M1030 - M1036)"],
     ["Living Arrangements (M1100)"],
     ["Living Arrangements Clinical", "poc_page"],
     ["Sensory Status (M1200 - M1230)"],
     ["Sensory Status Clinical", "poc_page"],
     ["Pain Care Plan (M1240 - M1242)"],
     ["Care Plan Clinical", "poc_page"],
     ["Integumentary Status (M1300 - M1306)"],
     ["Integumentary Status Clinical", "poc_page"],
     ["Integumentary Status 2 (M1308)"],
     ["Pressure Ulser (M1320 - M1324)"],
     ["Wound Care Plan Clinical", "poc_page"],
     ["Stasis Ulcer/Wound (M1330 - M1350)"],
     ["Respiratory Cardiac (M1400 - M1410)"],
     ["Respiratory Cardiac Clinical", "poc_page"],
     ["Elimination (M1600 - M1630)"],
     ["Elimination Clinical", "poc_page"],
     ["Neuro/Emotional/Behavioural (M1700 - M1730)"],
     ["Neuro/Emotional/Behavioural  Clinical", "poc_page"],
     ["Neuro/Emotional/Behavioural 2 (M1740 - M1750)"],
     ["Neuro/Emotional/Behavioural 2  Clinical", "poc_page"],
     ["ADLs/IADLs (M1800 - M1830)"],
     ["ADLs/IADLs 2 (M1840 - M1870)"],
     ["ADLs/IADLs 3 (M1880 - M1890)"],
     ["ADLs/IADLs 4 (M1900 - M1910)"],
     ["ADLs/IADLs 4 Clinical", "poc_page"],
     ["Medications (M2000 - M2030)"],
     ["Medications Clinical", "poc_page"],
     ["Medications 2 (M2040)"],
     ["Types/Sources of Assistance (M2102)"],
     ["Types/Sources of Assistance Clinical", "poc_page"],
     ["ADL/IADL Assistance (M2110)" ],
     ["Therapy Need (M2200)"],
     ["Plan Of Care (M2250)"],
     ["Plan Of Care Clinical", "poc_page"]
    ]

  end

  def get_combo_box_values_icd10
    [["General Patient Information (M0010 - M0140)"],
     ["Payment Source (M0150)"],
     ["Clinical Record Items (M0080 - M0110)"],
     ["In Patient Discharge (M1000 - M1005)"],
     ["Diagnosis Codes (M1010)", 'icd9'],
     ["Diagnosis Codes (M1011)"],
     ["Diagnoses Regimen Change (M1016 - M1018)", 'icd9'],
     ["Diagnoses Regimen change (M1017 - M1018)"],
     ["Patient History and Diagnosis Clinical", "poc_page"],
     ["Diagnoses Symptom Payment", 'icd9'],
     ["Diagnoses Symptom Payment ICD10"],
     ["Primary Other Payment 1 (M1020 - M1024)", 'icd9'],
     ["Primary Other Payment 2 (M1022 - M1024)", 'icd9'],
     ["Primary Other Payment 1 (M1021 - M1025)"],
     ["Primary Other Payment 2 (M1023 - M1025)"],
     ["Status Risk Vaccine (M1030 - M1036)"],
     ["Living Arrangements (M1100)"],
     ["Living Arrangements Clinical", "poc_page"],
     ["Sensory Status (M1200 - M1230)"],
     ["Sensory Status Clinical", "poc_page"],
     ["Pain Care Plan (M1240 - M1242)"],
     ["Care Plan Clinical", "poc_page"],
     ["Integumentary Status (M1300 - M1306)"],
     ["Integumentary Status Clinical", "poc_page"],
     ["Integumentary Status 2 (M1308)"],
     ["Pressure Ulser (M1320 - M1324)"],
     ["Wound Care Plan Clinical", "poc_page"],
     ["Stasis Ulcer/Wound (M1330 - M1350)"],
     ["Respiratory Cardiac (M1400 - M1410)"],
     ["Respiratory Cardiac Clinical", "poc_page"],
     ["Elimination (M1600 - M1630)"],
     ["Elimination Clinical", "poc_page"],
     ["Neuro/Emotional/Behavioural (M1700 - M1730)"],
     ["Neuro/Emotional/Behavioural  Clinical", "poc_page"],
     ["Neuro/Emotional/Behavioural 2 (M1740 - M1750)"],
     ["Neuro/Emotional/Behavioural 2  Clinical", "poc_page"],
     ["ADLs/IADLs (M1800 - M1830)"],
     ["ADLs/IADLs 2 (M1840 - M1870)"],
     ["ADLs/IADLs 3 (M1880 - M1890)"],
     ["ADLs/IADLs 4 (M1900 - M1910)"],
     ["ADLs/IADLs 4 Clinical", "poc_page"],
     ["Medications (M2000 - M2030)"],
     ["Medications Clinical", "poc_page"],
     ["Medications 2 (M2040)"],
     ["Types/Sources of Assistance (M2102)"],
     ["Types/Sources of Assistance Clinical", "poc_page"],
     ["ADL/IADL Assistance (M2110)" ],
     ["Therapy Need (M2200)"],
     ["Plan Of Care (M2250)"],
     ["Plan Of Care Clinical", "poc_page"]
    ]

  end

  def get_combo_box_values_icd9
    [["General Patient Information (M0010 - M0140)"],
     ["Payment Source (M0150)"],
     ["Clinical Record Items (M0080 - M0110)"],
     ["In Patient Discharge (M1000 - M1005)"],
     ["Diagnosis Codes (M1010)"],
     ["Diagnosis Codes (M1011)", 'icd10'],
     ["Diagnoses Regimen Change (M1016 - M1018)",],
     ["Diagnoses Regimen change (M1017 - M1018)", 'icd10'],
     ["Patient History and Diagnosis Clinical", "poc_page"],
     ["Diagnoses Symptom Payment"],
     ["Diagnoses Symptom Payment ICD10", 'icd10'],
     ["Primary Other Payment 1 (M1020 - M1024)"],
     ["Primary Other Payment 2 (M1022 - M1024)"],
     ["Primary Other Payment 1 (M1021 - M1025)", 'icd10'],
     ["Primary Other Payment 2 (M1023 - M1025)", 'icd10'],
     ["Status Risk Vaccine (M1030 - M1036)"],
     ["Living Arrangements (M1100)"],
     ["Living Arrangements Clinical", "poc_page"],
     ["Sensory Status (M1200 - M1230)"],
     ["Sensory Status Clinical", "poc_page"],
     ["Pain Care Plan (M1240 - M1242)"],
     ["Care Plan Clinical", "poc_page"],
     ["Integumentary Status (M1300 - M1306)"],
     ["Integumentary Status Clinical", "poc_page"],
     ["Integumentary Status 2 (M1308)"],
     ["Pressure Ulser (M1320 - M1324)"],
     ["Wound Care Plan Clinical", "poc_page"],
     ["Stasis Ulcer/Wound (M1330 - M1350)"],
     ["Respiratory Cardiac (M1400 - M1410)"],
     ["Respiratory Cardiac Clinical", "poc_page"],
     ["Elimination (M1600 - M1630)"],
     ["Elimination Clinical", "poc_page"],
     ["Neuro/Emotional/Behavioural (M1700 - M1730)"],
     ["Neuro/Emotional/Behavioural  Clinical", "poc_page"],
     ["Neuro/Emotional/Behavioural 2 (M1740 - M1750)"],
     ["Neuro/Emotional/Behavioural 2  Clinical", "poc_page"],
     ["ADLs/IADLs (M1800 - M1830)"],
     ["ADLs/IADLs 2 (M1840 - M1870)"],
     ["ADLs/IADLs 3 (M1880 - M1890)"],
     ["ADLs/IADLs 4 (M1900 - M1910)"],
     ["ADLs/IADLs 4 Clinical", "poc_page"],
     ["Medications (M2000 - M2030)"],
     ["Medications Clinical", "poc_page"],
     ["Medications 2 (M2040)"],
     ["Types/Sources of Assistance (M2102)"],
     ["Types/Sources of Assistance Clinical", "poc_page"],
     ["ADL/IADL Assistance (M2110)" ],
     ["Therapy Need (M2200)"],
     ["Plan Of Care (M2250)"],
     ["Plan Of Care Clinical", "poc_page"]
    ]
  end

end