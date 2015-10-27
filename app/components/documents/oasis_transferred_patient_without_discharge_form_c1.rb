class Documents::OasisTransferredPatientWithoutDischargeFormC1 < Documents::OasisTransferredPatientWithDischargeFormC1
  def configuration
    c = super
    c.merge(
        model: "OasisTransferredPatientWithoutDischarge"
    )
  end
end