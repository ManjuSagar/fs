class ServicePayments < Mahaswami::GridPanel

  def configuration
    c = super
    c.merge(
        model: 'MedicareRemittanceClaimLineItem',
        title:  "Line Item Payments",
        edit_on_dbl_click: false,
        bbar: [],
        columns: [
            {name: :internal_control_number, header: "ICN", editable: false},
            {name: :patient_responsibility_amount, header: "Patient Responsibility", width: 160, editable: false, align: "right", renderer: :formattedAmount},
            {name: :service_from_date, header: "Service Date", editable: false, },
            {name: :line_item_billed_amount, header: "Billed Amt", editable: false, align: "right", renderer: :formattedAmount},
            {name: :line_item_paid_amount, header: "Paid Amt", editable: false, align: "right", renderer: :formattedAmount},
        ]
    )
  end
end