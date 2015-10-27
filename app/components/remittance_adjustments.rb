class RemittanceAdjustments < Mahaswami::GridPanel

  def configuration
    c = super
    c.merge(
        model: 'MedicareRemittanceAdjustment',
        edit_on_dbl_click: false,
    bbar: [],
        columns: [
            {name: :code, header: "Code", width: 130, editable: false},
            {name: :adjusted_quantity, header: "Quantity", width: 130, editable: false},
            {name: :amount, header: "Amount", width: 130, editable: false, align: "right", renderer: :formattedAmount},
        ]
    )
  end
end