class Documents::Oasis::Musculoskeletal < Mahaswami::SubPanel
  def configuration
    super.merge(
        autoScroll: true,
        items:[
            {
                xtype: "musculoskeletal",
                border: false
            }
            ]
    )
  end

end