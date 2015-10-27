class Document::AbstractOasisTransferredPatientWithoutDischargeForm < Documents::AbstractOasisDocumentForm
  def configuration
    c = super
    c.merge(
        model: "OasisTransferredPatientWithoutDischarge"
    )
  end

end