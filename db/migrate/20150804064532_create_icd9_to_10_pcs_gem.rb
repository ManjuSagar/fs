class CreateIcd9To10PcsGem < ActiveRecord::Migration
  def change
    create_table :icd9_to_icd10_pcs_gems  do |t|
      t.string :icd9_code, :limit => 10
      t.string :icd10_code, :limit => 10
      t.string :approximation, :limit => 1
      t.string :no_map, :limit => 1
      t.string :combination, :limit => 1
      t.string :scenario, :limit => 3
      t.string :choice_list, :limit => 3
      t.timestamps
    end
  end
end
