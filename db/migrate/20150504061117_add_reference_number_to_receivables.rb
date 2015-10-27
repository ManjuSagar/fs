class AddReferenceNumberToReceivables < ActiveRecord::Migration
  def change
    add_column :receivables, :reference_number, :string, :limit => 75
  end
end
