class Documents::AbstractOasisRecertificationForm < Documents::AbstractOasisDocumentForm
  def configuration
    c = super
    c.merge(
        model: "OasisRecertification"
    )
  end

end