class Documents::Oasis::NutritionalStatus < Mahaswami::SubPanel

  def configuration
    s = super
    s.merge(
        autoScroll: true,
        items: [
           {
               xtype: "nutritionalstatus"
           }
        ]
    )
  end

end