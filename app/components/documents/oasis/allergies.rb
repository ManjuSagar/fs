class Documents::Oasis::Allergies < Mahaswami::SubPanel
  def configuration
    super.merge(
        autoScroll: true,
        border: 0,
        items: [
          {
              xtype: "medicationsPocAllergies"
          }
        ]
    )

  end
end










