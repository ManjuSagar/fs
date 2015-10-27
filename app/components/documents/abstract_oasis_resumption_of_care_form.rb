class Documents::AbstractOasisResumptionOfCareForm < Documents::AbstractOasisDocumentForm
  def configuration
    c = super
    c.merge(
        model: "OasisResumptionOfCare"
    )
  end

end