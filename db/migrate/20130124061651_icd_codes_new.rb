class IcdCodesNew < ActiveRecord::Migration
  def up
    create_table :icd_9_procedure_codes, {id: false, force: true} do |t|
      t.string :icd_code, :limit => 7, :null => false
      t.string :short_description, :limit => 100
      t.string :long_description, :limit => 255
    end

    create_table :icd_9_diagnostic_codes, {id: false, :force => true} do |t|
      t.string :icd_code, :limit => 7, :null => false
      t.string :short_description, :limit => 100
      t.string :long_description, :limit => 255
    end
    execute ("alter table icd_9_procedure_codes add constraint icd_9_procedure_codes_pkey primary key(icd_code)")
    execute ("alter table icd_9_diagnostic_codes add constraint icd_9_diagnostic_codes_pkey primary key(icd_code)")

  end

  def down
  end
end
