class DocumentDefnSetInHaDetail < ActiveRecord::Migration
  def up
    add_column :health_agency_details, :document_defn_set_id, :integer
  end

  def down
  end
end
