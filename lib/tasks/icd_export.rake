  desc "Export OASIS ICD9 Diagnostc Codes, Ex: 1) rake export_icd_diagnostic_codes 2) rake export_icd_diagnostic_codes file='<file_name>'"
  task :export_icd_diagnostic_codes => [:environment] do
    require "csv"
    file_name = ENV['file'] || "#{Rails.root}/icd_files/icd9_diagnosis_codes.csv"
    fields_spec_arr = get_fields_arr("ProspectivePaymentSystem::Icd9DiagnosticCode")
    CSV.open(file_name, "wb") {|csv|
      fields_spec_arr.each{|out|
        csv << out
      }
    }
  end

  desc "Export OASIS ICD9 Procedure Codes, Ex: 1) rake export_icd_procedure_codes 2) rake export_icd_procedure_codes file='<file_name>'"
  task :export_icd_procedure_codes => [:environment] do
    require "csv"
    file_name = ENV['file'] || "#{Rails.root}/icd_files/icd9_procedure_codes.csv"
    fields_spec_arr = get_fields_arr("ProspectivePaymentSystem::Icd9ProcedureCode")
    CSV.open(file_name, "wb") {|csv|
      fields_spec_arr.each{|out|
        csv << out
      }
    }
  end



  def get_fields_arr(model)
    icd_records = model.constantize.all
    icd_codes_arr = []
    icd_records.each{|field_spec|
      icd_code_arr = []
      field_spec.attributes.each{|attr, value|
        next if attr == 'id'
        icd_code_arr << value
      }
      icd_codes_arr << icd_code_arr
    }
    icd_codes_arr
  end