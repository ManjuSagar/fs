class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.string :drug_name, :limit => 100, :null => false
      t.string :dosage, :limit => 100, :null => false
      t.string :active_ingredients, :limit => 200, :null => false
      t.string :status, :limit => 1, :null => false
      t.string :ndu_code, :limit => 15, :null => false

      t.timestamps
    end
  end
end
