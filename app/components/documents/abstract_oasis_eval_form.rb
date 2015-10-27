class Documents::AbstractOasisEvalForm < Documents::AbstractOasisDocumentForm
  def configuration
    c = super
    c.merge(
        model: "OasisEvaluation"
    )
  end

end