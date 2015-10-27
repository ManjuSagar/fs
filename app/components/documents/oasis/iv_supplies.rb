class Documents::Oasis::IvSupplies < Mahaswami::SubPanel
  def configuration
    super.merge(
        autoScroll: true,
        border: 0,
        items: [
            {
                xtype: "medicationsPocIvSupplies"
            }
        ]
    )
  end

end