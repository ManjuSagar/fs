class ClaimPayments < Mahaswami::GridPanel
  def configuration
    c = super
    c.merge(
        model: 'MedicareRemittanceClaim',
        title:  "Claim Payments",
        edit_on_dbl_click: false,
        bbar: [],
        columns: [
            {name: :claim_adjusted_amount, header: "Adj. Amt", editable: false, align: "right", width: 90, renderer: :formattedAmount},
            {name: :claim_billed_amount, header: "Claim Amt", editable: false, align: "right", width: 90, renderer: :formattedAmount},
            {name: :patient_responsibility, header: "Pat Responsibility", editable: false, align: "right", width: 120, renderer: :formattedAmount},
            {name: :provider_paid_amount, header: "Paid Amt", editable: false, align: "right", width: 85, renderer: :formattedAmount},
            {name: :late_filling_charge, header: "Late Filling Charge", editable: false, align: "right", width: 120, renderer: :formattedAmount},
            {name: :claim_interest_amount, header: "Int. Amt", editable: false, align: "right", width: 85, renderer: :formattedAmount},
        ]
    )
  end
end