class CreateIcd10Codes < ActiveRecord::Migration
  def change
    create_table :icd_10_procedure_codes  do |t|
      t.string :icd_code, :limit => 10, :null => false
      t.string :short_description
      t.string :long_description
      t.timestamps
    end

    ProspectivePaymentSystem::Icd10ProcedureCode.reset_column_information
    add_index :icd_10_procedure_codes, :icd_code, :unique => true

    create_table :icd_10_diagnostic_codes do |t|
      t.string :icd_code, :limit => 10, :null => false
      t.string :short_description
      t.string :long_description
      t.timestamps
    end

    ProspectivePaymentSystem::Icd9DiagnosticCode.reset_column_information
    add_index :icd_10_diagnostic_codes, :icd_code, :unique => true

  end
end
