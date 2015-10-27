class AddAutoGeneraedMoToMedicalOrders < ActiveRecord::Migration
  def change
    add_column :medical_orders, :mo_editable, :boolean, :default => false, :null => false

    if OrderType::EVAL.present?
      medical_orders = MedicalOrder.where(["order_type_id = ?", OrderType::EVAL.id])
      medical_orders.update_all(:mo_editable => true) unless medical_orders.empty?
    end
  end
end
