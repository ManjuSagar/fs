class AddTreatmentIdToReceivables < ActiveRecord::Migration
  def change
    add_column :receivables, :treatment_id, :integer, :null => true
  end
end
