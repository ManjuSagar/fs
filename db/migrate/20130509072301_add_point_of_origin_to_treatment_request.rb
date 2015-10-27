class AddPointOfOriginToTreatmentRequest < ActiveRecord::Migration
  def change
    add_column :treatment_requests, :point_of_origin, :string, :limit => 1
    TreatmentRequest.update_all(:point_of_origin => '1')
    change_column :treatment_requests, :point_of_origin, :string, :limit => 1, :null => false
  end
end
