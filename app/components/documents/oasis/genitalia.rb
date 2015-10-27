class Documents::Oasis::Genitalia < Mahaswami::SubPanel

  def configuration
    s = super
    s.merge(
        autoScroll: true,
        margin: 5,
        items: [
            {
                xtype: "genitalia"
            }
        ]
    )
  end
end