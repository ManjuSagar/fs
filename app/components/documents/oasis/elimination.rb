class Documents::Oasis::Elimination < Mahaswami::SubPanel

  def configuration
    s = super
    s.merge(
        autoScroll: true,
        margin: 5,
        items: [
            {
                xtype: "elimination"
            }
        ]
    )
  end
end