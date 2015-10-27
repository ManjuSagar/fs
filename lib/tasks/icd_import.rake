desc "Import ICD Procedure Codes, Ex: rake import_icd_procedure_codes file='icd_files/icd9_procedure_codes.csv'"
task :import_icd_procedure_codes => [:environment] do
  raise "Please provide file name in 'file' argument" unless ENV['file']
  limit = ENV['limit'].to_i
  process_file ENV['file'], limit, 'P'
end

desc "Import ICD Diagnostic Codes, Ex: rake import_icd_diagnostic_codes file='icd_files/icd9_diagnosis_codes.csv'"
task :import_icd_diagnostic_codes => [:environment] do
  raise "Please provide file name in 'file' argument" unless ENV['file']
  limit = ENV['limit'].to_i
  process_file ENV['file'], limit, 'D'
end

def process_file(file, limit, type)
  require 'csv'
  data_class = (type == 'P') ? ProspectivePaymentSystem::Icd9ProcedureCode : ProspectivePaymentSystem::Icd9DiagnosticCode
  data_class.destroy_all
  IO.readlines(file).each_with_index {|line, idx|
    rec_number = idx + 1
    break if limit > 0 and limit < rec_number
    print "Inserting Record #{rec_number}..."
    code, short_desc, long_desc  = CSV.parse(line).flatten
    rec = data_class.new(short_description: short_desc, long_description: long_desc)
    rec.icd_code = code
    begin
      rec.save!
    rescue ActiveRecord::RecordNotUnique => r
      puts "Code(#{code}) already exists!!!, skipping."
    end
    puts "done."
  }
end