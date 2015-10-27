class Documents::Oasis::FoleySupplies < Mahaswami::SubPanel

  def configuration
    s = super
    s.merge(
        header: false,
        border: false,
        items: [
            {
                header: false,
                border: false,
                items: [
                    {
                        xtype: :label,
                        text: "FOLEY SUPPLIES"
                    },{header: false,
                       border: false,
                       layout: {type: :table, columns: 2},
                       items: [
                           {
                               xtype: "checkboxfield",
                               name: "foley_supplies",
                               isHeader: false,
                               boxLabel: "French catheter kit (tray, bag, foley)",
                               width: 140,
                               margin: "0 5 0 0"
                           },
                           {
                               xtype: "textfield",
                               name: "catheter_kit",
                               isHeader: false,
                               field_label: "Size",
                               labelWidth: 40
                           }
                       ]
                    },
                   {
                        xtype: "checkboxfield",
                        name: "foley_supplies",
                        boxLabel: "Straight catheter",
                        inputValue: "1"
                    },{
                        xtype: "checkboxfield",
                        name: "foley_supplies",
                        boxLabel: "Irrigation tray",
                        inputValue: "2"
                    },{
                        xtype: "checkboxfield",
                        name: "foley_supplies",
                        boxLabel: "Saline",
                        inputValue: "3"
                    },{
                        xtype: "checkboxfield",
                        name: "foley_supplies",
                        boxLabel: "Acetic acid",
                        inputValue: "4"
                    },{
                        xtype: "checkboxfield",
                        name: "foley_supplies",
                        boxLabel: "Other",
                        isHeader: false,
                        inputValue: "5"
                   },{
                        xtype: "textarea",
                        name: "other_foley_supplies",
                        isHeader: false,
                        cols: 50,
                        rows: 6
                    }
                ]
            }
        ]
    )
  end
end