class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.string :discipline_code, :limit => 15, :null => false
      t.string :discipline_description, :limit => 100, :null => false
      t.timestamps
    end
  end
end
