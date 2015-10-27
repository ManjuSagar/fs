class Documents::Oasis::FallRiskManagement < Mahaswami::SubPanel
  def configuration
    super.merge(
        autoScroll: true,
        border: 0,
        layout: {
            type: 'vbox',
        },
        items: [
            {
                xtype: "fallRiskManagement",
                border: false
            }
        ]
    )
  end

end