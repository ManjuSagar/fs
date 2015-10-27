class Documents::Oasis::Abdomen < Mahaswami::SubPanel

  def configuration
    s = super
    s.merge(
        autoScroll: true,
        margin: 5,
        items: [
            {
                xtype: "abdomen"
            }
        ]
    )
  end
end