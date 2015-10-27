class Documents::OasisTransferredPatientWithDischargeFormC1 < Documents::AbstractOasisTransferredPatientWithDischargeForm

  def get_form_panels
    [
        { xtype: "generalPatientInformationM0010M0069"},
        { xtype: "paymentSourceM0150" },
        { xtype: "clinicalRecordItemsM0080M0100" },
        { xtype: "statusRiskVaccineM1040M1055TrnC1"  },
        { xtype: "respiratoryCardiacM1500M1510"  },
        { xtype: "medicationsM2004M2015C1"  },
        { xtype: "emergentCareM2300M2310C1"  },
        { xtype: "interventionSynopsisM2400C1"  },
        { xtype: "inpatientFacilityM2410M2430C1"  },
        { xtype: "dischargeDatesM0903M0906"  }
    ]
  end

  def get_combo_box_values
    [["General Patient Information (M0010 - M0069)"],
     ["Payment Source (M0150)"],
     ["Clinical Record Items (M0080 - M0090)"],
     ["Status Risk Vaccine (M1041 - M1056)"],
     ["Respiratory/Cardiac (M1500 - M1510)"],
     ["Medications (M2004 - M2015)"],
     ["Emergent Care (M2300 - M2310)"],
     ["Intervention Synopsis (M2400)"],
     ["Inpatient Facility (M2410 - M2430)"],
     ["Discharge Dates (M0903 - M0906)"]
    ]
  end

end