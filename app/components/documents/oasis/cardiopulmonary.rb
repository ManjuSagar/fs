class Documents::Oasis::Cardiopulmonary < Mahaswami::SubPanel
  def configuration
    super.merge(
      autoScroll: true,
      layout: 'hbox',
      border: 0,
      title: 'Cardiopulmonary',
      items:[
          :breath_sounds.component,
          :heart_sounds.component
      ]
    )
  end

  component :breath_sounds do
    {
        class_name: "Documents::Oasis::BreathSounds",
    }
  end

  component :heart_sounds do
    {
        class_name: "Documents::Oasis::HeartSounds",
    }
  end
end