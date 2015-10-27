class Documents::OasisResumptionOfCareForm < Documents::AbstractOasisResumptionOfCareForm

  def get_form_panels
    [
        { xtype: "generalPatientInformationM0010M0140"},
        { xtype: "paymentSourceM0150" },
        { xtype: "clinicalRecordItemsM0080M0110" },
        { xtype: "inPatientDischargeM1000M1005"  },
        { xtype: "diagnosisAndProcedureCodesM1010M1012" },
        { xtype: "diagnosesRegimenChangeM1016M1018" },
        { xtype: "diagnosissymptompayment" },
        { xtype: "primaryPaymentM1020M1024" },
        { xtype: "primaryPaymentM1022M1024" },
        { xtype: "statusRiskVaccineM1030M1036" },
        { xtype: "livingarrangmentm1100" },
        { xtype: "sensoryStatusM1200M1230" },
        { xtype: "painCarePlanM1240M1242" },
        { xtype: "integumentaryStatusM1300M1306" },
        { xtype: "integumentryStatus2M1308SocRoc", itemId: "integumentarystatus2_m1308"},
        { xtype: "pressureUlserM1310M1324", itemId: "pressure_ulcer_m1310_m1324" },
        { xtype: "stasisUlcerWoundM1330M1350", layout: "hbox" },
        { xtype: "respiratoryCardacM1400M1410" },
        { xtype: "eliminationM1600M1630", layout: "hbox" },
        { xtype: "neuroEmotionalBehaviouralM17001730" },
        { xtype: "neuroEmotionalBehavioural2M1740M1750" },
        { xtype: "adlIadls1M1800M1830" },
        { xtype: "adlIadls2M1840M1870", itemId: "adl_iadls2_m1840_m1870" },
        { xtype: "adlIadls3M1880M1890", itemId: "adl_iadls3_m1880_m1890" },
        { xtype: "adlIadls4M1900M1910", itemId: "adl_iadls4_m1900_m1910" },
        { xtype: "medicationsM2000M2030" },
        { xtype: "medications2M2040"},
        { xtype: "typesSourcesOfAssistancem2100"},
        { xtype: "adliadlAssistanceM2110", itemId: "adl_iadl_assistance_m2110"},
        { xtype: "therapyNeedm2200"},
        { xtype: "PlanOfCareM2250"}
    ]
  end

  def get_combo_box_values
    [["General Patient Information (M0010 - M0140)"],
                      ["Payment Source (M0150)"],
                      ["Clinical Record Items (M0080 - M0110)"],
                      ["In Patient Discharge (M1000 - M1005)"],
                      ["Diagnosis and Procedure Codes (M1010 - M1012)"],
                      ["Diagnoses Regimen Change (M1016 - M1018)"],
                      ["Diagnoses Symptom Payment"],
                      ["Primary Other Payment 1 (M1020 - M1024)"],
                      ["Primary Other Payment 2 (M1022 - M1024)"],
                      ["Status Risk Vaccine (M1030 - M1036)"],
                      ["Living Arrangements (M1100)"],
                      ["Sensory Status (M1200 - M1230)"],
                      ["Pain Care Plan (M1240 - M1242)"],
                      ["Integumentary Status (M1300 - M1306)"],
                      ["Integumentary Status 2 (M1308)"],
                      ["Pressure Ulser (M1310 - M1324)"],
                      ["Stasis Ulcer/Wound (M1330 - M1350)"],
                      ["Respiratory Cardiac (M1400 - M1410)"],
                      ["Elimination (M1600 - M1630)"],
                      ["Neuro/Emotional/Behavioural (M1700 - M1730)"],
                      ["Neuro/Emotional/Behavioural 2 (M1740 - M1750)"],
                      ["ADLs/IADLs (M1800 - M1830)"],
                      ["ADLs/IADLs 2 (M1840 - M1870)"],
                      ["ADLs/IADLs 3 (M1880 - M1890)"],
                      ["ADLs/IADLs 4 (M1900 - M1910)"],
                      ["Medications (M2000 - M2030)"],
                      ["Medications 2 (M2040)"],
                      ["Types/Sources of Assistance (M2100)"],
                      ["ADL/IADL Assistance (M2110)" ],
                      ["Therapy Need (M2200)"],
                      ["Plan Of Care (M2250)"]
    ]
  end

end