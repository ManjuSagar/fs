class Documents::Oasis::Genitourinary < Mahaswami::SubPanel

  def configuration
    s = super
    s.merge(
        autoScroll: true,
        layout: {type: :vbox, align: :stretch},
        items: [
           {
               xtype: "genitourinary"
           }
        ]
    )
  end
end