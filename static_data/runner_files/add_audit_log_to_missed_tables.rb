audited_klasses = []
klasses = []
Dir.foreach("#{Rails.root}/app/models") do |model_path|
  file_name = model_path[0..-4]
  next if model_path == "prospective_payment_system"
  next if model_path == "report_data_source"
  next if model_path == "."
  next if model_path == ".."
  debug_log model_path
  lines = File.readlines("#{Rails.root}/app/models/#{model_path}")
  unless lines.grep(/audited/).size > 0
    klasses << model_path
  else
    audited_klasses << model_path
  end
end
puts audited_klasses
debug_log "############"
puts klasses