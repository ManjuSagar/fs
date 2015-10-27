class AddIndexToFdaLibraries < ActiveRecord::Migration
  def change
    add_index :fda_drug_libraries, [:drug_name, :strength], :name => 'drug_name_and_strength_index'
  end
end
