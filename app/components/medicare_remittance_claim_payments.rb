class MedicareRemittanceClaimPayments < Netzke::Basepack::Panel

  def configuration
    s = super
    s.merge(
        header: false,
        border: false,
        flex: 1,
        items: [
            :claim_payments.component,
            :remittance_adjustments.component
        ]
    )
  end

  component :claim_payments do
    {
      class_name: "ClaimPayments",
      item_id: 'claim_payment',
      height: 200,
      margin: '0 0 5 0',
      scope: {invoice_id: config[:invoice_id]}.merge(config[:remit_claim_id] ? {id: config[:remit_claim_id]} : {})
    }
  end

  component :remittance_adjustments do
    {
        class_name: "RemittanceAdjustments",
        item_id: 'claim_payment_adjustment',
        height: 200,
        invoice_id: config[:invoice_id],
        scope: {adjustment_id: config[:claim_pmt_id], adjustment_type: "MedicareRemittanceClaim"},
        title: "Claim Adjustments"

    }
  end
end