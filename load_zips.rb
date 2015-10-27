ZipCode.delete_all
require 'csv'
file = File.join(Rails.root, 'static_data', 'zip', 'US.txt')
if Rails.env == 'test'
  file = File.join(Rails.root, 'static_data', 'zip', 'zip_codes_for_unit_test.txt')
end

CSV.foreach(file, { :headers => false, :col_sep => "\t", :skip_blanks => true }) do |row|
  ZipCode.create( {
    :zip_code => row[1],
    :locality => row[2],
    :admin_name_1 => row[3],
    :admin_code_1 => row[4],
    :admin_name_2 => row[5],
    :admin_code_2 => row[6],
    :lat => row[9],
    :lng => row[10],
    })
end