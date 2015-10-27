class Documents::AbstractOasisDischargeFromAgencyForm < Documents::AbstractOasisDocumentForm
  def configuration
    c = super
    c.merge(
        model: "OasisDischargeFromAgency"
    )
  end

end