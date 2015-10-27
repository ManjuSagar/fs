class MedicareRemittanceDetailsStoreInDB
  attr_accessor :remittance, :parser

  def initialize(remittance)
    @remittance = remittance
    @parser = MedicareRemittanceParser.new(@remittance)

    assign_remit_summery
    create_medicare_remittance_claims
    create_remittance_provider_adjustments

    @remittance.save!
  end

  def assign_remit_summery
    remittance.check_eft_date = parser.remit_transaction_date
    remittance.check_eft_amount = parser.remit_transaction_amount
    remittance.check_eft_type = parser.remit_transaction_type
    remittance.check_eft_number = parser.cheque_or_eft_number
    remittance.total_no_of_claims = parser.total_number_of_claims
    remittance.total_billed_amount = parser.remit_billed_amount
    remittance.total_adjusted_amount = parser.remit_adjustment_amount
    remittance.total_allowed_amount = parser.remit_allowed_amount
    remittance.total_co_ins_amount = parser.remit_co_ins_amount
    remittance.total_deductible_amount = parser.remit_deductible_amount
    remittance.total_paid_amount = parser.remit_paid_amount
    remittance.total_interest_amount = parser.remit_interest_amount
  end

  def create_medicare_remittance_claims
    claim_list = parser.claim_list
    claim_list.each do |claim_attr|
      invoice = Invoice.invoices_from_invoice_number(remittance, claim_attr[:service_from_date], claim_attr[:service_to_date],
                                                     claim_attr[:medicare_number])
      next unless invoice.present?
      attrs = claim_attr.reject{|k, v|[:services, :adjustments, :rarcs, :medicare_number].include?(k) }.merge(invoice: invoice)
      claim = remittance.medicare_remittance_claims.create!(attrs)

      create_adjustments(claim, claim_attr[:adjustments])
      add_remarks_codes(claim, claim_attr[:rarcs])

      claim_attr[:services].each do |service_attr|
        serv_attrs = service_attr.reject{|k, v|[:adjustments, :rarcs, :service_revenue_code].include?(k) }
        receivable = find_receivable(invoice, service_attr)
        service = claim.medicare_remittance_claim_line_items.create!(serv_attrs.merge(receivable: receivable))
        create_adjustments(service, service_attr[:adjustments])
        add_remarks_codes(service, service_attr[:rarcs])
      end
    end
  end

  def create_remittance_provider_adjustments
    plb_adjustments = parser.provider_adjustments
    plb_adjustments.each do |plb|
      plb[:adjustments].each do |adj|
        remittance.medicare_remittance_provider_adjustments.create!(adj)
      end
    end
  end

  def create_adjustments(parent, adjustments)
    adjustments.each do |adjustment|
      parent.medicare_remittance_adjustments.create!(adjustment)
    end
  end

  def add_remarks_codes(parent, rarcs)
    rarcs.each do |rarc_code|
      parent.medicare_remittance_adjustments.create!({:reason_code => rarc_code})
    end
  end

  def find_receivable(claim, service_attrs)
    date = service_attrs[:service_from_date]
    res = claim.receivables.where(["receivable_date = ?", date])
    res = res.where(["receivable_amount = ?", service_attrs[:line_item_billed_amount]])
    res = res.where(["service_units = ?", service_attrs[:submitted_no_of_services]]) if service_attrs[:submitted_no_of_services].blank? == false
    res = res.where(["hcpcs_code in (?)", service_attrs[:procedure_codes].split(", ")]) if service_attrs[:procedure_codes].blank? == false
    res = res.where(["revenue_code = ?", service_attrs[:service_revenue_code]]) if service_attrs[:service_revenue_code]
    res.first
  end

end