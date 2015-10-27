class Documents::OasisRecertificationFormC1 < Documents::OasisOtherFollowupFormC1
  def configuration
    c = super
    c.merge(
        model: "OasisRecertification"
    )
  end
end