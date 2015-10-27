class Documents::Oasis::BreathSounds < Mahaswami::SubPanel

  def configuration
    super.merge(
        border: 0,
        header: false,
        items:[
            {
                xtype: "breathSounds"
            }
        ]
    )
  end

end