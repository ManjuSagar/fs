class TreatmentRequestPaymentSources < ActiveRecord::Migration
  def up
    create_table :treatment_request_payment_sources, :force => true do |t|
      t.integer :request_id, :null => false
      t.string :payment_source_id, :null => false
      t.integer :lock_version, :null => false, :default => 0
    end

  end

  def down
  end
end
