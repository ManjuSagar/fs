class ReferralReceivedFlagInReferral < ActiveRecord::Migration
  def up
    add_column :treatment_requests, :referral_received_flag, :boolean, :default => false
  end

  def down
  end
end
