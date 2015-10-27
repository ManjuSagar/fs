class Documents::Oasis::SuppliesEquipment < Mahaswami::SubPanel
  def configuration
    super.merge(
        autoScroll: true,
        border: 0,
        layout: 'vbox',
        items: [
            {
                xtype: "suppliesEquipment",
                border: false
            }
        ]
    )
  end
end