class DocumentVisitMap < ActiveRecord::Migration
  def up
    add_column :documents, :visit_id, :integer
  end

  def down
  end
end
