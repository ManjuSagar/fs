class LangRelated < ActiveRecord::Migration
  def up
    remove_column :treatment_requests, :preferred_gender
    remove_column :treatment_requests, :preferred_language_id
    add_column :users, :gender, :string, :limit => 1
  end

  def down
  end
end
