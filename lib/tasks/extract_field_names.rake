desc "Extract Field Names from Form, EX: rake extract_field_names file='<file_name>'"
task :extract_field_names do
	puts "File = #{ENV['file']}"
	require 'pp'
  pp process_form(file)
end

desc "Extract Oasis Field Names from its Forms, Ex: rake extract_oasis_fields"
task :extract_oasis_fields do
  require 'pp'
  files = Dir.glob("app/components/documents/oasis/*.rb")
  pp files.collect{|f| process_form(f)}.flatten
end

def process_form(file)
  a = `sed -n /name:/p #{file}`
  lines = a.split("\n")
  lines.collect{|line| line.scan(/["'](.*)["']/).flatten.first}.uniq
end