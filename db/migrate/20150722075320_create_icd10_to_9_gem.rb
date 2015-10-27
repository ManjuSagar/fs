class CreateIcd10To9Gem < ActiveRecord::Migration
  def change
    create_table :icd10cm_to_icd9_gems  do |t|
      t.string :icd10_code, :limit => 10
      t.string :icd9_code, :limit => 10
      t.string :approximation, :limit => 1
      t.string :no_map, :limit => 1
      t.string :combination, :limit => 1
      t.string :scenario, :limit => 3
      t.string :choice_list, :limit => 3
      t.timestamps
    end
  end
end
