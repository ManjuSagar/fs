class CorrectionRequest < Mahaswami::Panel

  def configuration
    c = super
    c.merge(

        collapsable: true,
        collapsed: true,
        region: :center,
        width: 200,
        items:[
        {
            xtype: 'button',
            text: "TEST"
        }
    ]

    )
  end

  component :notes do {
   class_name: 'Notes'
  }
  end
end