class Documents::Oasis::ActivitiesPermitted < Mahaswami::SubPanel
  def configuration
    super.merge(
        autoScroll: true,
        border: 0,
        layout: {
            type: 'vbox',
        },
        items: [
            {
                xtype: "activitiesPermitted",
                border: false
            }
        ]

    )
  end
end