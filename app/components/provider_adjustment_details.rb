class ProviderAdjustmentDetails < Mahaswami::GridPanel
  def configuration
    s = super
    s.merge(
      model: 'MedicareRemittanceProviderAdjustment',
      bbar: [],
      context_menu: [],
      columns: [
        {name: :reason_code, header: "Reason", editable: false, width: '40%'},
        {name: :financial_control_number, header: "FCN", editable: false, width: '30%'},
        {name: :amount, header: "Amount", editable: false, width: '15%', align: 'right', renderer: :formattedAmount},
    ]
    )
  end

end