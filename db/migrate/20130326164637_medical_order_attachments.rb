class MedicalOrderAttachments < ActiveRecord::Migration
  def up
    create_table :medical_order_attached_docs, force: true do |t|
      t.integer :medical_order_id, null: false
      t.integer :document_id, null: false
    end
  end

  def down
  end
end
