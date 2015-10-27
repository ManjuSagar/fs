class CopyClaimInitialHippsCodeToFinalHippsCode < ActiveRecord::Migration
  def up
    User.current = User.find_by_email "info@mymetrohc.com"
    episodes = TreatmentEpisode.org_scope
    episodes.each do |episode|
      rap = episode.invoices.where(["invoice_type = ?", '322']).first
      final = episode.invoices.where(["invoice_type = ?", '329']).first
      next if (final.nil? or rap.nil?)
      rap_receivable = rap.receivables.find_by_purpose("Home Health Services")
      final_receivable = final.receivables.find_by_purpose("Home Health Services")
      hipps_code = rap_receivable.hcpcs_code
      final_receivable.update_column(:hcpcs_code, hipps_code)
      episode.update_attributes!({final_hipps_code: hipps_code})
    end
  end

  def down
  end
end
