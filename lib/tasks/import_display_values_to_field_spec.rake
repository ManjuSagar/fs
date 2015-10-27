#Run this task after running the OASIS FIELD SPEC related CSVS.
desc "import display values to field spec"
task :import_display_values_to_field_spec => [:environment] do
  require 'csv'
  lines = CSV.readlines("#{Rails.root}/oasis/oasis_c1/v2.11.3/display_value.csv", :headers=>true, skip_blanks: true)
  lines.each do |row|
    OasisFieldSpec.where(field_name: row[0], oasis_spec_version: "02.11.3").update_all(display_value: row[1])
  end

end