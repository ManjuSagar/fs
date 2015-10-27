class RemittanceClaimPaymentsExplorer < Netzke::Basepack::Panel

  def configuration
    c = super
    c.merge(
        layout: {
            type: 'hbox',
        },
        items:
          [
            :service_details.component,
            :claim_details.component
          ]
    )
  end

  component :service_details do
    {
      flex: 1,
      class_name: "MedicareRemittanceClaimServicePayments",
      invoice_id: config[:invoice_id],
      margin: '0 5 0 0',
      receivable_id: config[:receivable_id],
      service_id: config[:service_id],
      remit_claim_id: config[:remit_claim_id]
    }
  end

  component :claim_details do
    {
      flex: 1,
      class_name: "MedicareRemittanceClaimPayments",
      invoice_id: config[:invoice_id],
      claim_pmt_id: config[:claim_pmt_id],
      remit_claim_id: config[:remit_claim_id]
    }
  end

end