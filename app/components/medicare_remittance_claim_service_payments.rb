class MedicareRemittanceClaimServicePayments < Netzke::Basepack::Panel

  def configuration
    s = super
    s.merge(
      header: false,
      border: false,
      flex: 1,
      items: [
        :service_payments.component,
        :remittance_adjustments.component
      ]
    )
  end

  component :service_payments do
    {
      class_name: "ServicePayments",
      item_id: 'claim_service_payment',
      height: 200,
      margin: '0 0 5 0',
      invoice_id: config[:invoice_id],
      scope: {receivable_id: config[:receivable_id]}.merge(config[:remit_claim_id] ? {medicare_remittance_claim_id: config[:remit_claim_id]} : {})
    }
  end

  component :remittance_adjustments do
    {
      class_name: "RemittanceAdjustments",
      item_id: 'service_payment_adjustment',
      height: 200,
      invoice_id: config[:invoice_id],
      scope: {adjustment_id: config[:service_id], adjustment_type: "MedicareRemittanceClaimLineItem"},
      title: "Line Item Adjustments"
    }
  end
end