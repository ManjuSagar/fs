class CreatePrimaryDiagnosticsAndProcedureCodes < ActiveRecord::Migration
  def change
    drop_table :icd_9_diagnostic_codes
    drop_table :icd_9_procedure_codes

    ProspectivePaymentSystem::Icd9DiagnosticCode.reset_column_information
    ProspectivePaymentSystem::Icd9ProcedureCode.reset_column_information

    create_table :icd_9_procedure_codes  do |t|
      t.string :icd_code, :limit => 7, :null => false
      t.string :short_description, :limit => 100
      t.string :long_description, :limit => 255
    end

    ProspectivePaymentSystem::Icd9DiagnosticCode.reset_column_information
    add_index :icd_9_procedure_codes, :icd_code, :unique => true
    
    create_table :icd_9_diagnostic_codes do |t|
      t.string :icd_code, :limit => 7, :null => false
      t.string :short_description, :limit => 100
      t.string :long_description, :limit => 255
    end

    ProspectivePaymentSystem::Icd9ProcedureCode.reset_column_information
		add_index :icd_9_diagnostic_codes, :icd_code, :unique => true

  end



end
