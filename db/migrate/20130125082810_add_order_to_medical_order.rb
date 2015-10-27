class AddOrderToMedicalOrder < ActiveRecord::Migration
  def change
    change_table :medical_orders do |t|
      t.has_attached_file :printable_order
      t.has_attached_file :signed_order
    end
  end
end
