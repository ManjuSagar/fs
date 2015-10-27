class CreateMedicareRemits < ActiveRecord::Migration
  def change
    create_table :medicare_remittances do |t|
      t.has_attached_file :medicare_remittance
      t.date :check_eft_date
      t.decimal :check_eft_amount
      t.string :check_eft_type
      t.string :check_eft_number
      t.string :total_no_of_claims
      t.decimal :total_billed_amount
      t.decimal :total_adjusted_amount
      t.decimal :total_allowed_amount
      t.decimal :total_co_ins_amount
      t.decimal :total_deductible_amount
      t.decimal :total_paid_amount
      t.decimal :total_interest_amount
      t.integer :lock_version
      t.timestamps
    end

    create_table :medicare_remittance_claims do |t|
      t.integer :invoice_id, :null => false
      t.integer :medicare_remittance_id, :null => false
      t.string :account_number
      t.string :internal_control_number
      t.decimal :claim_billed_amount
      t.decimal :claim_adjusted_amount
      t.decimal :claim_allowed_amount
      t.decimal :claim_co_ins_amount
      t.decimal :claim_deductible_amount
      t.decimal :provider_paid_amount
      t.string :claim_assignment, :limit => 1
      t.date :service_from_date
      t.date :service_to_date
      t.string :patient_name
      t.decimal :claim_interest_amount
      t.decimal :late_filling_charge
      t.integer :lock_version
      t.timestamps
    end

    create_table :medicare_remittance_provider_adjustments do |t|
      t.integer :medicare_remittance_id, :null => false
      t.string :reason_code
      t.string :financial_control_number
      t.decimal :amount
      t.integer :lock_version
      t.timestamps
    end

    create_table :medicare_remittance_claim_line_items do |t|
      t.integer :medicare_remittance_claim_id, :null => false
      t.string :internal_control_number
      t.decimal :line_item_billed_amount
      t.decimal :line_item_paid_amount
      t.decimal :line_item_coinsurance_amount
      t.decimal :line_item_deductible_amount
      t.decimal :line_item_allowed_amount
      t.decimal :line_item_adjustment_amount
      t.string :paid_no_of_services
      t.string :submitted_no_of_services
      t.string :procedure_codes
      t.string :submitted_procedure_codes
      t.string :procedure_code_modifiers
      t.date :service_from_date
      t.date :service_to_date
      t.integer :lock_version
      t.timestamps
    end

    create_table :medicare_remittance_adjustments do |t|
      t.string :group_code
      t.string :reason_code
      t.string :reason_description
      t.decimal :amount
      t.integer :adjustment_id, :null => false
      t.string :adjustment_type, :null => false
      t.string :adjusted_quantity
      t.integer :lock_version
      t.timestamps
    end

  end

end
