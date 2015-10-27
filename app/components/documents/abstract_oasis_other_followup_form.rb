class Documents::AbstractOasisOtherFollowupForm < Documents::AbstractOasisDocumentForm
  def configuration
    c = super
    c.merge(
        model: "OasisOtherFollowup"
    )
  end

end