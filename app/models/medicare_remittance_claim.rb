class MedicareRemittanceClaim < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :medicare_remittance
  belongs_to :invoice
  has_many :medicare_remittance_claim_line_items, :dependent => :destroy
  has_many :medicare_remittance_adjustments, :as => :adjustment, :dependent => :destroy

  audited :associated_with => :medicare_remittance, :allow_mass_assignment => true

  def self.get_patient_and_amount_details(invoice_id)
    invoice = Invoice.org_scope.find(invoice_id)
    claim_payments = where(:invoice_id => invoice_id)
    hsh = if claim_payments.size > 0
            remit_claim = claim_payments.first
            {
               patient_name: remit_claim.patient_name.upcase,
               paid_amount: remit_claim.formatted_amount(claim_payments.map(&:provider_paid_amount).sum),
               patient_responsibility: remit_claim.formatted_amount(claim_payments.map(&:claim_co_ins_amount).compact.sum +
                                        claim_payments.map(&:claim_deductible_amount).compact.sum)
            }
          else
            {
                patient_name: invoice.formatted_patient_name,
                paid_amount: invoice.formatted_amount(0),
                patient_responsibility: invoice.formatted_amount(0)
            }
          end
    hsh.merge({from_date: date_format_from_mmddyyyy(invoice.statement_covers_period_from),
               to_date: date_format_from_mmddyyyy(invoice.statement_covers_period_through),
     sent_date: invoice.sent_date_formatted, billed_amount: invoice.formatted_amount(invoice.billed_amount),
     invoice_status: invoice.invoice_status.to_s.titleize})
  end

  def self.date_format_from_mmddyyyy(date)
    date[0..1] + "/" + date[2..3] + "/" + date[4..7]
  end

  def service_from_date_display
    service_from_date.strftime("%m/%d/%Y") if service_from_date
  end

  def service_to_date_display
    service_to_date.strftime("%m/%d/%Y") if service_to_date
  end

  def formatted_amount(amount)
    amount ||= 0
    number_to_currency(amount)
  end

  def patient_responsibility
    claim_deductible_amount.to_f + claim_co_ins_amount.to_f
  end
end