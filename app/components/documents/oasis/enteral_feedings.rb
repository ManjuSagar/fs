class Documents::Oasis::EnteralFeedings < Mahaswami::SubPanel

  def configuration
    s = super
    s.merge(
        autoScroll: true,
        items: [
           {
               xtype: "eternalfeedings"
           }
        ]
    )
  end
end


