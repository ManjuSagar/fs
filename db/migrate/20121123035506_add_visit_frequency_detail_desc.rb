class AddVisitFrequencyDetailDesc < ActiveRecord::Migration
  def up
    add_column :visit_frequency_details, :detail_description, :string, :limit => 20
  end

  def down
  end
end
