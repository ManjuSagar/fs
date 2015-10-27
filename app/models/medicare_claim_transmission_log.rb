class MedicareClaimTransmissionLog < ActiveRecord::Base
  has_attached_file :claim_edi

  belongs_to :invoice

  RESPONSES = [['', "---"], ['TA1', "TA1"],['999', "999"], ['277CA',"277CA"],['837EDI', "837EDI"]]

  FileType =  [['',"---"],['Incoming', "Incoming"], ['Outgoing', "Outgoing"]]

  TRANSMISSION_STATUS = [["","---"],["accepted","Accepted"],["rejected","Rejected"],["edi_generation_failure","Edi
              Generation Failed"],["pending_trn","Pending TRN"],["pending_999","Pending 999"],
              ["pending_277","Pending 277"],["ta1_failure","TA1 Failure"],["trn_failure","TRN Failure"],
              ["999_failure","999 Failure"]]

  def claim_number
    invoice.invoice_number if invoice.present?
  end

  def org_name
    invoice.org.to_s if invoice.present?
  end

  def self.download_url_path(log_id)
    Rails.application.routes.url_helpers.transmission_log_file_path(log_id)
  end

  def self.transmission_status status
    if status == 'trn_failure'
      'TRN Failure'
    elsif status == 'ta1_failure'
      'TA1 Failure'
    else
      status.titleize
    end
  end

end