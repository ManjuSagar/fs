class AddTransferFromAnotherHhaToReferral < ActiveRecord::Migration
  def change
    add_column :treatment_requests, :transfer_from_hha, :string, limit: 4
  end
end
