class Documents::Oasis::FunctionalLimitations < Mahaswami::SubPanel
  def configuration
    super.merge(
        autoScroll: true,
        border: 0,
        layout: {
            type: 'vbox',
        },
        items: [
            {
                xtype: "functionalLimitations",
                border: false
            }
        ]
    )
  end
end