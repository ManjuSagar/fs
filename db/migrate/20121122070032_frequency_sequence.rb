class FrequencySequence < ActiveRecord::Migration
  def up
    add_column :visit_frequency_details, :detail_sequence, :integer
  end

  def down
  end
end
