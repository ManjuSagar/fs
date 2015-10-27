class RemoveChargeableRateFromDocumentDefinitions < ActiveRecord::Migration
  def up
    remove_column :document_definitions, :chargeable_rate
  end

  def down
  end
end
