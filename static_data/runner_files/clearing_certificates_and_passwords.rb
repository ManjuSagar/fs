

unless Rails.application.config.perform_actual_electronic_claim_delivery.present?
  ActiveRecord::Base.connection.exec_query("update health_agency_details set certificate_alias_name = null,
                                          certificate_password = null, clm_billing_cert_alias_name = null,
                                          clm_billing_cert_password = null, claims_electronic_transmission = false")
end

