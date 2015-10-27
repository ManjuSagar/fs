desc "Import OASIS Header Field Specifications, EX: rake import_oasis_header_fields file='oasis/header.csv'"
task :import_oasis_header_fields => [:environment] do
  raise "Please provide file name in 'file' argument" unless ENV['file']
  limit = ENV['limit'].to_i
  process_header_file ENV['file']
end

desc "Import OASIS Trailer Field Specifications, EX: rake import_oasis_trailer_fields file='oasis/trailer.csv'"
task :import_oasis_trailer_fields => [:environment] do
  raise "Please provide file name in 'file' argument" unless ENV['file']
  limit = ENV['limit'].to_i
  process_trailer_file ENV['file']
end

desc "Import OASIS Body Field Specifications, EX: rake import_oasis_body_fields file='oasis/body.csv'"
task :import_oasis_body_fields => [:environment] do
  raise "Please provide file name in 'file' argument" unless ENV['file']
  limit = ENV['limit'].to_i
  process_body_file ENV['file']
end

desc "Import OASIS C and C1 Field Specifications, EX: rake import_oasis_c_and_c1_fields"
task :import_oasis_c_and_c1_fields => [:environment] do
  require 'csv'
  record_type = {"Control" => 'L', "Filler" => 'F', "Asmt" => 'A', "Calc" => 'C'}
  # OasisFieldSpec.where({oasis_spec_version: "02.11.3"}).delete_all
  # OasisFieldSpec.where({oasis_spec_version: "02.10.1"}).delete_all
  # OasisFieldSpec.update_all("oasis_spec_version = '02.00'")
  value_files = ["#{Rails.root}/oasis/oasis_c1/v2.12.0/itm_val.csv"]
  ["#{Rails.root}/oasis/oasis_c1/v2.12.0/itm_mstr.csv"].each_with_index do |file_name, index|
    field_values = CSV.read(value_files[index], {headers: true})
    CSV.foreach(file_name, {headers: true}) do |row|
      values = field_values.select{|r| r[3] == row[3] }
      boolean_type = (values.any?{|r| r[4] == '0'} and values.any?{|r| r[4] == '1'})
      field_detail = {}
      field_detail[:field_sequence] = row[0]
      field_detail[:field_name] = row[3]
      field_detail[:length] = row[15]
      field_detail[:start_position] = row[12]
      field_detail[:end_position] = row[13]
      field_detail[:rfa_1] = (row[19] == 'x')
      field_detail[:rfa_2] = false
      field_detail[:rfa_3] = (row[20] == 'x')
      field_detail[:rfa_4] = (row[21] == 'x')
      field_detail[:rfa_5] = (row[22] == 'x')
      field_detail[:rfa_6] = (row[23] == 'x')
      field_detail[:rfa_7] = (row[24] == 'x')
      field_detail[:rfa_8] = (row[25] == 'x')
      field_detail[:rfa_9] = (row[26] == 'x')
      field_detail[:rfa_10] = (row[27] == 'x')
      field_detail[:field_description] = row[5]
      field_detail[:record_type] = record_type[row[7]]
      # field_detail[:oasis_spec_version] = (index == 0) ?  "02.10.1" : "02.11.3"
      field_detail[:oasis_spec_version] = "02.12.0"

      field_detail[:data_type] = boolean_type ? "Boolean" : row[10]

      OasisFieldSpec.create!(field_detail)
    end
  end

end
require 'csv'
def process_header_file(file)
  OasisFieldSpec.header.destroy_all
  IO.readlines(file).each_with_index {|line, idx|
    next if idx == 0
    rec_number = idx + 1
    print "Inserting Record #{rec_number}..."
    field_name, length, start_pos, end_pos, default_value, consistency, applicable_condition_expression = CSV.parse(line).flatten
    rec = OasisFieldSpec.new(field_name: field_name,
                             length: length, start_position: start_pos, end_position: end_pos,
                             field_sequence: idx, default_value: default_value, consistency: consistency,
                             applicable_condition_expression: applicable_condition_expression)
    rec.record_type = "H"
    if field_name == 'CRG_RTN'
      rec.default_value = "\r"
    elsif field_name == 'LN_FD'
      rec.default_value = "\n"
    end
    begin
      rec.save!
    rescue ActiveRecord::RecordNotUnique => r
      puts "Code(#{code}) already exists!!!, skipping."
    end
    puts "done."
  }
end

def process_trailer_file(file)
  OasisFieldSpec.trailer.destroy_all
  IO.readlines(file).each_with_index {|line, idx|
    next if idx == 0
    rec_number = idx + 1
    print "Inserting Record #{rec_number}..."
    field_name, length, start_pos, end_pos, default_value, consistency, applicable_condition_expression = CSV.parse(line).flatten
    rec = OasisFieldSpec.new(field_name: field_name,
                             length: length, start_position: start_pos, end_position: end_pos,
                             field_sequence: idx, default_value: default_value, consistency: consistency,
                             applicable_condition_expression: applicable_condition_expression)
    rec.record_type = "T"
    if field_name == 'CRG_RTN'
      rec.default_value = "\r"
    elsif field_name == 'LN_FD'
      rec.default_value = "\n"
    end
    begin
      rec.save!
    rescue ActiveRecord::RecordNotUnique => r
      puts "Code(#{code}) already exists!!!, skipping."
    end
    puts "done."
  }
end

def process_body_file(file)
  OasisFieldSpec.body.destroy_all
  IO.readlines(file).each_with_index {|line, idx|
    next if idx == 0
    rec_number = idx + 1
    print "Inserting Record #{rec_number}..."
    field_name, length, start_pos, end_pos, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, default_value, data_type,
        field_description, consistency, applicable_condition_expression, display_value = CSV.parse(line).flatten
    rec = OasisFieldSpec.new(field_name: field_name,
                             length: length, start_position: start_pos, end_position: end_pos,
                              rfa_1: r1, rfa_2: r2, rfa_3: r3, rfa_4: r4, rfa_5: r5, rfa_6: r6, rfa_7: r7, rfa_8: r8,
    rfa_9: r9, rfa_10: r10, field_sequence: idx, default_value: default_value, data_type: data_type,
    field_description: field_description, consistency: consistency, applicable_condition_expression: applicable_condition_expression, display_value: display_value)
    rec.record_type = "B"
    if field_name == 'CRG_RTN'
      rec.default_value = "\r"
    elsif field_name == 'LN_FD'
      rec.default_value = "\n"
    end
    begin
      rec.save!
    rescue ActiveRecord::RecordNotUnique => r
      puts "Code(#{code}) already exists!!!, skipping."
    end
    puts "done."
  }
end