class ChangeDefaultValuesForMo < ActiveRecord::Migration
  def change
    change_column :medical_orders, :mo_editable, :boolean, :default => true
    if OrderType::EVAL.present?
      medical_orders = MedicalOrder.where(["order_type_id = ?", OrderType::EVAL.id])
      medical_orders.update_all(:mo_editable => false) unless medical_orders.empty?
    end
  end
end
