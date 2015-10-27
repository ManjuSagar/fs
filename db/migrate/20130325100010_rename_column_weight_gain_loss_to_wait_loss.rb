class RenameColumnWeightGainLossToWaitLoss < ActiveRecord::Migration
  def change
    rename_column :treatment_vitals, :weight_gain_loss_in_lbs, :weight_loss_in_lbs

   vitals = VitalsReferenceRange.all
    vitals.each do |vital|
      vital.vital_sign = "weight_loss_in_lbs" if vital.vital_sign == "weight_gain_loss_in_lbs"
      vital.save!
    end
  end
end
