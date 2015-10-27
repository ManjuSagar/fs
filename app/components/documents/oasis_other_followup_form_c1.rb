class Documents::OasisOtherFollowupFormC1 < Documents::AbstractOasisOtherFollowupForm

  def get_form_panels
    [
        { xtype: "generalPatientInformationM0010M0069"},
        { xtype: "paymentSourceM0150" },
        { xtype: "clinicalRecordItemsM0080M0100" },
        { xtype: "clinicalRecordItemsM0110"  },
        { xtype: "diagnosisAndProcedureCodesM1011OtherFollowUp"},
        { xtype: "primaryPaymentM1020M1024"  },
        { xtype: "primaryPaymentM1022M1024"  },
        { xtype: "primaryPaymentM1021M1025" },
        { xtype: "primaryPaymentM1023M1025"  },
        { xtype: "statusRiskVaccineM1030"  },
        { xtype: "sensoryStatusM1200"  },
        { xtype: "integumentaryStatusM1306"  },
        { xtype: "integumentryStatus2M1308SocRocC1", itemId: "integumentarystatus2_m1308" },
        { xtype: "pressureUlserM1322M1324C1"  },
        { xtype: "stasisUlcerWoundM1330M1342C1", layout: "hbox"  },
        { xtype: "respiratoryCardiacM1400"  },
        { xtype: "eliminationM1610M1630C1"  },
        { xtype: "adliadLs1M1810M1830"  },
        { xtype: "adliadLs2M1840M1860"  },
        { xtype: "medicationsM2030"  },
        { xtype: "therapyNeedm2200"  }
    ]
  end

  def get_combo_box_values
    [["General Patient Information (M0010 - M0069)"],
     ["Payment Source (M0150)"],
     ["Clinical Record Items1 (M0080 - M0090)"],
     ["Clinical Record Items2 (M0110)"],
     ["Diagnosis Codes (M1011)"],
     ["Primary Other Payment 1 (M1020 - M1024)"],
     ["Primary Other Payment 2 (M1022 - M1024)"],
     ["Primary Other Payment 1 (M1021 - M1025)"],
     ["Primary Other Payment 2 (M1023 - M1025)"],
     ["Status Risk Vaccine (M1030)"],
     ["Sensory Status (M1200 - M1242)"],
     ["Integumentary Status (M1306)"],
     ["Integumentary Status 2 (M1308)"],
     ["Pressure Ulser (M1322 - M1324)"],
     ["Stasis Ulcer/Wound (M1330 - M1342)"],
     ["Respiratory/Cardiac (M1400)"],
     ["Elimination (M1610 - M1630)"],
     ["ADL/IADLs (M1810 - M1830)"],
     ["ADL/IADLs 2 (M1840 - M1860)"],
     ["Medications (M2030)"],
     ["Therapy Need (M2200)"],
    ]

  end
  def get_combo_box_values_icd9
    [["General Patient Information (M0010 - M0069)"],
     ["Payment Source (M0150)"],
     ["Clinical Record Items1 (M0080 - M0090)"],
     ["Clinical Record Items2 (M0110)"],
     ["Diagnosis Codes (M1011)", 'icd10'],
     ["Primary Other Payment 1 (M1020 - M1024)"],
     ["Primary Other Payment 2 (M1022 - M1024)"],
     ["Primary Other Payment 1 (M1021 - M1025)", "icd10"],
     ["Primary Other Payment 2 (M1023 - M1025)", 'icd10'],
     ["Status Risk Vaccine (M1030)"],
     ["Sensory Status (M1200 - M1242)"],
     ["Integumentary Status (M1306)"],
     ["Integumentary Status 2 (M1308)"],
     ["Pressure Ulser (M1322 - M1324)"],
     ["Stasis Ulcer/Wound (M1330 - M1342)"],
     ["Respiratory/Cardiac (M1400)"],
     ["Elimination (M1610 - M1630)"],
     ["ADL/IADLs (M1810 - M1830)"],
     ["ADL/IADLs 2 (M1840 - M1860)"],
     ["Medications (M2030)"],
     ["Therapy Need (M2200)"],
    ]

  end

  def get_combo_box_values_icd10
    [["General Patient Information (M0010 - M0069)"],
     ["Payment Source (M0150)"],
     ["Clinical Record Items1 (M0080 - M0090)"],
     ["Clinical Record Items2 (M0110)"],
     ["Diagnosis Codes (M1011)"],
     ["Primary Other Payment 1 (M1020 - M1024)", 'icd9'],
     ["Primary Other Payment 2 (M1022 - M1024)",'icd9'],
     ["Primary Other Payment 1 (M1021 - M1025)"],
     ["Primary Other Payment 2 (M1023 - M1025)"],
     ["Status Risk Vaccine (M1030)"],
     ["Sensory Status (M1200 - M1242)"],
     ["Integumentary Status (M1306)"],
     ["Integumentary Status 2 (M1308)"],
     ["Pressure Ulser (M1322 - M1324)"],
     ["Stasis Ulcer/Wound (M1330 - M1342)"],
     ["Respiratory/Cardiac (M1400)"],
     ["Elimination (M1610 - M1630)"],
     ["ADL/IADLs (M1810 - M1830)"],
     ["ADL/IADLs 2 (M1840 - M1860)"],
     ["Medications (M2030)"],
     ["Therapy Need (M2200)"],
    ]
  end

end