class RemoveChargeableRateFromVisitTypes < ActiveRecord::Migration
  def up
  remove_column :visit_types, :chargeable_rate
  end

  def down
  end
end
