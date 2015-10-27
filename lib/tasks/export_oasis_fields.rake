desc "Export OASIS Header Field Specifications, EX: 1) rake export_oasis_header_fields 2) rake export_oasis_header_fields file='oasis/header.csv'"
task :export_oasis_header_fields => [:environment] do
  require "csv"
  file_name = ENV['file'] || "#{Rails.root}/oasis/header.csv"
  fields_spec_arr = get_fields_arr("H")
  CSV.open(file_name, "wb") {|csv|
    csv << ["FIELD_NAME","LENGTH","START_POSITION","END_POSITION","DEFAULT_VALUE", "CONSISTENCY", "APPLICABLE_CONDITION_EXPRESSION"]
    fields_spec_arr.each{|out|
      csv << out
    }
  }
end

desc "Export OASIS Trailer Field Specifications, EX: 1) rake export_oasis_trailer_fields 2) rake export_oasis_trailer_fields file='oasis/trailer.csv'"
task :export_oasis_trailer_fields => [:environment] do
  require "csv"
  file_name = ENV['file'] || "#{Rails.root}/oasis/trailer.csv"
  fields_spec_arr = get_fields_arr("T")
  CSV.open(file_name, "wb") {|csv|
    csv << ["FIELD_NAME","LENGTH","START_POSITION","END_POSITION","DEFAULT_VALUE", "CONSISTENCY", "APPLICABLE_CONDITION_EXPRESSION"]
    fields_spec_arr.each{|out|
      csv << out
    }
  }
end

desc "Export OASIS Body Field Specifications, EX: 1) rake export_oasis_body_fields 2) rake export_oasis_body_fields file='oasis/body.csv'"
task :export_oasis_body_fields => [:environment] do
  require "csv"
  file_name = ENV['file'] || "#{Rails.root}/oasis/body.csv"
  fields_spec_arr = get_fields_arr("B")
  CSV.open(file_name, "wb") {|csv|
    csv << ["FIELD_NAME","LENGTH","START_POSITION","END_POSITION","RFA_1","RFA_2","RFA_3","RFA_4","RFA_5","RFA_6","RFA_7","RFA_8","RFA_9",
            "RFA_10","DEFAULT_VALUE","DATA_TYPE","FIELD_DESCRIPTION", "CONSISTENCY", "APPLICABLE_CONDITION_EXPRESSION", "DISPLAY_VALUE"]
    fields_spec_arr.each{|out|
      csv << out
    }
  }
end

def get_fields_arr(record_type)
  header_fields = ["FIELD_NAME","LENGTH","START_POSITION","END_POSITION","DEFAULT_VALUE", "CONSISTENCY", "APPLICABLE_CONDITION_EXPRESSION"]
  trailer_fields = ["FIELD_NAME","LENGTH","START_POSITION","END_POSITION","DEFAULT_VALUE", "CONSISTENCY", "APPLICABLE_CONDITION_EXPRESSION"]
  body_fields = ["FIELD_NAME","LENGTH","START_POSITION","END_POSITION","RFA_1","RFA_2","RFA_3","RFA_4","RFA_5","RFA_6","RFA_7","RFA_8","RFA_9",
   "RFA_10","DEFAULT_VALUE","DATA_TYPE","FIELD_DESCRIPTION", "CONSISTENCY", "APPLICABLE_CONDITION_EXPRESSION", "DISPLAY_VALUE"]
  field_specs = OasisFieldSpec.where(record_type: record_type).order("field_sequence ASC")
  fields_spec_arr = []
  interested_attrs = if record_type == "H"
                       header_fields
                     elsif record_type == "B"
                       body_fields
                     else
                      trailer_fields
                     end
  field_specs.each{|field_spec|
    field_spec_arr = []
    field_spec.attributes.each{|attr, value|
      field_spec_arr << value if interested_attrs.include?(attr.to_s.upcase)
    }
    default_field_index = (record_type == "B")? -5 : -3
    if field_spec.field_name == 'CRG_RTN'
      field_spec_arr[default_field_index] = nil
    elsif field_spec.field_name == 'LN_FD'
      field_spec_arr[default_field_index] = nil
    end
    fields_spec_arr << field_spec_arr
  }
  fields_spec_arr
end