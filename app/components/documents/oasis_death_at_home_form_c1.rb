class Documents::OasisDeathAtHomeFormC1 < Documents::AbstractOasisDeathAtHomeForm

  def get_form_panels
    [
        { xtype: "generalPatientInformationM0010M0069"},
        { xtype: "paymentSourceM0150"},
        { xtype: "clinicalRecordItemsM0080M0100"},
        { xtype: "dischargeDatesM0903M0906"}
    ]
  end

  def get_combo_box_values
    [["General Patient Information (M0010 - M0069)"],
     ["Payment Source (M0150)"],
     ["Clinical Record Items (M0080 - M0090)"],
     ["Discharge Dates (M0903 - M0906)"]
    ]
  end

end