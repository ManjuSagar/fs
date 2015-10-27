class Documents::AbstractOasisTransferredPatientWithDischargeForm < Documents::AbstractOasisDocumentForm
  def configuration
    c = super
    c.merge(
        model: "OasisTransferredPatientWithDischarge"
    )
  end

end