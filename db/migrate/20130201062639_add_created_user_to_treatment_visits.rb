class AddCreatedUserToTreatmentVisits < ActiveRecord::Migration
  def change
    add_column :treatment_visits, :created_user_id, :integer
    TreatmentVisit.update_all(:created_user_id => 1)
    change_column :treatment_visits, :created_user_id, :integer, :null =>  false
  end
end
