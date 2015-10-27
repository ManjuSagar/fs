class Documents::OasisDischargeFromAgencyFormC1 < Documents::AbstractOasisDischargeFromAgencyForm

  def get_form_panels
    [
        { xtype: "generalPatientInformationM0010M0069"},
        { xtype: "paymentSourceM0150" },
        { xtype: "clinicalRecordItemsM0080M0100" },
        { xtype: "statusRiskVaccineM1040M1055DcC1" },
        { xtype: "sensoryStatusM1230M1242" },
        { xtype: "integumentaryStatusM1306M1307C1" },
        { xtype: "integumentryStatus2M1308C1", itemId: "integumentarystatus2_m1308" },
        { xtype: "pressureUlserM1310M1324C1", itemId: "pressure_ulcer_m1310_m1324" },
        { xtype: "stasisUlcerWoundM1330M1342C1", layout: "hbox" },
        { xtype: "respiratoryCardiacM1400M1510C1" },
        { xtype: "eliminationM1600M1620"},
        { xtype: "neuroEmotionalBehaviouralM17001720" },
        { xtype: "neuroEmotionalBehavioural2M1740M1745" },
        { xtype: "adlIadls1M1800M1830" },
        { xtype: "adlIadls2M1840M1870", itemId: "adl_iadls2_m1840_m1870" },
        { xtype: "adlIadls3M1880M1890", itemId: "adl_iadls3_m1880_m1890" },
        { xtype: "medicationsM2004M2030" },
        { xtype: "typesSourcesOfAssistanceM2102C1"},
        { xtype: "emergentCareM2300M2310" },
        { xtype: "interventionSynopsisM2400C1" },
        { xtype: "inpatientFacilityM2410M2420" },
        { xtype: "dischargeDatesM0903M0906" }
    ]
  end

  def get_combo_box_values
    [["General Patient Information (M0010 - M069)"],
     ["Payment Source (M0150)"],
     ["Clinical Record Items (M0080 - M0090)"],
     ["Status Risk Vaccine (M1041 - M1056)"],
     ["Sensory Status (M1230 - M1242)"],
     ["Integumentary Status (M1306 - M1307)"],
     ["Integumentary Status 2 (M1308 - M1309)"],
     ["Pressure Ulser (M1320 - M1324)"],
     ["Stasis Ulcer/Wound (M1330 - M1342)"],
     ["Respiratory Cardiac (M1400 - M1510)"],
     ["Elimination (M1600 - M1620)"],
     ["Neuro/Emotional/Behavioural (M1700 - M1720)"],
     ["Neuro/Emotional/Behavioural 2 (M1740 - M1745)"],
     ["ADL/IADLs (M1800 - M1830)"],
     ["ADL/IADLs 2 (M1840 - M1870)"],
     ["ADL/IADLs 3 (M1880 - M1890)"],
     ["Medications (M2004 - M2030)"],
     ["Types/Sources of Assistance (M2102)"],
     ["Emergent Care (M2300 - M2310)"],
     ["Intervention Synopsis (M2400)"],
     ["Inpatient Facility (M2410 - M2420)"],
     ["Discharge Dates (M0903 - M0906)"]
    ]
  end

end