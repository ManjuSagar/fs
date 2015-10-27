class CreateTableMedicareClaimTransmssionLog < ActiveRecord::Migration
  def up
    create_table :medicare_claim_transmission_logs do |t|
      t.has_attached_file :claim_edi
      t.string :transmission_status
      t.integer :invoice_id
      t.integer :claim_start_line_number
      t.integer :claim_end_line_number
      t.string :type_of_response
      t.datetime :transmission_time
      t.string :type_of_file
      t.timestamps
    end
  end

  def down
  end
end
