class Documents::AbstractOasisDeathAtHomeForm < Documents::AbstractOasisDocumentForm
  def configuration
    c = super
    c.merge(
        model: "OasisDeathAtHome"
    )
  end

end