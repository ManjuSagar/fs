class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :state_code, :limit => 2, :null => false
      t.string :state_description, :limit => 50, :null => false

      t.timestamps
    end
  end
end
