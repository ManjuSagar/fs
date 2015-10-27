class AddRefferralReceivedDate < ActiveRecord::Migration
  def change
    add_column :treatment_requests, :referral_received_date, :date
  end
end
