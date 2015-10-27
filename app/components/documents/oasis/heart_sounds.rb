class Documents::Oasis::HeartSounds < Mahaswami::SubPanel
  def configuration
    super.merge(
        border: 0,
        header:false,
        items:[
              {
                  xtype: "heartsounds"
              }
        ]
    )
  end

end