class Documents::OasisRecertificationForm < Documents::OasisOtherFollowupForm
  def configuration
    c = super
    c.merge(
        model: "OasisRecertification"
    )
  end
end