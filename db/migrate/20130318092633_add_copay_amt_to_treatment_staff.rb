class AddCopayAmtToTreatmentStaff < ActiveRecord::Migration
  def change
    add_column :treatment_staffs, :co_pay_amt, :decimal, :precision => 8, :scale => 2
  end
end
