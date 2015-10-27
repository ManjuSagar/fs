class Documents::OasisTransferredPatientWithoutDischargeForm < Documents::OasisTransferredPatientWithDischargeForm
  def configuration
    c = super
    c.merge(
        model: "OasisTransferredPatientWithoutDischarge"
    )
  end
end